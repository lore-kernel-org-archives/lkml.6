Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeEOHnE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 03:43:04 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33638 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752054AbeEOHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 03:43:01 -0400
Date: Tue, 15 May 2018 09:42:42 +0200
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Message-ID: <20180515074241.kgvjbhrgw2dbec6o@verge.net.au>
References: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 09:31:37AM +0100, Phil Edworthy wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> One point to mention is that I have made it possible for users to have
> unconnected interrupts by specifying holes in the list of interrupts. This is
> done by supporting the interrupts-extended DT prop.
> However, I have no use for this and had to hack some test case for this.
> Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
> 
> v6:
>  - Treat DT and ACPI the same as much as possible. Note that we can't use
>    platform_get_irq() to get the DT interrupts as they are in the port
>    sub-node and hence do not have an associated platform device.
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
> ---
>  .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  9 +++-
>  drivers/gpio/gpio-dwapb.c                          | 49 +++++++++++++++-------
>  drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-
>  include/linux/platform_data/gpio-dwapb.h           |  3 +-
>  4 files changed, 45 insertions(+), 19 deletions(-)
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

An enhanced example might be helpful.

That not withstanding:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
