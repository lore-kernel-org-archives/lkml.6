Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeBEKHq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:07:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40704 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeBEKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:07:32 -0500
X-Google-Smtp-Source: AH8x225Hg9OLTa9QQlQumNAMnwpmq4tc7rUWVEp1Bgxrf17Y6yQopY/QT75m6QAjLn6P1UwO6Jd/aNrFNSnyRT4X3yU=
MIME-Version: 1.0
In-Reply-To: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 5 Feb 2018 11:07:08 +0100
Message-ID: <CAH9NwWeom2H89D5hUixxSL28YgDna_WS26boayzUBAPyVFUvTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode
 during open
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

2017-04-27 14:22 GMT+02:00 Martin Kepplinger <martin.kepplinger@ginzinger.com>:
> The device could as well be in command mode, in which this driver cannot
> handle the device. When opening the device, let's make sure the device
> will be in the mode we expect it to be for this driver.
>

I run into issues caused by this change. It turns out that the device
is non-functional
after some warm-reboots and as a result I am not able to use xorg's
evdev driver.
So I have some questions about this change:

* Should we enable irq before calling i2c_master_send(..) as the chip raises an
  irq if the command was processed?

* Would it be enough to send this command only once during driver
lifetime? I can
  see that on my system open gets called 3 times during boot-up.

* What are the circumstances the touch device would be in an other state? In the
  official kernel driver the userspace can send commands via sysfs.
Also the driver
  does set the touch enable mode as this patch does.


> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 1a94d8b..2a76231 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -18,6 +18,12 @@
>  #define AR1021_MAX_X   4095
>  #define AR1021_MAX_Y   4095
>
> +#define AR1021_CMD     0x55
> +#define AR1021_TOUCH   0x80
> +
> +#define AR1021_CMD_ENABLE_TOUCH                0x12
> +#define AR1021_CMD_DISABLE_TOUCH       0x13
> +
>  struct ar1021_i2c {
>         struct i2c_client *client;
>         struct input_dev *input;
> @@ -58,6 +64,15 @@ static int ar1021_i2c_open(struct input_dev *dev)
>  {
>         struct ar1021_i2c *ar1021 = input_get_drvdata(dev);
>         struct i2c_client *client = ar1021->client;
> +       int error;
> +       u8 cmd_enable_touch[3] = {AR1021_CMD,
> +                                 0x01, /* number of bytes after this */
> +                                 AR1021_CMD_ENABLE_TOUCH };
> +
> +       error = i2c_master_send(ar1021->client, cmd_enable_touch,
> +                               sizeof(cmd_enable_touch));
> +       if (error < 0)
> +               return error;
>
>         enable_irq(client->irq);
>
> --
> 2.1.4
>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info
