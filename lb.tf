#### RESOURCE #############################################

resource "aws_lb" "ngnix" {
  name               = "weblb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]

  enable_deletion_protection = false

  }


# Resource: aws_lb_target_group

resource "aws_lb_target_group" "alb_tg" {
  name     = "lbtg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test_vpc.id
}

# Resource: aws_lb_listener

resource "aws_lb_listener" "alb_lisn" {
  load_balancer_arn = aws_lb.ngnix.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}
# Resource: aws_lb_target_group_attachment

resource "aws_lb_target_group_attachment" "ngnix1" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.myec21.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "ngnix2" {
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.myec22.id
  port             = 80
}