Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933044AbeBMAic (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 19:38:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51264 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932877AbeBMAia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 19:38:30 -0500
Subject: Re: [linux-sunxi] [PATCH v2 2/6] pinctrl: sunxi: add support for the
 Allwinner H6 main pin controller
To: icenowy@aosc.io, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-3-icenowy@aosc.io>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <53a9e1e5-7b5e-c0de-3e4e-48fdc0fb0fe8@arm.com>
Date: Tue, 13 Feb 2018 00:38:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180203154942.63566-3-icenowy@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/02/18 15:49, Icenowy Zheng wrote:
> The Allwinner H6 SoC has two pin controllers, one main controller
> (called CPUX-PORT in user manual) and one controller in CPUs power
> domain (called CPUS-PORT in user manual).

Leaving aside that I don't like this approach of stashing yet another
pile of data in the kernel ...

> This commit introduces support for the main pin controller on H6.

So I went through *every* single pin of port C, D, F, G and H and
compared your entries with the manual. Quite impressively, I couldn't
find any issues. Well done!

> The pin bank A and B are not wired out and hidden from the SoC's
> documents, however it's shown that the "ATE" (an AC200 chip
> co-packaged with the H6 die) is connected to the main SoC die via these
> pin banks. The information about these banks is just copied from the BSP
> pinctrl driver, but re-formatted to fit the mainline pinctrl driver
> format.

See below ...

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Dropped without_bus_gate description.
> - Switched to SPDX license identifier.
> 
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          | 676 +++++++++++++++++++++
>  4 files changed, 682 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> index 09789fdfa749..ed5eb547afc8 100644
> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
> @@ -27,6 +27,7 @@ Required properties:
>    "allwinner,sun50i-a64-pinctrl"
>    "allwinner,sun50i-a64-r-pinctrl"
>    "allwinner,sun50i-h5-pinctrl"
> +  "allwinner,sun50i-h6-pinctrl"
>    "nextthing,gr8-pinctrl"
>  
>  - reg: Should contain the register physical address and length for the
> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
> index bfce99d86dfc..5de1f63b07bb 100644
> --- a/drivers/pinctrl/sunxi/Kconfig
> +++ b/drivers/pinctrl/sunxi/Kconfig
> @@ -77,4 +77,8 @@ config PINCTRL_SUN50I_H5
>  	def_bool ARM64 && ARCH_SUNXI
>  	select PINCTRL_SUNXI
>  
> +config PINCTRL_SUN50I_H6
> +	def_bool ARM64 && ARCH_SUNXI
> +	select PINCTRL_SUNXI
> +
>  endif
> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
> index 12a752e836ef..3c4aec6611e9 100644
> --- a/drivers/pinctrl/sunxi/Makefile
> +++ b/drivers/pinctrl/sunxi/Makefile
> @@ -18,5 +18,6 @@ obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
>  obj-$(CONFIG_PINCTRL_SUN8I_H3_R)	+= pinctrl-sun8i-h3-r.o
>  obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
>  obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
> +obj-$(CONFIG_PINCTRL_SUN50I_H6)		+= pinctrl-sun50i-h6.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
>  obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
> new file mode 100644
> index 000000000000..f1f728e2f6d3
> --- /dev/null
> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
> @@ -0,0 +1,676 @@
> +/*
> + * Allwinner H6 SoC pinctrl driver.
> + *
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-sunxi.h"
> +
> +static const struct sunxi_desc_pin h6_pins[] = {
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),

So why is this? If those pins are hardwired to the ATE's EMAC port, why
do we have GPIOs here? Is that actually possible to configure these as
an input/output, then bitbanging those pins?
And even if that would be possible, what would be the reason for doing
so? Doesn't naming gpio_in and gpio_out here make them appear as
exportable GPIOs in sysfs (and other GPIO interfaces)? I don't think
this is desirable?
>From dumping the MMIO registers in U-Boot I see that those pins reset to
0x7 (disabled), so we need to expose function 0x2 here to wire them
through to the ATE. But I don't believe that having function 0x0 and 0x1
here is useful.

Cheers,
Andre.

> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ERXD1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ERXD0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ECRS_DV */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ERXERR */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ETXD1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ETXD0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ETXCK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* ETXEN */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* EMDC */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "emac")),		/* EMDIO */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 0)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DE */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 1)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* HSYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 2)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* VSYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 3)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 4)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 5)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO2 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 6)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 7)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO4 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 8)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO5 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 9)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO6 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 10)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ccir"),		/* DO7 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 11)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s3"),		/* SYNC */
> +		  SUNXI_FUNCTION(0x4, "h_i2s3"),	/* SYNC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 12)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s3"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "h_i2s3"),	/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 13)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s3"),		/* DOUT */
> +		  SUNXI_FUNCTION(0x4, "h_i2s3"),	/* DOUT */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 14)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s3"),		/* DIN */
> +		  SUNXI_FUNCTION(0x4, "h_i2s3"),	/* DIN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 15)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 16),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s3"),		/* MCLK */
> +		  SUNXI_FUNCTION(0x4, "h_i2s3"),	/* MCLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 16)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 17),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SCK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 17)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 18),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c3"),		/* SDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 18)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 19),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "pwm1"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 19)),
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 20),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 0, 20)),
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* WE */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* CLK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* ALE */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* DS */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* CLE */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* MOSI */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* CE0 */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* MISO */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* RE */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* CLK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* RB0 */
> +		  SUNXI_FUNCTION(0x3, "mmc2"),		/* CMD */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* CS */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ0 */
> +		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D0 */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* HOLD */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ1 */
> +		  SUNXI_FUNCTION(0x3, "mmc2"),		/* D1 */
> +		  SUNXI_FUNCTION(0x4, "spi0")),		/* WP */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ2 */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ3 */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ4 */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ5 */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ6 */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQ7 */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* D7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0"),		/* DQS */
> +		  SUNXI_FUNCTION(0x3, "mmc2")),		/* RST */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0")),	/* CE1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(C, 16),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "nand0")),	/* RB1 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D2 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* PCLK */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ERXD3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D3 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* ERR */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* MCLK */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ERXD2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D4 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* SYNC */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* HSYNC */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ERXD1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D5 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* DVLD */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* VSYNC */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ERXD0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D6 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D0 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D0 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ERXCK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D7 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D1 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D1 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ERXCTL */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D10 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D2 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D2 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ENULL */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D11 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D3 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D3 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ETXD3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D12 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D4 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D4 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ETXD2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D13 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D5 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D5 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ETXD1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D14 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D6 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D6 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ETXD0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D15 */
> +		  SUNXI_FUNCTION(0x3, "ts0"),		/* D7 */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* D7 */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ETXCK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D18 */
> +		  SUNXI_FUNCTION(0x3, "ts1"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* SCK */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ETXCTL */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D19 */
> +		  SUNXI_FUNCTION(0x3, "ts1"),		/* ERR */
> +		  SUNXI_FUNCTION(0x4, "csi"),		/* SDA */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* ECLKIN */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D20 */
> +		  SUNXI_FUNCTION(0x3, "ts1"),		/* SYNC */
> +		  SUNXI_FUNCTION(0x4, "dmic"),		/* CLK */
> +		  SUNXI_FUNCTION(0x5, "csi")),		/* D8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 15),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D21 */
> +		  SUNXI_FUNCTION(0x3, "ts1"),		/* DVLD */
> +		  SUNXI_FUNCTION(0x4, "dmic"),		/* DATA0 */
> +		  SUNXI_FUNCTION(0x5, "csi")),		/* D9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 16),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D22 */
> +		  SUNXI_FUNCTION(0x3, "ts1"),		/* D0 */
> +		  SUNXI_FUNCTION(0x4, "dmic")),		/* DATA1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 17),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* D23 */
> +		  SUNXI_FUNCTION(0x3, "ts2"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "dmic")),		/* DATA2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 18),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* CLK */
> +		  SUNXI_FUNCTION(0x3, "ts2"),		/* ERR */
> +		  SUNXI_FUNCTION(0x4, "dmic")),		/* DATA3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 19),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* DE */
> +		  SUNXI_FUNCTION(0x3, "ts2"),		/* SYNC */
> +		  SUNXI_FUNCTION(0x4, "uart2"),		/* TX */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* EMDC */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 20),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* HSYNC */
> +		  SUNXI_FUNCTION(0x3, "ts2"),		/* DVLD */
> +		  SUNXI_FUNCTION(0x4, "uart2"),		/* RX */
> +		  SUNXI_FUNCTION(0x5, "emac")),		/* EMDIO */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 21),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "lcd0"),		/* VSYNC */
> +		  SUNXI_FUNCTION(0x3, "ts2"),		/* D0 */
> +		  SUNXI_FUNCTION(0x4, "uart2")),	/* RTS */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 22),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "pwm"),		/* PWM0 */
> +		  SUNXI_FUNCTION(0x3, "ts3"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "uart2")),	/* CTS */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 23),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c2"),		/* SCK */
> +		  SUNXI_FUNCTION(0x3, "ts3"),		/* ERR */
> +		  SUNXI_FUNCTION(0x4, "uart3"),		/* TX */
> +		  SUNXI_FUNCTION(0x5, "jtag")),		/* MS */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 24),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c2"),		/* SDA */
> +		  SUNXI_FUNCTION(0x3, "ts3"),		/* SYNC */
> +		  SUNXI_FUNCTION(0x4, "uart3"),		/* RX */
> +		  SUNXI_FUNCTION(0x5, "jtag")),		/* CK */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 25),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SCK */
> +		  SUNXI_FUNCTION(0x3, "ts3"),		/* DVLD */
> +		  SUNXI_FUNCTION(0x4, "uart3"),		/* RTS */
> +		  SUNXI_FUNCTION(0x5, "jtag")),		/* DO */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 26),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2c0"),		/* SDA */
> +		  SUNXI_FUNCTION(0x3, "ts3"),		/* D0 */
> +		  SUNXI_FUNCTION(0x4, "uart3"),		/* CTS */
> +		  SUNXI_FUNCTION(0x5, "jtag")),		/* DI */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D1 */
> +		  SUNXI_FUNCTION(0x3, "jtag"),		/* MS */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 0)),	/* PF_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D0 */
> +		  SUNXI_FUNCTION(0x3, "jtag"),		/* DI */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 1)),	/* PF_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CLK */
> +		  SUNXI_FUNCTION(0x3, "uart0"),		/* TX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 2)),	/* PF_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc0"),		/* CMD */
> +		  SUNXI_FUNCTION(0x3, "jtag"),		/* DO */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 3)),	/* PF_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D3 */
> +		  SUNXI_FUNCTION(0x3, "uart0"),		/* RX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 4)),	/* PF_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc0"),		/* D2 */
> +		  SUNXI_FUNCTION(0x3, "jtag"),		/* CK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 5)),	/* PF_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(F, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 1, 6)),	/* PF_EINT6 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 0)),	/* PG_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1"),		/* CMD */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 1)),	/* PG_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D0 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 2)),	/* PG_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D1 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 3)),	/* PG_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D2 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 4)),	/* PG_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "mmc1"),		/* D3 */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 5)),	/* PG_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* TX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 6)),	/* PG_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* RX */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 7)),	/* PG_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* RTS */
> +		  SUNXI_FUNCTION(0x4, "sim0"),		/* VPPEN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 8)),	/* PG_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart1"),		/* CTS */
> +		  SUNXI_FUNCTION(0x4, "sim0"),		/* VPPPP */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 9)),	/* PG_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s2"),		/* SYNC */
> +		  SUNXI_FUNCTION(0x3, "h_i2s2"),	/* SYNC */
> +		  SUNXI_FUNCTION(0x4, "sim0"),		/* PWREN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 10)),	/* PG_EINT10 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 11),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s2"),		/* CLK */
> +		  SUNXI_FUNCTION(0x3, "h_i2s2"),	/* CLK */
> +		  SUNXI_FUNCTION(0x4, "sim0"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* PG_EINT11 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 12),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s2"),		/* DOUT */
> +		  SUNXI_FUNCTION(0x3, "h_i2s2"),	/* DOUT */
> +		  SUNXI_FUNCTION(0x4, "sim0"),		/* DATA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 12)),	/* PG_EINT12 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 13),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s2"),		/* DIN */
> +		  SUNXI_FUNCTION(0x3, "h_i2s2"),	/* DIN */
> +		  SUNXI_FUNCTION(0x4, "sim0"),		/* RST */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 13)),	/* PG_EINT13 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(G, 14),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "i2s2"),		/* MCLK */
> +		  SUNXI_FUNCTION(0x3, "h_i2s2"),	/* MCLK */
> +		  SUNXI_FUNCTION(0x4, "sim0"),		/* DET */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 14)),	/* PG_EINT14 */
> +	/* Hole */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 0),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart0"),		/* TX */
> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* SYNC */
> +		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* SYNC */
> +		  SUNXI_FUNCTION(0x5, "sim1"),		/* VPPEN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 0)),	/* PH_EINT0 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 1),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "uart0"),		/* RX */
> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* CLK */
> +		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* CLK */
> +		  SUNXI_FUNCTION(0x5, "sim1"),		/* VPPPP */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 1)),	/* PH_EINT1 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 2),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "ir_tx"),
> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* DOUT */
> +		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* DOUT */
> +		  SUNXI_FUNCTION(0x5, "sim1"),		/* PWREN */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 2)),	/* PH_EINT2 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 3),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "spi1"),		/* CS */
> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* DIN */
> +		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* DIN */
> +		  SUNXI_FUNCTION(0x5, "sim1"),		/* CLK */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 3)),	/* PH_EINT3 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 4),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "spi1"),		/* CLK */
> +		  SUNXI_FUNCTION(0x3, "i2s0"),		/* MCLK */
> +		  SUNXI_FUNCTION(0x4, "h_i2s0"),	/* MCLK */
> +		  SUNXI_FUNCTION(0x5, "sim1"),		/* DATA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 4)),	/* PH_EINT4 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 5),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "spi1"),		/* MOSI */
> +		  SUNXI_FUNCTION(0x3, "spdif"),		/* MCLK */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SCK */
> +		  SUNXI_FUNCTION(0x5, "sim1"),		/* RST */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 5)),	/* PH_EINT5 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 6),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "spi1"),		/* MISO */
> +		  SUNXI_FUNCTION(0x3, "spdif"),		/* IN */
> +		  SUNXI_FUNCTION(0x4, "i2c1"),		/* SDA */
> +		  SUNXI_FUNCTION(0x5, "sim1"),		/* DET */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 6)),	/* PH_EINT6 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 7),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x3, "spdif"),		/* OUT */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 7)),	/* PH_EINT7 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 8),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "hdmi"),		/* HSCL */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 8)),	/* PH_EINT8 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 9),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "hdmi"),		/* HSDA */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 9)),	/* PH_EINT9 */
> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(H, 10),
> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> +		  SUNXI_FUNCTION(0x2, "hdmi"),		/* HCEC */
> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 3, 10)),	/* PH_EINT10 */
> +};
> +
> +static const unsigned int h6_irq_bank_map[] = { 1, 5, 6, 7 };
> +
> +static const struct sunxi_pinctrl_desc h6_pinctrl_data = {
> +	.pins = h6_pins,
> +	.npins = ARRAY_SIZE(h6_pins),
> +	.irq_banks = 3,
> +	.irq_bank_map = h6_irq_bank_map,
> +	.irq_read_needs_mux = true,
> +};
> +
> +static int h6_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return sunxi_pinctrl_init(pdev,
> +				  &h6_pinctrl_data);
> +}
> +
> +static const struct of_device_id h6_pinctrl_match[] = {
> +	{ .compatible = "allwinner,sun50i-h6-pinctrl", },
> +	{}
> +};
> +
> +static struct platform_driver h6_pinctrl_driver = {
> +	.probe	= h6_pinctrl_probe,
> +	.driver	= {
> +		.name		= "sun50i-h6-pinctrl",
> +		.of_match_table	= h6_pinctrl_match,
> +	},
> +};
> +builtin_platform_driver(h6_pinctrl_driver);
> 
