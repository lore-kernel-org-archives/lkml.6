Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeDRAJd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 20:09:33 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35553 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeDRAJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 20:09:30 -0400
X-Google-Smtp-Source: AIpwx4+rtMiHlN58UdvzE6qdJg5fh78NO7a+nVQSzGBi7L4iOu3b/8OqKFdsEg0X9cpY6rpq2EHOow==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] clk: qcom: Add some missing gcc clks for msm8996
Date: Tue, 17 Apr 2018 17:09:26 -0700
Message-Id: <20180418000926.4998-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

Add a few missing gcc clks for msm8996

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
[bjorn: omit aggre0_noc_qosgen_extref_clk]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

This patch was accompanied by one that allows the udelay to be defined per
branch clock, used by the aggre0_noc_qosgen_extref_clk. I dropped this clock
and the accompanying path in hope that we can get these clock in place.

Several of these clocks are needed by the MSS remoteproc driver.

 drivers/clk/qcom/gcc-msm8996.c               | 186 +++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8996.h |   9 ++
 2 files changed, 195 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 3d6452932797..182e1d2a8bd2 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -262,6 +262,36 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 	},
 };
 
+static struct clk_branch gcc_mmss_gpll0_div_clk = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x5200c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mmss_gpll0_div_clk",
+			.parent_names = (const char *[]){ "gpll0" },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_gpll0_div_clk = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x5200c,
+		.enable_mask = BIT(2),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_gpll0_div_clk",
+			.parent_names = (const char *[]){ "gpll0" },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops
+		},
+	},
+};
+
 static struct clk_alpha_pll gpll4_early = {
 	.offset = 0x77000,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
@@ -2886,6 +2916,36 @@ static struct clk_branch gcc_ufs_tx_symbol_clk_core_clk = {
 	},
 };
 
+static struct clk_branch hlos1_vote_lpass_core_smmu_clk = {
+	.halt_reg = 0x7d010,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "hlos1_vote_lpass_core_smmu_clk",
+			.parent_names = (const char *[]){ "config_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch hlos1_vote_lpass_adsp_smmu_clk = {
+	.halt_reg = 0x7d014,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x7d014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "hlos1_vote_lpass_adsp_smmu_clk",
+			.parent_names = (const char *[]){ "config_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_aggre0_snoc_axi_clk = {
 	.halt_reg = 0x81008,
 	.clkr = {
@@ -2946,6 +3006,20 @@ static struct clk_branch gcc_smmu_aggre0_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_aggre1_pnoc_ahb_clk = {
+	.halt_reg = 0x82014,
+	.clkr = {
+		.enable_reg = 0x82014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_aggre1_pnoc_ahb_clk",
+			.parent_names = (const char *[]){ "periph_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_aggre2_ufs_axi_clk = {
 	.halt_reg = 0x83014,
 	.clkr = {
@@ -2976,6 +3050,34 @@ static struct clk_branch gcc_aggre2_usb3_axi_clk = {
 	},
 };
 
+static struct clk_branch gcc_dcc_ahb_clk = {
+	.halt_reg = 0x84004,
+	.clkr = {
+		.enable_reg = 0x84004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_dcc_ahb_clk",
+			.parent_names = (const char *[]){ "config_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_aggre0_noc_mpu_cfg_ahb_clk = {
+	.halt_reg = 0x85000,
+	.clkr = {
+		.enable_reg = 0x85000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_aggre0_noc_mpu_cfg_ahb_clk",
+			.parent_names = (const char *[]){ "config_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_qspi_ahb_clk = {
 	.halt_reg = 0x8b004,
 	.clkr = {
@@ -3034,6 +3136,20 @@ static struct clk_branch gcc_hdmi_clkref_clk = {
 	},
 };
 
+static struct clk_branch gcc_edp_clkref_clk = {
+	.halt_reg = 0x88004,
+	.clkr = {
+		.enable_reg = 0x88004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_edp_clkref_clk",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_clkref_clk = {
 	.halt_reg = 0x88008,
 	.clkr = {
@@ -3090,6 +3206,62 @@ static struct clk_branch gcc_rx1_usb2_clkref_clk = {
 	},
 };
 
+static struct clk_branch gcc_mss_cfg_ahb_clk = {
+	.halt_reg = 0x8a000,
+	.clkr = {
+		.enable_reg = 0x8a000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_cfg_ahb_clk",
+			.parent_names = (const char *[]){ "config_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_mnoc_bimc_axi_clk = {
+	.halt_reg = 0x8a004,
+	.clkr = {
+		.enable_reg = 0x8a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_mnoc_bimc_axi_clk",
+			.parent_names = (const char *[]){ "system_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_snoc_axi_clk = {
+	.halt_reg = 0x8a024,
+	.clkr = {
+		.enable_reg = 0x8a024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_snoc_axi_clk",
+			.parent_names = (const char *[]){ "system_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
+	.halt_reg = 0x8a028,
+	.clkr = {
+		.enable_reg = 0x8a028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_q6_bimc_axi_clk",
+			.parent_names = (const char *[]){ "system_noc_clk_src" },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_hw *gcc_msm8996_hws[] = {
 	&xo.hw,
 	&gpll0_early_div.hw,
@@ -3350,6 +3522,7 @@ static struct clk_regmap *gcc_msm8996_clocks[] = {
 	[GCC_AGGRE0_CNOC_AHB_CLK] = &gcc_aggre0_cnoc_ahb_clk.clkr,
 	[GCC_SMMU_AGGRE0_AXI_CLK] = &gcc_smmu_aggre0_axi_clk.clkr,
 	[GCC_SMMU_AGGRE0_AHB_CLK] = &gcc_smmu_aggre0_ahb_clk.clkr,
+	[GCC_AGGRE1_PNOC_AHB_CLK] = &gcc_aggre1_pnoc_ahb_clk.clkr,
 	[GCC_AGGRE2_UFS_AXI_CLK] = &gcc_aggre2_ufs_axi_clk.clkr,
 	[GCC_AGGRE2_USB3_AXI_CLK] = &gcc_aggre2_usb3_axi_clk.clkr,
 	[GCC_QSPI_AHB_CLK] = &gcc_qspi_ahb_clk.clkr,
@@ -3360,6 +3533,19 @@ static struct clk_regmap *gcc_msm8996_clocks[] = {
 	[GCC_PCIE_CLKREF_CLK] = &gcc_pcie_clkref_clk.clkr,
 	[GCC_RX2_USB2_CLKREF_CLK] = &gcc_rx2_usb2_clkref_clk.clkr,
 	[GCC_RX1_USB2_CLKREF_CLK] = &gcc_rx1_usb2_clkref_clk.clkr,
+	[GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK] =
+					&hlos1_vote_lpass_core_smmu_clk.clkr,
+	[GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK] =
+					&hlos1_vote_lpass_adsp_smmu_clk.clkr,
+	[GCC_EDP_CLKREF_CLK] = &gcc_edp_clkref_clk.clkr,
+	[GCC_MSS_CFG_AHB_CLK] = &gcc_mss_cfg_ahb_clk.clkr,
+	[GCC_MSS_Q6_BIMC_AXI_CLK] = &gcc_mss_q6_bimc_axi_clk.clkr,
+	[GCC_MSS_SNOC_AXI_CLK] = &gcc_mss_snoc_axi_clk.clkr,
+	[GCC_MSS_MNOC_BIMC_AXI_CLK] = &gcc_mss_mnoc_bimc_axi_clk.clkr,
+	[GCC_DCC_AHB_CLK] = &gcc_dcc_ahb_clk.clkr,
+	[GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK] = &gcc_aggre0_noc_mpu_cfg_ahb_clk.clkr,
+	[GCC_MMSS_GPLL0_DIV_CLK] = &gcc_mmss_gpll0_div_clk.clkr,
+	[GCC_MSS_GPLL0_DIV_CLK] = &gcc_mss_gpll0_div_clk.clkr,
 };
 
 static struct gdsc *gcc_msm8996_gdscs[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8996.h b/include/dt-bindings/clock/qcom,gcc-msm8996.h
index 75b07cf5eed0..db80f2ee571b 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8996.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8996.h
@@ -235,6 +235,15 @@
 #define GCC_RX1_USB2_CLKREF_CLK					218
 #define GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK			219
 #define GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK			220
+#define GCC_EDP_CLKREF_CLK					221
+#define GCC_MSS_CFG_AHB_CLK					222
+#define GCC_MSS_Q6_BIMC_AXI_CLK					223
+#define GCC_MSS_SNOC_AXI_CLK					224
+#define GCC_MSS_MNOC_BIMC_AXI_CLK				225
+#define GCC_DCC_AHB_CLK						226
+#define GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK				227
+#define GCC_MMSS_GPLL0_DIV_CLK					228
+#define GCC_MSS_GPLL0_DIV_CLK					229
 
 #define GCC_SYSTEM_NOC_BCR					0
 #define GCC_CONFIG_NOC_BCR					1
-- 
2.16.2
