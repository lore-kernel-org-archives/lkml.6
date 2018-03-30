Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeC3V01 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:26:27 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:37031 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeC3V0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:26:24 -0400
X-Google-Smtp-Source: AIpwx4+VAElZbEjGjHgOzhLq6f4X9bFS1m7s27/0zBEqnXL2z5CFqwOnQOw467cYC5tnV0duJSjZYuldgvw/DKQyYTs=
MIME-Version: 1.0
In-Reply-To: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 31 Mar 2018 00:26:23 +0300
Message-ID: <CAHp75VeOTjZ30ok1JOW0cefZfxqUM-f0-zpTnC5TonyeqQVUKg@mail.gmail.com>
Subject: Re: [PATCH] gpio: dwapb: Add support for 32 interrupts
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 5:22 PM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> The DesignWare GPIO IP can be configured for either 1 or 32 interrupts,

1 to 32, or just a choice between two?

> but the driver currently only supports 1 interrupt. See the DesignWare
> DW_apb_gpio Databook description of the 'GPIO_INTR_IO' parameter.

Will see after holiday and perhaps make more comments. Here is just a
brief review.

> +- interrupts : The interrupts to the parent controller raised when GPIOs
> +  generate the interrupts. If the controller provides one combined interrupt
> +  for all GPIOs, specify a single interrupt. If the controller provides one
> +  interrupt for each GPIO, provide a list of interrupts that correspond to each
> +  of the GPIO pins. When specifying multiple interrupts, if any of the GPIOs are
> +  not connected to an interrupt, use the interrupt-mask property.
> +- interrupt-mask : a 32-bit bit mask that specifies which interrupts in the list
> +  of interrupts is valid, bit is 1 for a valid irq.

So, but why one will need that in practice? GPIO driver usually
provides a pin based IRQ chip which maps each pin to the corresponding
offset inside specific IRQ domain.

> +                       struct device_node *np = to_of_node(fwnode);
> +                       u32 irq_mask = 0xFFFFFFFF;

Why? Shouldn't it be dependent to the amount of actual pins / ports?
Intel Quark has only 8 AFAIR.

> +                       int j;
> +
> +                       /* Optional irq mask */
> +                       fwnode_property_read_u32(fwnode, "interrupt-mask", &irq_mask);
> +
> +                       /*
> +                        * The IP has configuration options to allow a single
> +                        * combined interrupt or one per gpio. If one per gpio,
> +                        * some might not be used.
> +                        */

> +                       for (j = 0; j < pp->ngpio; j++) {
> +                               if (irq_mask & BIT(j)) {

for_each_set_bit() is in kernel for ages!

> +                                       pp->irq[j] = irq_of_parse_and_map(np, j);
> +                                       if (pp->irq[j])
> +                                               pp->has_irq = true;
> +                               }
> +                       }


So, on the first glance the patch looks either superfluous or taking
wrong approach. Please, elaborate more why it's done in this way and
what the case for all this in practice.

-- 
With Best Regards,
Andy Shevchenko
