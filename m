Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbeCPIu0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:50:26 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34548 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbeCPIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:50:22 -0400
X-Google-Smtp-Source: AG47ELtIKSwBj28+FRNAJJGu75NsX5iTX44EB3UDhZwqeK07ul4s1FBanVpdZ7vgq+Sbq1a9R8nXWjuEC5RNqrMCw8U=
MIME-Version: 1.0
In-Reply-To: <20180315224202.96668-4-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com> <20180315224202.96668-4-dmitry.torokhov@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Mar 2018 09:50:21 +0100
X-Google-Sender-Auth: ASCo0CgcbGtnpbYfnaAC66Z-05U
Message-ID: <CAMuHMdX9CsWmGYN20mDge7h8UjRDWQMAXD+L2uKFjO3x=R5gLw@mail.gmail.com>
Subject: Re: [RFC 3/4] sh: ecovec24: convert backlight to use device properties
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Mar 15, 2018 at 11:42 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Instead of backlight legacy platform data, let's switch to using device
> properties and GPIO lookup tables.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks for your patch!

> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c

> @@ -367,17 +368,21 @@ static struct platform_device lcdc_device = {
>         },
>  };
>
> -static struct gpio_backlight_platform_data gpio_backlight_data = {
> -       .gpio = GPIO_PTR1,
> -       .def_value = 1,
> -       .name = "backlight",
> +static struct gpiod_lookup_table gpio_backlight_gpios_table = {

gpio_backlight_gpios_table is unused?

> +       .dev_id = "gpio-backlight.0",
> +       .table = {
> +               GPIO_LOOKUP_IDX("sh7724_pfc", GPIO_PTR1, NULL, 0, GPIO_ACTIVE_HIGH);
> +               { }
> +       },
> +};
> +
> +static struct property_entry gpio_backlight_properties[] = {

const

> +       PROPERTY_ENTRY_BOOL("default-on"),
> +       { }
>  };
>
>  static struct platform_device gpio_backlight_device = {
>         .name = "gpio-backlight",
> -       .dev = {
> -               .platform_data = &gpio_backlight_data,
> -       },
>  };
>
>  /* CEU0 */
> @@ -1436,6 +1441,8 @@ static int __init arch_setup(void)
>                 return error;
>
>         if (use_backlight) {
> +               device_add_properties(&gpio_backlight_device.dev,
> +                                     gpio_backlight_properties);
>                 error = platform_device_add(&gpio_backlight_device);
>                 if (error)
>                         pr_warn("%s: failed to register backlight: %d\n",

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
