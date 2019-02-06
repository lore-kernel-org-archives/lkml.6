Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE60C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024152184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l3U23o/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfBFLIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:08:48 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40172 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbfBFLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:08:44 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16B8hCS021546;
        Wed, 6 Feb 2019 05:08:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549451323;
        bh=hHvDHyJhCOPV3g/sNWjNZOCKOUD1ChYdMFhtyB20YKc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=l3U23o/BuL5ZLILWpIDwI/ehNIBsUqjqO/8yon8ZcUB1t2+OzsGmFdfEWpRYHhvqI
         GQBsS9x8N+7mKuYS/4xLo3VqAeVMiA91E53brh+h772h3APgZcNwFRGuhdC7LvJGJ3
         +qIjCUnZAgzTiikgT10wfItwlhKM5lcG+H4iqKXg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16B8hf6105113
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 05:08:43 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:08:42 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:08:42 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16B8Wac024645;
        Wed, 6 Feb 2019 05:08:41 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] phy: ti: Add a new SERDES driver for TI's AM654x SoC
Date:   Wed, 6 Feb 2019 16:37:53 +0530
Message-ID: <20190206110753.28738-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206110753.28738-1-kishon@ti.com>
References: <20190206110753.28738-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new SERDES driver for TI's AM654x SoC which configures
the SERDES only for PCIe. Support fo USB3 will be added later.

SERDES in am654x has three input clocks (left input, externel reference
clock and right input) and two output clocks (left output and right
output) in addition to a PLL mux clock which the SERDES uses for Clock
Multiplier Unit (CMU refclock).

The PLL mux clock can select from one of the three input clocks.
The right output can select between left input and external reference
clock while the left output can select between the right input and
external reference clock.

The driver has support to select PLL mux and left/right output mux as
specified in device tree.

[rogerq@ti.com: Fix boot lockup caused by accessing a structure member
(hw->init) allocated in stack of probe() and accessed in get_parent]
[rogerq@ti.com: Fix "Failed to find the parent" warnings]
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/Kconfig            |  11 +
 drivers/phy/ti/Makefile           |   1 +
 drivers/phy/ti/phy-am654-serdes.c | 539 ++++++++++++++++++++++++++++++
 3 files changed, 551 insertions(+)
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index f137e0107764..6357c32de115 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -20,6 +20,17 @@ config PHY_DM816X_USB
 	help
 	  Enable this for dm816x USB to work.
 
+config PHY_AM654_SERDES
+	tristate "TI AM654 SERDES support"
+	depends on OF && ARCH_K3 || COMPILE_TEST
+	select GENERIC_PHY
+	select MULTIPLEXER
+	select REGMAP_MMIO
+	select MUX_MMIO
+	help
+	  This option enables support for TI AM654 SerDes PHY used for
+	  PCIe.
+
 config OMAP_CONTROL_PHY
 	tristate "OMAP CONTROL PHY Driver"
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
index bea8f25a137a..bff901eb0ecc 100644
--- a/drivers/phy/ti/Makefile
+++ b/drivers/phy/ti/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
 obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
 obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
 obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
+obj-$(CONFIG_PHY_AM654_SERDES)		+= phy-am654-serdes.o
 obj-$(CONFIG_PHY_TI_GMII_SEL)		+= phy-gmii-sel.o
diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
new file mode 100644
index 000000000000..dfbd2d48503d
--- /dev/null
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -0,0 +1,539 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * PCIe SERDES driver for AM654x SoC
+ *
+ * Copyright (C) 2018 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ */
+
+#include <dt-bindings/phy/phy.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mux/consumer.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+
+#define CMU_R07C		0x7c
+#define CMU_MASTER_CDN_O	BIT(24)
+
+#define COMLANE_R138		0xb38
+#define CONFIG_VERSION_REG_MASK	GENMASK(23, 16)
+#define CONFIG_VERSION_REG_SHIFT 16
+#define VERSION			0x70
+
+#define COMLANE_R190		0xb90
+#define L1_MASTER_CDN_O		BIT(9)
+
+#define COMLANE_R194		0xb94
+#define CMU_OK_I_0		BIT(19)
+
+#define SERDES_CTRL		0x1fd0
+#define POR_EN			BIT(29)
+
+#define WIZ_LANEXCTL_STS	0x1fe0
+#define TX0_ENABLE_OVL		BIT(31)
+#define TX0_ENABLE_MASK		GENMASK(30, 29)
+#define TX0_ENABLE_SHIFT	29
+#define TX0_DISABLE_STATE	0x0
+#define TX0_SLEEP_STATE		0x1
+#define TX0_SNOOZE_STATE	0x2
+#define TX0_ENABLE_STATE	0x3
+#define RX0_ENABLE_OVL		BIT(15)
+#define RX0_ENABLE_MASK		GENMASK(14, 13)
+#define RX0_ENABLE_SHIFT	13
+#define RX0_DISABLE_STATE	0x0
+#define RX0_SLEEP_STATE		0x1
+#define RX0_SNOOZE_STATE	0x2
+#define RX0_ENABLE_STATE	0x3
+
+#define WIZ_PLL_CTRL		0x1ff4
+#define PLL_ENABLE_OVL		BIT(31)
+#define PLL_ENABLE_MASK		GENMASK(30, 29)
+#define PLL_ENABLE_SHIFT	29
+#define PLL_DISABLE_STATE	0x0
+#define PLL_SLEEP_STATE		0x1
+#define PLL_SNOOZE_STATE	0x2
+#define PLL_ENABLE_STATE	0x3
+#define PLL_OK			BIT(28)
+
+#define PLL_LOCK_TIME		100000	/* in microseconds */
+#define SLEEP_TIME		100	/* in microseconds */
+
+#define LANE_USB3		0x0
+#define LANE_PCIE0_LANE0	0x1
+
+#define LANE_PCIE1_LANE0	0x0
+#define LANE_PCIE0_LANE1	0x1
+
+#define SERDES_NUM_CLOCKS	3
+
+struct serdes_am654_clk_mux {
+	struct clk_hw	hw;
+	struct regmap	*regmap;
+	unsigned int	reg;
+	int		*table;
+	u32		mask;
+	u8		shift;
+	struct clk_init_data clk_data;
+};
+
+#define to_serdes_am654_clk_mux(_hw)	\
+		container_of(_hw, struct serdes_am654_clk_mux, hw)
+
+static struct regmap_config serdes_am654_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
+struct serdes_am654 {
+	struct regmap		*regmap;
+	struct device		*dev;
+	struct mux_control	*control;
+	bool			busy;
+	u32			type;
+	struct device_node	*of_node;
+	struct clk_onecell_data	clk_data;
+	struct clk		*clks[SERDES_NUM_CLOCKS];
+};
+
+static int serdes_am654_enable_pll(struct serdes_am654 *phy)
+{
+	u32 mask = PLL_ENABLE_OVL | PLL_ENABLE_MASK;
+	u32 val = PLL_ENABLE_OVL | (PLL_ENABLE_STATE << PLL_ENABLE_SHIFT);
+
+	regmap_update_bits(phy->regmap, WIZ_PLL_CTRL, mask, val);
+
+	return regmap_read_poll_timeout(phy->regmap, WIZ_PLL_CTRL, val,
+					val & PLL_OK, 1000, PLL_LOCK_TIME);
+}
+
+static void serdes_am654_disable_pll(struct serdes_am654 *phy)
+{
+	u32 mask = PLL_ENABLE_OVL | PLL_ENABLE_MASK;
+
+	regmap_update_bits(phy->regmap, WIZ_PLL_CTRL, mask, PLL_ENABLE_OVL);
+}
+
+static int serdes_am654_enable_txrx(struct serdes_am654 *phy)
+{
+	u32 mask;
+	u32 val;
+
+	/* Enable TX */
+	mask = TX0_ENABLE_OVL | TX0_ENABLE_MASK;
+	val = TX0_ENABLE_OVL | (TX0_ENABLE_STATE << TX0_ENABLE_SHIFT);
+	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, val);
+
+	/* Enable RX */
+	mask = RX0_ENABLE_OVL | RX0_ENABLE_MASK;
+	val = RX0_ENABLE_OVL | (RX0_ENABLE_STATE << RX0_ENABLE_SHIFT);
+	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, val);
+
+	return 0;
+}
+
+static int serdes_am654_disable_txrx(struct serdes_am654 *phy)
+{
+	u32 mask;
+
+	/* Disable TX */
+	mask = TX0_ENABLE_OVL | TX0_ENABLE_MASK;
+	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, TX0_ENABLE_OVL);
+
+	/* Disable RX */
+	mask = RX0_ENABLE_OVL | RX0_ENABLE_MASK;
+	regmap_update_bits(phy->regmap, WIZ_LANEXCTL_STS, mask, RX0_ENABLE_OVL);
+
+	return 0;
+}
+
+static int serdes_am654_power_on(struct phy *x)
+{
+	struct serdes_am654 *phy = phy_get_drvdata(x);
+	struct device *dev = phy->dev;
+	int ret;
+	u32 val;
+
+	ret = serdes_am654_enable_pll(phy);
+	if (ret) {
+		dev_err(dev, "Failed to enable PLL\n");
+		return ret;
+	}
+
+	ret = serdes_am654_enable_txrx(phy);
+	if (ret) {
+		dev_err(dev, "Failed to enable TX RX\n");
+		return ret;
+	}
+
+	return regmap_read_poll_timeout(phy->regmap, COMLANE_R194, val,
+					val & CMU_OK_I_0, SLEEP_TIME,
+					PLL_LOCK_TIME);
+}
+
+static int serdes_am654_power_off(struct phy *x)
+{
+	struct serdes_am654 *phy = phy_get_drvdata(x);
+
+	serdes_am654_disable_txrx(phy);
+	serdes_am654_disable_pll(phy);
+
+	return 0;
+}
+
+static int serdes_am654_init(struct phy *x)
+{
+	struct serdes_am654 *phy = phy_get_drvdata(x);
+	u32 mask;
+	u32 val;
+
+	mask = CONFIG_VERSION_REG_MASK;
+	val = VERSION << CONFIG_VERSION_REG_SHIFT;
+	regmap_update_bits(phy->regmap, COMLANE_R138, mask, val);
+
+	val = CMU_MASTER_CDN_O;
+	regmap_update_bits(phy->regmap, CMU_R07C, val, val);
+
+	val = L1_MASTER_CDN_O;
+	regmap_update_bits(phy->regmap, COMLANE_R190, val, val);
+
+	return 0;
+}
+
+static int serdes_am654_reset(struct phy *x)
+{
+	struct serdes_am654 *phy = phy_get_drvdata(x);
+	u32 val;
+
+	val = POR_EN;
+	regmap_update_bits(phy->regmap, SERDES_CTRL, val, val);
+	mdelay(1);
+	regmap_update_bits(phy->regmap, SERDES_CTRL, val, 0);
+
+	return 0;
+}
+
+static void serdes_am654_release(struct phy *x)
+{
+	struct serdes_am654 *phy = phy_get_drvdata(x);
+
+	phy->type = PHY_NONE;
+	phy->busy = false;
+	mux_control_deselect(phy->control);
+}
+
+struct phy *serdes_am654_xlate(struct device *dev, struct of_phandle_args
+				 *args)
+{
+	struct serdes_am654 *am654_phy;
+	struct phy *phy;
+	int ret;
+
+	phy = of_phy_simple_xlate(dev, args);
+	if (IS_ERR(phy))
+		return phy;
+
+	am654_phy = phy_get_drvdata(phy);
+	if (am654_phy->busy)
+		return ERR_PTR(-EBUSY);
+
+	ret = mux_control_select(am654_phy->control, args->args[1]);
+	if (ret) {
+		dev_err(dev, "Failed to select SERDES Lane Function\n");
+		return ERR_PTR(ret);
+	}
+
+	am654_phy->busy = true;
+	am654_phy->type = args->args[0];
+
+	return phy;
+}
+
+static const struct phy_ops ops = {
+	.reset		= serdes_am654_reset,
+	.init		= serdes_am654_init,
+	.power_on	= serdes_am654_power_on,
+	.power_off	= serdes_am654_power_off,
+	.release	= serdes_am654_release,
+	.owner		= THIS_MODULE,
+};
+
+static u8 serdes_am654_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct serdes_am654_clk_mux *mux = to_serdes_am654_clk_mux(hw);
+	unsigned int num_parents = clk_hw_get_num_parents(hw);
+	struct regmap *regmap = mux->regmap;
+	unsigned int reg = mux->reg;
+	unsigned int val;
+	int i;
+
+	regmap_read(regmap, reg, &val);
+	val >>= mux->shift;
+	val &= mux->mask;
+
+	for (i = 0; i < num_parents; i++)
+		if (mux->table[i] == val)
+			return i;
+
+	/*
+	 * No parent? This should never happen!
+	 * Verify if we set a valid parent in serdes_am654_clk_register()
+	 */
+	WARN(1, "Failed to find the parent of %s clock\n", hw->init->name);
+
+	/* Make the parent lookup to fail */
+	return num_parents;
+}
+
+static int serdes_am654_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct serdes_am654_clk_mux *mux = to_serdes_am654_clk_mux(hw);
+	struct regmap *regmap = mux->regmap;
+	unsigned int reg = mux->reg;
+	int val;
+	int ret;
+
+	val = mux->table[index];
+
+	if (val == -1)
+		return -EINVAL;
+
+	val <<= mux->shift;
+	ret = regmap_update_bits(regmap, reg, mux->mask << mux->shift, val);
+
+	return ret;
+}
+
+static const struct clk_ops serdes_am654_clk_mux_ops = {
+	.set_parent = serdes_am654_clk_mux_set_parent,
+	.get_parent = serdes_am654_clk_mux_get_parent,
+};
+
+static int mux_table[SERDES_NUM_CLOCKS][3] = {
+	/*
+	 * The entries represent values for selecting between
+	 * {left input, external reference clock, right input}
+	 * Only one of Left Output or Right Output should be used since
+	 * both left and right output clock uses the same bits and modifying
+	 * one clock will impact the other.
+	 */
+	{ BIT(2),               0, BIT(0) }, /* Mux of CMU refclk */
+	{     -1,          BIT(3), BIT(1) }, /* Mux of Left Output */
+	{ BIT(1), BIT(3) | BIT(1),     -1 }, /* Mux of Right Output */
+};
+
+static int mux_mask[SERDES_NUM_CLOCKS] = { 0x5, 0xa, 0xa };
+
+static int serdes_am654_clk_register(struct serdes_am654 *am654_phy,
+				     const char *clock_name, int clock_num)
+{
+	struct device_node *node = am654_phy->of_node;
+	struct device *dev = am654_phy->dev;
+	struct serdes_am654_clk_mux *mux;
+	struct device_node *regmap_node;
+	const char **parent_names;
+	struct clk_init_data *init;
+	unsigned int num_parents;
+	struct regmap *regmap;
+	const __be32 *addr;
+	unsigned int reg;
+	struct clk *clk;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return -ENOMEM;
+
+	init = &mux->clk_data;
+
+	regmap_node = of_parse_phandle(node, "ti,serdes-clk", 0);
+	of_node_put(regmap_node);
+	if (!regmap_node) {
+		dev_err(dev, "Fail to get serdes-clk node\n");
+		return -ENODEV;
+	}
+
+	regmap = syscon_node_to_regmap(regmap_node->parent);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Fail to get Syscon regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 2) {
+		dev_err(dev, "SERDES clock must have parents\n");
+		return -EINVAL;
+	}
+
+	parent_names = devm_kzalloc(dev, (sizeof(char *) * num_parents),
+				    GFP_KERNEL);
+	if (!parent_names)
+		return -ENOMEM;
+
+	of_clk_parent_fill(node, parent_names, num_parents);
+
+	addr = of_get_address(regmap_node, 0, NULL, NULL);
+	if (!addr)
+		return -EINVAL;
+
+	reg = be32_to_cpu(*addr);
+
+	init->ops = &serdes_am654_clk_mux_ops;
+	init->flags = CLK_SET_RATE_NO_REPARENT;
+	init->parent_names = parent_names;
+	init->num_parents = num_parents;
+	init->name = clock_name;
+
+	mux->table = mux_table[clock_num];
+	mux->regmap = regmap;
+	mux->reg = reg;
+	mux->shift = 4;
+	mux->mask = mux_mask[clock_num];
+	mux->hw.init = init;
+
+	/*
+	 * setup a sane default so get_parent() call evaluates
+	 * to a valid parent. Index 1 is the safest choice as
+	 * the default as it is valid value for all of serdes's
+	 * output clocks.
+	 */
+	serdes_am654_clk_mux_set_parent(&mux->hw, 1);
+	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	am654_phy->clks[clock_num] = clk;
+
+	return 0;
+}
+
+static const struct of_device_id serdes_am654_id_table[] = {
+	{
+		.compatible = "ti,phy-am654-serdes",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, serdes_am654_id_table);
+
+static int serdes_am654_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct clk_onecell_data *clk_data;
+	struct serdes_am654 *am654_phy;
+	struct mux_control *control;
+	const char *clock_name;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+	struct phy *phy;
+	int ret;
+	int i;
+
+	am654_phy = devm_kzalloc(dev, sizeof(*am654_phy), GFP_KERNEL);
+	if (!am654_phy)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "serdes");
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &serdes_am654_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to initialize regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	control = devm_mux_control_get(dev, NULL);
+	if (IS_ERR(control))
+		return PTR_ERR(control);
+
+	am654_phy->dev = dev;
+	am654_phy->of_node = node;
+	am654_phy->regmap = regmap;
+	am654_phy->control = control;
+	am654_phy->type = PHY_NONE;
+
+	platform_set_drvdata(pdev, am654_phy);
+
+	for (i = 0; i < SERDES_NUM_CLOCKS; i++) {
+		ret = of_property_read_string_index(node, "clock-output-names",
+						    i, &clock_name);
+		if (ret) {
+			dev_err(dev, "Failed to get clock name\n");
+			return ret;
+		}
+
+		ret = serdes_am654_clk_register(am654_phy, clock_name, i);
+		if (ret) {
+			dev_err(dev, "Failed to initialize clock %s\n",
+				clock_name);
+			return ret;
+		}
+	}
+
+	clk_data = &am654_phy->clk_data;
+	clk_data->clks = am654_phy->clks;
+	clk_data->clk_num = SERDES_NUM_CLOCKS;
+	ret = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(dev);
+
+	phy = devm_phy_create(dev, NULL, &ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	phy_set_drvdata(phy, am654_phy);
+	phy_provider = devm_of_phy_provider_register(dev, serdes_am654_xlate);
+	if (IS_ERR(phy_provider)) {
+		ret = PTR_ERR(phy_provider);
+		goto clk_err;
+	}
+
+	return 0;
+
+clk_err:
+	of_clk_del_provider(node);
+
+	return ret;
+}
+
+static int serdes_am654_remove(struct platform_device *pdev)
+{
+	struct serdes_am654 *am654_phy = platform_get_drvdata(pdev);
+	struct device_node *node = am654_phy->of_node;
+
+	pm_runtime_disable(&pdev->dev);
+	of_clk_del_provider(node);
+
+	return 0;
+}
+
+static struct platform_driver serdes_am654_driver = {
+	.probe		= serdes_am654_probe,
+	.remove		= serdes_am654_remove,
+	.driver		= {
+		.name	= "phy-am654",
+		.of_match_table = serdes_am654_id_table,
+	},
+};
+module_platform_driver(serdes_am654_driver);
+
+MODULE_ALIAS("platform:phy-am654");
+MODULE_AUTHOR("Texas Instruments Inc.");
+MODULE_DESCRIPTION("TI AM654x SERDES driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

