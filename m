Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbeDLUAO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:00:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46836 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbeDLUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:00:11 -0400
X-Google-Smtp-Source: AIpwx4/vhFgewJhFHwAjSbpjbuN2ZSkIKOl7bnKZH8GpuKlxA5MBZNMyvPiau/hnsui/2nBrT+JmSA==
From: Christian Lamparter <chunkeey@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpiolib: add hogs support for machine code
Date: Thu, 12 Apr 2018 22:00:07 +0200
Message-ID: <17720832.6ELUnVt0BR@debian64>
In-Reply-To: <20180410203028.11412-1-brgl@bgdev.pl>
References: <20180410203028.11412-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 10. April 2018 22:30:28 CEST Bartosz Golaszewski wrote:
> Board files constitute a significant part of the users of the legacy
> GPIO framework. In many cases they only export a line and set its
> desired value. We could use GPIO hogs for that like we do for DT and
> ACPI but there's no support for that in machine code.
> 
> This patch proposes to extend the machine.h API with support for
> registering hog tables in board files.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
> @@ -1326,6 +1364,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
>  
>  	acpi_gpiochip_add(chip);
>  
> +	machine_gpiochip_add(chip);
> +
>  	/*
>  	 * By first adding the chardev, and then adding the device,
>  	 * we get a device node entry in sysfs under
> @@ -3462,6 +3502,33 @@ void gpiod_remove_lookup_table(struct gpiod_lookup_table *table)

I think I see the same problem right here in regards to pinctrls
and gpiohogs that have with DeviceTree:
<https://patchwork.kernel.org/patch/10313767/>

The problem is that unlike native gpio-controllers, pinctrls need 
to have a "pin/gpio range" defined before any gpio-hogs can be added.

If this is not the case the generic pinctrl_gpio_reguest() [0] will
fail with -EPROBE_DEFER at this point. (see the call chain in the
"pinctrl: msm: fix gpio-hog related boot issueslogin register" mail
starting from gpiod_hog).

And now the crux of the matter is that currently in order for pinctrl
drivers to register the range they have to call gpiochip_add_pin_range() [1]. 
But they only can do it after the gpiochip_add_data_with_key() [2], since
this function initializes the pin_ranges list [3].

So what will happen is that you'll get an
"gpiochip_machine_hog: unable to hog GPIO line $LABEL $GPIONR -517" error
for every single gpio-hog and wonder why :(.

Regards,
Christian

[0] <https://elixir.bootlin.com/linux/v4.16.2/source/drivers/pinctrl/core.c#L743>
[1] <https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2078>
[2] <https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L1136>
[3] <https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L1253>
