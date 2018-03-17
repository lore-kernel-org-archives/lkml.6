Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeCQBEh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 21:04:37 -0400
Received: from mailoutvs4.siol.net ([213.250.19.137]:39530 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeCQBEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 21:04:34 -0400
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH v4 7/9] clk: sunxi-ng: add support for the Allwinner H6 CCU
Date: Sat, 17 Mar 2018 01:57:34 +0100
Message-ID: <1577280.FZNre3TR2r@jernej-laptop>
In-Reply-To: <20180316140215.28663-8-icenowy@aosc.io>
References: <20180316140215.28663-1-icenowy@aosc.io> <20180316140215.28663-8-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne petek, 16. marec 2018 ob 15:02:13 CET je Icenowy Zheng napisal(a):
> The Allwinner H6 SoC has a CCU which has been largely rearranged.
> 
> Add support for it in the sunxi-ng CCU framework.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
> Changes in v4:
> - Extract the device tree binding document to another patch.
> 
> Changes in v3:
> - SPDX license idetifier fix.
> - Add some comments at initialization.
> 
> Changes in v2:
> - Exported APB1 bus clock for PIO.
> - Switch to SPDX license identifier.
> 
>  drivers/clk/sunxi-ng/Kconfig              |    5 +
>  drivers/clk/sunxi-ng/Makefile             |    1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c      | 1207
> +++++++++++++++++++++++++++++ drivers/clk/sunxi-ng/ccu-sun50i-h6.h      |  
> 56 ++
>  include/dt-bindings/clock/sun50i-h6-ccu.h |  124 +++
>  include/dt-bindings/reset/sun50i-h6-ccu.h |   73 ++
>  6 files changed, 1466 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h6.h
>  create mode 100644 include/dt-bindings/clock/sun50i-h6-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-h6-ccu.h
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 33168f94ee39..79dfd296c3d1 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -11,6 +11,11 @@ config SUN50I_A64_CCU
>  	default ARM64 && ARCH_SUNXI
>  	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> 
> +config SUN50I_H6_CCU
> +	bool "Support for the Allwinner H6 CCU"
> +	default ARM64 && ARCH_SUNXI
> +	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +
>  config SUN4I_A10_CCU
>  	bool "Support for the Allwinner A10/A20 CCU"
>  	default MACH_SUN4I
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 4141c3fe08ae..128a40ee5c5e 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -22,6 +22,7 @@ lib-$(CONFIG_SUNXI_CCU)		+= ccu_mp.o
> 
>  # SoC support
>  obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
> +obj-$(CONFIG_SUN50I_H6_CCU)	+= ccu-sun50i-h6.o
>  obj-$(CONFIG_SUN4I_A10_CCU)	+= ccu-sun4i-a10.o
>  obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
>  obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c new file mode 100644
> index 000000000000..d5eab49e6350
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -0,0 +1,1207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_mult.h"
> +#include "ccu_nk.h"
> +#include "ccu_nkm.h"
> +#include "ccu_nkmp.h"
> +#include "ccu_nm.h"
> +
> +#include "ccu-sun50i-h6.h"
> +
> +/*
> + * The CPU PLL is actually NP clock, with P being /1, /2 or /4. However
> + * P should only be used for output frequencies lower than 288 MHz.
> + *
> + * For now we can just model it as a multiplier clock, and force P to /1.
> + *
> + * The M factor is present in the register's description, but not in the
> + * frequency formula, and it's documented as "M is only used for backdoor
> + * testing", so it's not modelled and then force to 0.
> + */
> +#define SUN50I_H6_PLL_CPUX_REG		0x000
> +static struct ccu_mult pll_cpux_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.mult		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.common		= {
> +		.reg		= 0x000,
> +		.hw.init	= CLK_HW_INIT("pll-cpux", "osc24M",
> +					      &ccu_mult_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
> +#define SUN50I_H6_PLL_DDR0_REG		0x010
> +static struct ccu_nkmp pll_ddr0_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		= {
> +		.reg		= 0x010,
> +		.hw.init	= CLK_HW_INIT("pll-ddr0", "osc24M",
> +					      &ccu_nkmp_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +#define SUN50I_H6_PLL_PERIPH0_REG	0x020
> +static struct ccu_nkmp pll_periph0_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.fixed_post_div	= 4,
> +	.common		= {
> +		.reg		= 0x020,
> +		.features	= CCU_FEATURE_FIXED_POSTDIV,
> +		.hw.init	= CLK_HW_INIT("pll-periph0", "osc24M",
> +					      &ccu_nkmp_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +#define SUN50I_H6_PLL_PERIPH1_REG	0x028
> +static struct ccu_nkmp pll_periph1_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.fixed_post_div	= 4,
> +	.common		= {
> +		.reg		= 0x028,
> +		.features	= CCU_FEATURE_FIXED_POSTDIV,
> +		.hw.init	= CLK_HW_INIT("pll-periph1", "osc24M",
> +					      &ccu_nkmp_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +#define SUN50I_H6_PLL_GPU_REG		0x030
> +static struct ccu_nkmp pll_gpu_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		= {
> +		.reg		= 0x030,
> +		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
> +					      &ccu_nkmp_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +/*
> + * For Video PLLs, the output divider is described as "used for testing"
> + * in the user manual. So it's not modelled and forced to 0.
> + */
> +#define SUN50I_H6_PLL_VIDEO0_REG	0x040
> +static struct ccu_nm pll_video0_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.fixed_post_div	= 4,
> +	.common		= {
> +		.reg		= 0x040,
> +		.features	= CCU_FEATURE_FIXED_POSTDIV,
> +		.hw.init	= CLK_HW_INIT("pll-video0", "osc24M",
> +					      &ccu_nm_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +#define SUN50I_H6_PLL_VIDEO1_REG	0x048
> +static struct ccu_nm pll_video1_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.fixed_post_div	= 4,
> +	.common		= {
> +		.reg		= 0x048,
> +		.features	= CCU_FEATURE_FIXED_POSTDIV,
> +		.hw.init	= CLK_HW_INIT("pll-video1", "osc24M",
> +					      &ccu_nm_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +#define SUN50I_H6_PLL_VE_REG		0x058
> +static struct ccu_nkmp pll_ve_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		= {
> +		.reg		= 0x058,
> +		.hw.init	= CLK_HW_INIT("pll-ve", "osc24M",
> +					      &ccu_nkmp_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +#define SUN50I_H6_PLL_DE_REG		0x060
> +static struct ccu_nkmp pll_de_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		= {
> +		.reg		= 0x060,
> +		.hw.init	= CLK_HW_INIT("pll-de", "osc24M",
> +					      &ccu_nkmp_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +#define SUN50I_H6_PLL_HSIC_REG		0x070
> +static struct ccu_nkmp pll_hsic_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		= {
> +		.reg		= 0x070,
> +		.hw.init	= CLK_HW_INIT("pll-hsic", "osc24M",
> +					      &ccu_nkmp_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +/*
> + * The Audio PLL is supposed to have 3 outputs: 2 fixed factors from
> + * the base (2x and 4x), and one variable divider (the one true pll audio).
> + *
> + * We don't have any need for the variable divider for now, so we just
> + * hardcode it to match with the clock names.
> + */
> +#define SUN50I_H6_PLL_AUDIO_REG		0x078
> +static struct ccu_nm pll_audio_base_clk = {
> +	.enable		= BIT(31),
> +	.lock		= BIT(28),
> +	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
> +	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		= {
> +		.reg		= 0x078,
> +		.hw.init	= CLK_HW_INIT("pll-audio-base", "osc24M",
> +					      &ccu_nm_ops,
> +					      CLK_SET_RATE_UNGATE),
> +	},
> +};
> +
> +static const char * const cpux_parents[] = { "osc24M", "osc32k",
> +					     "iosc", "pll-cpux" };
> +static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
> +		     0x500, 24, 2, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> +static SUNXI_CCU_M(axi_clk, "axi", "cpux", 0x500, 0, 2, 0);
> +static SUNXI_CCU_M(cpux_apb_clk, "cpux-apb", "cpux", 0x500, 8, 2, 0);
> +
> +static const char * const psi_ahb1_ahb2_parents[] = { "osc24M", "osc32k",
> +						      "iosc", "pll-periph0" };
> +static SUNXI_CCU_MP_WITH_MUX(psi_ahb1_ahb2_clk, "psi-ahb1-ahb2",
> +			     psi_ahb1_ahb2_parents,
> +			     0x510,
> +			     0, 5,	/* M */
> +			     16, 2,	/* P */
> +			     24, 2,	/* mux */
> +			     0);
> +
> +static const char * const ahb3_apb1_apb2_parents[] = { "osc24M", "osc32k",
> +						       "psi-ahb1-ahb2",
> +						       "pll-periph0" };
> +static SUNXI_CCU_MP_WITH_MUX(ahb3_clk, "ahb3", ahb3_apb1_apb2_parents,
> 0x51c, +			     0, 5,	/* M */
> +			     16, 2,	/* P */
> +			     24, 2,	/* mux */
> +			     0);
> +
> +static SUNXI_CCU_MP_WITH_MUX(apb1_clk, "apb1", ahb3_apb1_apb2_parents,
> 0x520, +			     0, 5,	/* M */
> +			     16, 2,	/* P */
> +			     24, 2,	/* mux */
> +			     0);
> +
> +static SUNXI_CCU_MP_WITH_MUX(apb2_clk, "apb2", ahb3_apb1_apb2_parents,
> 0x524, +			     0, 5,	/* M */
> +			     16, 2,	/* P */
> +			     24, 2,	/* mux */
> +			     0);
> +
> +static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x",
> +					     "pll-ddr0", "pll-periph0-4x" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents, 0x540,
> +				       0, 3,	/* M */
> +				       24, 2,	/* mux */
> +				       BIT(31),	/* gate */
> +				       CLK_IS_CRITICAL);
> +
> +static const char * const de_parents[] = { "pll-de", "pll-periph0-2x" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
> +				       0, 4,	/* M */
> +				       24, 1,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_GATE(bus_de_clk, "bus-de", "psi-ahb1-ahb2",
> +		      0x60c, BIT(0), 0);
> +
> +static const char * const deinterlace_parents[] = { "pll-periph0",
> +						    "pll-periph1" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace",
> +				       deinterlace_parents,
> +				       0x620,
> +				       0, 4,	/* M */
> +				       24, 1,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_GATE(bus_deinterlace_clk, "bus-deinterlace",
> "psi-ahb1-ahb2", +		      0x62c, BIT(0), 0);
> +
> +static const char * const gpu_parents[] = { "pll-gpu" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> +				       0, 3,	/* M */
> +				       24, 1,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
> +		      0x67c, BIT(0), 0);
> +
> +/* Also applies to EMCE */
> +static const char * const ce_parents[] = { "osc24M", "pll-periph0-2x" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 1,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_GATE(bus_ce_clk, "bus-ce", "psi-ahb1-ahb2",
> +		      0x68c, BIT(0), 0);
> +
> +static const char * const ve_parents[] = { "pll-ve" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
> +				       0, 3,	/* M */
> +				       24, 1,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_GATE(bus_ve_clk, "bus-ve", "psi-ahb1-ahb2",
> +		      0x69c, BIT(0), 0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(emce_clk, "emce", ce_parents, 0x6b0,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 1,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_GATE(bus_emce_clk, "bus-emce", "psi-ahb1-ahb2",
> +		      0x6bc, BIT(0), 0);
> +
> +static const char * const vp9_parents[] = { "pll-ve", "pll-periph0-2x" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(vp9_clk, "vp9", vp9_parents, 0x6c0,
> +				       0, 3,	/* M */
> +				       24, 1,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_GATE(bus_vp9_clk, "bus-vp9", "psi-ahb1-ahb2",
> +		      0x6cc, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(bus_dma_clk, "bus-dma", "psi-ahb1-ahb2",
> +		      0x70c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(bus_msgbox_clk, "bus-msgbox", "psi-ahb1-ahb2",
> +		      0x71c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(bus_spinlock_clk, "bus-spinlock", "psi-ahb1-ahb2",
> +		      0x72c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(bus_hstimer_clk, "bus-hstimer", "psi-ahb1-ahb2",
> +		      0x73c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(avs_clk, "avs", "osc24M", 0x740, BIT(31), 0);
> +
> +static SUNXI_CCU_GATE(bus_dbg_clk, "bus-dbg", "psi-ahb1-ahb2",
> +		      0x78c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(bus_psi_clk, "bus-psi", "psi-ahb1-ahb2",
> +		      0x79c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(bus_pwm_clk, "bus-pwm", "apb1", 0x79c, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE(bus_iommu_clk, "bus-iommu", "apb1", 0x7bc, BIT(0),
> 0); +
> +static const char * const dram_parents[] = { "pll-ddr0" };
> +static struct ccu_div dram_clk = {
> +	.div		= _SUNXI_CCU_DIV(0, 2),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common	= {
> +		.reg		= 0x800,
> +		.hw.init	= CLK_HW_INIT_PARENTS("dram",
> +						      dram_parents,
> +						      &ccu_div_ops,
> +						      CLK_IS_CRITICAL),
> +	},
> +};
> +
> +static SUNXI_CCU_GATE(mbus_dma_clk, "mbus-dma", "mbus",
> +		      0x804, BIT(0), 0);
> +static SUNXI_CCU_GATE(mbus_ve_clk, "mbus-ve", "mbus",
> +		      0x804, BIT(1), 0);
> +static SUNXI_CCU_GATE(mbus_ce_clk, "mbus-ce", "mbus",
> +		      0x804, BIT(2), 0);
> +static SUNXI_CCU_GATE(mbus_ts_clk, "mbus-ts", "mbus",
> +		      0x804, BIT(3), 0);
> +static SUNXI_CCU_GATE(mbus_nand_clk, "mbus-nand", "mbus",
> +		      0x804, BIT(5), 0);
> +static SUNXI_CCU_GATE(mbus_csi_clk, "mbus-csi", "mbus",
> +		      0x804, BIT(8), 0);
> +static SUNXI_CCU_GATE(mbus_deinterlace_clk, "mbus-deinterlace", "mbus",
> +		      0x804, BIT(11), 0);
> +
> +static SUNXI_CCU_GATE(bus_dram_clk, "bus-dram", "psi-ahb1-ahb2",
> +		      0x80c, BIT(0), CLK_IS_CRITICAL);
> +
> +static const char * const nand_spi_parents[] = { "osc24M", "pll-periph0",
> +					     "pll-periph1", "pll-periph0-2x",
> +					     "pll-periph1-2x" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(nand0_clk, "nand0", nand_spi_parents,
> 0x810, +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(nand1_clk, "nand1", nand_spi_parents,
> 0x814, +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand", "ahb3", 0x82c, BIT(0), 0);
> +
> +static const char * const mmc_parents[] = { "osc24M", "pll-periph0-2x",
> +					    "pll-periph1-2x" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc_parents, 0x830,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc_parents, 0x834,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc_parents, 0x838,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c, BIT(1), 0);
> +static SUNXI_CCU_GATE(bus_mmc2_clk, "bus-mmc2", "ahb3", 0x84c, BIT(2), 0);
> +
> +static SUNXI_CCU_GATE(bus_uart0_clk, "bus-uart0", "apb2", 0x90c, BIT(0),
> 0); +static SUNXI_CCU_GATE(bus_uart1_clk, "bus-uart1", "apb2", 0x90c,
> BIT(1), 0); +static SUNXI_CCU_GATE(bus_uart2_clk, "bus-uart2", "apb2",
> 0x90c, BIT(2), 0); +static SUNXI_CCU_GATE(bus_uart3_clk, "bus-uart3",
> "apb2", 0x90c, BIT(3), 0); +
> +static SUNXI_CCU_GATE(bus_i2c0_clk, "bus-i2c0", "apb2", 0x91c, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_i2c1_clk, "bus-i2c1", "apb2", 0x91c, BIT(1), 0);
> +static SUNXI_CCU_GATE(bus_i2c2_clk, "bus-i2c2", "apb2", 0x91c, BIT(2), 0);
> +static SUNXI_CCU_GATE(bus_i2c3_clk, "bus-i2c3", "apb2", 0x91c, BIT(3), 0);
> +
> +static SUNXI_CCU_GATE(bus_scr0_clk, "bus-scr0", "apb2", 0x93c, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_scr1_clk, "bus-scr1", "apb2", 0x93c, BIT(1), 0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(spi0_clk, "spi0", nand_spi_parents,
> 0x940, +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(spi1_clk, "spi1", nand_spi_parents,
> 0x944, +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_GATE(bus_spi0_clk, "bus-spi0", "ahb3", 0x96c, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_spi1_clk, "bus-spi1", "ahb3", 0x96c, BIT(1), 0);
> +
> +static SUNXI_CCU_GATE(bus_emac_clk, "bus-emac", "ahb3", 0x97c, BIT(0), 0);
> +
> +static const char * const ts_parents[] = { "osc24M", "pll-periph0" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x9b0,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 1,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_GATE(bus_ts_clk, "bus-ts", "ahb3", 0x9bc, BIT(0), 0);
> +
> +static const char * const ir_tx_parents[] = { "osc32k", "osc24M" };
> +static SUNXI_CCU_MP_WITH_MUX_GATE(ir_tx_clk, "ir-tx", ir_tx_parents, 0x9c0,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 1,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_GATE(bus_ir_tx_clk, "bus-ir-tx", "apb1", 0x9cc, BIT(0),
> 0); +
> +static SUNXI_CCU_GATE(bus_ths_clk, "bus-ths", "apb1", 0x9fc, BIT(0), 0);
> +
> +static const char * const audio_parents[] = { "pll-audio", "pll-audio-2x",
> "pll-audio-4x" }; +static struct ccu_div i2s3_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common		= {
> +		.reg		= 0xa0c,
> +		.hw.init	= CLK_HW_INIT_PARENTS("i2s3",
> +						      audio_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static struct ccu_div i2s0_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common		= {
> +		.reg		= 0xa10,
> +		.hw.init	= CLK_HW_INIT_PARENTS("i2s0",
> +						      audio_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static struct ccu_div i2s1_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common		= {
> +		.reg		= 0xa14,
> +		.hw.init	= CLK_HW_INIT_PARENTS("i2s1",
> +						      audio_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static struct ccu_div i2s2_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common		= {
> +		.reg		= 0xa18,
> +		.hw.init	= CLK_HW_INIT_PARENTS("i2s2",
> +						      audio_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static SUNXI_CCU_GATE(bus_i2s0_clk, "bus-i2s0", "apb1", 0xa1c, BIT(0), 0);
> +static SUNXI_CCU_GATE(bus_i2s1_clk, "bus-i2s1", "apb1", 0xa1c, BIT(1), 0);
> +static SUNXI_CCU_GATE(bus_i2s2_clk, "bus-i2s2", "apb1", 0xa1c, BIT(2), 0);
> +static SUNXI_CCU_GATE(bus_i2s3_clk, "bus-i2s3", "apb1", 0xa1c, BIT(3), 0);
> +
> +static struct ccu_div spdif_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common		= {
> +		.reg		= 0xa20,
> +		.hw.init	= CLK_HW_INIT_PARENTS("spdif",
> +						      audio_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static SUNXI_CCU_GATE(bus_spdif_clk, "bus-spdif", "apb1", 0xa2c, BIT(0),
> 0); +
> +static struct ccu_div dmic_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common		= {
> +		.reg		= 0xa40,
> +		.hw.init	= CLK_HW_INIT_PARENTS("dmic",
> +						      audio_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static SUNXI_CCU_GATE(bus_dmic_clk, "bus-dmic", "apb1", 0xa4c, BIT(0), 0);
> +
> +static struct ccu_div audio_hub_clk = {
> +	.enable		= BIT(31),
> +	.div		= _SUNXI_CCU_DIV_FLAGS(8, 2, CLK_DIVIDER_POWER_OF_TWO),
> +	.mux		= _SUNXI_CCU_MUX(24, 2),
> +	.common		= {
> +		.reg		= 0xa60,
> +		.hw.init	= CLK_HW_INIT_PARENTS("audio-hub",
> +						      audio_parents,
> +						      &ccu_div_ops,
> +						      0),
> +	},
> +};
> +
> +static SUNXI_CCU_GATE(bus_audio_hub_clk, "bus-audio-hub", "apb1", 0xa6c,
> BIT(0), 0); +
> +/*
> + * There are OHCI 12M clock source selection bits for 2 USB 2.0 ports.
> + * We will force them to 0 (12M divided from 48M).
> + */
> +#define SUN50I_H6_USB0_CLK_REG		0xa70
> +#define SUN50I_H6_USB3_CLK_REG		0xa7c
> +
> +static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc12M", 0xa70, BIT(31),
> 0); +static SUNXI_CCU_GATE(usb_phy0_clk, "usb-phy0", "osc24M", 0xa70,
> BIT(29), 0); +
> +static SUNXI_CCU_GATE(usb_phy1_clk, "usb-phy1", "osc24M", 0xa74, BIT(29),
> 0); +
> +static SUNXI_CCU_GATE(usb_ohci3_clk, "usb-ohci3", "osc12M", 0xa7c, BIT(31),
> 0); +static SUNXI_CCU_GATE(usb_phy3_clk, "usb-phy3", "osc12M", 0xa7c,
> BIT(29), 0); +static SUNXI_CCU_GATE(usb_hsic_12m_clk, "usb-hsic-12M",
> "osc12M", 0xa7c, BIT(27), 0); +static SUNXI_CCU_GATE(usb_hsic_clk,
> "usb-hsic", "pll-hsic", 0xa7c, BIT(26), 0); +
> +static SUNXI_CCU_GATE(bus_ohci0_clk, "bus-ohci0", "ahb3", 0xa8c, BIT(0),
> 0); +static SUNXI_CCU_GATE(bus_ohci3_clk, "bus-ohci3", "ahb3", 0xa8c,
> BIT(3), 0); +static SUNXI_CCU_GATE(bus_ehci0_clk, "bus-ehci0", "ahb3",
> 0xa8c, BIT(4), 0); +static SUNXI_CCU_GATE(bus_xhci_clk, "bus-xhci", "ahb3",
> 0xa8c, BIT(5), 0); +static SUNXI_CCU_GATE(bus_ehci3_clk, "bus-ehci3",
> "ahb3", 0xa8c, BIT(7), 0); +static SUNXI_CCU_GATE(bus_otg_clk, "bus-otg",
> "ahb3", 0xa8c, BIT(8), 0); +
> +static CLK_FIXED_FACTOR(pcie_ref_100m_clk, "pcie-ref-100M",
> +			"pll-periph0-4x", 24, 1, 0);
> +static SUNXI_CCU_GATE(pcie_ref_clk, "pcie-ref", "pcie-ref-100M",
> +		      0xab0, BIT(31), 0);
> +static SUNXI_CCU_GATE(pcie_ref_out_clk, "pcie-ref-out", "pcie-ref",
> +		      0xab0, BIT(30), 0);
> +
> +static SUNXI_CCU_M_WITH_GATE(pcie_maxi_clk, "pcie-maxi",
> +			     "pll-periph0", 0xab4,
> +			     0, 4,	/* M */
> +			     BIT(31),	/* gate */
> +			     0);
> +
> +static SUNXI_CCU_M_WITH_GATE(pcie_aux_clk, "pcie-aux", "osc24M", 0xab8,
> +			     0, 5,	/* M */
> +			     BIT(31),	/* gate */
> +			     0);
> +
> +static SUNXI_CCU_GATE(bus_pcie_clk, "bus-pcie", "psi-ahb1-ahb2",
> +		      0xabc, BIT(0), 0);
> +
> +static const char * const hdmi_parents[] = { "pll-video0", "pll-video1",
> +					      "pll-video1-4x" };
> +static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents, 0xb00,
> +				 0, 4,		/* M */
> +				 24, 2,		/* mux */
> +				 BIT(31),	/* gate */
> +				 0);
> +

HDMI slow clock is missing here.

Best regards,
Jernej
