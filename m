Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB871C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701BD2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548742232;
	bh=8OWpSkUy4dPTB7G6tQ9SurVjPpM690XiBZ84Y9OR6w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WH+MLtW74cCS3rtqEoC0Y+As5fXsHMcjI13sRR7d62HTjK2ERaEtAM7wmqz8IWwjR
	 B3HqV3UAiez4RsPEXow3eomNDm8pdMcU1l6mrEzxJko3Ibevp0tusikNfU3BflMQUW
	 rrEg0yuZHc/7daV1jPxuN7X/3cNhnczGPvW6Lm/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfA2GKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfA2GK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:10:27 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E12021873;
        Tue, 29 Jan 2019 06:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548742225;
        bh=8OWpSkUy4dPTB7G6tQ9SurVjPpM690XiBZ84Y9OR6w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muTgoQHowEnKiFGG6ylcj22+mZq+vGuj9K7fSfc2u5xYy2jcVfpGhp6NJqNZGSxdT
         7SuZp/uE3Px0Mw+kBYK93yUDWQtvyUG6YQyHm1ioBpH4+mxrZbwTjlYKu61O+HPIU7
         NFUrAIVVmS4MdjPJETWNBy4Uen5hRiMK3ROibhSc=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 8/9] clk: qcom: gcc-sdm845: Migrate to DT parent mapping
Date:   Mon, 28 Jan 2019 22:10:20 -0800
Message-Id: <20190129061021.94775-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129061021.94775-1-sboyd@kernel.org>
References: <20190129061021.94775-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TODO: Fully convert driver

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-sdm845.c | 180 +++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 91 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index f133b7f5652f..9da9a337238d 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -25,6 +25,59 @@
 #include "gdsc.h"
 #include "reset.h"
 
+static struct clk_alpha_pll gpll0 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll0",
+			.parent_names = (const char *[]){ "bi_tcxo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_fabia_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gpll4 = {
+	.offset = 0x76000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll4",
+			.parent_names = (const char *[]){ "bi_tcxo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_fabia_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_fabia_even[] = {
+	{ 0x0, 1 },
+	{ 0x1, 2 },
+	{ 0x3, 4 },
+	{ 0x7, 8 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gpll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_fabia_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll0_out_even",
+		.parent_names = (const char *[]){ "gpll0" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
 enum {
 	P_BI_TCXO,
 	P_AUD_REF_CLK,
@@ -42,11 +95,11 @@ static const struct parent_map gcc_parent_map_0[] = {
 	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
-static const char * const gcc_parent_names_0[] = {
-	"bi_tcxo",
-	"gpll0",
-	"gpll0_out_even",
-	"core_bi_pll_test_se",
+static const struct clk_parent_data gcc_parent_data_0[] = {
+	{ .name = "xo", .fallback = "bi_tcxo" },
+	{ .hw = &gpll0.clkr.hw },
+	{ .hw = &gpll0_out_even.clkr.hw },
+	{ .name = "core_bi_pll_test_se", .fallback = "core_bi_pll_test_se" }
 };
 
 static const struct parent_map gcc_parent_map_1[] = {
@@ -144,59 +197,6 @@ static const char * const gcc_parent_names_10[] = {
 	"core_bi_pll_test_se",
 };
 
-static struct clk_alpha_pll gpll0 = {
-	.offset = 0x0,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
-	.clkr = {
-		.enable_reg = 0x52000,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpll0",
-			.parent_names = (const char *[]){ "bi_tcxo" },
-			.num_parents = 1,
-			.ops = &clk_alpha_pll_fixed_fabia_ops,
-		},
-	},
-};
-
-static struct clk_alpha_pll gpll4 = {
-	.offset = 0x76000,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
-	.clkr = {
-		.enable_reg = 0x52000,
-		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpll4",
-			.parent_names = (const char *[]){ "bi_tcxo" },
-			.num_parents = 1,
-			.ops = &clk_alpha_pll_fixed_fabia_ops,
-		},
-	},
-};
-
-static const struct clk_div_table post_div_table_fabia_even[] = {
-	{ 0x0, 1 },
-	{ 0x1, 2 },
-	{ 0x3, 4 },
-	{ 0x7, 8 },
-	{ }
-};
-
-static struct clk_alpha_pll_postdiv gpll0_out_even = {
-	.offset = 0x0,
-	.post_div_shift = 8,
-	.post_div_table = post_div_table_fabia_even,
-	.num_post_div = ARRAY_SIZE(post_div_table_fabia_even),
-	.width = 4,
-	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "gpll0_out_even",
-		.parent_names = (const char *[]){ "gpll0" },
-		.num_parents = 1,
-		.ops = &clk_alpha_pll_postdiv_fabia_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_gcc_cpuss_ahb_clk_src[] = {
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	{ }
@@ -334,7 +334,7 @@ static struct clk_rcg2 gcc_pcie_phy_refgen_clk_src = {
 	.freq_tbl = ftbl_gcc_pcie_phy_refgen_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pcie_phy_refgen_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -356,7 +356,7 @@ static struct clk_rcg2 gcc_qspi_core_clk_src = {
 	.freq_tbl = ftbl_gcc_qspi_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_qspi_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_floor_ops,
 	},
@@ -377,7 +377,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.freq_tbl = ftbl_gcc_pdm2_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_pdm2_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -404,7 +404,7 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s0_clk_init = {
 	.name = "gcc_qupv3_wrap0_s0_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -420,7 +420,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s1_clk_init = {
 	.name = "gcc_qupv3_wrap0_s1_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -436,7 +436,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s2_clk_init = {
 	.name = "gcc_qupv3_wrap0_s2_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -452,7 +452,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s3_clk_init = {
 	.name = "gcc_qupv3_wrap0_s3_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -468,7 +468,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s4_clk_init = {
 	.name = "gcc_qupv3_wrap0_s4_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -484,7 +484,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s5_clk_init = {
 	.name = "gcc_qupv3_wrap0_s5_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -500,7 +500,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s6_clk_init = {
 	.name = "gcc_qupv3_wrap0_s6_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -516,7 +516,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap0_s7_clk_init = {
 	.name = "gcc_qupv3_wrap0_s7_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -532,7 +532,7 @@ static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s0_clk_init = {
 	.name = "gcc_qupv3_wrap1_s0_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -548,7 +548,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s1_clk_init = {
 	.name = "gcc_qupv3_wrap1_s1_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -564,7 +564,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s2_clk_init = {
 	.name = "gcc_qupv3_wrap1_s2_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -580,7 +580,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s3_clk_init = {
 	.name = "gcc_qupv3_wrap1_s3_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -596,7 +596,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s4_clk_init = {
 	.name = "gcc_qupv3_wrap1_s4_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -612,7 +612,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s5_clk_init = {
 	.name = "gcc_qupv3_wrap1_s5_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -628,7 +628,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s6_clk_init = {
 	.name = "gcc_qupv3_wrap1_s6_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -644,7 +644,7 @@ static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
 
 static struct clk_init_data gcc_qupv3_wrap1_s7_clk_init = {
 	.name = "gcc_qupv3_wrap1_s7_clk_src",
-	.parent_names = gcc_parent_names_0,
+	.parent_data = gcc_parent_data_0,
 	.num_parents = 4,
 	.ops = &clk_rcg2_shared_ops,
 };
@@ -701,7 +701,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_sdcc4_apps_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -743,7 +743,7 @@ static struct clk_rcg2 gcc_ufs_card_axi_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_axi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_axi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -765,7 +765,7 @@ static struct clk_rcg2 gcc_ufs_card_ice_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_ice_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_ice_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -800,7 +800,7 @@ static struct clk_rcg2 gcc_ufs_card_unipro_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_unipro_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_card_unipro_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -823,7 +823,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_axi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -837,7 +837,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_ice_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_ice_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -865,7 +865,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.freq_tbl = ftbl_gcc_ufs_card_unipro_core_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -888,7 +888,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_master_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -910,7 +910,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_shared_ops,
 	},
@@ -924,7 +924,7 @@ static struct clk_rcg2 gcc_usb30_sec_master_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_master_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -938,7 +938,7 @@ static struct clk_rcg2 gcc_usb30_sec_mock_utmi_clk_src = {
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_sec_mock_utmi_clk_src",
-		.parent_names = gcc_parent_names_0,
+		.parent_data = gcc_parent_data_0,
 		.num_parents = 4,
 		.ops = &clk_rcg2_ops,
 	},
@@ -1030,9 +1030,7 @@ static struct clk_branch gcc_aggre_ufs_card_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre_ufs_card_axi_clk",
-			.parent_names = (const char *[]){
-				"gcc_ufs_card_axi_clk_src",
-			},
+			.parent_hws = (struct clk_hw *[]){ &gcc_ufs_card_axi_clk_src.clkr.hw },
 			.num_parents = 1,
 			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
-- 
Sent by a computer through tubes

