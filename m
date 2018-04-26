Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756780AbeDZQdp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:33:45 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52444 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756506AbeDZQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:33:41 -0400
X-Google-Smtp-Source: AB8JxZrJ4DMZr6iAabXcoTPheGl+3cZfz8Q7fFnhfr8GqAcVdaRY8wGAhdSXpnjnzxTJA/d01P6bl5B6N9mnOtIsHn4=
MIME-Version: 1.0
In-Reply-To: <1524759587-7007-1-git-send-email-phil.edworthy@renesas.com>
References: <1524759587-7007-1-git-send-email-phil.edworthy@renesas.com>
From: Hoan Tran <hotran@apm.com>
Date: Thu, 26 Apr 2018 09:33:40 -0700
Message-ID: <CAFHUOYxW6C9F-etiPSw5WBH7UDc6nia+5m9bqMND=SdfteJCPg@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: dwapb: Add support for 1 interrupt per port A GPIO
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 26, 2018 at 9:19 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> The DesignWare GPIO IP can be configured for either 1 interrupt or 1
> per GPIO in port A, but the driver currently only supports 1 interrupt.
> See the DesignWare DW_apb_gpio Databook description of the
> 'GPIO_INTR_IO' parameter.
>
> This change allows the driver to work with up to 32 interrupts, it will
> get as many interrupts as specified in the DT 'interrupts' property.
> It doesn't do anything clever with the different interrupts, it just calls
> the same handler used for single interrupt hardware.
>
> ACPI companion code provided by Hoan Tran <hotran@apm.com>. This was tested
> on X-Gene by Hoan.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> One point to mention is that I have made it possible for users to have
> unconncted interrupts by specifying holes in the list of interrupts. This is
> done by supporting the interrupts-extended DT prop.
> However, I have no use for this and had to hack some test case for this.
> Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
>
> v5:
>  - Rolled ACPI companion code provided by Hoan Tran into this patch.
> v4:
>  - Use of_irq_get() instead of of_irq_parse_one()+irq_create_of_mapping()
> v3:
>  - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid bisect problems
> v2:
>  - Replaced interrupt-mask DT prop with support for the interrupts-extended
>    prop. This means replacing the call to irq_of_parse_and_map() with calls
>    to of_irq_parse_one() and irq_create_of_mapping().
>
> Note: There are a few *code* lines over 80 chars, but this is just guidance,
>    right? Especially as there are already some lines over 80 chars.
> ---
>  .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  9 ++++-
>  drivers/gpio/gpio-dwapb.c                          | 46 +++++++++++++++++-----
>  drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-
>  include/linux/platform_data/gpio-dwapb.h           |  3 +-
>  4 files changed, 48 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> index 4a75da7..3c1118b 100644
> --- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> @@ -26,8 +26,13 @@ controller.
>    the second encodes the triger flags encoded as described in
>    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  - interrupt-parent : The parent interrupt controller.
> -- interrupts : The interrupt to the parent controller raised when GPIOs
> -  generate the interrupts.
> +- interrupts : The interrupts to the parent controller raised when GPIOs
> +  generate the interrupts. If the controller provides one combined interrupt
> +  for all GPIOs, specify a single interrupt. If the controller provides one
> +  interrupt for each GPIO, provide a list of interrupts that correspond to each
> +  of the GPIO pins. When specifying multiple interrupts, if any are unconnected,
> +  use the interrupts-extended property to specify the interrupts and set the
> +  interrupt controller handle for unused interrupts to 0.
>  - snps,nr-gpios : The number of pins in the port, a single cell.
>  - resets : Reset line for the controller.
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 226977f..7dcd06b 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -441,14 +441,19 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
>         irq_gc->chip_types[1].handler = handle_edge_irq;
>
>         if (!pp->irq_shared) {
> -               irq_set_chained_handler_and_data(pp->irq, dwapb_irq_handler,
> -                                                gpio);
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
> -               err = devm_request_irq(gpio->dev, pp->irq,
> +               err = devm_request_irq(gpio->dev, pp->irq[0],
>                                        dwapb_irq_handler_mfd,
>                                        IRQF_SHARED, "gpio-dwapb-mfd", gpio);
>                 if (err) {
> @@ -524,7 +529,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>         if (pp->idx == 0)
>                 port->gc.set_config = dwapb_gpio_set_config;
>
> -       if (pp->irq)
> +       if (pp->has_irq)
>                 dwapb_configure_irqs(gpio, port, pp);
>
>         err = gpiochip_add_data(&port->gc, port);
> @@ -535,7 +540,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>                 port->is_registered = true;
>
>         /* Add GPIO-signaled ACPI event support */
> -       if (pp->irq)
> +       if (pp->has_irq)
>                 acpi_gpiochip_request_interrupts(&port->gc);
>
>         return err;
> @@ -601,13 +606,36 @@ dwapb_gpio_get_pdata(struct device *dev)
>                 if (dev->of_node && pp->idx == 0 &&
>                         fwnode_property_read_bool(fwnode,
>                                                   "interrupt-controller")) {
> -                       pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
> -                       if (!pp->irq)
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
> +
> +                       if (!pp->has_irq)
>                                 dev_warn(dev, "no irq for port%d\n", pp->idx);
>                 }
>
> -               if (has_acpi_companion(dev) && pp->idx == 0)
> -                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
> +               if (has_acpi_companion(dev) && pp->idx == 0) {
> +                       unsigned int j;
> +
> +                       for (j = 0; j < pp->ngpio; j++) {
> +                               pp->irq[j] = platform_get_irq(to_platform_device(dev), j);
> +                               if (pp->irq[j])
> +                                       pp->has_irq = true;
> +                       }
> +               }
>
>                 pp->irq_shared  = false;
>                 pp->gpio_base   = -1;
> diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
> index 90e35de..5bddb84 100644
> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -233,7 +233,8 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>         pdata->properties->idx          = 0;
>         pdata->properties->ngpio        = INTEL_QUARK_MFD_NGPIO;
>         pdata->properties->gpio_base    = INTEL_QUARK_MFD_GPIO_BASE;
> -       pdata->properties->irq          = pdev->irq;
> +       pdata->properties->irq[0]       = pdev->irq;
> +       pdata->properties->has_irq      = true;
>         pdata->properties->irq_shared   = true;
>
>         cell->platform_data = pdata;
> diff --git a/include/linux/platform_data/gpio-dwapb.h b/include/linux/platform_data/gpio-dwapb.h
> index 2dc7f4a..5a52d69 100644
> --- a/include/linux/platform_data/gpio-dwapb.h
> +++ b/include/linux/platform_data/gpio-dwapb.h
> @@ -19,7 +19,8 @@ struct dwapb_port_property {
>         unsigned int    idx;
>         unsigned int    ngpio;
>         unsigned int    gpio_base;
> -       unsigned int    irq;
> +       unsigned int    irq[32];
> +       bool            has_irq;
>         bool            irq_shared;
>  };
>

Acked-by: Hoan Tran <hotran@apm.com>

Thanks
Hoan

> --
> 2.7.4
>
