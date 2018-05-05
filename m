Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeEEKtE (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:49:04 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:46329 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeEEKtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:49:00 -0400
X-Google-Smtp-Source: AB8JxZo9i9qVl09F9V2rrg4alNEEh3r8POKRGvd55SbC+W7g5kUeQzEvKi7PHZXzHeaQ9KjFuib4yDUa0FWA/n0n+Xw=
MIME-Version: 1.0
In-Reply-To: <1524759587-7007-1-git-send-email-phil.edworthy@renesas.com>
References: <1524759587-7007-1-git-send-email-phil.edworthy@renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 5 May 2018 13:48:59 +0300
Message-ID: <CAHp75Vc3qBOYjUAgxZCkpXAdg=ueM2KApPynPdpkEmOoMR7sQQ@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: dwapb: Add support for 1 interrupt per port A GPIO
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 7:19 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:

Sotty fo a late response. Consider follow up fixes for below.

>         if (!pp->irq_shared) {
> +               int i;
> +
> +               for (i = 0; i < pp->ngpio; i++) {
> +                       if (pp->irq[i])
> +                               irq_set_chained_handler_and_data(pp->irq[i],
> +                                               dwapb_irq_handler, gpio);
> +               }
>         } else {
>                 /*
>                  * Request a shared IRQ since where MFD would have devices
>                  * using the same irq pin
>                  */
> +               err = devm_request_irq(gpio->dev, pp->irq[0],
>                                        dwapb_irq_handler_mfd,
>                                        IRQF_SHARED, "gpio-dwapb-mfd", gpio);

> +       if (pp->has_irq)
>                 dwapb_configure_irqs(gpio, port, pp);

I would rather make irq array a type of signed int and move
conditional into the function to test per IRQ based.

>         /* Add GPIO-signaled ACPI event support */
> +       if (pp->has_irq)
>                 acpi_gpiochip_request_interrupts(&port->gc);

Perhaps something similar.

>                 if (dev->of_node && pp->idx == 0 &&
>                         fwnode_property_read_bool(fwnode,
>                                                   "interrupt-controller")) {

> +                       struct device_node *np = to_of_node(fwnode);
> +                       unsigned int j;
> +
> +                       /*
> +                        * The IP has configuration options to allow a single
> +                        * combined interrupt or one per gpio. If one per gpio,
> +                        * some might not be used.
> +                        */
> +                       for (j = 0; j < pp->ngpio; j++) {
> +                               int irq = of_irq_get(np, j);
> +                               if (irq < 0)
> +                                       continue;
> +
> +                               pp->irq[j] = irq;
> +                               pp->has_irq = true;
> +                       }

for (...)
 pp->irq = of_irq_get();

>                 }

> +               if (has_acpi_companion(dev) && pp->idx == 0) {
> +                       unsigned int j;
> +
> +                       for (j = 0; j < pp->ngpio; j++) {
> +                               pp->irq[j] = platform_get_irq(to_platform_device(dev), j);
> +                               if (pp->irq[j])
> +                                       pp->has_irq = true;
> +                       }

Ditto.
Moreover you have a bug here. See my proposal at the top of this message.

And now even better to ask, why platform_get_irq() wouldn't work for DT case?

> +
> +                       if (!pp->has_irq)
>                                 dev_warn(dev, "no irq for port%d\n", pp->idx);

This could be issued in the actual function which will try to allocate
IRQs (perhaps on debug level)


P.S. Just think about it, perhaps you find even better solutions.

-- 
With Best Regards,
Andy Shevchenko
