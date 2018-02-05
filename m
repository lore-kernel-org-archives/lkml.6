Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeBEPcC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:32:02 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:16938 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752919AbeBEPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:31:54 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511852400";
   d="scan'208";a="11172908"
Date: Mon, 5 Feb 2018 16:31:37 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND][PATCH] video: fbdev: atmel_lcdfb: convert to use GPIO
 descriptors
Message-ID: <20180205153137.GF2580@rfolt0960.corp.atmel.com>
Mail-Followup-To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20180205084755.6011-1-ludovic.desroches@microchip.com>
 <CAHp75Vc1npdmhrs80Cdj0t6RWpTtuXFkpXUQwxKDe=6vrZxkFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vc1npdmhrs80Cdj0t6RWpTtuXFkpXUQwxKDe=6vrZxkFA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 03:06:33PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 5, 2018 at 10:47 AM, Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> > Use GPIO descriptors instead of relying on the old method.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Though few nitpicks below.
> 
> 
> > --- a/drivers/video/fbdev/atmel_lcdfb.c
> > +++ b/drivers/video/fbdev/atmel_lcdfb.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/backlight.h>
> >  #include <linux/gfp.h>
> 
> > +#include <linux/gpio/consumer.h>
> 
> I think you forgot to remove of_gpio.h.

Right. I'll remove it.

> 
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> 
> >         struct device_node *display_np;
> >         struct device_node *timings_np;
> >         struct display_timings *timings;
> > -       enum of_gpio_flags flags;
> >         struct atmel_lcdfb_power_ctrl_gpio *og;
> >         bool is_gpio_power = false;
> >         int ret = -ENOENT;
> > -       int i, gpio;
> > +       int i;
> > +       struct gpio_desc *gpiod;
> 
> I would rather preserve reversed tree style, i.e. put longer line upper.

Ok.

> 
> 
> > +       for (i = 0; i < gpiod_count(dev, "atmel,power-control"); i++) {
> > +               gpiod = devm_gpiod_get_index_optional(dev,
> > +                               "atmel,power-control", i, GPIOD_ASIS);
> > +               if (!gpiod)
> >                         continue;
> 
> What about IS_ERR() case?

if (!gpiod || IS_ERR(gpiod))
	continue;

Thanks.

> 
> >
> >                 og = devm_kzalloc(dev, sizeof(*og), GFP_KERNEL);
> >                 if (!og)
> >                         goto put_display_node;
> >
> > +               og->gpiod = gpiod;
> >                 is_gpio_power = true;
> >
> > +               ret = gpiod_direction_output(gpiod, gpiod_is_active_low(gpiod));
> >                 if (ret) {
> 
> I'm not sure this will be needed if you check IS_ERR() above.
> 

When in doubt, I keep it.

Regards

Ludovic

> > +                       dev_err(dev, "set direction output gpio atmel,power-control[%d] failed\n", i);
> >                         goto put_display_node;
> >                 }
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
