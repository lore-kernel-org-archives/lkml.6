Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCWOjt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:39:49 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:12467 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCWOjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:39:47 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
CC: Qiufang Dai <qiufang.dai@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/7] clk: meson-axg: Add AO Clock and Reset controller driver
Date: Fri, 23 Mar 2018 22:38:14 +0800
Message-ID: <20180323143816.200573-6-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180323143816.200573-1-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiufang Dai <qiufang.dai@amlogic.com>

Adds a Clock and Reset controller driver for the Always-On part
of the Amlogic Meson-AXG SoC.

Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/Makefile    |   2 +-
 drivers/clk/meson/axg-aoclk.c | 162 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h |  31 ++++++++
 3 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 555ab9c6ab64..fa6d1e36cef6 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -5,5 +5,5 @@
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o meson-aoclk.o gxbb-aoclk.o gxbb-aoclk-32k.o
-obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
+obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o meson-aoclk.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
new file mode 100644
index 000000000000..121ecb45264f
--- /dev/null
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Amlogic Meson-AXG Clock Controller Driver
+ *
+ * Copyright (c) 2016 Baylibre SAS.
+ * Author: Michael Turquette <mturquette@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/mfd/syscon.h>
+#include <linux/init.h>
+#include "clkc.h"
+#include "axg-aoclk.h"
+
+#define AXG_AO_GATE(_name, _bit)					\
+static struct clk_regmap _name##_ao = {					\
+	.data = &(struct clk_regmap_gate_data) {			\
+		.offset = (AO_RTI_GEN_CNTL_REG0),			\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name "_ao",					\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_names = (const char *[]){ "clk81" },		\
+		.num_parents = 1,					\
+		.flags = CLK_IGNORE_UNUSED,				\
+	},								\
+}
+
+AXG_AO_GATE(remote, 0);
+AXG_AO_GATE(i2c_master, 1);
+AXG_AO_GATE(i2c_slave, 2);
+AXG_AO_GATE(uart1, 3);
+AXG_AO_GATE(uart2, 5);
+AXG_AO_GATE(ir_blaster, 6);
+AXG_AO_GATE(saradc, 7);
+
+static struct clk_regmap ao_clk81 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.mask = 0x1,
+		.shift = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_clk81",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "clk81", "ao_alt_xtal"},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap axg_saradc_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_SAR_CLK,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_saradc_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "xtal", "ao_clk81" },
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap axg_saradc_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = AO_SAR_CLK,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_saradc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "axg_saradc_mux" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_saradc_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = AO_SAR_CLK,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_saradc_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "axg_saradc_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static unsigned int axg_aoclk_reset[] = {
+	[RESET_AO_REMOTE] = 16,
+	[RESET_AO_I2C_MASTER] = 18,
+	[RESET_AO_I2C_SLAVE] = 19,
+	[RESET_AO_UART1] = 17,
+	[RESET_AO_UART2] = 22,
+	[RESET_AO_IR_BLASTER] = 23,
+};
+
+static struct clk_regmap *axg_aoclk_regmap[] = {
+	[CLKID_AO_REMOTE]	= &remote_ao,
+	[CLKID_AO_I2C_MASTER]	= &i2c_master_ao,
+	[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao,
+	[CLKID_AO_UART1]	= &uart1_ao,
+	[CLKID_AO_UART2]	= &uart2_ao,
+	[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao,
+	[CLKID_AO_SAR_ADC]	= &saradc_ao,
+	[CLKID_AO_CLK81]	= &ao_clk81,
+	[CLKID_AO_SAR_ADC_SEL]	= &axg_saradc_mux,
+	[CLKID_AO_SAR_ADC_DIV]	= &axg_saradc_div,
+	[CLKID_AO_SAR_ADC_CLK]	= &axg_saradc_gate,
+};
+
+static struct clk_hw_onecell_data axg_aoclk_onecell_data = {
+	.hws = {
+		[CLKID_AO_REMOTE]	= &remote_ao.hw,
+		[CLKID_AO_I2C_MASTER]	= &i2c_master_ao.hw,
+		[CLKID_AO_I2C_SLAVE]	= &i2c_slave_ao.hw,
+		[CLKID_AO_UART1]	= &uart1_ao.hw,
+		[CLKID_AO_UART2]	= &uart2_ao.hw,
+		[CLKID_AO_IR_BLASTER]	= &ir_blaster_ao.hw,
+		[CLKID_AO_SAR_ADC]	= &saradc_ao.hw,
+		[CLKID_AO_CLK81]	= &ao_clk81.hw,
+		[CLKID_AO_SAR_ADC_SEL]	= &axg_saradc_mux.hw,
+		[CLKID_AO_SAR_ADC_DIV]	= &axg_saradc_div.hw,
+		[CLKID_AO_SAR_ADC_CLK]	= &axg_saradc_gate.hw,
+	},
+	.num = NR_CLKS,
+};
+
+static int axg_aoclkc_probe(struct platform_device *pdev)
+{
+	return meson_aoclkc_probe(pdev, AO_RTI_GEN_CNTL_REG0,
+			axg_aoclk_reset,
+			ARRAY_SIZE(axg_aoclk_reset),
+			axg_aoclk_regmap,
+			ARRAY_SIZE(axg_aoclk_regmap),
+			&axg_aoclk_onecell_data);
+}
+
+static const struct of_device_id axg_aoclkc_match_table[] = {
+	{ .compatible = "amlogic,meson-axg-aoclkc" },
+	{ }
+};
+
+static struct platform_driver axg_aoclkc_driver = {
+	.probe		= axg_aoclkc_probe,
+	.driver		= {
+		.name	= "axg-aoclkc",
+		.of_match_table = axg_aoclkc_match_table,
+	},
+};
+
+builtin_platform_driver(axg_aoclkc_driver);
diff --git a/drivers/clk/meson/axg-aoclk.h b/drivers/clk/meson/axg-aoclk.h
new file mode 100644
index 000000000000..396cd3023064
--- /dev/null
+++ b/drivers/clk/meson/axg-aoclk.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2017 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+
+#ifndef __AXG_AOCLKC_H
+#define __AXG_AOCLKC_H
+
+#include "meson-aoclk.h"
+
+#define NR_CLKS	11
+/* AO Configuration Clock registers offsets
+ * Register offsets from the data sheet must be multiplied by 4.
+ */
+#define AO_RTI_PWR_CNTL_REG1	0x0C
+#define AO_RTI_PWR_CNTL_REG0	0x10
+#define AO_RTI_GEN_CNTL_REG0	0x40
+#define AO_OSCIN_CNTL		0x58
+#define AO_CRT_CLK_CNTL1	0x68
+#define AO_SAR_CLK		0x90
+#define AO_RTC_ALT_CLK_CNTL0	0x94
+#define AO_RTC_ALT_CLK_CNTL1	0x98
+
+#include <dt-bindings/clock/axg-aoclkc.h>
+#include <dt-bindings/reset/axg-aoclkc.h>
+
+#endif /* __AXG_AOCLKC_H */
-- 
2.15.1
