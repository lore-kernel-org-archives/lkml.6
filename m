Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeCPXkr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 19:40:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45648 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeCPXkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 19:40:45 -0400
X-Google-Smtp-Source: AG47ELumiKBkTwCSXIaAh8t56QJZTv/1HDJahjSBMfb49yScr030U7Xsh+NvWZOhJTyd7i4MSJ6WRw==
Date: Fri, 16 Mar 2018 16:40:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [RFC 3/4] sh: ecovec24: convert backlight to use device
 properties
Message-ID: <20180316234041.GB32310@dtor-ws>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
 <20180315224202.96668-4-dmitry.torokhov@gmail.com>
 <CAMuHMdX9CsWmGYN20mDge7h8UjRDWQMAXD+L2uKFjO3x=R5gLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX9CsWmGYN20mDge7h8UjRDWQMAXD+L2uKFjO3x=R5gLw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:50:21AM +0100, Geert Uytterhoeven wrote:
> Hi Dmitry,
> 
> On Thu, Mar 15, 2018 at 11:42 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Instead of backlight legacy platform data, let's switch to using device
> > properties and GPIO lookup tables.
> >
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/sh/boards/mach-ecovec24/setup.c
> > +++ b/arch/sh/boards/mach-ecovec24/setup.c
> 
> > @@ -367,17 +368,21 @@ static struct platform_device lcdc_device = {
> >         },
> >  };
> >
> > -static struct gpio_backlight_platform_data gpio_backlight_data = {
> > -       .gpio = GPIO_PTR1,
> > -       .def_value = 1,
> > -       .name = "backlight",
> > +static struct gpiod_lookup_table gpio_backlight_gpios_table = {
> 
> gpio_backlight_gpios_table is unused?

There was supposed to be gpiod_add_lookup_table() that I lost as I was
reshuffling and reshuffling the patches.

> 
> > +       .dev_id = "gpio-backlight.0",
> > +       .table = {
> > +               GPIO_LOOKUP_IDX("sh7724_pfc", GPIO_PTR1, NULL, 0, GPIO_ACTIVE_HIGH);
> > +               { }
> > +       },
> > +};
> > +
> > +static struct property_entry gpio_backlight_properties[] = {
> 
> const

OK.

> 
> > +       PROPERTY_ENTRY_BOOL("default-on"),
> > +       { }
> >  };
> >
> >  static struct platform_device gpio_backlight_device = {
> >         .name = "gpio-backlight",
> > -       .dev = {
> > -               .platform_data = &gpio_backlight_data,
> > -       },
> >  };
> >
> >  /* CEU0 */
> > @@ -1436,6 +1441,8 @@ static int __init arch_setup(void)
> >                 return error;
> >
> >         if (use_backlight) {
> > +               device_add_properties(&gpio_backlight_device.dev,
> > +                                     gpio_backlight_properties);
> >                 error = platform_device_add(&gpio_backlight_device);
> >                 if (error)
> >                         pr_warn("%s: failed to register backlight: %d\n",
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Dmitry
