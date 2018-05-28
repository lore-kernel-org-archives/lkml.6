Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbeE1IxH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:53:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbeE1IxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:53:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90D4860618
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From: Amit Nischal <anischal@codeaurora.org>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH] clk: qcom: Enable clocks which needs to be always on for SDM845
Date: Mon, 28 May 2018 14:22:44 +0530
Message-Id: <1527497564-11125-1-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain clocks which needs to be always enabled for
system operation. Remove support for such clocks from the clock
driver and enable them explicitly gcc driver probe.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/gcc-sdm845.c               | 119 +---------
 include/dt-bindings/clock/qcom,gcc-sdm845.h | 351 ++++++++++++++--------------
 2 files changed, 182 insertions(+), 288 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index e78e6f5..b40aafc 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -1093,21 +1093,6 @@ enum {
 	},
 };

-static struct clk_branch gcc_camera_ahb_clk = {
-	.halt_reg = 0xb008,
-	.halt_check = BRANCH_HALT,
-	.hwcg_reg = 0xb008,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0xb008,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_camera_ahb_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_camera_axi_clk = {
 	.halt_reg = 0xb020,
 	.halt_check = BRANCH_VOTED,
@@ -1121,19 +1106,6 @@ enum {
 	},
 };

-static struct clk_branch gcc_camera_xo_clk = {
-	.halt_reg = 0xb02c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xb02c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_camera_xo_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_ce1_ahb_clk = {
 	.halt_reg = 0x4100c,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -1260,21 +1232,6 @@ enum {
 	},
 };

-static struct clk_branch gcc_disp_ahb_clk = {
-	.halt_reg = 0xb00c,
-	.halt_check = BRANCH_HALT,
-	.hwcg_reg = 0xb00c,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0xb00c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_disp_ahb_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_disp_axi_clk = {
 	.halt_reg = 0xb024,
 	.halt_check = BRANCH_VOTED,
@@ -1320,19 +1277,6 @@ enum {
 	},
 };

-static struct clk_branch gcc_disp_xo_clk = {
-	.halt_reg = 0xb030,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xb030,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_disp_xo_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_gp1_clk = {
 	.halt_reg = 0x64000,
 	.halt_check = BRANCH_HALT,
@@ -1387,21 +1331,6 @@ enum {
 	},
 };

-static struct clk_branch gcc_gpu_cfg_ahb_clk = {
-	.halt_reg = 0x71004,
-	.halt_check = BRANCH_HALT,
-	.hwcg_reg = 0x71004,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x71004,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_gpu_cfg_ahb_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_gpu_gpll0_clk_src = {
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
@@ -2975,21 +2904,6 @@ enum {
 	},
 };

-static struct clk_branch gcc_video_ahb_clk = {
-	.halt_reg = 0xb004,
-	.halt_check = BRANCH_HALT,
-	.hwcg_reg = 0xb004,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0xb004,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_video_ahb_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_video_axi_clk = {
 	.halt_reg = 0xb01c,
 	.halt_check = BRANCH_VOTED,
@@ -3003,19 +2917,6 @@ enum {
 	},
 };

-static struct clk_branch gcc_video_xo_clk = {
-	.halt_reg = 0xb028,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0xb028,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_video_xo_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_vs_ctrl_ahb_clk = {
 	.halt_reg = 0x7a014,
 	.halt_check = BRANCH_HALT,
@@ -3167,9 +3068,7 @@ enum {
 	[GCC_AGGRE_USB3_SEC_AXI_CLK] = &gcc_aggre_usb3_sec_axi_clk.clkr,
 	[GCC_APC_VS_CLK] = &gcc_apc_vs_clk.clkr,
 	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
-	[GCC_CAMERA_AHB_CLK] = &gcc_camera_ahb_clk.clkr,
 	[GCC_CAMERA_AXI_CLK] = &gcc_camera_axi_clk.clkr,
-	[GCC_CAMERA_XO_CLK] = &gcc_camera_xo_clk.clkr,
 	[GCC_CE1_AHB_CLK] = &gcc_ce1_ahb_clk.clkr,
 	[GCC_CE1_AXI_CLK] = &gcc_ce1_axi_clk.clkr,
 	[GCC_CE1_CLK] = &gcc_ce1_clk.clkr,
@@ -3180,18 +3079,15 @@ enum {
 	[GCC_CPUSS_RBCPR_CLK] = &gcc_cpuss_rbcpr_clk.clkr,
 	[GCC_CPUSS_RBCPR_CLK_SRC] = &gcc_cpuss_rbcpr_clk_src.clkr,
 	[GCC_DDRSS_GPU_AXI_CLK] = &gcc_ddrss_gpu_axi_clk.clkr,
-	[GCC_DISP_AHB_CLK] = &gcc_disp_ahb_clk.clkr,
 	[GCC_DISP_AXI_CLK] = &gcc_disp_axi_clk.clkr,
 	[GCC_DISP_GPLL0_CLK_SRC] = &gcc_disp_gpll0_clk_src.clkr,
 	[GCC_DISP_GPLL0_DIV_CLK_SRC] = &gcc_disp_gpll0_div_clk_src.clkr,
-	[GCC_DISP_XO_CLK] = &gcc_disp_xo_clk.clkr,
 	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
 	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
 	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
 	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
 	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
-	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
 	[GCC_GPU_GPLL0_CLK_SRC] = &gcc_gpu_gpll0_clk_src.clkr,
 	[GCC_GPU_GPLL0_DIV_CLK_SRC] = &gcc_gpu_gpll0_div_clk_src.clkr,
 	[GCC_GPU_IREF_CLK] = &gcc_gpu_iref_clk.clkr,
@@ -3334,9 +3230,7 @@ enum {
 	[GCC_VDDA_VS_CLK] = &gcc_vdda_vs_clk.clkr,
 	[GCC_VDDCX_VS_CLK] = &gcc_vddcx_vs_clk.clkr,
 	[GCC_VDDMX_VS_CLK] = &gcc_vddmx_vs_clk.clkr,
-	[GCC_VIDEO_AHB_CLK] = &gcc_video_ahb_clk.clkr,
 	[GCC_VIDEO_AXI_CLK] = &gcc_video_axi_clk.clkr,
-	[GCC_VIDEO_XO_CLK] = &gcc_video_xo_clk.clkr,
 	[GCC_VS_CTRL_AHB_CLK] = &gcc_vs_ctrl_ahb_clk.clkr,
 	[GCC_VS_CTRL_CLK] = &gcc_vs_ctrl_clk.clkr,
 	[GCC_VS_CTRL_CLK_SRC] = &gcc_vs_ctrl_clk_src.clkr,
@@ -3433,9 +3327,16 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
 	regmap_update_bits(regmap, 0x71028, 0x3, 0x3);

-	/* Enable CPUSS clocks */
-	regmap_update_bits(regmap, 0x48190, BIT(0), 0x1);
-	regmap_update_bits(regmap, 0x52004, BIT(22), 0x1);
+	/* Enable clocks which are required to be always ON */
+	regmap_update_bits(regmap, 0xb004, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0xb008, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0xb00c, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0xb028, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0xb02c, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0xb030, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0x48190, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0x52004, BIT(22), BIT(22));
+	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));

 	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
 }
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index aca6126..6330c3f 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -13,185 +13,178 @@
 #define GCC_AGGRE_USB3_PRIM_AXI_CLK				3
 #define GCC_AGGRE_USB3_SEC_AXI_CLK				4
 #define GCC_BOOT_ROM_AHB_CLK					5
-#define GCC_CAMERA_AHB_CLK					6
-#define GCC_CAMERA_AXI_CLK					7
-#define GCC_CAMERA_XO_CLK					8
-#define GCC_CE1_AHB_CLK						9
-#define GCC_CE1_AXI_CLK						10
-#define GCC_CE1_CLK						11
-#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				12
-#define GCC_CFG_NOC_USB3_SEC_AXI_CLK				13
-#define GCC_CPUSS_AHB_CLK					14
-#define GCC_CPUSS_AHB_CLK_SRC					15
-#define GCC_CPUSS_RBCPR_CLK					16
-#define GCC_CPUSS_RBCPR_CLK_SRC					17
-#define GCC_DDRSS_GPU_AXI_CLK					18
-#define GCC_DISP_AHB_CLK					19
-#define GCC_DISP_AXI_CLK					20
-#define GCC_DISP_GPLL0_CLK_SRC					21
-#define GCC_DISP_GPLL0_DIV_CLK_SRC				22
-#define GCC_DISP_XO_CLK						23
-#define GCC_GP1_CLK						24
-#define GCC_GP1_CLK_SRC						25
-#define GCC_GP2_CLK						26
-#define GCC_GP2_CLK_SRC						27
-#define GCC_GP3_CLK						28
-#define GCC_GP3_CLK_SRC						29
-#define GCC_GPU_CFG_AHB_CLK					30
-#define GCC_GPU_GPLL0_CLK_SRC					31
-#define GCC_GPU_GPLL0_DIV_CLK_SRC				32
-#define GCC_GPU_MEMNOC_GFX_CLK					33
-#define GCC_GPU_SNOC_DVM_GFX_CLK				34
-#define GCC_MSS_AXIS2_CLK					35
-#define GCC_MSS_CFG_AHB_CLK					36
-#define GCC_MSS_GPLL0_DIV_CLK_SRC				37
-#define GCC_MSS_MFAB_AXIS_CLK					38
-#define GCC_MSS_Q6_MEMNOC_AXI_CLK				39
-#define GCC_MSS_SNOC_AXI_CLK					40
-#define GCC_PCIE_0_AUX_CLK					41
-#define GCC_PCIE_0_AUX_CLK_SRC					42
-#define GCC_PCIE_0_CFG_AHB_CLK					43
-#define GCC_PCIE_0_CLKREF_CLK					44
-#define GCC_PCIE_0_MSTR_AXI_CLK					45
-#define GCC_PCIE_0_PIPE_CLK					46
-#define GCC_PCIE_0_SLV_AXI_CLK					47
-#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				48
-#define GCC_PCIE_1_AUX_CLK					49
-#define GCC_PCIE_1_AUX_CLK_SRC					50
-#define GCC_PCIE_1_CFG_AHB_CLK					51
-#define GCC_PCIE_1_CLKREF_CLK					52
-#define GCC_PCIE_1_MSTR_AXI_CLK					53
-#define GCC_PCIE_1_PIPE_CLK					54
-#define GCC_PCIE_1_SLV_AXI_CLK					55
-#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				56
-#define GCC_PCIE_PHY_AUX_CLK					57
-#define GCC_PCIE_PHY_REFGEN_CLK					58
-#define GCC_PCIE_PHY_REFGEN_CLK_SRC				59
-#define GCC_PDM2_CLK						60
-#define GCC_PDM2_CLK_SRC					61
-#define GCC_PDM_AHB_CLK						62
-#define GCC_PDM_XO4_CLK						63
-#define GCC_PRNG_AHB_CLK					64
-#define GCC_QMIP_CAMERA_AHB_CLK					65
-#define GCC_QMIP_DISP_AHB_CLK					66
-#define GCC_QMIP_VIDEO_AHB_CLK					67
-#define GCC_QUPV3_WRAP0_S0_CLK					68
-#define GCC_QUPV3_WRAP0_S0_CLK_SRC				69
-#define GCC_QUPV3_WRAP0_S1_CLK					70
-#define GCC_QUPV3_WRAP0_S1_CLK_SRC				71
-#define GCC_QUPV3_WRAP0_S2_CLK					72
-#define GCC_QUPV3_WRAP0_S2_CLK_SRC				73
-#define GCC_QUPV3_WRAP0_S3_CLK					74
-#define GCC_QUPV3_WRAP0_S3_CLK_SRC				75
-#define GCC_QUPV3_WRAP0_S4_CLK					76
-#define GCC_QUPV3_WRAP0_S4_CLK_SRC				77
-#define GCC_QUPV3_WRAP0_S5_CLK					78
-#define GCC_QUPV3_WRAP0_S5_CLK_SRC				79
-#define GCC_QUPV3_WRAP0_S6_CLK					80
-#define GCC_QUPV3_WRAP0_S6_CLK_SRC				81
-#define GCC_QUPV3_WRAP0_S7_CLK					82
-#define GCC_QUPV3_WRAP0_S7_CLK_SRC				83
-#define GCC_QUPV3_WRAP1_S0_CLK					84
-#define GCC_QUPV3_WRAP1_S0_CLK_SRC				85
-#define GCC_QUPV3_WRAP1_S1_CLK					86
-#define GCC_QUPV3_WRAP1_S1_CLK_SRC				87
-#define GCC_QUPV3_WRAP1_S2_CLK					88
-#define GCC_QUPV3_WRAP1_S2_CLK_SRC				89
-#define GCC_QUPV3_WRAP1_S3_CLK					90
-#define GCC_QUPV3_WRAP1_S3_CLK_SRC				91
-#define GCC_QUPV3_WRAP1_S4_CLK					92
-#define GCC_QUPV3_WRAP1_S4_CLK_SRC				93
-#define GCC_QUPV3_WRAP1_S5_CLK					94
-#define GCC_QUPV3_WRAP1_S5_CLK_SRC				95
-#define GCC_QUPV3_WRAP1_S6_CLK					96
-#define GCC_QUPV3_WRAP1_S6_CLK_SRC				97
-#define GCC_QUPV3_WRAP1_S7_CLK					98
-#define GCC_QUPV3_WRAP1_S7_CLK_SRC				99
-#define GCC_QUPV3_WRAP_0_M_AHB_CLK				100
-#define GCC_QUPV3_WRAP_0_S_AHB_CLK				101
-#define GCC_QUPV3_WRAP_1_M_AHB_CLK				102
-#define GCC_QUPV3_WRAP_1_S_AHB_CLK				103
-#define GCC_SDCC2_AHB_CLK					104
-#define GCC_SDCC2_APPS_CLK					105
-#define GCC_SDCC2_APPS_CLK_SRC					106
-#define GCC_SDCC4_AHB_CLK					107
-#define GCC_SDCC4_APPS_CLK					108
-#define GCC_SDCC4_APPS_CLK_SRC					109
-#define GCC_SYS_NOC_CPUSS_AHB_CLK				110
-#define GCC_TSIF_AHB_CLK					111
-#define GCC_TSIF_INACTIVITY_TIMERS_CLK				112
-#define GCC_TSIF_REF_CLK					113
-#define GCC_TSIF_REF_CLK_SRC					114
-#define GCC_UFS_CARD_AHB_CLK					115
-#define GCC_UFS_CARD_AXI_CLK					116
-#define GCC_UFS_CARD_AXI_CLK_SRC				117
-#define GCC_UFS_CARD_CLKREF_CLK					118
-#define GCC_UFS_CARD_ICE_CORE_CLK				119
-#define GCC_UFS_CARD_ICE_CORE_CLK_SRC				120
-#define GCC_UFS_CARD_PHY_AUX_CLK				121
-#define GCC_UFS_CARD_PHY_AUX_CLK_SRC				122
-#define GCC_UFS_CARD_RX_SYMBOL_0_CLK				123
-#define GCC_UFS_CARD_RX_SYMBOL_1_CLK				124
-#define GCC_UFS_CARD_TX_SYMBOL_0_CLK				125
-#define GCC_UFS_CARD_UNIPRO_CORE_CLK				126
-#define GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC			127
-#define GCC_UFS_MEM_CLKREF_CLK					128
-#define GCC_UFS_PHY_AHB_CLK					129
-#define GCC_UFS_PHY_AXI_CLK					130
-#define GCC_UFS_PHY_AXI_CLK_SRC					131
-#define GCC_UFS_PHY_ICE_CORE_CLK				132
-#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				133
-#define GCC_UFS_PHY_PHY_AUX_CLK					134
-#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				135
-#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				136
-#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				137
-#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				138
-#define GCC_UFS_PHY_UNIPRO_CORE_CLK				139
-#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				140
-#define GCC_USB30_PRIM_MASTER_CLK				141
-#define GCC_USB30_PRIM_MASTER_CLK_SRC				142
-#define GCC_USB30_PRIM_MOCK_UTMI_CLK				143
-#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			144
-#define GCC_USB30_PRIM_SLEEP_CLK				145
-#define GCC_USB30_SEC_MASTER_CLK				146
-#define GCC_USB30_SEC_MASTER_CLK_SRC				147
-#define GCC_USB30_SEC_MOCK_UTMI_CLK				148
-#define GCC_USB30_SEC_MOCK_UTMI_CLK_SRC				149
-#define GCC_USB30_SEC_SLEEP_CLK					150
-#define GCC_USB3_PRIM_CLKREF_CLK				151
-#define GCC_USB3_PRIM_PHY_AUX_CLK				152
-#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				153
-#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				154
-#define GCC_USB3_PRIM_PHY_PIPE_CLK				155
-#define GCC_USB3_SEC_CLKREF_CLK					156
-#define GCC_USB3_SEC_PHY_AUX_CLK				157
-#define GCC_USB3_SEC_PHY_AUX_CLK_SRC				158
-#define GCC_USB3_SEC_PHY_PIPE_CLK				159
-#define GCC_USB3_SEC_PHY_COM_AUX_CLK				160
-#define GCC_USB_PHY_CFG_AHB2PHY_CLK				161
-#define GCC_VIDEO_AHB_CLK					162
-#define GCC_VIDEO_AXI_CLK					163
-#define GCC_VIDEO_XO_CLK					164
-#define GPLL0							165
-#define GPLL0_OUT_EVEN						166
-#define GPLL0_OUT_MAIN						167
-#define GCC_GPU_IREF_CLK					168
-#define GCC_SDCC1_AHB_CLK					169
-#define GCC_SDCC1_APPS_CLK					170
-#define GCC_SDCC1_ICE_CORE_CLK					171
-#define GCC_SDCC1_APPS_CLK_SRC					172
-#define GCC_SDCC1_ICE_CORE_CLK_SRC				173
-#define GCC_APC_VS_CLK						174
-#define GCC_GPU_VS_CLK						175
-#define GCC_MSS_VS_CLK						176
-#define GCC_VDDA_VS_CLK						177
-#define GCC_VDDCX_VS_CLK					178
-#define GCC_VDDMX_VS_CLK					179
-#define GCC_VS_CTRL_AHB_CLK					180
-#define GCC_VS_CTRL_CLK						181
-#define GCC_VS_CTRL_CLK_SRC					182
-#define GCC_VSENSOR_CLK_SRC					183
-#define GPLL4							184
+#define GCC_CAMERA_AXI_CLK					6
+#define GCC_CE1_AHB_CLK						7
+#define GCC_CE1_AXI_CLK						8
+#define GCC_CE1_CLK						9
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				10
+#define GCC_CFG_NOC_USB3_SEC_AXI_CLK				11
+#define GCC_CPUSS_AHB_CLK					12
+#define GCC_CPUSS_AHB_CLK_SRC					13
+#define GCC_CPUSS_RBCPR_CLK					14
+#define GCC_CPUSS_RBCPR_CLK_SRC					15
+#define GCC_DDRSS_GPU_AXI_CLK					16
+#define GCC_DISP_AXI_CLK					17
+#define GCC_DISP_GPLL0_CLK_SRC					18
+#define GCC_DISP_GPLL0_DIV_CLK_SRC				19
+#define GCC_GP1_CLK						20
+#define GCC_GP1_CLK_SRC						21
+#define GCC_GP2_CLK						22
+#define GCC_GP2_CLK_SRC						23
+#define GCC_GP3_CLK						24
+#define GCC_GP3_CLK_SRC						25
+#define GCC_GPU_GPLL0_CLK_SRC					26
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				27
+#define GCC_GPU_MEMNOC_GFX_CLK					28
+#define GCC_GPU_SNOC_DVM_GFX_CLK				29
+#define GCC_MSS_AXIS2_CLK					30
+#define GCC_MSS_CFG_AHB_CLK					31
+#define GCC_MSS_GPLL0_DIV_CLK_SRC				32
+#define GCC_MSS_MFAB_AXIS_CLK					33
+#define GCC_MSS_Q6_MEMNOC_AXI_CLK				34
+#define GCC_MSS_SNOC_AXI_CLK					35
+#define GCC_PCIE_0_AUX_CLK					36
+#define GCC_PCIE_0_AUX_CLK_SRC					37
+#define GCC_PCIE_0_CFG_AHB_CLK					38
+#define GCC_PCIE_0_CLKREF_CLK					39
+#define GCC_PCIE_0_MSTR_AXI_CLK					40
+#define GCC_PCIE_0_PIPE_CLK					41
+#define GCC_PCIE_0_SLV_AXI_CLK					42
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				43
+#define GCC_PCIE_1_AUX_CLK					44
+#define GCC_PCIE_1_AUX_CLK_SRC					45
+#define GCC_PCIE_1_CFG_AHB_CLK					46
+#define GCC_PCIE_1_CLKREF_CLK					47
+#define GCC_PCIE_1_MSTR_AXI_CLK					48
+#define GCC_PCIE_1_PIPE_CLK					49
+#define GCC_PCIE_1_SLV_AXI_CLK					50
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				51
+#define GCC_PCIE_PHY_AUX_CLK					52
+#define GCC_PCIE_PHY_REFGEN_CLK					53
+#define GCC_PCIE_PHY_REFGEN_CLK_SRC				54
+#define GCC_PDM2_CLK						55
+#define GCC_PDM2_CLK_SRC					56
+#define GCC_PDM_AHB_CLK						57
+#define GCC_PDM_XO4_CLK						58
+#define GCC_PRNG_AHB_CLK					59
+#define GCC_QMIP_CAMERA_AHB_CLK					60
+#define GCC_QMIP_DISP_AHB_CLK					61
+#define GCC_QMIP_VIDEO_AHB_CLK					62
+#define GCC_QUPV3_WRAP0_S0_CLK					63
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				64
+#define GCC_QUPV3_WRAP0_S1_CLK					65
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				66
+#define GCC_QUPV3_WRAP0_S2_CLK					67
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				68
+#define GCC_QUPV3_WRAP0_S3_CLK					69
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				70
+#define GCC_QUPV3_WRAP0_S4_CLK					71
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				72
+#define GCC_QUPV3_WRAP0_S5_CLK					73
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				74
+#define GCC_QUPV3_WRAP0_S6_CLK					75
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC				76
+#define GCC_QUPV3_WRAP0_S7_CLK					77
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC				78
+#define GCC_QUPV3_WRAP1_S0_CLK					79
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				80
+#define GCC_QUPV3_WRAP1_S1_CLK					81
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				82
+#define GCC_QUPV3_WRAP1_S2_CLK					83
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				84
+#define GCC_QUPV3_WRAP1_S3_CLK					85
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				86
+#define GCC_QUPV3_WRAP1_S4_CLK					87
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				88
+#define GCC_QUPV3_WRAP1_S5_CLK					89
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				90
+#define GCC_QUPV3_WRAP1_S6_CLK					91
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC				92
+#define GCC_QUPV3_WRAP1_S7_CLK					93
+#define GCC_QUPV3_WRAP1_S7_CLK_SRC				94
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				95
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				96
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				97
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				98
+#define GCC_SDCC2_AHB_CLK					99
+#define GCC_SDCC2_APPS_CLK					100
+#define GCC_SDCC2_APPS_CLK_SRC					101
+#define GCC_SDCC4_AHB_CLK					102
+#define GCC_SDCC4_APPS_CLK					103
+#define GCC_SDCC4_APPS_CLK_SRC					104
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				105
+#define GCC_TSIF_AHB_CLK					106
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK				107
+#define GCC_TSIF_REF_CLK					108
+#define GCC_TSIF_REF_CLK_SRC					109
+#define GCC_UFS_CARD_AHB_CLK					110
+#define GCC_UFS_CARD_AXI_CLK					111
+#define GCC_UFS_CARD_AXI_CLK_SRC				112
+#define GCC_UFS_CARD_CLKREF_CLK					113
+#define GCC_UFS_CARD_ICE_CORE_CLK				114
+#define GCC_UFS_CARD_ICE_CORE_CLK_SRC				115
+#define GCC_UFS_CARD_PHY_AUX_CLK				116
+#define GCC_UFS_CARD_PHY_AUX_CLK_SRC				117
+#define GCC_UFS_CARD_RX_SYMBOL_0_CLK				118
+#define GCC_UFS_CARD_RX_SYMBOL_1_CLK				119
+#define GCC_UFS_CARD_TX_SYMBOL_0_CLK				120
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK				121
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC			122
+#define GCC_UFS_MEM_CLKREF_CLK					123
+#define GCC_UFS_PHY_AHB_CLK					124
+#define GCC_UFS_PHY_AXI_CLK					125
+#define GCC_UFS_PHY_AXI_CLK_SRC					126
+#define GCC_UFS_PHY_ICE_CORE_CLK				127
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				128
+#define GCC_UFS_PHY_PHY_AUX_CLK					129
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				130
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				131
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				132
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				133
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				134
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				135
+#define GCC_USB30_PRIM_MASTER_CLK				136
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				137
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				138
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			139
+#define GCC_USB30_PRIM_SLEEP_CLK				140
+#define GCC_USB30_SEC_MASTER_CLK				141
+#define GCC_USB30_SEC_MASTER_CLK_SRC				142
+#define GCC_USB30_SEC_MOCK_UTMI_CLK				143
+#define GCC_USB30_SEC_MOCK_UTMI_CLK_SRC				144
+#define GCC_USB30_SEC_SLEEP_CLK					145
+#define GCC_USB3_PRIM_CLKREF_CLK				146
+#define GCC_USB3_PRIM_PHY_AUX_CLK				147
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				148
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				149
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				150
+#define GCC_USB3_SEC_CLKREF_CLK					151
+#define GCC_USB3_SEC_PHY_AUX_CLK				152
+#define GCC_USB3_SEC_PHY_AUX_CLK_SRC				153
+#define GCC_USB3_SEC_PHY_PIPE_CLK				154
+#define GCC_USB3_SEC_PHY_COM_AUX_CLK				155
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK				156
+#define GCC_VIDEO_AXI_CLK					157
+#define GPLL0							158
+#define GPLL0_OUT_EVEN						159
+#define GPLL0_OUT_MAIN						160
+#define GCC_GPU_IREF_CLK					161
+#define GCC_SDCC1_AHB_CLK					162
+#define GCC_SDCC1_APPS_CLK					163
+#define GCC_SDCC1_ICE_CORE_CLK					164
+#define GCC_SDCC1_APPS_CLK_SRC					165
+#define GCC_SDCC1_ICE_CORE_CLK_SRC				166
+#define GCC_APC_VS_CLK						167
+#define GCC_GPU_VS_CLK						168
+#define GCC_MSS_VS_CLK						169
+#define GCC_VDDA_VS_CLK						170
+#define GCC_VDDCX_VS_CLK					171
+#define GCC_VDDMX_VS_CLK					172
+#define GCC_VS_CTRL_AHB_CLK					173
+#define GCC_VS_CTRL_CLK						174
+#define GCC_VS_CTRL_CLK_SRC					175
+#define GCC_VSENSOR_CLK_SRC					176
+#define GPLL4							177

 /* GCC Resets */
 #define GCC_MMSS_BCR						0
--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
