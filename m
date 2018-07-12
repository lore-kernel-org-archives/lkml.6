Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C3C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62148208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62148208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeGLNZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:25:42 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:32951 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeGLNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:25:41 -0400
Received: from localhost.localdomain (10.18.20.250) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 12 Jul 2018
 21:15:18 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] clk: meson: add sub MMC clock controller driver
Date:   Thu, 12 Jul 2018 21:12:44 +0000
Message-ID: <20180712211244.11428-3-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712211244.11428-1-yixun.lan@amlogic.com>
References: <20180712211244.11428-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch will add a MMC clock controller driver which used by MMC or NAND,
It provide a mux and divider clock, and three phase clocks - core, tx, tx.

Two clocks are provided as the parent of MMC clock controller from
upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.

To specify which clock the MMC or NAND driver may consume,
the preprocessor macros in the dt-bindings/clock/emmc-clkc.h header
can be used in the device tree sources.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/Kconfig    |   9 +
 drivers/clk/meson/Makefile   |   1 +
 drivers/clk/meson/mmc-clkc.c | 367 +++++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+)
 create mode 100644 drivers/clk/meson/mmc-clkc.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index efaa70f682b4..edc18e65c89b 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -15,6 +15,15 @@ config COMMON_CLK_MESON_AO
 	select COMMON_CLK_REGMAP_MESON
 	select RESET_CONTROLLER
 
+config COMMON_CLK_MMC_MESON
+	tristate "Meson MMC Sub Clock Controller Driver"
+	depends on COMMON_CLK_AMLOGIC
+	select MFD_SYSCON
+	select REGMAP
+	help
+	  Support for the MMC sub clock controller on Amlogic Meson Platform,
+	  Say Y if you want this clock enabled.
+
 config COMMON_CLK_REGMAP_MESON
 	bool
 	select REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 72ec8c40d848..4b3817f80ba1 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
+obj-$(CONFIG_COMMON_CLK_MMC_MESON) 	+= mmc-clkc.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
new file mode 100644
index 000000000000..36c4c7cd69a6
--- /dev/null
+++ b/drivers/clk/meson/mmc-clkc.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson MMC Sub Clock Controller Driver
+ *
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/amlogic,meson-mmc-clkc.h>
+
+#include "clkc.h"
+
+/* clock ID used by internal driver */
+#define CLKID_MMC_MUX			0
+#define CLKID_MMC_PHASE_CORE		2
+
+#define SD_EMMC_CLOCK			0
+#define   CLK_DIV_MASK			GENMASK(5, 0)
+#define   CLK_SRC_MASK			GENMASK(7, 6)
+#define   CLK_CORE_PHASE_MASK		GENMASK(9, 8)
+#define   CLK_TX_PHASE_MASK		GENMASK(11, 10)
+#define   CLK_RX_PHASE_MASK		GENMASK(13, 12)
+#define   CLK_V2_TX_DELAY_MASK		GENMASK(19, 16)
+#define   CLK_V2_RX_DELAY_MASK		GENMASK(23, 20)
+#define   CLK_V2_ALWAYS_ON		BIT(24)
+
+#define   CLK_V3_TX_DELAY_MASK		GENMASK(21, 16)
+#define   CLK_V3_RX_DELAY_MASK		GENMASK(27, 22)
+#define   CLK_V3_ALWAYS_ON		BIT(28)
+
+#define   CLK_DELAY_STEP_PS		200
+#define   CLK_PHASE_STEP		30
+#define   CLK_PHASE_POINT_NUM		(360 / CLK_PHASE_STEP)
+
+#define MUX_CLK_NUM_PARENTS		2
+#define MMC_MAX_CLKS			5
+
+struct clk_phase_delay_data {
+	unsigned long			phase_mask;
+	unsigned long			delay_mask;
+	unsigned int			delay_step_ps;
+};
+
+struct mmc_clkc_data {
+	struct clk_phase_delay_data	tx;
+	struct clk_phase_delay_data	rx;
+};
+
+static inline struct clk_phase_delay_data *
+clk_get_regmap_phase_data(struct clk_regmap *clk)
+{
+	return (struct clk_phase_delay_data *)clk->data;
+}
+
+static struct clk_regmap_mux_data mmc_clkc_mux_data = {
+	.offset		= SD_EMMC_CLOCK,
+	.mask		= 0x3,
+	.shift		= 6,
+	.flags		= CLK_DIVIDER_ROUND_CLOSEST,
+};
+
+static struct clk_regmap_div_data mmc_clkc_div_data = {
+	.offset		= SD_EMMC_CLOCK,
+	.shift		= 0,
+	.width		= 6,
+	.flags		= CLK_DIVIDER_ROUND_CLOSEST | CLK_DIVIDER_ONE_BASED,
+};
+
+static struct clk_phase_delay_data mmc_clkc_core_delay_phase = {
+	.phase_mask	= CLK_CORE_PHASE_MASK,
+};
+
+static const struct mmc_clkc_data mmc_clkc_gx_data = {
+	{
+		.phase_mask	= CLK_TX_PHASE_MASK,
+		.delay_mask	= CLK_V2_TX_DELAY_MASK,
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+	{
+		.phase_mask	= CLK_RX_PHASE_MASK,
+		.delay_mask	= CLK_V2_RX_DELAY_MASK,
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+};
+
+static const struct mmc_clkc_data mmc_clkc_axg_data = {
+	{
+		.phase_mask	= CLK_TX_PHASE_MASK,
+		.delay_mask	= CLK_V3_TX_DELAY_MASK,
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+	{
+		.phase_mask	= CLK_RX_PHASE_MASK,
+		.delay_mask	= CLK_V3_RX_DELAY_MASK,
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+};
+
+static const struct of_device_id mmc_clkc_match_table[] = {
+	{
+		.compatible	= "amlogic,meson-gx-mmc-clkc",
+		.data		= &mmc_clkc_gx_data
+	},
+	{
+		.compatible	= "amlogic,meson-axg-mmc-clkc",
+		.data		= &mmc_clkc_axg_data
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
+
+static struct clk_regmap *
+mmc_clkc_register_clk(struct device *dev, struct regmap *map,
+		      struct clk_init_data *init,
+		      const char *suffix, void *data)
+{
+	struct clk_regmap *clk;
+	char *name;
+	int ret;
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	init->name = name;
+
+	clk->map = map;
+	clk->data = data;
+	clk->hw.init = init;
+
+	ret = devm_clk_hw_register(dev, &clk->hw);
+	if (ret)
+		clk = ERR_PTR(ret);
+
+	kfree(name);
+	return clk;
+}
+
+static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
+						struct regmap *map)
+{
+	const char *parent_names[MUX_CLK_NUM_PARENTS];
+	struct clk_init_data init;
+	struct clk_regmap *mux;
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
+		char name[8];
+
+		snprintf(name, sizeof(name), "clkin%d", i);
+		clk = devm_clk_get(dev, name);
+		if (IS_ERR(clk)) {
+			if (clk != ERR_PTR(-EPROBE_DEFER))
+				dev_err(dev, "Missing clock %s\n", name);
+			return ERR_PTR((long)clk);
+		}
+
+		parent_names[i] = __clk_get_name(clk);
+	}
+
+	init.ops = &clk_regmap_mux_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_names;
+	init.num_parents = MUX_CLK_NUM_PARENTS;
+
+	mux = mmc_clkc_register_clk(dev, map, &init, "mux", &mmc_clkc_mux_data);
+	if (IS_ERR(mux))
+		dev_err(dev, "Mux clock registration failed\n");
+
+	return mux;
+}
+
+static int clk_regmap_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_phase_delay_data *ph = clk_get_regmap_phase_data(clk);
+	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
+	unsigned long period_ps, p, d;
+	int degrees;
+	u32 val;
+
+	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
+	p = (val & ph->phase_mask) >> __ffs(ph->phase_mask);
+	degrees = p * 360 / phase_num;
+
+	if (ph->delay_mask) {
+		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+					 clk_get_rate(hw->clk));
+		d = (val & ph->delay_mask) >> __ffs(ph->delay_mask);
+		degrees += d * ph->delay_step_ps * 360 / period_ps;
+		degrees %= 360;
+	}
+
+	return degrees;
+}
+
+static void clk_regmap_apply_phase_delay(struct clk_regmap *clk,
+					 unsigned int phase,
+					 unsigned int delay)
+{
+	struct clk_phase_delay_data *ph = clk->data;
+	u32 val;
+
+	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
+
+	val &= ~ph->phase_mask;
+	val |= phase << __ffs(ph->phase_mask);
+
+	if (ph->delay_mask) {
+		val &= ~ph->delay_mask;
+		val |= delay << __ffs(ph->delay_mask);
+	}
+
+	regmap_write(clk->map, SD_EMMC_CLOCK, val);
+}
+
+static int clk_regmap_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_phase_delay_data *ph = clk_get_regmap_phase_data(clk);
+	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
+	unsigned long period_ps, d = 0, r;
+	u64 p;
+
+	p = degrees % 360;
+
+	if (!ph->delay_mask) {
+		p = DIV_ROUND_CLOSEST_ULL(p, 360 / phase_num);
+	} else {
+		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+					 clk_get_rate(hw->clk));
+
+		/* First compute the phase index (p), the remainder (r) is the
+		 * part we'll try to acheive using the delays (d).
+		 */
+		r = do_div(p, 360 / phase_num);
+		d = DIV_ROUND_CLOSEST(r * period_ps,
+				      360 * ph->delay_step_ps);
+		d = min(d, ph->delay_mask >> __ffs(ph->delay_mask));
+	}
+
+	clk_regmap_apply_phase_delay(clk, p, d);
+	return 0;
+}
+
+static const struct clk_ops clk_regmap_phase_ops = {
+	.get_phase = clk_regmap_get_phase,
+	.set_phase = clk_regmap_set_phase,
+};
+
+static struct clk_regmap *
+mmc_clkc_register_other_clk(struct device *dev, struct regmap *map,
+			    char *suffix, char *parent_suffix,
+			    unsigned long flags,
+			    const struct clk_ops *ops, void *data)
+{
+	struct clk_init_data init;
+	struct clk_regmap *clk;
+	char *parent;
+
+	parent = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), parent_suffix);
+	if (!parent)
+		return ERR_PTR(-ENOMEM);
+
+	init.ops = ops;
+	init.flags = flags;
+	init.parent_names = (const char* const []){ parent, };
+	init.num_parents = 1;
+
+	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
+	if (IS_ERR(clk))
+		dev_err(dev, "Core %s clock registration failed\n", suffix);
+
+	kfree(parent);
+	return clk;
+}
+
+static int mmc_clkc_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *onecell_data;
+	struct device *dev = &pdev->dev;
+	struct mmc_clkc_data *data;
+	struct regmap *map;
+	struct clk_regmap *mux, *div, *core, *rx, *tx;
+
+	data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	map = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(map)) {
+		dev_err(dev, "could not find mmc clock controller\n");
+		return PTR_ERR(map);
+	}
+
+	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
+				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
+				    GFP_KERNEL);
+	if (!onecell_data)
+		return -ENOMEM;
+
+	mux = mmc_clkc_register_mux(dev, map);
+	if (IS_ERR(mux))
+		return PTR_ERR(mux);
+
+	div = mmc_clkc_register_other_clk(dev, map, "div", "mux",
+					  CLK_SET_RATE_PARENT,
+					  &clk_regmap_divider_ops,
+					  &mmc_clkc_div_data);
+	if (IS_ERR(div))
+		return PTR_ERR(div);
+
+	core = mmc_clkc_register_other_clk(dev, map, "core", "div",
+					   CLK_SET_RATE_PARENT,
+					   &clk_regmap_phase_ops,
+					   &mmc_clkc_core_delay_phase);
+	if (IS_ERR(core))
+		return PTR_ERR(core);
+
+	rx = mmc_clkc_register_other_clk(dev, map, "rx", "core", 0,
+					 &clk_regmap_phase_ops,
+					 &data->rx);
+	if (IS_ERR(rx))
+		return PTR_ERR(rx);
+
+	tx = mmc_clkc_register_other_clk(dev, map, "tx", "core", 0,
+					 &clk_regmap_phase_ops,
+					 &data->tx);
+	if (IS_ERR(tx))
+		return PTR_ERR(tx);
+
+	onecell_data->hws[CLKID_MMC_MUX]		= &mux->hw,
+	onecell_data->hws[CLKID_MMC_DIV]		= &div->hw,
+	onecell_data->hws[CLKID_MMC_PHASE_CORE]		= &core->hw,
+	onecell_data->hws[CLKID_MMC_PHASE_RX]		= &rx->hw,
+	onecell_data->hws[CLKID_MMC_PHASE_TX]		= &tx->hw,
+	onecell_data->num				= MMC_MAX_CLKS;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   onecell_data);
+}
+
+static struct platform_driver mmc_clkc_driver = {
+	.probe		= mmc_clkc_probe,
+	.driver		= {
+		.name	= "meson-mmc-clkc",
+		.of_match_table = of_match_ptr(mmc_clkc_match_table),
+	},
+};
+
+module_platform_driver(mmc_clkc_driver);
-- 
2.18.0

