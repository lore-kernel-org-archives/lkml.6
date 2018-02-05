Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752967AbeBENGl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:06:41 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:46940 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752710AbeBENGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:06:35 -0500
X-Google-Smtp-Source: AH8x224KmVohLYgERz0sTWvX+AokNqDhSGB6UWkeV2D8UiitVoxJhBzOOy6ecGHKEvkjYav0IcJcHCTNRWp2pAAEZkc=
MIME-Version: 1.0
In-Reply-To: <20180205084755.6011-1-ludovic.desroches@microchip.com>
References: <20180205084755.6011-1-ludovic.desroches@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Feb 2018 15:06:33 +0200
Message-ID: <CAHp75Vc1npdmhrs80Cdj0t6RWpTtuXFkpXUQwxKDe=6vrZxkFA@mail.gmail.com>
Subject: Re: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO descriptors
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 10:47 AM, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
> Use GPIO descriptors instead of relying on the old method.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Though few nitpicks below.


> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -18,6 +18,7 @@
>  #include <linux/delay.h>
>  #include <linux/backlight.h>
>  #include <linux/gfp.h>

> +#include <linux/gpio/consumer.h>

I think you forgot to remove of_gpio.h.

>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>

>         struct device_node *display_np;
>         struct device_node *timings_np;
>         struct display_timings *timings;
> -       enum of_gpio_flags flags;
>         struct atmel_lcdfb_power_ctrl_gpio *og;
>         bool is_gpio_power = false;
>         int ret = -ENOENT;
> -       int i, gpio;
> +       int i;
> +       struct gpio_desc *gpiod;

I would rather preserve reversed tree style, i.e. put longer line upper.


> +       for (i = 0; i < gpiod_count(dev, "atmel,power-control"); i++) {
> +               gpiod = devm_gpiod_get_index_optional(dev,
> +                               "atmel,power-control", i, GPIOD_ASIS);
> +               if (!gpiod)
>                         continue;

What about IS_ERR() case?

>
>                 og = devm_kzalloc(dev, sizeof(*og), GFP_KERNEL);
>                 if (!og)
>                         goto put_display_node;
>
> +               og->gpiod = gpiod;
>                 is_gpio_power = true;
>
> +               ret = gpiod_direction_output(gpiod, gpiod_is_active_low(gpiod));
>                 if (ret) {

I'm not sure this will be needed if you check IS_ERR() above.

> +                       dev_err(dev, "set direction output gpio atmel,power-control[%d] failed\n", i);
>                         goto put_display_node;
>                 }


-- 
With Best Regards,
Andy Shevchenko
