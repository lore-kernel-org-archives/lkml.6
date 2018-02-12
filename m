Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbeBLPc4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:32:56 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39837 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeBLPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:32:54 -0500
X-Google-Smtp-Source: AH8x224kks/MucvskVnzhEPeFXl3/40wIIjORTepB46NqTJ532pxv8iQHYNwMfEkySMtaK61X7eaMg==
Message-ID: <1518449571.2883.30.camel@baylibre.com>
Subject: Re: [PATCH 2/2] clk: meson-axg: Add AO Clock and Reset controller
 driver
From: Jerome Brunet <jbrunet@baylibre.com>
To: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2018 16:32:51 +0100
In-Reply-To: <20180209070026.193879-3-yixun.lan@amlogic.com>
References: <20180209070026.193879-1-yixun.lan@amlogic.com>
         <20180209070026.193879-3-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-09 at 15:00 +0800, Yixun Lan wrote:
> Adds a Clock and Reset controller driver for the Always-On part
> of the Amlogic Meson-AXG SoC.
> 
> Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  drivers/clk/meson/Makefile    |   2 +-
>  drivers/clk/meson/axg-aoclk.c | 236 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/axg-aoclk.h |  25 +++++
>  3 files changed, 262 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/axg-aoclk.c
>  create mode 100644 drivers/clk/meson/axg-aoclk.h
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 11f99139b844..c7510744406a 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -6,6 +6,6 @@ obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
>  obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
> -obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
> +obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
> diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
> new file mode 100644
> index 000000000000..832aa19dd76c
> --- /dev/null
> +++ b/drivers/clk/meson/axg-aoclk.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AmLogic Meson-AXG Clock Controller Driver

Unless there a rule behind it, I think we should stop 
with the funny camel case and stick to "Amlogic" like written below.

> + *
> + * Copyright (c) 2016 Baylibre SAS.
> + * Author: Michael Turquette <mturquette@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
I did not see what is requiring this header. Did I miss something ?

> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
Same question for this one.

> +#include <dt-bindings/clock/axg-aoclkc.h>
> +#include <dt-bindings/reset/axg-aoclkc.h>

I think those should be included in the same fashion as axg.h, gxbb.h and
meson8.h ... which is at the end of the private header.

> +#include "clkc.h"
> +#include "axg-aoclk.h"
> +
> +struct axg_aoclk_reset_controller {
> +	struct reset_controller_dev reset;
> +	unsigned int *data;
> +	struct regmap *regmap;
> +};

This duplicate what is gxbb-aoclk.
Please make something cleaner with a shared definition.

> +
> +static int axg_aoclk_do_reset(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	struct axg_aoclk_reset_controller *reset =
> +		container_of(rcdev, struct axg_aoclk_reset_controller, reset);
> +
> +	return regmap_write(reset->regmap, AO_RTI_GEN_CNTL_REG0,
> +			    BIT(reset->data[id]));
> +}
> +
> +static const struct reset_control_ops axg_aoclk_reset_ops = {
> +	.reset = axg_aoclk_do_reset,
> +};
> +
> +#define AXG_AO_GATE(_name, _bit)					\
> +static struct clk_regmap _name##_ao = {					\
> +	.data = &(struct clk_regmap_gate_data) {			\
> +		.offset = (AO_RTI_GEN_CNTL_REG0),			\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name "_ao",					\
> +		.ops = &clk_regmap_gate_ops,				\
> +		.parent_names = (const char *[]){ "clk81" },		\
> +		.num_parents = 1,					\
> +		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\

These clock are peripheral clocks (meant to enable/disable IPs):
* CLK_SET_RATE_PARENT: why do you need rate propagation here ? do you really
want a consumer of these gate to be able to change clk81 ? 

* CLK_IGNORE_UNUSED: Why do need this flag ? All the IPs behind this
definition should be able to claim the pclk properly. If not the driver should
be fixed.

> +	},								\
> +}
> +
> +AXG_AO_GATE(remote, 0);
> +AXG_AO_GATE(i2c_master, 1);
> +AXG_AO_GATE(i2c_slave, 2);
> +AXG_AO_GATE(uart1, 3);
> +AXG_AO_GATE(uart2, 5);
> +AXG_AO_GATE(ir_blaster, 6);
> +AXG_AO_GATE(saradc, 7);
> +
> +static struct clk_fixed_rate ao_alt_xtal = {
> +	.fixed_rate = 32000,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ao_alt_xtal",
> +		.num_parents = 0,
> +		.ops = &clk_fixed_rate_ops,
> +	},
> +};

Unless this xtal is actually embedded in SoC, this should be defined it the DT,
same as the other xtal.

> +
> +static struct clk_regmap ao_clk81 = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = AO_RTI_PWR_CNTL_REG0,
> +		.mask = 0x1,
> +		.shift = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "ao_clk81",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_names = (const char *[]){ "clk81", "ao_alt_xtal"},
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_regmap axg_saradc_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = AO_SAR_CLK,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "axg_saradc_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_names = (const char *[]){ "xtal", "ao_clk81" },
> +		.num_parents = 2,
> +	},
> +};
> +
> +static struct clk_regmap axg_saradc_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = AO_SAR_CLK,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "axg_saradc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_names = (const char *[]){ "axg_saradc_mux" },
> +		.num_parents = 1,

Should the saradc mux change to accomodate the requested rate, if needed ?
If so, you might want to add a CLK_SET_RATE_PARENT here.

> +	},
> +};
> +
> +static struct clk_regmap axg_saradc_gate = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = AO_SAR_CLK,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "axg_saradc_gate",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_names = (const char *[]){ "axg_saradc_div" },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static unsigned int axg_aoclk_reset[] = {
> +	[RESET_AO_REMOTE] = 16,
> +	[RESET_AO_I2C_MASTER] = 18,
> +	[RESET_AO_I2C_SLAVE] = 19,
> +	[RESET_AO_UART1] = 17,
> +	[RESET_AO_UART2] = 22,
> +	[RESET_AO_IR_BLASTER] = 23,
> +};
> +
> +static struct clk_regmap *axg_aoclk_regmap[] = {
> +	[CLKID_AO_REMOTE]	= &remote_ao,
> +	[CLKID_AO_I2C_MASTER]	= &i2c_master_ao,
> +	[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao,
> +	[CLKID_AO_UART1]	= &uart1_ao,
> +	[CLKID_AO_UART2]	= &uart2_ao,
> +	[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao,
> +	[CLKID_AO_SAR_ADC]	= &saradc_ao,
> +	[CLKID_AO_CLK81]	= &ao_clk81,
> +	[CLKID_AO_SAR_ADC_SEL]	= &axg_saradc_mux,
> +	[CLKID_AO_SAR_ADC_DIV]	= &axg_saradc_div,
> +	[CLKID_AO_SAR_ADC_CLK]	= &axg_saradc_gate,
> +};
> +
> +static struct clk_hw_onecell_data axg_aoclk_onecell_data = {
> +	.hws = {
> +		[CLKID_AO_REMOTE]	= &remote_ao.hw,
> +		[CLKID_AO_I2C_MASTER]	= &i2c_master_ao.hw,
> +		[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao.hw,
> +		[CLKID_AO_UART1]	= &uart1_ao.hw,
> +		[CLKID_AO_UART2]	= &uart2_ao.hw,
> +		[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao.hw,
> +		[CLKID_AO_SAR_ADC]	= &saradc_ao.hw,
> +		[CLKID_AO_CLK81]	= &ao_clk81.hw,
> +		[CLKID_AO_SAR_ADC_SEL]	= &axg_saradc_mux.hw,
> +		[CLKID_AO_SAR_ADC_DIV]	= &axg_saradc_div.hw,
> +		[CLKID_AO_SAR_ADC_CLK]	= &axg_saradc_gate.hw,
> +		[CLKID_AO_ALT_XTAL]	= &ao_alt_xtal.hw,
> +	},
> +	.num = 12,

I would prefer having a NR_CLKS defined in drivers/clk/meson/axg-aoclk.h

> +};
> +
> +static int axg_aoclkc_probe(struct platform_device *pdev)
> +{
> +	struct axg_aoclk_reset_controller *rstc;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	int ret, clkid;
> +
> +	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
> +	if (!rstc)
> +		return -ENOMEM;
> +
> +	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to get regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Reset Controller */
> +	rstc->regmap = regmap;
> +	rstc->data = axg_aoclk_reset;
> +	rstc->reset.ops = &axg_aoclk_reset_ops;
> +	rstc->reset.nr_resets = ARRAY_SIZE(axg_aoclk_reset);
> +	rstc->reset.of_node = dev->of_node;
> +	ret = devm_reset_controller_register(dev, &rstc->reset);
> +
> +	/*
> +	 * Populate regmap and register all clks
> +	 */
> +	for (clkid = 0; clkid < ARRAY_SIZE(axg_aoclk_regmap); clkid++) {
> +		axg_aoclk_regmap[clkid]->map = regmap;
> +
> +		ret = devm_clk_hw_register(dev,
> +					axg_aoclk_onecell_data.hws[clkid]);
> +		if (ret) {
> +			dev_err(dev, "clk register failed.\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Specific clocks */
> +	ret = devm_clk_hw_register(dev, &ao_alt_xtal.hw);
> +	if (ret) {
> +		dev_err(dev, "clk alt_xtal register failed.\n");
> +		return ret;
> +	}
> +
> +	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +			&axg_aoclk_onecell_data);
> +}
> +
> +static const struct of_device_id axg_aoclkc_match_table[] = {
> +	{ .compatible = "amlogic,meson-axg-aoclkc" },
> +	{ }
> +};
> +
> +static struct platform_driver axg_aoclkc_driver = {
> +	.probe		= axg_aoclkc_probe,
> +	.driver		= {
> +		.name	= "axg-aoclkc",
> +		.of_match_table = axg_aoclkc_match_table,
> +	},
> +};
> +
> +builtin_platform_driver(axg_aoclkc_driver);
> diff --git a/drivers/clk/meson/axg-aoclk.h b/drivers/clk/meson/axg-aoclk.h
> new file mode 100644
> index 000000000000..70f82004d3db
> --- /dev/null
> +++ b/drivers/clk/meson/axg-aoclk.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + */
> +
> +#ifndef __AXG_AOCLKC_H
> +#define __AXG_AOCLKC_H
> +
> +/* AO Configuration Clock registers offsets
> + * Register offsets from the data sheet must be multiplied by 4.
> + */
> +#define AO_RTI_PWR_CNTL_REG1	(0x03 << 2)
> +#define AO_RTI_PWR_CNTL_REG0	(0x04 << 2)
> +#define AO_RTI_GEN_CNTL_REG0	(0x10 << 2)
> +#define AO_OSCIN_CNTL		(0x16 << 2)
> +#define AO_CRT_CLK_CNTL1	(0x1a << 2)
> +#define AO_SAR_CLK		(0x24 << 2)
> +#define AO_RTC_ALT_CLK_CNTL0	(0x25 << 2)
> +#define AO_RTC_ALT_CLK_CNTL1	(0x26 << 2)

As already pointed out for the axg clk series, please remove those
calculation from the header file.

> +
> +#endif /* __AXG_AOCLKC_H */
