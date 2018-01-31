Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeAaSMv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:12:51 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46632 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbeAaSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:02 -0500
X-Google-Smtp-Source: AH8x227ZV1eIRwi3sXM/N+G2aAJNRsZn/SHuqobx3qVCeK/wztRRrUvVdQ/UzzJ/ueqJdTDNjdv+9g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] clk: meson: migrate muxes to clk_regmap
Date: Wed, 31 Jan 2018 19:09:37 +0100
Message-Id: <20180131180945.18025-12-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move meson8b, gxbb and axg clocks using clk_mux to clk_regmap
Also remove a few useless tables in the process

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     |  60 ++++-----
 drivers/clk/meson/gxbb.c    | 312 +++++++++++++++++++++-----------------------
 drivers/clk/meson/meson8b.c |  27 ++--
 3 files changed, 184 insertions(+), 215 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 60b822d8905c..6ce413a9d0dd 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -418,16 +418,16 @@ static const char * const clk81_parent_names[] = {
 	"fclk_div3", "fclk_div5"
 };
 
-static struct clk_mux axg_mpeg_clk_sel = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 12,
-	.flags = CLK_MUX_READ_ONLY,
-	.table = mux_table_clk81,
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_mpeg_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 12,
+		.table = mux_table_clk81,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_sel",
-		.ops = &clk_mux_ro_ops,
+		.ops = &clk_regmap_mux_ro_ops,
 		.parent_names = clk81_parent_names,
 		.num_parents = ARRAY_SIZE(clk81_parent_names),
 	},
@@ -474,14 +474,15 @@ static const char * const axg_sd_emmc_clk0_parent_names[] = {
 };
 
 /* SDcard clock */
-static struct clk_mux axg_sd_emmc_b_clk0_sel = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 25,
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_sd_emmc_b_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 25,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = axg_sd_emmc_clk0_parent_names,
 		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_names),
 		.flags = CLK_SET_RATE_PARENT,
@@ -519,14 +520,15 @@ static struct clk_regmap axg_sd_emmc_b_clk0 = {
 };
 
 /* EMMC/NAND clock */
-static struct clk_mux axg_sd_emmc_c_clk0_sel = {
-	.reg = (void *)HHI_NAND_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 9,
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_sd_emmc_c_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_NAND_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 9,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = axg_sd_emmc_clk0_parent_names,
 		.num_parents = ARRAY_SIZE(axg_sd_emmc_clk0_parent_names),
 		.flags = CLK_SET_RATE_PARENT,
@@ -703,12 +705,6 @@ static struct meson_clk_mpll *const axg_clk_mplls[] = {
 	&axg_mpll3,
 };
 
-static struct clk_mux *const axg_clk_muxes[] = {
-	&axg_mpeg_clk_sel,
-	&axg_sd_emmc_b_clk0_sel,
-	&axg_sd_emmc_c_clk0_sel,
-};
-
 static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_clk81,
 	&axg_ddr,
@@ -760,6 +756,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_mpeg_clk_div,
 	&axg_sd_emmc_b_clk0_div,
 	&axg_sd_emmc_c_clk0_div,
+	&axg_mpeg_clk_sel,
+	&axg_sd_emmc_b_clk0_sel,
+	&axg_sd_emmc_c_clk0_sel,
 };
 
 struct clkc_data {
@@ -767,8 +766,6 @@ struct clkc_data {
 	unsigned int clk_mplls_count;
 	struct meson_clk_pll *const *clk_plls;
 	unsigned int clk_plls_count;
-	struct clk_mux *const *clk_muxes;
-	unsigned int clk_muxes_count;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
@@ -777,8 +774,6 @@ static const struct clkc_data axg_clkc_data = {
 	.clk_mplls_count = ARRAY_SIZE(axg_clk_mplls),
 	.clk_plls = axg_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(axg_clk_plls),
-	.clk_muxes = axg_clk_muxes,
-	.clk_muxes_count = ARRAY_SIZE(axg_clk_muxes),
 	.hw_onecell_data = &axg_hw_onecell_data,
 };
 
@@ -829,11 +824,6 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_mplls_count; i++)
 		clkc_data->clk_mplls[i]->base = clk_base;
 
-	/* Populate base address for muxes */
-	for (i = 0; i < clkc_data->clk_muxes_count; i++)
-		clkc_data->clk_muxes[i]->reg = clk_base +
-			(u64)clkc_data->clk_muxes[i]->reg;
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
 		axg_clk_regmaps[i]->map = map;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index cdb20bf0682d..d9f426265774 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -583,16 +583,16 @@ static const char * const clk81_parent_names[] = {
 	"fclk_div3", "fclk_div5"
 };
 
-static struct clk_mux gxbb_mpeg_clk_sel = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 12,
-	.flags = CLK_MUX_READ_ONLY,
-	.table = mux_table_clk81,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mpeg_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 12,
+		.table = mux_table_clk81,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_sel",
-		.ops = &clk_mux_ro_ops,
+		.ops = &clk_regmap_mux_ro_ops,
 		/*
 		 * bits 14:12 selects from 8 possible parents:
 		 * xtal, 1'b0 (wtf), fclk_div7, mpll_clkout1, mpll_clkout2,
@@ -634,14 +634,15 @@ static struct clk_regmap gxbb_clk81 = {
 	},
 };
 
-static struct clk_mux gxbb_sar_adc_clk_sel = {
-	.reg = (void *)HHI_SAR_CLK_CNTL,
-	.mask = 0x3,
-	.shift = 9,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sar_adc_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SAR_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sar_adc_clk_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/* NOTE: The datasheet doesn't list the parents for bit 10 */
 		.parent_names = (const char *[]){ "xtal", "clk81", },
 		.num_parents = 2,
@@ -681,21 +682,20 @@ static struct clk_regmap gxbb_sar_adc_clk = {
  * muxed by a glitch-free switch.
  */
 
-static u32 mux_table_mali_0_1[] = {0, 1, 2, 3, 4, 5, 6, 7};
 static const char * const gxbb_mali_0_1_parent_names[] = {
 	"xtal", "gp0_pll", "mpll2", "mpll1", "fclk_div7",
 	"fclk_div4", "fclk_div3", "fclk_div5"
 };
 
-static struct clk_mux gxbb_mali_0_sel = {
-	.reg = (void *)HHI_MALI_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 9,
-	.table = mux_table_mali_0_1,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mali_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 9,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bits 10:9 selects from 8 possible parents:
 		 * xtal, gp0_pll, mpll2, mpll1, fclk_div7,
@@ -736,15 +736,15 @@ static struct clk_regmap gxbb_mali_0 = {
 	},
 };
 
-static struct clk_mux gxbb_mali_1_sel = {
-	.reg = (void *)HHI_MALI_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 25,
-	.table = mux_table_mali_0_1,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mali_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 25,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bits 10:9 selects from 8 possible parents:
 		 * xtal, gp0_pll, mpll2, mpll1, fclk_div7,
@@ -785,36 +785,35 @@ static struct clk_regmap gxbb_mali_1 = {
 	},
 };
 
-static u32 mux_table_mali[] = {0, 1};
 static const char * const gxbb_mali_parent_names[] = {
 	"mali_0", "mali_1"
 };
 
-static struct clk_mux gxbb_mali = {
-	.reg = (void *)HHI_MALI_CLK_CNTL,
-	.mask = 1,
-	.shift = 31,
-	.table = mux_table_mali,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mali = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.mask = 1,
+		.shift = 31,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mali",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = gxbb_mali_parent_names,
 		.num_parents = 2,
 		.flags = CLK_SET_RATE_NO_REPARENT,
 	},
 };
 
-static struct clk_mux gxbb_cts_amclk_sel = {
-	.reg = (void *) HHI_AUD_CLK_CNTL,
-	.mask = 0x3,
-	.shift = 9,
-	/* Default parent unknown (register reset value: 0) */
-	.table = (u32[]){ 1, 2, 3 },
-	.lock = &meson_clk_lock,
-		.hw.init = &(struct clk_init_data){
+static struct clk_regmap gxbb_cts_amclk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_AUD_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+		.table = (u32[]){ 1, 2, 3 },
+	},
+	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "mpll0", "mpll1", "mpll2" },
 		.num_parents = 3,
 		.flags = CLK_SET_RATE_PARENT,
@@ -852,16 +851,16 @@ static struct clk_regmap gxbb_cts_amclk = {
 	},
 };
 
-static struct clk_mux gxbb_cts_mclk_i958_sel = {
-	.reg = (void *)HHI_AUD_CLK_CNTL2,
-	.mask = 0x3,
-	.shift = 25,
-	/* Default parent unknown (register reset value: 0) */
-	.table = (u32[]){ 1, 2, 3 },
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_cts_mclk_i958_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.mask = 0x3,
+		.shift = 25,
+		.table = (u32[]){ 1, 2, 3 },
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "cts_mclk_i958_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "mpll0", "mpll1", "mpll2" },
 		.num_parents = 3,
 		.flags = CLK_SET_RATE_PARENT,
@@ -898,14 +897,15 @@ static struct clk_regmap gxbb_cts_mclk_i958 = {
 	},
 };
 
-static struct clk_mux gxbb_cts_i958 = {
-	.reg = (void *)HHI_AUD_CLK_CNTL2,
-	.mask = 0x1,
-	.shift = 27,
-	.lock = &meson_clk_lock,
-		.hw.init = &(struct clk_init_data){
+static struct clk_regmap gxbb_cts_i958 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.mask = 0x1,
+		.shift = 27,
+		},
+	.hw.init = &(struct clk_init_data){
 		.name = "cts_i958",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = (const char *[]){ "cts_amclk", "cts_mclk_i958" },
 		.num_parents = 2,
 		/*
@@ -949,14 +949,15 @@ static const char * const gxbb_32k_clk_parent_names[] = {
 	"xtal", "cts_slow_oscin", "fclk_div3", "fclk_div5"
 };
 
-static struct clk_mux gxbb_32k_clk_sel = {
-	.reg = (void *)HHI_32K_CLK_CNTL,
-	.mask = 0x3,
-	.shift = 16,
-	.lock = &meson_clk_lock,
-		.hw.init = &(struct clk_init_data){
+static struct clk_regmap gxbb_32k_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_32K_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 16,
+		},
+	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = gxbb_32k_clk_parent_names,
 		.num_parents = 4,
 		.flags = CLK_SET_RATE_PARENT,
@@ -975,14 +976,15 @@ static const char * const gxbb_sd_emmc_clk0_parent_names[] = {
 };
 
 /* SDIO clock */
-static struct clk_mux gxbb_sd_emmc_a_clk0_sel = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 9,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sd_emmc_a_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 9,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_a_clk0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = gxbb_sd_emmc_clk0_parent_names,
 		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1020,14 +1022,15 @@ static struct clk_regmap gxbb_sd_emmc_a_clk0 = {
 };
 
 /* SDcard clock */
-static struct clk_mux gxbb_sd_emmc_b_clk0_sel = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 25,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sd_emmc_b_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 25,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_b_clk0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = gxbb_sd_emmc_clk0_parent_names,
 		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1065,14 +1068,15 @@ static struct clk_regmap gxbb_sd_emmc_b_clk0 = {
 };
 
 /* EMMC/NAND clock */
-static struct clk_mux gxbb_sd_emmc_c_clk0_sel = {
-	.reg = (void *)HHI_NAND_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 9,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sd_emmc_c_clk0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_NAND_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 9,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "sd_emmc_c_clk0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		.parent_names = gxbb_sd_emmc_clk0_parent_names,
 		.num_parents = ARRAY_SIZE(gxbb_sd_emmc_clk0_parent_names),
 		.flags = CLK_SET_RATE_PARENT,
@@ -1111,20 +1115,19 @@ static struct clk_regmap gxbb_sd_emmc_c_clk0 = {
 
 /* VPU Clock */
 
-static u32 mux_table_vpu[] = {0, 1, 2, 3};
 static const char * const gxbb_vpu_parent_names[] = {
 	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7"
 };
 
-static struct clk_mux gxbb_vpu_0_sel = {
-	.reg = (void *)HHI_VPU_CLK_CNTL,
-	.mask = 0x3,
-	.shift = 9,
-	.lock = &meson_clk_lock,
-	.table = mux_table_vpu,
+static struct clk_regmap gxbb_vpu_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bits 9:10 selects from 4 possible parents:
 		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
@@ -1164,15 +1167,15 @@ static struct clk_regmap gxbb_vpu_0 = {
 	},
 };
 
-static struct clk_mux gxbb_vpu_1_sel = {
-	.reg = (void *)HHI_VPU_CLK_CNTL,
-	.mask = 0x3,
-	.shift = 25,
-	.lock = &meson_clk_lock,
-	.table = mux_table_vpu,
+static struct clk_regmap gxbb_vpu_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 0x3,
+		.shift = 25,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_1_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bits 25:26 selects from 4 possible parents:
 		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
@@ -1212,14 +1215,15 @@ static struct clk_regmap gxbb_vpu_1 = {
 	},
 };
 
-static struct clk_mux gxbb_vpu = {
-	.reg = (void *)HHI_VPU_CLK_CNTL,
-	.mask = 1,
-	.shift = 31,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vpu = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.mask = 1,
+		.shift = 31,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bit 31 selects from 2 possible parents:
 		 * vpu_0 or vpu_1
@@ -1232,20 +1236,19 @@ static struct clk_mux gxbb_vpu = {
 
 /* VAPB Clock */
 
-static u32 mux_table_vapb[] = {0, 1, 2, 3};
 static const char * const gxbb_vapb_parent_names[] = {
 	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7"
 };
 
-static struct clk_mux gxbb_vapb_0_sel = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.mask = 0x3,
-	.shift = 9,
-	.lock = &meson_clk_lock,
-	.table = mux_table_vapb,
+static struct clk_regmap gxbb_vapb_0_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.mask = 0x3,
+		.shift = 9,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_0_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bits 9:10 selects from 4 possible parents:
 		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
@@ -1285,15 +1288,15 @@ static struct clk_regmap gxbb_vapb_0 = {
 	},
 };
 
-static struct clk_mux gxbb_vapb_1_sel = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.mask = 0x3,
-	.shift = 25,
-	.lock = &meson_clk_lock,
-	.table = mux_table_vapb,
+static struct clk_regmap gxbb_vapb_1_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.mask = 0x3,
+		.shift = 25,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_1_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bits 25:26 selects from 4 possible parents:
 		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
@@ -1333,14 +1336,15 @@ static struct clk_regmap gxbb_vapb_1 = {
 	},
 };
 
-static struct clk_mux gxbb_vapb_sel = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.mask = 1,
-	.shift = 31,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vapb_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.mask = 1,
+		.shift = 31,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "vapb_sel",
-		.ops = &clk_mux_ops,
+		.ops = &clk_regmap_mux_ops,
 		/*
 		 * bit 31 selects from 2 possible parents:
 		 * vapb_0 or vapb_1
@@ -1773,27 +1777,6 @@ static struct meson_clk_mpll *const gxbb_clk_mplls[] = {
 	&gxbb_mpll2,
 };
 
-static struct clk_mux *const gxbb_clk_muxes[] = {
-	&gxbb_mpeg_clk_sel,
-	&gxbb_sar_adc_clk_sel,
-	&gxbb_mali_0_sel,
-	&gxbb_mali_1_sel,
-	&gxbb_mali,
-	&gxbb_cts_amclk_sel,
-	&gxbb_cts_mclk_i958_sel,
-	&gxbb_cts_i958,
-	&gxbb_32k_clk_sel,
-	&gxbb_sd_emmc_a_clk0_sel,
-	&gxbb_sd_emmc_b_clk0_sel,
-	&gxbb_sd_emmc_c_clk0_sel,
-	&gxbb_vpu_0_sel,
-	&gxbb_vpu_1_sel,
-	&gxbb_vpu,
-	&gxbb_vapb_0_sel,
-	&gxbb_vapb_1_sel,
-	&gxbb_vapb_sel,
-};
-
 static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
 	&gxbb_cts_amclk_div,
 };
@@ -1908,6 +1891,24 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_vpu_1_div,
 	&gxbb_vapb_0_div,
 	&gxbb_vapb_1_div,
+	&gxbb_mpeg_clk_sel,
+	&gxbb_sar_adc_clk_sel,
+	&gxbb_mali_0_sel,
+	&gxbb_mali_1_sel,
+	&gxbb_mali,
+	&gxbb_cts_amclk_sel,
+	&gxbb_cts_mclk_i958_sel,
+	&gxbb_cts_i958,
+	&gxbb_32k_clk_sel,
+	&gxbb_sd_emmc_a_clk0_sel,
+	&gxbb_sd_emmc_b_clk0_sel,
+	&gxbb_sd_emmc_c_clk0_sel,
+	&gxbb_vpu_0_sel,
+	&gxbb_vpu_1_sel,
+	&gxbb_vpu,
+	&gxbb_vapb_0_sel,
+	&gxbb_vapb_1_sel,
+	&gxbb_vapb_sel,
 };
 
 struct clkc_data {
@@ -1915,12 +1916,8 @@ struct clkc_data {
 	unsigned int clk_mplls_count;
 	struct meson_clk_pll *const *clk_plls;
 	unsigned int clk_plls_count;
-	struct clk_mux *const *clk_muxes;
-	unsigned int clk_muxes_count;
 	struct meson_clk_audio_divider *const *clk_audio_dividers;
 	unsigned int clk_audio_dividers_count;
-	struct clk_regmap *const *clk_regmaps;
-	unsigned int clk_regmaps_count;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
@@ -1929,8 +1926,6 @@ static const struct clkc_data gxbb_clkc_data = {
 	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
 	.clk_plls = gxbb_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(gxbb_clk_plls),
-	.clk_muxes = gxbb_clk_muxes,
-	.clk_muxes_count = ARRAY_SIZE(gxbb_clk_muxes),
 	.clk_audio_dividers = gxbb_audio_dividers,
 	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
 	.hw_onecell_data = &gxbb_hw_onecell_data,
@@ -1941,8 +1936,6 @@ static const struct clkc_data gxl_clkc_data = {
 	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
 	.clk_plls = gxl_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(gxl_clk_plls),
-	.clk_muxes = gxbb_clk_muxes,
-	.clk_muxes_count = ARRAY_SIZE(gxbb_clk_muxes),
 	.clk_audio_dividers = gxbb_audio_dividers,
 	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
 	.hw_onecell_data = &gxl_hw_onecell_data,
@@ -1995,11 +1988,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_mplls_count; i++)
 		clkc_data->clk_mplls[i]->base = clk_base;
 
-	/* Populate base address for muxes */
-	for (i = 0; i < clkc_data->clk_muxes_count; i++)
-		clkc_data->clk_muxes[i]->reg = clk_base +
-			(u64)clkc_data->clk_muxes[i]->reg;
-
 	/* Populate base address for the audio dividers */
 	for (i = 0; i < clkc_data->clk_audio_dividers_count; i++)
 		clkc_data->clk_audio_dividers[i]->base = clk_base;
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index e9c5278072cd..e643f7556f5e 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -370,17 +370,16 @@ static struct meson_clk_cpu meson8b_cpu_clk = {
 };
 
 static u32 mux_table_clk81[]	= { 6, 5, 7 };
-
-struct clk_mux meson8b_mpeg_clk_sel = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.mask = 0x7,
-	.shift = 12,
-	.flags = CLK_MUX_READ_ONLY,
-	.table = mux_table_clk81,
-	.lock = &meson_clk_lock,
+static struct clk_regmap meson8b_mpeg_clk_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.mask = 0x7,
+		.shift = 12,
+		.table = mux_table_clk81,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mpeg_clk_sel",
-		.ops = &clk_mux_ro_ops,
+		.ops = &clk_regmap_mux_ro_ops,
 		/*
 		 * FIXME bits 14:12 selects from 8 possible parents:
 		 * xtal, 1'b0 (wtf), fclk_div7, mpll_clkout1, mpll_clkout2,
@@ -620,10 +619,6 @@ static struct meson_clk_mpll *const meson8b_clk_mplls[] = {
 	&meson8b_mpll2,
 };
 
-static struct clk_mux *const meson8b_clk_muxes[] = {
-	&meson8b_mpeg_clk_sel,
-};
-
 static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_clk81,
 	&meson8b_ddr,
@@ -704,6 +699,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_ao_ahb_bus,
 	&meson8b_ao_iface,
 	&meson8b_mpeg_clk_div,
+	&meson8b_mpeg_clk_sel,
 };
 
 static const struct meson8b_clk_reset_line {
@@ -837,11 +833,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 	/* Populate the base address for CPU clk */
 	meson8b_cpu_clk.base = clk_base;
 
-	/* Populate base address for muxes */
-	for (i = 0; i < ARRAY_SIZE(meson8b_clk_muxes); i++)
-		meson8b_clk_muxes[i]->reg = clk_base +
-			(u32)meson8b_clk_muxes[i]->reg;
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(meson8b_clk_regmaps); i++)
 		meson8b_clk_regmaps[i]->map = map;
-- 
2.14.3
