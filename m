Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA164C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F22087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfAHNvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:51:20 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:63162 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfAHNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:51:15 -0500
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 8 Jan 2019
 21:51:33 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 4/4] clk: meson: add sub MMC clock controller driver
Date:   Tue, 8 Jan 2019 21:50:44 +0800
Message-ID: <1546955444-7549-5-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yixun Lan <yixun.lan@amlogic.com>

The patch will add a MMC clock controller driver which used by MMC or NAND,
It provide a mux and divider clock, and three phase clocks - core, tx, tx.

Two clocks are provided as the parent of MMC clock controller from
upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.

To specify which clock the MMC or NAND driver may consume,
the preprocessor macros in the dt-bindings/clock/amlogic,mmc-clkc.h header
can be used in the device tree sources.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/clk/meson/Kconfig    |  10 ++
 drivers/clk/meson/Makefile   |   1 +
 drivers/clk/meson/mmc-clkc.c | 304 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+)
 create mode 100644 drivers/clk/meson/mmc-clkc.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index efaa70f..3555f9d 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -15,6 +15,16 @@ config COMMON_CLK_MESON_AO
 	select COMMON_CLK_REGMAP_MESON
 	select RESET_CONTROLLER
 
+config COMMON_CLK_MMC_MESON
+	tristate "Meson MMC Sub Clock Controller Driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	select MFD_SYSCON
+	select COMMON_CLK_AMLOGIC
+	help
+	  Support for the MMC sub clock controller on Amlogic Meson Platform,
+	  which include S905 (GXBB, GXL), A113D/X (AXG) devices.
+	  Say Y if you want this clock enabled.
+
 config COMMON_CLK_REGMAP_MESON
 	bool
 	select REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index d59620d..54416a2 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -12,4 +12,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
+obj-$(CONFIG_COMMON_CLK_MMC_MESON) 	+= mmc-clkc.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
new file mode 100644
index 0000000..2582a98
--- /dev/null
+++ b/drivers/clk/meson/mmc-clkc.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson MMC Sub Clock Controller Driver
+ *
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ * Author: Jianxin Pan <jianxin.pan@amlogic.com>
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
+#include <dt-bindings/clock/amlogic,mmc-clkc.h>
+
+#include "clkc.h"
+
+/* clock ID used by internal driver */
+
+#define SD_EMMC_CLOCK		0
+#define CLK_DELAY_STEP_PS	200
+#define MUX_CLK_NUM_PARENTS	2
+#define MMC_MAX_CLKS		4
+
+struct mmc_clkc_data {
+	struct meson_clk_phase_delay_data tx;
+	struct meson_clk_phase_delay_data rx;
+};
+
+static struct clk_regmap_mux_data mmc_clkc_mux_data = {
+	.offset = SD_EMMC_CLOCK,
+	.mask   = 0x3,
+	.shift  = 6,
+};
+
+static const struct meson_sclk_div_data mmc_clkc_div_data = {
+	.div = {
+		.reg_off = SD_EMMC_CLOCK,
+		.width   = 6,
+	},
+	.flags = CLK_DIVIDER_ONE_BASED,
+};
+
+static struct meson_clk_phase_data mmc_clkc_core_phase = {
+	.ph = {
+		.reg_off = SD_EMMC_CLOCK,
+		.shift   = 8,
+		.width   = 2,
+	}
+};
+
+static const struct mmc_clkc_data mmc_clkc_gx_data = {
+	.tx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 10,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 16,
+			.width   = 4,
+		},
+		.delay_step_ps = CLK_DELAY_STEP_PS,
+	},
+	.rx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 12,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 20,
+			.width   = 4,
+		},
+		.delay_step_ps   = CLK_DELAY_STEP_PS,
+	},
+};
+
+static const struct mmc_clkc_data mmc_clkc_axg_data = {
+	.tx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 10,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 16,
+			.width   = 6,
+		},
+		.delay_step_ps   = CLK_DELAY_STEP_PS,
+	},
+	.rx = {
+		.phase = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 12,
+			.width   = 2,
+		},
+		.delay = {
+			.reg_off = SD_EMMC_CLOCK,
+			.shift   = 22,
+			.width   = 6,
+		},
+		.delay_step_ps   = CLK_DELAY_STEP_PS,
+	},
+};
+
+static const struct of_device_id mmc_clkc_match_table[] = {
+	{
+		.compatible	= "amlogic,gx-mmc-clkc",
+		.data		= &mmc_clkc_gx_data
+	},
+	{
+		.compatible	= "amlogic,axg-mmc-clkc",
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
+	clk->map = map;
+	clk->data = data;
+	clk->hw.init = init;
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
+			return ERR_CAST(clk);
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
+static struct clk_regmap *
+mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
+				  char *suffix, const struct clk_hw *hw,
+				  unsigned long flags,
+				  const struct clk_ops *ops, void *data)
+{
+	struct clk_init_data init;
+	struct clk_regmap *clk;
+	const char *parent_name = clk_hw_get_name(hw);
+
+	init.ops = ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
+	if (IS_ERR(clk))
+		dev_err(dev, "%s clock registration failed\n", suffix);
+
+	return clk;
+}
+
+static int mmc_clkc_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *onecell_data;
+	struct device *dev = &pdev->dev;
+	struct mmc_clkc_data *data;
+	struct regmap *map;
+	struct clk_regmap *clk, *core;
+	struct meson_sclk_div_data *div_data;
+
+	/*cast to drop the const in match->data*/
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
+	clk = mmc_clkc_register_mux(dev, map);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	div_data = devm_kzalloc(dev, sizeof(*div_data), GFP_KERNEL);
+	if (!div_data)
+		return -ENOMEM;
+
+	memcpy(div_data, &mmc_clkc_div_data, sizeof(*div_data));
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
+						&clk->hw,
+						CLK_SET_RATE_PARENT,
+						&meson_sclk_div_ops,
+						div_data);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	onecell_data->hws[CLKID_MMC_DIV] = &clk->hw,
+
+	core = mmc_clkc_register_clk_with_parent(dev, map, "core",
+						 &clk->hw,
+						 CLK_SET_RATE_PARENT,
+						 &meson_clk_phase_ops,
+						 &mmc_clkc_core_phase);
+	if (IS_ERR(core))
+		return PTR_ERR(core);
+
+	onecell_data->hws[CLKID_MMC_PHASE_CORE] = &core->hw,
+
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "rx",
+						&core->hw,  0,
+						&meson_clk_phase_delay_ops,
+						&data->rx);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	onecell_data->hws[CLKID_MMC_PHASE_RX] = &clk->hw,
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "tx",
+						&core->hw,  0,
+						&meson_clk_phase_delay_ops,
+						&data->tx);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	onecell_data->hws[CLKID_MMC_PHASE_TX] = &clk->hw,
+	onecell_data->num = MMC_MAX_CLKS;
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
+
+MODULE_DESCRIPTION("Amlogic AXG MMC clock driver");
+MODULE_AUTHOR("Jianxin Pan <jianxin.pan@amlogic.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

