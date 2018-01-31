Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeAaSNL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:13:11 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39184 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbeAaSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:01 -0500
X-Google-Smtp-Source: AH8x226gQ9zR+LJJE64F0avA2Hi6k2WTrI8LL+JgBx76floKrPHynQyRuS2Xjtvetu64N7e3Bc6y9g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/19] clk: meson: migrate dividers to clk_regmap
Date: Wed, 31 Jan 2018 19:09:36 +0100
Message-Id: <20180131180945.18025-11-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move meson8b, gxbb and axg clocks using clk_divider to clk_regmap

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  61 ++++++-------
 drivers/clk/meson/gxbb.c    | 217 ++++++++++++++++++++++----------------------
 drivers/clk/meson/meson8b.c |  23 ++---
 3 files changed, 142 insertions(+), 159 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 3b7c970907c1..60b822d8905c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -433,14 +433,15 @@ static struct clk_mux axg_mpeg_clk_sel = {
 	},
 };
 
-static struct clk_divider axg_mpeg_clk_div = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_mpeg_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -487,15 +488,16 @@ static struct clk_mux axg_sd_emmc_b_clk0_sel = {
 	},
 };
 
-static struct clk_divider axg_sd_emmc_b_clk0_div = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.shift = 16,
-	.width = 7,
-	.lock = &meson_clk_lock,
-	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+static struct clk_regmap axg_sd_emmc_b_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sd_emmc_b_clk0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -531,15 +533,16 @@ static struct clk_mux axg_sd_emmc_c_clk0_sel = {
 	},
 };
 
-static struct clk_divider axg_sd_emmc_c_clk0_div = {
-	.reg = (void *)HHI_NAND_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
-	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+static struct clk_regmap axg_sd_emmc_c_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_NAND_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sd_emmc_c_clk0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -706,12 +709,6 @@ static struct clk_mux *const axg_clk_muxes[] = {
 	&axg_sd_emmc_c_clk0_sel,
 };
 
-static struct clk_divider *const axg_clk_dividers[] = {
-	&axg_mpeg_clk_div,
-	&axg_sd_emmc_b_clk0_div,
-	&axg_sd_emmc_c_clk0_div,
-};
-
 static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_clk81,
 	&axg_ddr,
@@ -760,6 +757,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_ao_i2c,
 	&axg_sd_emmc_b_clk0,
 	&axg_sd_emmc_c_clk0,
+	&axg_mpeg_clk_div,
+	&axg_sd_emmc_b_clk0_div,
+	&axg_sd_emmc_c_clk0_div,
 };
 
 struct clkc_data {
@@ -769,8 +769,6 @@ struct clkc_data {
 	unsigned int clk_plls_count;
 	struct clk_mux *const *clk_muxes;
 	unsigned int clk_muxes_count;
-	struct clk_divider *const *clk_dividers;
-	unsigned int clk_dividers_count;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
@@ -781,8 +779,6 @@ static const struct clkc_data axg_clkc_data = {
 	.clk_plls_count = ARRAY_SIZE(axg_clk_plls),
 	.clk_muxes = axg_clk_muxes,
 	.clk_muxes_count = ARRAY_SIZE(axg_clk_muxes),
-	.clk_dividers = axg_clk_dividers,
-	.clk_dividers_count = ARRAY_SIZE(axg_clk_dividers),
 	.hw_onecell_data = &axg_hw_onecell_data,
 };
 
@@ -838,11 +834,6 @@ static int axg_clkc_probe(struct platform_device *pdev)
 		clkc_data->clk_muxes[i]->reg = clk_base +
 			(u64)clkc_data->clk_muxes[i]->reg;
 
-	/* Populate base address for dividers */
-	for (i = 0; i < clkc_data->clk_dividers_count; i++)
-		clkc_data->clk_dividers[i]->reg = clk_base +
-			(u64)clkc_data->clk_dividers[i]->reg;
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
 		axg_clk_regmaps[i]->map = map;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index ee1cd3785348..cdb20bf0682d 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -604,14 +604,15 @@ static struct clk_mux gxbb_mpeg_clk_sel = {
 	},
 };
 
-static struct clk_divider gxbb_mpeg_clk_div = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mpeg_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_sel" },
 		.num_parents = 1,
 		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
@@ -647,14 +648,15 @@ static struct clk_mux gxbb_sar_adc_clk_sel = {
 	},
 };
 
-static struct clk_divider gxbb_sar_adc_clk_div = {
-	.reg = (void *)HHI_SAR_CLK_CNTL,
-	.shift = 0,
-	.width = 8,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sar_adc_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SAR_CLK_CNTL,
+		.shift = 0,
+		.width = 8,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sar_adc_clk_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sar_adc_clk_sel" },
 		.num_parents = 1,
 	},
@@ -705,14 +707,15 @@ static struct clk_mux gxbb_mali_0_sel = {
 	},
 };
 
-static struct clk_divider gxbb_mali_0_div = {
-	.reg = (void *)HHI_MALI_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mali_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "mali_0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_NO_REPARENT,
@@ -753,14 +756,15 @@ static struct clk_mux gxbb_mali_1_sel = {
 	},
 };
 
-static struct clk_divider gxbb_mali_1_div = {
-	.reg = (void *)HHI_MALI_CLK_CNTL,
-	.shift = 16,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mali_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "mali_1_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_NO_REPARENT,
@@ -864,15 +868,16 @@ static struct clk_mux gxbb_cts_mclk_i958_sel = {
 	},
 };
 
-static struct clk_divider gxbb_cts_mclk_i958_div = {
-	.reg = (void *)HHI_AUD_CLK_CNTL2,
-	.shift = 16,
-	.width = 8,
-	.lock = &meson_clk_lock,
-	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+static struct clk_regmap gxbb_cts_mclk_i958_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.shift = 16,
+		.width = 8,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "cts_mclk_i958_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -911,14 +916,15 @@ static struct clk_mux gxbb_cts_i958 = {
 	},
 };
 
-static struct clk_divider gxbb_32k_clk_div = {
-	.reg = (void *)HHI_32K_CLK_CNTL,
-	.shift = 0,
-	.width = 14,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_32k_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_32K_CLK_CNTL,
+		.shift = 0,
+		.width = 14,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "32k_clk_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT | CLK_DIVIDER_ROUND_CLOSEST,
@@ -983,15 +989,16 @@ static struct clk_mux gxbb_sd_emmc_a_clk0_sel = {
 	},
 };
 
-static struct clk_divider gxbb_sd_emmc_a_clk0_div = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
-	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+static struct clk_regmap gxbb_sd_emmc_a_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_a_clk0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sd_emmc_a_clk0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1027,15 +1034,16 @@ static struct clk_mux gxbb_sd_emmc_b_clk0_sel = {
 	},
 };
 
-static struct clk_divider gxbb_sd_emmc_b_clk0_div = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.shift = 16,
-	.width = 7,
-	.lock = &meson_clk_lock,
-	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+static struct clk_regmap gxbb_sd_emmc_b_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sd_emmc_b_clk0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1071,15 +1079,16 @@ static struct clk_mux gxbb_sd_emmc_c_clk0_sel = {
 	},
 };
 
-static struct clk_divider gxbb_sd_emmc_c_clk0_div = {
-	.reg = (void *)HHI_NAND_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
-	.flags = CLK_DIVIDER_ROUND_CLOSEST,
+static struct clk_regmap gxbb_sd_emmc_c_clk0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_NAND_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "sd_emmc_c_clk0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1126,14 +1135,15 @@ static struct clk_mux gxbb_vpu_0_sel = {
 	},
 };
 
-static struct clk_divider gxbb_vpu_0_div = {
-	.reg = (void *)HHI_VPU_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vpu_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "vpu_0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1173,14 +1183,15 @@ static struct clk_mux gxbb_vpu_1_sel = {
 	},
 };
 
-static struct clk_divider gxbb_vpu_1_div = {
-	.reg = (void *)HHI_VPU_CLK_CNTL,
-	.shift = 16,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vpu_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.shift = 16,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_1_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "vpu_1_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1245,14 +1256,15 @@ static struct clk_mux gxbb_vapb_0_sel = {
 	},
 };
 
-static struct clk_divider gxbb_vapb_0_div = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vapb_0_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_0_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "vapb_0_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1292,14 +1304,15 @@ static struct clk_mux gxbb_vapb_1_sel = {
 	},
 };
 
-static struct clk_divider gxbb_vapb_1_div = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.shift = 16,
-	.width = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vapb_1_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.shift = 16,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_1_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "vapb_1_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1781,22 +1794,6 @@ static struct clk_mux *const gxbb_clk_muxes[] = {
 	&gxbb_vapb_sel,
 };
 
-static struct clk_divider *const gxbb_clk_dividers[] = {
-	&gxbb_mpeg_clk_div,
-	&gxbb_sar_adc_clk_div,
-	&gxbb_mali_0_div,
-	&gxbb_mali_1_div,
-	&gxbb_cts_mclk_i958_div,
-	&gxbb_32k_clk_div,
-	&gxbb_sd_emmc_a_clk0_div,
-	&gxbb_sd_emmc_b_clk0_div,
-	&gxbb_sd_emmc_c_clk0_div,
-	&gxbb_vpu_0_div,
-	&gxbb_vpu_1_div,
-	&gxbb_vapb_0_div,
-	&gxbb_vapb_1_div,
-};
-
 static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
 	&gxbb_cts_amclk_div,
 };
@@ -1898,6 +1895,19 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_vapb_0,
 	&gxbb_vapb_1,
 	&gxbb_vapb,
+	&gxbb_mpeg_clk_div,
+	&gxbb_sar_adc_clk_div,
+	&gxbb_mali_0_div,
+	&gxbb_mali_1_div,
+	&gxbb_cts_mclk_i958_div,
+	&gxbb_32k_clk_div,
+	&gxbb_sd_emmc_a_clk0_div,
+	&gxbb_sd_emmc_b_clk0_div,
+	&gxbb_sd_emmc_c_clk0_div,
+	&gxbb_vpu_0_div,
+	&gxbb_vpu_1_div,
+	&gxbb_vapb_0_div,
+	&gxbb_vapb_1_div,
 };
 
 struct clkc_data {
@@ -1907,8 +1917,6 @@ struct clkc_data {
 	unsigned int clk_plls_count;
 	struct clk_mux *const *clk_muxes;
 	unsigned int clk_muxes_count;
-	struct clk_divider *const *clk_dividers;
-	unsigned int clk_dividers_count;
 	struct meson_clk_audio_divider *const *clk_audio_dividers;
 	unsigned int clk_audio_dividers_count;
 	struct clk_regmap *const *clk_regmaps;
@@ -1923,8 +1931,6 @@ static const struct clkc_data gxbb_clkc_data = {
 	.clk_plls_count = ARRAY_SIZE(gxbb_clk_plls),
 	.clk_muxes = gxbb_clk_muxes,
 	.clk_muxes_count = ARRAY_SIZE(gxbb_clk_muxes),
-	.clk_dividers = gxbb_clk_dividers,
-	.clk_dividers_count = ARRAY_SIZE(gxbb_clk_dividers),
 	.clk_audio_dividers = gxbb_audio_dividers,
 	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
 	.hw_onecell_data = &gxbb_hw_onecell_data,
@@ -1937,8 +1943,6 @@ static const struct clkc_data gxl_clkc_data = {
 	.clk_plls_count = ARRAY_SIZE(gxl_clk_plls),
 	.clk_muxes = gxbb_clk_muxes,
 	.clk_muxes_count = ARRAY_SIZE(gxbb_clk_muxes),
-	.clk_dividers = gxbb_clk_dividers,
-	.clk_dividers_count = ARRAY_SIZE(gxbb_clk_dividers),
 	.clk_audio_dividers = gxbb_audio_dividers,
 	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
 	.hw_onecell_data = &gxl_hw_onecell_data,
@@ -1996,11 +2000,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 		clkc_data->clk_muxes[i]->reg = clk_base +
 			(u64)clkc_data->clk_muxes[i]->reg;
 
-	/* Populate base address for dividers */
-	for (i = 0; i < clkc_data->clk_dividers_count; i++)
-		clkc_data->clk_dividers[i]->reg = clk_base +
-			(u64)clkc_data->clk_dividers[i]->reg;
-
 	/* Populate base address for the audio dividers */
 	for (i = 0; i < clkc_data->clk_audio_dividers_count; i++)
 		clkc_data->clk_audio_dividers[i]->base = clk_base;
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 835dbb1d2c9d..e9c5278072cd 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -393,14 +393,15 @@ struct clk_mux meson8b_mpeg_clk_sel = {
 	},
 };
 
-struct clk_divider meson8b_mpeg_clk_div = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.shift = 0,
-	.width = 7,
-	.lock = &meson_clk_lock,
+struct clk_regmap meson8b_mpeg_clk_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.shift = 0,
+		.width = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_div",
-		.ops = &clk_divider_ops,
+		.ops = &clk_regmap_divider_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_sel" },
 		.num_parents = 1,
 		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
@@ -623,10 +624,6 @@ static struct clk_mux *const meson8b_clk_muxes[] = {
 	&meson8b_mpeg_clk_sel,
 };
 
-static struct clk_divider *const meson8b_clk_dividers[] = {
-	&meson8b_mpeg_clk_div,
-};
-
 static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_clk81,
 	&meson8b_ddr,
@@ -706,6 +703,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_ao_ahb_sram,
 	&meson8b_ao_ahb_bus,
 	&meson8b_ao_iface,
+	&meson8b_mpeg_clk_div,
 };
 
 static const struct meson8b_clk_reset_line {
@@ -844,11 +842,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 		meson8b_clk_muxes[i]->reg = clk_base +
 			(u32)meson8b_clk_muxes[i]->reg;
 
-	/* Populate base address for dividers */
-	for (i = 0; i < ARRAY_SIZE(meson8b_clk_dividers); i++)
-		meson8b_clk_dividers[i]->reg = clk_base +
-			(u32)meson8b_clk_dividers[i]->reg;
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(meson8b_clk_regmaps); i++)
 		meson8b_clk_regmaps[i]->map = map;
-- 
2.14.3
