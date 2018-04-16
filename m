Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeDPUDe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 16:03:34 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37518 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753644AbeDPUDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 16:03:31 -0400
X-Google-Smtp-Source: AIpwx4/rUVwOOVOxNWcGaCX0IrRQRaHPaa49rHxjEdHuzYP/WH+btmsDYGcuAAJzL+bQcm5LdhnR+A==
Date: Mon, 16 Apr 2018 15:03:29 -0500
From: Rob Herring <robh@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Message-ID: <20180416200329.notqjtdztzjrnim7@rob-hp-laptop>
References: <1523609472-4481-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523609472-4481-1-git-send-email-phil.edworthy@renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 09:51:12AM +0100, Phil Edworthy wrote:
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
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> One point to mention is that I have made it possible for users to have
> unconncted interrupts by specifying holes in the list of interrupts. This is
> done by supporting the interrupts-extended DT prop.
> However, I have no use for this and had to hack some test case for this.
> Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
> 
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
>  drivers/gpio/gpio-dwapb.c                          | 43 +++++++++++++++++-----
>  drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-
>  include/linux/platform_data/gpio-dwapb.h           |  3 +-
>  4 files changed, 45 insertions(+), 13 deletions(-)
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
> index 226977f..3273504 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -441,14 +441,19 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
>  	irq_gc->chip_types[1].handler = handle_edge_irq;
>  
>  	if (!pp->irq_shared) {
> -		irq_set_chained_handler_and_data(pp->irq, dwapb_irq_handler,
> -						 gpio);
> +		int i;
> +
> +		for (i = 0; i < pp->ngpio; i++) {
> +			if (pp->irq[i])
> +				irq_set_chained_handler_and_data(pp->irq[i],
> +						dwapb_irq_handler, gpio);
> +		}
>  	} else {
>  		/*
>  		 * Request a shared IRQ since where MFD would have devices
>  		 * using the same irq pin
>  		 */
> -		err = devm_request_irq(gpio->dev, pp->irq,
> +		err = devm_request_irq(gpio->dev, pp->irq[0],
>  				       dwapb_irq_handler_mfd,
>  				       IRQF_SHARED, "gpio-dwapb-mfd", gpio);
>  		if (err) {
> @@ -524,7 +529,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>  	if (pp->idx == 0)
>  		port->gc.set_config = dwapb_gpio_set_config;
>  
> -	if (pp->irq)
> +	if (pp->has_irq)
>  		dwapb_configure_irqs(gpio, port, pp);
>  
>  	err = gpiochip_add_data(&port->gc, port);
> @@ -535,7 +540,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>  		port->is_registered = true;
>  
>  	/* Add GPIO-signaled ACPI event support */
> -	if (pp->irq)
> +	if (pp->has_irq)
>  		acpi_gpiochip_request_interrupts(&port->gc);
>  
>  	return err;
> @@ -601,13 +606,33 @@ dwapb_gpio_get_pdata(struct device *dev)
>  		if (dev->of_node && pp->idx == 0 &&
>  			fwnode_property_read_bool(fwnode,
>  						  "interrupt-controller")) {
> -			pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
> -			if (!pp->irq)
> +			struct device_node *np = to_of_node(fwnode);
> +			struct of_phandle_args oirq;
> +			unsigned int j;
> +
> +			/*
> +			 * The IP has configuration options to allow a single
> +			 * combined interrupt or one per gpio. If one per gpio,
> +			 * some might not be used.
> +			 */
> +			for (j = 0; j < pp->ngpio; j++) {
> +				if (of_irq_parse_one(np, j, &oirq))
> +					continue;
> +
> +				pp->irq[j] = irq_create_of_mapping(&oirq);

I'm hoping to not have new users of of_irq_parse_one and 
irq_create_of_mapping. Can you use of_irq_get instead? It will base back 
error codes so you can distinguish different conditions.

> +				if (pp->irq[j])
> +					pp->has_irq = true;
> +			}
> +
> +			if (!pp->has_irq)
>  				dev_warn(dev, "no irq for port%d\n", pp->idx);
>  		}
>  
> -		if (has_acpi_companion(dev) && pp->idx == 0)
> -			pp->irq = platform_get_irq(to_platform_device(dev), 0);
> +		if (has_acpi_companion(dev) && pp->idx == 0) {
> +			pp->irq[0] = platform_get_irq(to_platform_device(dev), 0);
> +			if (pp->irq[0])
> +				pp->has_irq = true;
> +		}
>  
>  		pp->irq_shared	= false;
>  		pp->gpio_base	= -1;
