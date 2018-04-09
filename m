Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbeDITUS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:20:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33045 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbeDITUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:20:16 -0400
X-Google-Smtp-Source: AIpwx4+BH8Rlkq2JBzW9dfpnRJTFQDd7dcuRLUe+0dnlXm0rH8zsY82G15wqkcfXZFiADGCBwDViSw==
Date: Mon, 9 Apr 2018 14:20:13 -0500
From: Rob Herring <robh@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: dwapb: Add support for 32 interrupts
Message-ID: <20180409192013.5rytwgoixtyraow3@rob-hp-laptop>
References: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522246950-9110-1-git-send-email-phil.edworthy@renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 03:22:30PM +0100, Phil Edworthy wrote:
> The DesignWare GPIO IP can be configured for either 1 or 32 interrupts,
> but the driver currently only supports 1 interrupt. See the DesignWare
> DW_apb_gpio Databook description of the 'GPIO_INTR_IO' parameter.

Someday h/w designers will realize this does nothing to optimize 
interrupt handling...

> This change allows the driver to work with up to 32 interrupts, it will
> get as many interrupts as specified in the DT 'interrupts' property.
> It doesn't do anything clever with the different interrupts, it just calls
> the same handler used for single interrupt hardware.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> Note: There are a few lines over 80 chars, but this is just guidance, right?
>       Especially as there are already some lines over 80 chars.

Code, yes, but not for paragraphs of text in DT bindings.

> ---
>  .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   | 10 ++++-
>  drivers/gpio/gpio-dwapb.c                          | 44 +++++++++++++++++-----
>  include/linux/platform_data/gpio-dwapb.h           |  3 +-
>  3 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> index 4a75da7..e343581 100644
> --- a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> @@ -26,8 +26,14 @@ controller.
>    the second encodes the triger flags encoded as described in
>    Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  - interrupt-parent : The parent interrupt controller.
> -- interrupts : The interrupt to the parent controller raised when GPIOs
> -  generate the interrupts.
> +- interrupts : The interrupts to the parent controller raised when GPIOs
> +  generate the interrupts. If the controller provides one combined interrupt
> +  for all GPIOs, specify a single interrupt. If the controller provides one
> +  interrupt for each GPIO, provide a list of interrupts that correspond to each
> +  of the GPIO pins. When specifying multiple interrupts, if any of the GPIOs are
> +  not connected to an interrupt, use the interrupt-mask property.
> +- interrupt-mask : a 32-bit bit mask that specifies which interrupts in the list
> +  of interrupts is valid, bit is 1 for a valid irq.

This is not a standard property and would need a vendor prefix. However, 
I'd prefer you just skip any not connected interrupts with an invalid 
interrupt number. Then the GPIO number is the index into "interrupts".

>  - snps,nr-gpios : The number of pins in the port, a single cell.

This BTW should be deprecated to use "nr-gpios" instead, but that's 
another patch.

>  - resets : Reset line for the controller.
>  
