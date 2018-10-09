Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58565C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAB72086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YjsoSyZX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lHZd+09C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAB72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJIVPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:15:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42746 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeJIVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:15:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30BE560D0C; Tue,  9 Oct 2018 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539093497;
        bh=lX0EUBw2cFWxHjD52F9iYHASrGwAPE+bXw0Gjyz3v+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjsoSyZXL3yyenPf+WjCn9rOXsQ8//t+kZIQKHGM0/DKkEeonpBXteK2deDhK2bQX
         lr0maiFZIGWYfpISvpFQTzIr5rd/83dYHVoUtuiad5nhCUGnotZnVEfk4mQIRlLi8Y
         wn3nb1dMORhHOHn2z1PzZTNSivo/OM0Wm29ErD3A=
Received: from tdas-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20A0260C7E;
        Tue,  9 Oct 2018 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539093492;
        bh=lX0EUBw2cFWxHjD52F9iYHASrGwAPE+bXw0Gjyz3v+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHZd+09CwffGQES6X62nUkjumiwyWRQh5u6bkoKvrHu2/rrHtLQpD/umMmwEAPrKz
         qfYEd3pxsVbqfUf2+kZz+q60zOgE7caJzpaP14nLcLfEO5mAdejWef6Fg+a7IZFE62
         PE3o3VCVFY3MKHctavq0Ns6QkqSLfItvPPEYAOs8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20A0260C7E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port clocks
Date:   Tue,  9 Oct 2018 19:27:47 +0530
Message-Id: <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 dispcc supports RCG and CBCRs for display port, so add support for
the same.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/dispcc-sdm845.c               | 232 +++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,dispcc-sdm845.h |  11 ++
 2 files changed, 243 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sdm845.c b/drivers/clk/qcom/dispcc-sdm845.c
index 0cc4909..6d3136a 100644
--- a/drivers/clk/qcom/dispcc-sdm845.c
+++ b/drivers/clk/qcom/dispcc-sdm845.c
@@ -29,6 +29,8 @@ enum {
 	P_DSI1_PHY_PLL_OUT_DSICLK,
 	P_GPLL0_OUT_MAIN,
 	P_GPLL0_OUT_MAIN_DIV,
+	P_DP_PHY_PLL_LINK_CLK,
+	P_DP_PHY_PLL_VCO_DIV_CLK,
 };

 static const struct parent_map disp_cc_parent_map_0[] = {
@@ -45,6 +47,20 @@ enum {
 	"core_bi_pll_test_se",
 };

+static const struct parent_map disp_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DP_PHY_PLL_LINK_CLK, 1 },
+	{ P_DP_PHY_PLL_VCO_DIV_CLK, 2 },
+	{ P_CORE_BI_PLL_TEST_SE, 7 },
+};
+
+static const char * const disp_cc_parent_names_1[] = {
+	"bi_tcxo",
+	"dp_link_clk_divsel_ten",
+	"dp_vco_divided_clk_src_mux",
+	"core_bi_pll_test_se",
+};
+
 static const struct parent_map disp_cc_parent_map_2[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
@@ -128,6 +144,100 @@ enum {
 	},
 };

+static const struct freq_tbl ftbl_disp_cc_mdss_dp_aux_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
+	.cmd_rcgr = 0x219c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_2,
+	.freq_tbl = ftbl_disp_cc_mdss_dp_aux_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_dp_aux_clk_src",
+		.parent_names = disp_cc_parent_names_2,
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_dp_crypto_clk_src[] = {
+	F(108000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
+	F(180000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
+	F(360000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
+	F(540000, P_DP_PHY_PLL_LINK_CLK,   3,   0,   0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
+	.cmd_rcgr = 0x2154,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_1,
+	.freq_tbl = ftbl_disp_cc_mdss_dp_crypto_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_dp_crypto_clk_src",
+		.parent_names = disp_cc_parent_names_1,
+		.num_parents = 4,
+		.flags = CLK_GET_RATE_NOCACHE,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] = {
+	F(162000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
+	F(270000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
+	F(540000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
+	F(810000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
+	.cmd_rcgr = 0x2138,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_1,
+	.freq_tbl = ftbl_disp_cc_mdss_dp_link_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_dp_link_clk_src",
+		.parent_names = disp_cc_parent_names_1,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_dp_pixel1_clk_src = {
+	.cmd_rcgr = 0x2184,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_1,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_dp_pixel1_clk_src",
+		.parent_names = disp_cc_parent_names_1,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_dp_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src = {
+	.cmd_rcgr = 0x216c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_1,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_dp_pixel_clk_src",
+		.parent_names = disp_cc_parent_names_1,
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_dp_ops,
+	},
+};
+
 static const struct freq_tbl ftbl_disp_cc_mdss_esc0_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	{ }
@@ -391,6 +501,115 @@ enum {
 	},
 };

+static struct clk_branch disp_cc_mdss_dp_aux_clk = {
+	.halt_reg = 0x2054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_dp_aux_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_dp_aux_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_dp_crypto_clk = {
+	.halt_reg = 0x2048,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_dp_crypto_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_dp_crypto_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_dp_link_clk = {
+	.halt_reg = 0x2040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_dp_link_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_dp_link_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+/* reset state of disp_cc_mdss_dp_link_div_clk_src divider is 0x3 (div 4) */
+static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
+	.halt_reg = 0x2044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_dp_link_intf_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_dp_link_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_dp_pixel1_clk = {
+	.halt_reg = 0x2050,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2050,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_dp_pixel1_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_dp_pixel1_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_dp_pixel_clk = {
+	.halt_reg = 0x204c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x204c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_dp_pixel_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_dp_pixel_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch disp_cc_mdss_esc0_clk = {
 	.halt_reg = 0x2038,
 	.halt_check = BRANCH_HALT,
@@ -589,6 +808,19 @@ enum {
 	[DISP_CC_MDSS_BYTE1_INTF_CLK] = &disp_cc_mdss_byte1_intf_clk.clkr,
 	[DISP_CC_MDSS_BYTE1_DIV_CLK_SRC] =
 					&disp_cc_mdss_byte1_div_clk_src.clkr,
+	[DISP_CC_MDSS_DP_AUX_CLK] = &disp_cc_mdss_dp_aux_clk.clkr,
+	[DISP_CC_MDSS_DP_AUX_CLK_SRC] = &disp_cc_mdss_dp_aux_clk_src.clkr,
+	[DISP_CC_MDSS_DP_CRYPTO_CLK] = &disp_cc_mdss_dp_crypto_clk.clkr,
+	[DISP_CC_MDSS_DP_CRYPTO_CLK_SRC] =
+					&disp_cc_mdss_dp_crypto_clk_src.clkr,
+	[DISP_CC_MDSS_DP_LINK_CLK] = &disp_cc_mdss_dp_link_clk.clkr,
+	[DISP_CC_MDSS_DP_LINK_CLK_SRC] = &disp_cc_mdss_dp_link_clk_src.clkr,
+	[DISP_CC_MDSS_DP_LINK_INTF_CLK] = &disp_cc_mdss_dp_link_intf_clk.clkr,
+	[DISP_CC_MDSS_DP_PIXEL1_CLK] = &disp_cc_mdss_dp_pixel1_clk.clkr,
+	[DISP_CC_MDSS_DP_PIXEL1_CLK_SRC] =
+					&disp_cc_mdss_dp_pixel1_clk_src.clkr,
+	[DISP_CC_MDSS_DP_PIXEL_CLK] = &disp_cc_mdss_dp_pixel_clk.clkr,
+	[DISP_CC_MDSS_DP_PIXEL_CLK_SRC] = &disp_cc_mdss_dp_pixel_clk_src.clkr,
 	[DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
 	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
 	[DISP_CC_MDSS_ESC1_CLK] = &disp_cc_mdss_esc1_clk.clkr,
diff --git a/include/dt-bindings/clock/qcom,dispcc-sdm845.h b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
index 11eed4b..526d98a 100644
--- a/include/dt-bindings/clock/qcom,dispcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
@@ -35,6 +35,17 @@
 #define DISP_CC_PLL0						25
 #define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				26
 #define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				27
+#define DISP_CC_MDSS_DP_AUX_CLK					28
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC				29
+#define DISP_CC_MDSS_DP_CRYPTO_CLK				30
+#define DISP_CC_MDSS_DP_CRYPTO_CLK_SRC				31
+#define DISP_CC_MDSS_DP_LINK_CLK				32
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC				33
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK				34
+#define DISP_CC_MDSS_DP_PIXEL1_CLK				35
+#define DISP_CC_MDSS_DP_PIXEL1_CLK_SRC				36
+#define DISP_CC_MDSS_DP_PIXEL_CLK				37
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC				38

 /* DISP_CC Reset */
 #define DISP_CC_MDSS_RSCC_BCR					0
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

