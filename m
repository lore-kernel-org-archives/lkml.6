Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeECN0x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:26:53 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:55861 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeECN0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:26:23 -0400
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
Subject: [PATCH v8 4/5] clk: meson-axg: Add AO Clock and Reset controller driver
Date: Thu, 3 May 2018 21:26:23 +0800
Message-ID: <20180503132624.78453-5-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503132624.78453-1-yixun.lan@amlogic.com>
References: <20180503132624.78453-1-yixun.lan@amlogic.com>
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
 drivers/clk/meson/Kconfig     |   1 +
 drivers/clk/meson/Makefile    |   2 +-
 drivers/clk/meson/axg-aoclk.c | 164 ++++++++++++++++++++++++++++++++++
 drivers/clk/meson/axg-aoclk.h |  29 ++++++
 4 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/axg-aoclk.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index fddc7ec7b820..815659eebea3 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -38,6 +38,7 @@ config COMMON_CLK_AXG
 	bool
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
+	select COMMON_CLK_MESON_AO
 	select COMMON_CLK_REGMAP_MESON
 	select MFD_SYSCON
 	help
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 0a8df284f4e7..d0d13aeb369a 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -6,5 +6,5 @@ obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
-obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
+obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
new file mode 100644
index 000000000000..29e088542387
--- /dev/null
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -0,0 +1,164 @@
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
+#include "clk-regmap.h"
+#include "meson-aoclk.h"
+#include "axg-aoclk.h"
+
+#define AXG_AO_GATE(_name, _bit)					\
+static struct clk_regmap axg_aoclk_##_name = {				\
+	.data = &(struct clk_regmap_gate_data) {			\
+		.offset = (AO_RTI_GEN_CNTL_REG0),			\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name =  "axg_ao_" #_name,				\
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
+static struct clk_regmap axg_aoclk_clk81 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.mask = 0x1,
+		.shift = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_clk81",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "clk81", "ao_alt_xtal"},
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap axg_aoclk_saradc_mux = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_SAR_CLK,
+		.mask = 0x3,
+		.shift = 9,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_saradc_mux",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "xtal", "axg_ao_clk81" },
+		.num_parents = 2,
+	},
+};
+
+static struct clk_regmap axg_aoclk_saradc_div = {
+	.data = &(struct clk_regmap_div_data) {
+		.offset = AO_SAR_CLK,
+		.shift = 0,
+		.width = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_saradc_div",
+		.ops = &clk_regmap_divider_ops,
+		.parent_names = (const char *[]){ "axg_ao_saradc_mux" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap axg_aoclk_saradc_gate = {
+	.data = &(struct clk_regmap_gate_data) {
+		.offset = AO_SAR_CLK,
+		.bit_idx = 8,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "axg_ao_saradc_gate",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "axg_ao_saradc_div" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const unsigned int axg_aoclk_reset[] = {
+	[RESET_AO_REMOTE]	= 16,
+	[RESET_AO_I2C_MASTER]	= 18,
+	[RESET_AO_I2C_SLAVE]	= 19,
+	[RESET_AO_UART1]	= 17,
+	[RESET_AO_UART2]	= 22,
+	[RESET_AO_IR_BLASTER]	= 23,
+};
+
+static struct clk_regmap *axg_aoclk_regmap[] = {
+	[CLKID_AO_REMOTE]	= &axg_aoclk_remote,
+	[CLKID_AO_I2C_MASTER]	= &axg_aoclk_i2c_master,
+	[CLKID_AO_I2C_SLAVE]	= &axg_aoclk_i2c_slave,
+	[CLKID_AO_UART1]	= &axg_aoclk_uart1,
+	[CLKID_AO_UART2]	= &axg_aoclk_uart2,
+	[CLKID_AO_IR_BLASTER]	= &axg_aoclk_ir_blaster,
+	[CLKID_AO_SAR_ADC]	= &axg_aoclk_saradc,
+	[CLKID_AO_CLK81]	= &axg_aoclk_clk81,
+	[CLKID_AO_SAR_ADC_SEL]	= &axg_aoclk_saradc_mux,
+	[CLKID_AO_SAR_ADC_DIV]	= &axg_aoclk_saradc_div,
+	[CLKID_AO_SAR_ADC_CLK]	= &axg_aoclk_saradc_gate,
+};
+
+static const struct clk_hw_onecell_data axg_aoclk_onecell_data = {
+	.hws = {
+		[CLKID_AO_REMOTE]	= &axg_aoclk_remote.hw,
+		[CLKID_AO_I2C_MASTER]	= &axg_aoclk_i2c_master.hw,
+		[CLKID_AO_I2C_SLAVE]	= &axg_aoclk_i2c_slave.hw,
+		[CLKID_AO_UART1]	= &axg_aoclk_uart1.hw,
+		[CLKID_AO_UART2]	= &axg_aoclk_uart2.hw,
+		[CLKID_AO_IR_BLASTER]	= &axg_aoclk_ir_blaster.hw,
+		[CLKID_AO_SAR_ADC]	= &axg_aoclk_saradc.hw,
+		[CLKID_AO_CLK81]	= &axg_aoclk_clk81.hw,
+		[CLKID_AO_SAR_ADC_SEL]	= &axg_aoclk_saradc_mux.hw,
+		[CLKID_AO_SAR_ADC_DIV]	= &axg_aoclk_saradc_div.hw,
+		[CLKID_AO_SAR_ADC_CLK]	= &axg_aoclk_saradc_gate.hw,
+	},
+	.num = NR_CLKS,
+};
+
+static const struct meson_aoclk_data axg_aoclkc_data = {
+	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
+	.num_reset	= ARRAY_SIZE(axg_aoclk_reset),
+	.reset		= axg_aoclk_reset,
+	.num_clks	= ARRAY_SIZE(axg_aoclk_regmap),
+	.clks		= axg_aoclk_regmap,
+	.hw_data	= &axg_aoclk_onecell_data,
+};
+
+static const struct of_device_id axg_aoclkc_match_table[] = {
+	{
+		.compatible	= "amlogic,meson-axg-aoclkc",
+		.data		= &axg_aoclkc_data,
+	},
+	{ }
+};
+
+static struct platform_driver axg_aoclkc_driver = {
+	.probe		= meson_aoclkc_probe,
+	.driver		= {
+		.name	= "axg-aoclkc",
+		.of_match_table = axg_aoclkc_match_table,
+	},
+};
+
+builtin_platform_driver(axg_aoclkc_driver);
diff --git a/drivers/clk/meson/axg-aoclk.h b/drivers/clk/meson/axg-aoclk.h
new file mode 100644
index 000000000000..91384d8dd844
--- /dev/null
+++ b/drivers/clk/meson/axg-aoclk.h
@@ -0,0 +1,29 @@
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
2.17.0
