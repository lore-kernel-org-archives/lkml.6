Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeEHRvk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 13:51:40 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37753 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeEHRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 13:51:38 -0400
X-Google-Smtp-Source: AB8JxZqNfBNx4g4gJ/4/uFCzz5I+NijtqqPXS2rBN4/rTO5Y1HWff//dm4nQ3BzvB5ZPF0cBWDO9tg==
Date: Tue, 8 May 2018 12:51:36 -0500
From: Rob Herring <robh@kernel.org>
To: Philipp Puschmann <pp@emlix.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, rydberg@bitmath.org,
        andi@etezian.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ili251x - add support for Ilitek ILI251x
 touchscreens
Message-ID: <20180508175136.GA26802@rob-hp-laptop>
References: <20180507131823.28800-1-pp@emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507131823.28800-1-pp@emlix.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 03:18:23PM +0200, Philipp Puschmann wrote:
> The driver supports at least the ili2511 chipset but may support other
> Ilitek chipsets using Ilitek i2c protocol v3.x.
> 
> The tested ili2511-based touchscreen delivers garbage for more than 6
> fingers while it should support up to 10 fingers. The reason is still
> unclear and this remains a FIXME in the driver for now.
> 
> The usage of pressure is optional. Touchscreens may deliver constant
> and so useless pressure data.
> 
> Signed-off-by: Philipp Puschmann <pp@emlix.com>
> ---
>  .../bindings/input/touchscreen/ili251x.txt    |  35 ++

Please make the binding a separate patch.

>  drivers/input/touchscreen/Kconfig             |  12 +
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/ili251x.c           | 350 ++++++++++++++++++
>  4 files changed, 398 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ili251x.txt
>  create mode 100644 drivers/input/touchscreen/ili251x.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ili251x.txt b/Documentation/devicetree/bindings/input/touchscreen/ili251x.txt
> new file mode 100644
> index 000000000000..f21ad93d3bdd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ili251x.txt
> @@ -0,0 +1,35 @@
> +Ilitek ili251x touchscreen driver

Bindings are not drivers.
> +
> +This driver uses protocol version 3 and should be compatible with other
> +Ilitek touch controllers that use protocol 3.x
> +
> +Required properties:
> + - compatible:  "ili251x"

Needs a vendor prefix.

Don't use wildcards in compatible strings. Maybe you want to incorporate 
the protocol version into the compatible string.

> + - reg:         I2C slave address of the chip (0x41)
> + - interrupt-parent: a phandle pointing to the interrupt controller
> +                     serving the interrupt for this chip
> + - interrupts:       interrupt specification for the touchdetect
> +                     interrupt
> +
> +Optional properties:
> + - reset-gpios: GPIO specification for the RESET input
> +
> + - pinctrl-names: should be "default"
> + - pinctrl-0:   a phandle pointing to the pin settings for the
> +                control gpios
> + - max-fingers: the maximum number of fingers to handle

We already have 'silead,max-fingers', so probably time for a common 
property.

> + - pressure: support pressure data

This should be implied by the compatible string.

> + - generic options	   : See touchscreen.txt
> +
> +Example:
> +
> +	ili251x@41 {

touchscreen@41

> +		compatible = "ili251x";
> +		reg = <0x41>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touchpanel>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <20 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
> +		max-fingers = <6>;
> +	};
