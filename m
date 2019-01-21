Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCECC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FD82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T2mqsyl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfAUJsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:48:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfAUJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:48:00 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0L9lwSe129334;
        Mon, 21 Jan 2019 03:47:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548064078;
        bh=Grx5uL30EIqi2vnu+F5WSP/JWc7BIxLHvKy6cn30Iwc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=T2mqsyl1x1mfw7fiBDexdkyGk4sDK3pGl6Ywo6yEFgWze+EmQv9Xi2Uc+ghAcUF+z
         59iT4GaHX7yfprWxgB1yb8q/gRc9sdjE0Mtf2jQcLf84nkIOEHXBpqCZQM/9yXq6dp
         Mcss6QzRGAme/38c5zXig29ZAWq0Ucnl1/FJw/MU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0L9lwAU037113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 03:47:58 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 03:47:56 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 03:47:55 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0L9lr8h017557;
        Mon, 21 Jan 2019 03:47:54 -0600
Subject: Re: [PATCH 3/3] phy: ti: Add a new SERDES driver for TI's AM654x SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20190121064813.18444-1-kishon@ti.com>
 <20190121064813.18444-4-kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C459549.8090403@ti.com>
Date:   Mon, 21 Jan 2019 11:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190121064813.18444-4-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 21/01/19 08:48, Kishon Vijay Abraham I wrote:
> Add a new SERDES driver for TI's AM654x SoC which configures
> the SERDES only for PCIe. Support fo USB3 will be added later.
> 
> SERDES in am654x has three input clocks (left input, externel reference
> clock and right input) and two output clocks (left output and right
> output) in addition to a PLL mux clock which the SERDES uses for Clock
> Multiplier Unit (CMU refclock).
> 
> The PLL mux clock can select from one of the three input clocks.
> The right output can select between left input and external reference
> clock while the left output can select between the right input and
> external reference clock.
> 
> The driver has support to select PLL mux and left/right output mux as
> specified in device tree.
> 
> [rogerq@ti.com: Fix boot lockup caused by accessing a structure member
> (hw->init) allocated in stack of probe() and accessed in get_parent]
> [rogerq@ti.com: Fix "Failed to find the parent" warnings]
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/ti/Kconfig            |  11 +
>  drivers/phy/ti/Makefile           |   1 +
>  drivers/phy/ti/phy-am654-serdes.c | 528 ++++++++++++++++++++++++++++++
>  3 files changed, 540 insertions(+)
>  create mode 100644 drivers/phy/ti/phy-am654-serdes.c
> 
> diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
> index f137e0107764..6357c32de115 100644
> --- a/drivers/phy/ti/Kconfig
> +++ b/drivers/phy/ti/Kconfig
> @@ -20,6 +20,17 @@ config PHY_DM816X_USB
>  	help
>  	  Enable this for dm816x USB to work.
>  
> +config PHY_AM654_SERDES
> +	tristate "TI AM654 SERDES support"
> +	depends on OF && ARCH_K3 || COMPILE_TEST
> +	select GENERIC_PHY
> +	select MULTIPLEXER
> +	select REGMAP_MMIO
> +	select MUX_MMIO
> +	help
> +	  This option enables support for TI AM654 SerDes PHY used for
> +	  PCIe.
> +
>  config OMAP_CONTROL_PHY
>  	tristate "OMAP CONTROL PHY Driver"
>  	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
> index bea8f25a137a..bff901eb0ecc 100644
> --- a/drivers/phy/ti/Makefile
> +++ b/drivers/phy/ti/Makefile
> @@ -6,4 +6,5 @@ obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
>  obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
>  obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
> +obj-$(CONFIG_PHY_AM654_SERDES)		+= phy-am654-serdes.o
>  obj-$(CONFIG_PHY_TI_GMII_SEL)		+= phy-gmii-sel.o
> diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
> new file mode 100644
> index 000000000000..fcc0a98fbbd3
> --- /dev/null
> +++ b/drivers/phy/ti/phy-am654-serdes.c
> @@ -0,0 +1,528 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * PCIe SERDES driver for AM654x SoC
> + *
> + * Copyright (C) 2018 Texas Instruments
> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + */
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mux/consumer.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/mfd/syscon.h>
> +
> +#define CMU_R07C		0x7c
> +#define CMU_MASTER_CDN_O	BIT(24)
> +
> +#define COMLANE_R138		0xb38
> +#define CONFIG_VERSION_REG_MASK	GENMASK(23, 16)
> +#define CONFIG_VERSION_REG_SHIFT 16
> +#define VERSION			0x70
> +
> +#define COMLANE_R190		0xb90
> +#define L1_MASTER_CDN_O		BIT(9)
> +
> +#define COMLANE_R194		0xb94
> +#define CMU_OK_I_0		BIT(19)
> +
> +#define SERDES_CTRL		0x1fd0
> +#define POR_EN			BIT(29)
> +
> +#define WIZ_LANEXCTL_STS	0x1fe0
> +#define TX0_ENABLE_OVL		BIT(31)
> +#define TX0_ENABLE_MASK		GENMASK(30, 29)
> +#define TX0_ENABLE_SHIFT	29
> +#define TX0_DISABLE_STATE	0x0
> +#define TX0_SLEEP_STATE		0x1
> +#define TX0_SNOOZE_STATE	0x2
> +#define TX0_ENABLE_STATE	0x3
> +#define RX0_ENABLE_OVL		BIT(15)
> +#define RX0_ENABLE_MASK		GENMASK(14, 13)
> +#define RX0_ENABLE_SHIFT	13
> +#define RX0_DISABLE_STATE	0x0
> +#define RX0_SLEEP_STATE		0x1
> +#define RX0_SNOOZE_STATE	0x2
> +#define RX0_ENABLE_STATE	0x3
> +
> +#define WIZ_PLL_CTRL		0x1ff4
> +#define PLL_ENABLE_OVL		BIT(31)
> +#define PLL_ENABLE_MASK		GENMASK(30, 29)
> +#define PLL_ENABLE_SHIFT	29
> +#define PLL_DISABLE_STATE	0x0
> +#define PLL_SLEEP_STATE		0x1
> +#define PLL_SNOOZE_STATE	0x2
> +#define PLL_ENABLE_STATE	0x3
> +#define PLL_OK			BIT(28)
> +
> +#define PLL_LOCK_TIME		100000	/* in microseconds */
> +#define SLEEP_TIME		100	/* in microseconds */
> +
> +#define LANE_USB3		0x0
> +#define LANE_PCIE0_LANE0	0x1
> +
> +#define LANE_PCIE1_LANE0	0x0
> +#define LANE_PCIE0_LANE1	0x1
> +
> +#define SERDES_NUM_CLOCKS	3
> +
> +struct serdes_am654_clk_mux {
> +	struct clk_hw	hw;
> +	struct regmap	*regmap;
> +	unsigned int	reg;
> +	int		*table;
> +	u32		mask;
> +	u8		shift;
> +	struct clk_init_data clk_data;
> +};
> +
> +#define to_serdes_am654_clk_mux(_hw)	\
> +		container_of(_hw, struct serdes_am654_clk_mux, hw)
> +
> +static struct regmap_config serdes_am654_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,
> +};
> +
> +struct serdes_am654 {
> +	struct regmap		*regmap;
> +	struct device		*dev;
> +	struct mux_control	*control;
> +	bool			busy;
> +	u32			type;
> +	struct device_node	*of_node;
> +	struct clk_onecell_data	clk_data;
> +	struct clk		*clks[SERDES_NUM_CLOCKS];
> +};
> +
> +static int serdes_am654_enable_pll(struct serdes_am654 *phy)
> +{
> +	u32 mask = PLL_ENABLE_OVL | PLL_ENABLE_MASK;
> +	u32 val = PLL_ENABLE_OVL | (PLL_ENABLE_STATE << PLL_ENABLE_SHIFT);
> +
> +	regmap_update_bits(phy->regmap, WIZ_PLL_CTRL, mask, val);
> +
> +	return regmap_read_poll_timeout(phy->regmap, WIZ_PLL_CTRL, val,
> +					val & PLL_OK, 1000, PLL_LOCK_TIME);
> +}
> +
> +static void serdes_am654_disable_pll(struct serdes_am654 *phy)
> +{
> +	u32 mask = PLL_ENABLE_OVL | PLL_ENABLE_MASK;
> +
> +	regmap_update_bits(phy->regmap, WIZ_PLL_CTRL, mask, 0);

Shouldn't PLL_ENABLE_OVL be left set otherwise override mechanism won't work?

So,

	regmap_update_bits(phy->regmap, WIZ_PLL_CTRL, mask, PLL_ENABLE_OVL);

> +}
> +
> +static int serdes_am654_enable_txrx(struct serdes_am654 *phy)
> +{
> +	u32 mask;
> +	u32 val;
> +
> +	/* Enable TX */
> +	mask = TX0_ENABLE_OVL | TX0_ENABLE_MASK;
> +	val = TX0_ENABLE_OVL | (TX0_ENABLE_STATE << TX0_ENABLE_SHIFT);
> +	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, val);
> +
> +	/* Enable RX */
> +	mask = RX0_ENABLE_OVL | RX0_ENABLE_MASK;
> +	val = RX0_ENABLE_OVL | (RX0_ENABLE_STATE << RX0_ENABLE_SHIFT);
> +	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, val);
> +
> +	return 0;
> +}
> +
> +static int serdes_am654_disable_txrx(struct serdes_am654 *phy)
> +{
> +	u32 mask;
> +
> +	/* Disable TX */
> +	mask = TX0_ENABLE_OVL | TX0_ENABLE_MASK;
> +	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, 0);

Here too.
> +
> +	/* Disable RX */
> +	mask = RX0_ENABLE_OVL | RX0_ENABLE_MASK;
> +	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, 0);

Here as well.

> +
> +	return 0;
> +}
> +
> +static int serdes_am654_power_on(struct phy *x)
> +{
> +	struct serdes_am654 *phy = phy_get_drvdata(x);
> +	struct device *dev = phy->dev;
> +	int ret;
> +	u32 val;
> +
> +	ret = serdes_am654_enable_pll(phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable PLL\n");
> +		return ret;
> +	}
> +
> +	ret = serdes_am654_enable_txrx(phy);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable TX RX\n");
> +		return ret;
> +	}
> +
> +	return regmap_read_poll_timeout(phy->regmap, COMLANE_R194, val,
> +					val & CMU_OK_I_0, SLEEP_TIME,
> +					PLL_LOCK_TIME);
> +}
> +
> +static int serdes_am654_power_off(struct phy *x)
> +{
> +	struct serdes_am654 *phy = phy_get_drvdata(x);
> +
> +	serdes_am654_disable_txrx(phy);
> +	serdes_am654_disable_pll(phy);
> +
> +	return 0;
> +}
> +
> +static int serdes_am654_init(struct phy *x)
> +{
> +	struct serdes_am654 *phy = phy_get_drvdata(x);
> +	u32 mask;
> +	u32 val;
> +
> +	mask = CONFIG_VERSION_REG_MASK;
> +	val = VERSION << CONFIG_VERSION_REG_SHIFT;
> +	regmap_update_bits(phy->regmap, COMLANE_R138, mask, val);
> +
> +	val = CMU_MASTER_CDN_O;
> +	regmap_update_bits(phy->regmap, CMU_R07C, val, val);
> +
> +	val = L1_MASTER_CDN_O;
> +	regmap_update_bits(phy->regmap, COMLANE_R190, val, val);
> +
> +	return 0;
> +}
> +
> +static int serdes_am654_reset(struct phy *x)
> +{
> +	struct serdes_am654 *phy = phy_get_drvdata(x);
> +	u32 val;
> +
> +	val = POR_EN;
> +	regmap_update_bits(phy->regmap, SERDES_CTRL, val, val);
> +	mdelay(1);
> +	regmap_update_bits(phy->regmap, SERDES_CTRL, val, 0);
> +
> +	return 0;
> +}
> +
> +struct phy *serdes_am654_xlate(struct device *dev, struct of_phandle_args
> +				 *args)
> +{
> +	struct serdes_am654 *am654_phy;
> +	struct phy *phy;
> +	int ret;
> +
> +	phy = of_phy_simple_xlate(dev, args);
> +	if (IS_ERR(phy))
> +		return phy;
> +
> +	am654_phy = phy_get_drvdata(phy);
> +	if (am654_phy->type != args->args[0] && am654_phy->busy)
> +		return ERR_PTR(-EBUSY);

You set the busy flag in this function but it is never cleared.
This means the second phy_get() will always fail. We might get into this
situation for example if the driver doing the phy_get() had to bail out
due to some reason (e.g. -EPROBE_DEFER), and gets probed again and does
a phy_get() a second time for the same PHY and lane.

Can we clear the busy flag and call mux_control_deselect() on phy_put()?

cheers,
-roger

> +
> +	ret = mux_control_select(am654_phy->control, args->args[1]);
> +	if (ret) {
> +		dev_err(dev, "Failed to select SERDES Lane Function\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	am654_phy->busy = true;
> +	am654_phy->type = args->args[0];
> +
> +	return phy;
> +}
> +
> +static const struct phy_ops ops = {
> +	.reset		= serdes_am654_reset,
> +	.init		= serdes_am654_init,
> +	.power_on	= serdes_am654_power_on,
> +	.power_off	= serdes_am654_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static u8 serdes_am654_clk_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct serdes_am654_clk_mux *mux = to_serdes_am654_clk_mux(hw);
> +	unsigned int num_parents = clk_hw_get_num_parents(hw);
> +	struct regmap *regmap = mux->regmap;
> +	unsigned int reg = mux->reg;
> +	unsigned int val;
> +	int i;
> +
> +	regmap_read(regmap, reg, &val);
> +	val >>= mux->shift;
> +	val &= mux->mask;
> +
> +	for (i = 0; i < num_parents; i++)
> +		if (mux->table[i] == val)
> +			return i;
> +
> +	/*
> +	 * No parent? This should never happen!
> +	 * Verify if we set a valid parent in serdes_am654_clk_register()
> +	 */
> +	WARN(1, "Failed to find the parent of %s clock\n", hw->init->name);
> +
> +	/* Make the parent lookup to fail */
> +	return num_parents;
> +}
> +
> +static int serdes_am654_clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct serdes_am654_clk_mux *mux = to_serdes_am654_clk_mux(hw);
> +	struct regmap *regmap = mux->regmap;
> +	unsigned int reg = mux->reg;
> +	int val;
> +	int ret;
> +
> +	val = mux->table[index];
> +
> +	if (val == -1)
> +		return -EINVAL;
> +
> +	val <<= mux->shift;
> +	ret = regmap_update_bits(regmap, reg, mux->mask << mux->shift, val);
> +
> +	return ret;
> +}
> +
> +static const struct clk_ops serdes_am654_clk_mux_ops = {
> +	.set_parent = serdes_am654_clk_mux_set_parent,
> +	.get_parent = serdes_am654_clk_mux_get_parent,
> +};
> +
> +static int mux_table[SERDES_NUM_CLOCKS][3] = {
> +	/*
> +	 * The entries represent values for selecting between
> +	 * {left input, external reference clock, right input}
> +	 * Only one of Left Output or Right Output should be used since
> +	 * both left and right output clock uses the same bits and modifying
> +	 * one clock will impact the other.
> +	 */
> +	{ BIT(2),               0, BIT(0) }, /* Mux of CMU refclk */
> +	{     -1,          BIT(3), BIT(1) }, /* Mux of Left Output */
> +	{ BIT(1), BIT(3) | BIT(1),     -1 }, /* Mux of Right Output */
> +};
> +
> +static int mux_mask[SERDES_NUM_CLOCKS] = { 0x5, 0xa, 0xa };
> +
> +static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
> +				     const char *clock_name, int clock_num)
> +{
> +	struct device_node *node = am654_phy->of_node;
> +	struct device *dev = am654_phy->dev;
> +	struct serdes_am654_clk_mux *mux;
> +	struct device_node *regmap_node;
> +	const char **parent_names;
> +	struct clk_init_data *init;
> +	unsigned int num_parents;
> +	struct regmap *regmap;
> +	const __be32 *addr;
> +	unsigned int reg;
> +	struct clk *clk;
> +
> +	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
> +	if (!mux)
> +		return -ENOMEM;
> +
> +	init = &mux->clk_data;
> +
> +	regmap_node = of_parse_phandle(node, "ti,serdes-clk", 0);
> +	of_node_put(regmap_node);
> +	if (!regmap_node) {
> +		dev_err(dev, "Fail to get serdes-clk node\n");
> +		return -ENODEV;
> +	}
> +
> +	regmap = syscon_node_to_regmap(regmap_node->parent);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Fail to get Syscon regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	num_parents = of_clk_get_parent_count(node);
> +	if (num_parents < 3) {
> +		dev_err(dev, "SERDES clock must have parents\n");
> +		return -EINVAL;
> +	}
> +
> +	parent_names = devm_kzalloc(dev, (sizeof(char *) * num_parents),
> +				    GFP_KERNEL);
> +	if (!parent_names)
> +		return -ENOMEM;
> +
> +	of_clk_parent_fill(node, parent_names, num_parents);
> +
> +	addr = of_get_address(regmap_node, 0, NULL, NULL);
> +	if (!addr)
> +		return -EINVAL;
> +
> +	reg = be32_to_cpu(*addr);
> +
> +	init->ops = &serdes_am654_clk_mux_ops;
> +	init->flags = CLK_SET_RATE_NO_REPARENT;
> +	init->parent_names = parent_names;
> +	init->num_parents = num_parents;
> +	init->name = clock_name;
> +
> +	mux->table = mux_table[clock_num];
> +	mux->regmap = regmap;
> +	mux->reg = reg;
> +	mux->shift = 4;
> +	mux->mask = mux_mask[clock_num];
> +	mux->hw.init = init;
> +
> +	/*
> +	 * setup a sane default so get_parent() call evaluates
> +	 * to a valid parent. Index 1 is the safest choice as
> +	 * the default as it is valid value for all of serdes's
> +	 * output clocks.
> +	 */
> +	serdes_am654_clk_mux_set_parent(&mux->hw, 1);
> +	clk = devm_clk_register(dev, &mux->hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	am654_phy->clks[clock_num] = clk;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id serdes_am654_id_table[] = {
> +	{
> +		.compatible = "ti,phy-am654-serdes",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, serdes_am654_id_table);
> +
> +static int serdes_am654_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct clk_onecell_data *clk_data;
> +	struct serdes_am654 *am654_phy;
> +	struct mux_control *control;
> +	const char *clock_name;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	void __iomem *base;
> +	struct phy *phy;
> +	int ret;
> +	int i;
> +
> +	am654_phy = devm_kzalloc(dev, sizeof(*am654_phy), GFP_KERNEL);
> +	if (!am654_phy)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "serdes");
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &serdes_am654_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Failed to initialize regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	control = devm_mux_control_get(dev, NULL);
> +	if (IS_ERR(control))
> +		return PTR_ERR(control);
> +
> +	am654_phy->dev = dev;
> +	am654_phy->of_node = node;
> +	am654_phy->regmap = regmap;
> +	am654_phy->control = control;
> +
> +	platform_set_drvdata(pdev, am654_phy);
> +
> +	for (i = 0; i < SERDES_NUM_CLOCKS; i++) {
> +		ret = of_property_read_string_index(node, "clock-output-names",
> +						    i, &clock_name);
> +		if (ret) {
> +			dev_err(dev, "Failed to get clock name\n");
> +			return ret;
> +		}
> +
> +		ret = serdes_am654_clk_register(am654_phy, clock_name, i);
> +		if (ret) {
> +			dev_err(dev, "Failed to initialize clock %s\n",
> +				clock_name);
> +			return ret;
> +		}
> +	}
> +
> +	clk_data = &am654_phy->clk_data;
> +	clk_data->clks = am654_phy->clks;
> +	clk_data->clk_num = SERDES_NUM_CLOCKS;
> +	ret = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_enable(dev);
> +
> +	phy = devm_phy_create(dev, NULL, &ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, am654_phy);
> +	phy_provider = devm_of_phy_provider_register(dev, serdes_am654_xlate);
> +	if (IS_ERR(phy_provider)) {
> +		ret = PTR_ERR(phy_provider);
> +		goto clk_err;
> +	}
> +
> +	return 0;
> +
> +clk_err:
> +	of_clk_del_provider(node);
> +
> +	return ret;
> +}
> +
> +static int serdes_am654_remove(struct platform_device *pdev)
> +{
> +	struct serdes_am654 *am654_phy = platform_get_drvdata(pdev);
> +	struct device_node *node = am654_phy->of_node;
> +
> +	pm_runtime_disable(&pdev->dev);
> +	of_clk_del_provider(node);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver serdes_am654_driver = {
> +	.probe		= serdes_am654_probe,
> +	.remove		= serdes_am654_remove,
> +	.driver		= {
> +		.name	= "phy-am654",
> +		.of_match_table = serdes_am654_id_table,
> +	},
> +};
> +module_platform_driver(serdes_am654_driver);
> +
> +MODULE_ALIAS("platform:phy-am654");
> +MODULE_AUTHOR("Texas Instruments Inc.");
> +MODULE_DESCRIPTION("TI AM654x SERDES driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
