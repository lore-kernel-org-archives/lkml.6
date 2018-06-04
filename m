Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeFDH4z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:56:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeFDH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:56:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3991A60763
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From: Taniya Das <tdas@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, robh@kernel.org
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 2/2] clk: qcom: Add display clock controller driver for SDM845
Date: Mon,  4 Jun 2018 13:26:25 +0530
Message-Id: <1528098985-3676-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
References: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the display clock controller found on SDM845
based devices. This would allow display drivers to probe and
control their clocks.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/Kconfig         |  10 +
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/dispcc-sdm845.c | 679 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 690 insertions(+)
 create mode 100644 drivers/clk/qcom/dispcc-sdm845.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index e06e1f8..d9e7e75 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -227,6 +227,16 @@ config SDM_GCC_845
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  I2C, USB, UFS, SDDC, PCIe, etc.

+config SDM_DISPCC_845
+	tristate "SDM845 Display Clock Controller"
+	select SDM_GCC_845
+	depends on COMMON_CLK_QCOM
+	help
+	  Support for the display clock controller on Qualcomm Technologies, Inc
+	  sdm845 devices.
+	  Say Y if you want to support display devices and functionality such as
+	  splash screen.
+
 config SPMI_PMIC_CLKDIV
 	tristate "SPMI PMIC clkdiv Support"
 	depends on (COMMON_CLK_QCOM && SPMI) || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 82070e0..96142ff 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -38,4 +38,5 @@ obj-$(CONFIG_QCOM_CLK_APCS_MSM8916) += apcs-msm8916.o
 obj-$(CONFIG_QCOM_CLK_RPM) += clk-rpm.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
+obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
new file mode 100644
index 0000000..317ab33
--- /dev/null
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/qcom,dispcc-sdm845.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "common.h"
+#include "gdsc.h"
+#include "reset.h"
+
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+
+enum {
+	P_BI_TCXO,
+	P_CORE_BI_PLL_TEST_SE,
+	P_DISP_CC_PLL0_OUT_MAIN,
+	P_DSI0_PHY_PLL_OUT_BYTECLK,
+	P_DSI0_PHY_PLL_OUT_DSICLK,
+	P_DSI1_PHY_PLL_OUT_BYTECLK,
+	P_DSI1_PHY_PLL_OUT_DSICLK,
+	P_GPLL0_OUT_MAIN,
+	P_GPLL0_OUT_MAIN_DIV,
+};
+
+static const struct parent_map disp_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 1 },
+	{ P_DSI1_PHY_PLL_OUT_BYTECLK, 2 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 },
+};
+
+static const char * const disp_cc_parent_names_0[] = {
+	"bi_tcxo",
+	"dsi0_phy_pll_out_byteclk",
+	"dsi1_phy_pll_out_byteclk",
+	"core_bi_pll_test_se",
+};
+
+static const struct parent_map disp_cc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 },
+};
+
+static const char * const disp_cc_parent_names_2[] = {
+	"bi_tcxo",
+	"core_bi_pll_test_se",
+};
+
+static const struct parent_map disp_cc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DISP_CC_PLL0_OUT_MAIN, 1 },
+	{ P_GPLL0_OUT_MAIN, 4 },
+	{ P_GPLL0_OUT_MAIN_DIV, 5 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 },
+};
+
+static const char * const disp_cc_parent_names_3[] = {
+	"bi_tcxo",
+	"disp_cc_pll0",
+	"gcc_disp_gpll0_clk_src",
+	"gcc_disp_gpll0_div_clk_src",
+	"core_bi_pll_test_se",
+};
+
+static const struct parent_map disp_cc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
+	{ P_DSI1_PHY_PLL_OUT_DSICLK, 2 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 },
+};
+
+static const char * const disp_cc_parent_names_4[] = {
+	"bi_tcxo",
+	"dsi0_phy_pll_out_dsiclk",
+	"dsi1_phy_pll_out_dsiclk",
+	"core_bi_pll_test_se",
+};
+
+static const struct alpha_pll_config disp_cc_pll0_config = {
+	.l = 0x2c,
+	.alpha = 0xcaaa,
+};
+
+static struct clk_alpha_pll disp_cc_pll0 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_pll0",
+			.parent_names = (const char *[]){ "bi_tcxo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
+	.cmd_rcgr = 0x20d0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_0,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_byte0_clk_src",
+		.parent_names = disp_cc_parent_names_0,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_byte2_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_byte1_clk_src = {
+	.cmd_rcgr = 0x20ec,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_0,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_byte1_clk_src",
+		.parent_names = disp_cc_parent_names_0,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_byte2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_esc0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
+	.cmd_rcgr = 0x2108,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_0,
+	.freq_tbl = ftbl_disp_cc_mdss_esc0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_esc0_clk_src",
+		.parent_names = disp_cc_parent_names_0,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
+	.cmd_rcgr = 0x2120,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_0,
+	.freq_tbl = ftbl_disp_cc_mdss_esc0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_esc1_clk_src",
+		.parent_names = disp_cc_parent_names_0,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(85714286, P_GPLL0_OUT_MAIN, 7, 0, 0),
+	F(100000000, P_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(150000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	F(171428571, P_GPLL0_OUT_MAIN, 3.5, 0, 0),
+	F(200000000, P_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
+	F(344000000, P_DISP_CC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	F(430000000, P_DISP_CC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
+	.cmd_rcgr = 0x2088,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_3,
+	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_mdp_clk_src",
+		.parent_names = disp_cc_parent_names_3,
+		.num_parents = 5,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
+	.cmd_rcgr = 0x2058,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_4,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_pclk0_clk_src",
+		.parent_names = disp_cc_parent_names_4,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_pixel_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_pclk1_clk_src = {
+	.cmd_rcgr = 0x2070,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_4,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_pclk1_clk_src",
+		.parent_names = disp_cc_parent_names_4,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_pixel_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_rot_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(171428571, P_GPLL0_OUT_MAIN, 3.5, 0, 0),
+	F(300000000, P_GPLL0_OUT_MAIN, 2, 0, 0),
+	F(344000000, P_DISP_CC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	F(430000000, P_DISP_CC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
+	.cmd_rcgr = 0x20a0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_3,
+	.freq_tbl = ftbl_disp_cc_mdss_rot_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_rot_clk_src",
+		.parent_names = disp_cc_parent_names_3,
+		.num_parents = 5,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
+	.cmd_rcgr = 0x20b8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_2,
+	.freq_tbl = ftbl_disp_cc_mdss_esc0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_vsync_clk_src",
+		.parent_names = disp_cc_parent_names_2,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch disp_cc_mdss_ahb_clk = {
+	.halt_reg = 0x4004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_axi_clk = {
+	.halt_reg = 0x4008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_byte0_clk = {
+	.halt_reg = 0x2028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte0_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_byte0_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
+	.reg = 0x20e8,
+	.shift = 0,
+	.width = 2,
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte0_div_clk_src",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_byte0_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
+	.halt_reg = 0x202c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x202c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte0_intf_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_byte0_div_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_byte1_clk = {
+	.halt_reg = 0x2030,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte1_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_byte1_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div disp_cc_mdss_byte1_div_clk_src = {
+	.reg = 0x2104,
+	.shift = 0,
+	.width = 2,
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte1_div_clk_src",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_byte1_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE,
+			.ops = &clk_regmap_div_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_byte1_intf_clk = {
+	.halt_reg = 0x2034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte1_intf_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_byte1_div_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_esc0_clk = {
+	.halt_reg = 0x2038,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2038,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_esc0_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_esc0_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_esc1_clk = {
+	.halt_reg = 0x203c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x203c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_esc1_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_esc1_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_mdp_clk = {
+	.halt_reg = 0x200c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x200c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_mdp_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_mdp_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
+	.halt_reg = 0x201c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x201c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_mdp_lut_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_mdp_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_pclk0_clk = {
+	.halt_reg = 0x2004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_pclk0_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_pclk0_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_pclk1_clk = {
+	.halt_reg = 0x2008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_pclk1_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_pclk1_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_rot_clk = {
+	.halt_reg = 0x2014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_rot_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_rot_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
+	.halt_reg = 0x5004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_rscc_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
+	.halt_reg = 0x5008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_rscc_vsync_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_vsync_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_vsync_clk = {
+	.halt_reg = 0x2024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_vsync_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_vsync_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x3000,
+	.pd = {
+		.name = "mdss_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL | POLL_CFG_GDSCR,
+};
+
+static struct clk_regmap *disp_cc_sdm845_clocks[] = {
+	[DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
+	[DISP_CC_MDSS_AXI_CLK] = &disp_cc_mdss_axi_clk.clkr,
+	[DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
+	[DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
+	[DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] =
+					&disp_cc_mdss_byte0_div_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE1_CLK] = &disp_cc_mdss_byte1_clk.clkr,
+	[DISP_CC_MDSS_BYTE1_CLK_SRC] = &disp_cc_mdss_byte1_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
+	[DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] =
+					&disp_cc_mdss_byte1_div_clk_src.clkr,
+	[DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
+	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
+	[DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
+	[DISP_CC_MDSS_ESC1_CLK_SRC] = &disp_cc_mdss_esc1_clk_src.clkr,
+	[DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
+	[DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
+	[DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
+	[DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
+	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
+	[DISP_CC_MDSS_PCLK1_CLK] = &disp_cc_mdss_pclk1_clk.clkr,
+	[DISP_CC_MDSS_PCLK1_CLK_SRC] = &disp_cc_mdss_pclk1_clk_src.clkr,
+	[DISP_CC_MDSS_ROT_CLK] = &disp_cc_mdss_rot_clk.clkr,
+	[DISP_CC_MDSS_ROT_CLK_SRC] = &disp_cc_mdss_rot_clk_src.clkr,
+	[DISP_CC_MDSS_RSCC_AHB_CLK] = &disp_cc_mdss_rscc_ahb_clk.clkr,
+	[DISP_CC_MDSS_RSCC_VSYNC_CLK] = &disp_cc_mdss_rscc_vsync_clk.clkr,
+	[DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
+	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
+	[DISP_CC_PLL0] = &disp_cc_pll0.clkr,
+};
+
+static const struct qcom_reset_map disp_cc_sdm845_resets[] = {
+	[DISP_CC_MDSS_RSCC_BCR] = { 0x5000 },
+};
+
+static struct gdsc *disp_cc_sdm845_gdscs[] = {
+	[MDSS_GDSC] = &mdss_gdsc,
+};
+
+static const struct regmap_config disp_cc_sdm845_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x10000,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc disp_cc_sdm845_desc = {
+	.config = &disp_cc_sdm845_regmap_config,
+	.clks = disp_cc_sdm845_clocks,
+	.num_clks = ARRAY_SIZE(disp_cc_sdm845_clocks),
+	.resets = disp_cc_sdm845_resets,
+	.num_resets = ARRAY_SIZE(disp_cc_sdm845_resets),
+	.gdscs = disp_cc_sdm845_gdscs,
+	.num_gdscs = ARRAY_SIZE(disp_cc_sdm845_gdscs),
+};
+
+static const struct of_device_id disp_cc_sdm845_match_table[] = {
+	{ .compatible = "qcom,sdm845-dispcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, disp_cc_sdm845_match_table);
+
+static int disp_cc_sdm845_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &disp_cc_sdm845_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_fabia_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
+
+	/* Enable clock gating for DSI and MDP clocks */
+	regmap_update_bits(regmap, 0x8000, 0x7f0, 0x7f0);
+
+	return qcom_cc_really_probe(pdev, &disp_cc_sdm845_desc, regmap);
+}
+
+static struct platform_driver disp_cc_sdm845_driver = {
+	.probe		= disp_cc_sdm845_probe,
+	.driver		= {
+		.name	= "disp_cc-sdm845",
+		.of_match_table = disp_cc_sdm845_match_table,
+	},
+};
+
+static int __init disp_cc_sdm845_init(void)
+{
+	return platform_driver_register(&disp_cc_sdm845_driver);
+}
+subsys_initcall(disp_cc_sdm845_init);
+
+static void __exit disp_cc_sdm845_exit(void)
+{
+	platform_driver_unregister(&disp_cc_sdm845_driver);
+}
+module_exit(disp_cc_sdm845_exit);
+
+MODULE_LICENSE("GPL v2");
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.
