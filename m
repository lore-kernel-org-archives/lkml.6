Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755467AbeEaP0q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:26:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755478AbeEaP0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:26:38 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org,
        boris.brezillon@bootlin.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, robh+dt@kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1527251668-31396-3-git-send-email-codrin.ciubotariu@microchip.com>
Cc: Cristian.Birsan@microchip.com
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-3-git-send-email-codrin.ciubotariu@microchip.com>
Message-ID: <152778039660.144038.4743783065942615925@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/7] clk: at91: add I2S clock mux driver
Date: Thu, 31 May 2018 08:26:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VFQm3s020029

Quoting Codrin Ciubotariu (2018-05-25 05:34:23)
> This driver is a simple muxing driver that controls the
> I2S's clock input by using syscon/regmap to change the parrent.

s/parrent/parent/

> The available inputs can be Peripheral clock and Generated clock.

Why capitalize peripheral and generated?

> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 1254bf9..903f23c 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -27,6 +27,7 @@ config SOC_SAMA5D2
>         select HAVE_AT91_H32MX
>         select HAVE_AT91_GENERATED_CLK
>         select HAVE_AT91_AUDIO_PLL
> +       select HAVE_AT91_I2S_MUX_CLK
>         select PINCTRL_AT91PIO4
>         help
>           Select this if ou are using one of Microchip's SAMA5D2 family SoC.
> @@ -129,6 +130,9 @@ config HAVE_AT91_GENERATED_CLK
>  config HAVE_AT91_AUDIO_PLL
>         bool
>  
> +config HAVE_AT91_I2S_MUX_CLK
> +       bool
> +
>  config SOC_SAM_V4_V5
>         bool
>  

I guess this is OK.

> diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
> index 082596f..facc169 100644
> --- a/drivers/clk/at91/Makefile
> +++ b/drivers/clk/at91/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_HAVE_AT91_USB_CLK)               += clk-usb.o
>  obj-$(CONFIG_HAVE_AT91_SMD)            += clk-smd.o
>  obj-$(CONFIG_HAVE_AT91_H32MX)          += clk-h32mx.o
>  obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)  += clk-generated.o
> +obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)    += clk-i2s-mux.o
> diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
> new file mode 100644
> index 0000000..2d56ded
> --- /dev/null
> +++ b/drivers/clk/at91/clk-i2s-mux.c
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2018 Microchip Technology Inc,
> + *                     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> + *
> + *
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <soc/at91/atmel-sfr.h>
> +
> +#define        I2S_BUS_NR      2
> +
> +struct clk_i2s_mux {
> +       struct clk_hw hw;
> +       struct regmap *regmap;
> +       u32 bus_id;

Can be a u8?

> +};
> +
> +#define to_clk_i2s_mux(hw) container_of(hw, struct clk_i2s_mux, hw)
> +
> +static u8 clk_i2s_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct clk_i2s_mux *mux = to_clk_i2s_mux(hw);
> +       u32 val;
> +
> +       regmap_read(mux->regmap, AT91_SFR_I2SCLKSEL, &val);
> +
> +       return (val & BIT(mux->bus_id)) >> mux->bus_id;
> +}
> +
> +static int clk_i2s_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct clk_i2s_mux *mux = to_clk_i2s_mux(hw);
> +
> +       return regmap_update_bits(mux->regmap, AT91_SFR_I2SCLKSEL,
> +                                 BIT(mux->bus_id), index << mux->bus_id);
> +}
> +
> +const struct clk_ops clk_i2s_mux_ops = {

static?

> +       .get_parent = clk_i2s_mux_get_parent,
> +       .set_parent = clk_i2s_mux_set_parent,
> +       .determine_rate = __clk_mux_determine_rate,
> +};
> +
> +static struct clk_hw * __init
> +at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
> +                         const char * const *parent_names,
> +                         unsigned int num_parents, u32 bus_id)
> +{
> +       struct clk_init_data init = {};
> +       struct clk_i2s_mux *i2s_ck;
> +       int ret;
> +
> +       i2s_ck = kzalloc(sizeof(*i2s_ck), GFP_KERNEL);
> +       if (!i2s_ck)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &clk_i2s_mux_ops;
> +       init.parent_names = parent_names;
> +       init.num_parents = num_parents;
> +       init.flags = CLK_IGNORE_UNUSED;

Really? Why?

> +
> +       i2s_ck->hw.init = &init;
> +       i2s_ck->bus_id = bus_id;
> +       i2s_ck->regmap = regmap;
> +
> +       ret = clk_hw_register(NULL, &i2s_ck->hw);
> +       if (ret) {
> +               kfree(i2s_ck);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return &i2s_ck->hw;
> +}
