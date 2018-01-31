Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753991AbeAaSNu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:13:50 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34055 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753739AbeAaSKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:00 -0500
X-Google-Smtp-Source: AH8x227cZGOUPMIxadThoFLSpARN3wix1GKL8gOV45ZPgsa1Bv+ONgVMbeuKTislH+7IrSDrxSvAIA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] clk: meson: migrate gates to clk_regmap
Date: Wed, 31 Jan 2018 19:09:35 +0100
Message-Id: <20180131180945.18025-10-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move meson8b, gxbb and axg clocks using clk_gate to clk_regmap

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Kconfig   |   4 +-
 drivers/clk/meson/axg.c     |  72 ++++++------
 drivers/clk/meson/clkc.h    |  20 ++--
 drivers/clk/meson/gxbb.c    | 268 +++++++++++++++++++++++---------------------
 drivers/clk/meson/meson8b.c |  39 +++----
 5 files changed, 208 insertions(+), 195 deletions(-)

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 9735335b17a9..936afddae406 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -11,7 +11,7 @@ config COMMON_CLK_MESON8B
 	bool
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
-	select REGMAP
+	select COMMON_CLK_REGMAP_MESON
 	help
 	  Support for the clock controller on AmLogic S802 (Meson8),
 	  S805 (Meson8b) and S812 (Meson8m2) devices. Say Y if you
@@ -30,7 +30,7 @@ config COMMON_CLK_AXG
 	bool
 	depends on COMMON_CLK_AMLOGIC
 	select RESET_CONTROLLER
-	select REGMAP
+	select COMMON_CLK_REGMAP_MESON
 	help
 	  Support for the clock controller on AmLogic A113D devices, aka axg.
 	  Say Y if you want peripherals and CPU frequency scaling to work.
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 669d0ed84ebc..3b7c970907c1 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -447,13 +447,14 @@ static struct clk_divider axg_mpeg_clk_div = {
 	},
 };
 
-static struct clk_gate axg_clk81 = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.bit_idx = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_clk81 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.bit_idx = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "clk81",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_div" },
 		.num_parents = 1,
 		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
@@ -501,13 +502,14 @@ static struct clk_divider axg_sd_emmc_b_clk0_div = {
 	},
 };
 
-static struct clk_gate axg_sd_emmc_b_clk0 = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.bit_idx = 23,
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_sd_emmc_b_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.bit_idx = 23,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_b_clk0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "sd_emmc_b_clk0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -544,13 +546,14 @@ static struct clk_divider axg_sd_emmc_c_clk0_div = {
 	},
 };
 
-static struct clk_gate axg_sd_emmc_c_clk0 = {
-	.reg = (void *)HHI_NAND_CLK_CNTL,
-	.bit_idx = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_sd_emmc_c_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_NAND_CLK_CNTL,
+		.bit_idx = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_c_clk0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "sd_emmc_c_clk0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -697,7 +700,19 @@ static struct meson_clk_mpll *const axg_clk_mplls[] = {
 	&axg_mpll3,
 };
 
-static struct clk_gate *const axg_clk_gates[] = {
+static struct clk_mux *const axg_clk_muxes[] = {
+	&axg_mpeg_clk_sel,
+	&axg_sd_emmc_b_clk0_sel,
+	&axg_sd_emmc_c_clk0_sel,
+};
+
+static struct clk_divider *const axg_clk_dividers[] = {
+	&axg_mpeg_clk_div,
+	&axg_sd_emmc_b_clk0_div,
+	&axg_sd_emmc_c_clk0_div,
+};
+
+static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_clk81,
 	&axg_ddr,
 	&axg_audio_locker,
@@ -747,21 +762,7 @@ static struct clk_gate *const axg_clk_gates[] = {
 	&axg_sd_emmc_c_clk0,
 };
 
-static struct clk_mux *const axg_clk_muxes[] = {
-	&axg_mpeg_clk_sel,
-	&axg_sd_emmc_b_clk0_sel,
-	&axg_sd_emmc_c_clk0_sel,
-};
-
-static struct clk_divider *const axg_clk_dividers[] = {
-	&axg_mpeg_clk_div,
-	&axg_sd_emmc_b_clk0_div,
-	&axg_sd_emmc_c_clk0_div,
-};
-
 struct clkc_data {
-	struct clk_gate *const *clk_gates;
-	unsigned int clk_gates_count;
 	struct meson_clk_mpll *const *clk_mplls;
 	unsigned int clk_mplls_count;
 	struct meson_clk_pll *const *clk_plls;
@@ -774,8 +775,6 @@ struct clkc_data {
 };
 
 static const struct clkc_data axg_clkc_data = {
-	.clk_gates = axg_clk_gates,
-	.clk_gates_count = ARRAY_SIZE(axg_clk_gates),
 	.clk_mplls = axg_clk_mplls,
 	.clk_mplls_count = ARRAY_SIZE(axg_clk_mplls),
 	.clk_plls = axg_clk_plls,
@@ -834,11 +833,6 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_mplls_count; i++)
 		clkc_data->clk_mplls[i]->base = clk_base;
 
-	/* Populate base address for gates */
-	for (i = 0; i < clkc_data->clk_gates_count; i++)
-		clkc_data->clk_gates[i]->reg = clk_base +
-			(u64)clkc_data->clk_gates[i]->reg;
-
 	/* Populate base address for muxes */
 	for (i = 0; i < clkc_data->clk_muxes_count; i++)
 		clkc_data->clk_muxes[i]->reg = clk_base +
@@ -849,6 +843,10 @@ static int axg_clkc_probe(struct platform_device *pdev)
 		clkc_data->clk_dividers[i]->reg = clk_base +
 			(u64)clkc_data->clk_dividers[i]->reg;
 
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
+		axg_clk_regmaps[i]->map = map;
+
 	for (i = 0; i < clkc_data->hw_onecell_data->num; i++) {
 		/* array might be sparse */
 		if (!clkc_data->hw_onecell_data->hws[i])
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 07aaba26a857..aa2dfa0ff89f 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -18,6 +18,9 @@
 #ifndef __CLKC_H
 #define __CLKC_H
 
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
 #define PMASK(width)			GENMASK(width - 1, 0)
 #define SETPMASK(width, shift)		GENMASK(shift + width - 1, shift)
 #define CLRPMASK(width, shift)		(~SETPMASK(width, shift))
@@ -134,16 +137,17 @@ struct meson_clk_audio_divider {
 };
 
 #define MESON_GATE(_name, _reg, _bit)					\
-struct clk_gate _name = { 						\
-	.reg = (void __iomem *) _reg, 					\
-	.bit_idx = (_bit), 						\
-	.lock = &meson_clk_lock,					\
-	.hw.init = &(struct clk_init_data) { 				\
-		.name = #_name,					\
-		.ops = &clk_gate_ops,					\
+struct clk_regmap _name = {						\
+	.data = &(struct clk_regmap_gate_data){				\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED), 	\
+		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
 	},								\
 };
 
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index e3faf0a0fdb7..ee1cd3785348 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -27,6 +27,7 @@
 
 #include "clkc.h"
 #include "gxbb.h"
+#include "clk-regmap.h"
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
@@ -617,14 +618,15 @@ static struct clk_divider gxbb_mpeg_clk_div = {
 	},
 };
 
-/* the mother of dragons^W gates */
-static struct clk_gate gxbb_clk81 = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.bit_idx = 7,
-	.lock = &meson_clk_lock,
+/* the mother of dragons gates */
+static struct clk_regmap gxbb_clk81 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.bit_idx = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "clk81",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_div" },
 		.num_parents = 1,
 		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
@@ -658,13 +660,14 @@ static struct clk_divider gxbb_sar_adc_clk_div = {
 	},
 };
 
-static struct clk_gate gxbb_sar_adc_clk = {
-	.reg = (void *)HHI_SAR_CLK_CNTL,
-	.bit_idx = 8,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sar_adc_clk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SAR_CLK_CNTL,
+		.bit_idx = 8,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sar_adc_clk",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "sar_adc_clk_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -716,13 +719,14 @@ static struct clk_divider gxbb_mali_0_div = {
 	},
 };
 
-static struct clk_gate gxbb_mali_0 = {
-	.reg = (void *)HHI_MALI_CLK_CNTL,
-	.bit_idx = 8,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mali_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.bit_idx = 8,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "mali_0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -763,13 +767,14 @@ static struct clk_divider gxbb_mali_1_div = {
 	},
 };
 
-static struct clk_gate gxbb_mali_1 = {
-	.reg = (void *)HHI_MALI_CLK_CNTL,
-	.bit_idx = 24,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_mali_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MALI_CLK_CNTL,
+		.bit_idx = 24,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "mali_1",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "mali_1_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -829,13 +834,14 @@ static struct meson_clk_audio_divider gxbb_cts_amclk_div = {
 	},
 };
 
-static struct clk_gate gxbb_cts_amclk = {
-	.reg = (void *) HHI_AUD_CLK_CNTL,
-	.bit_idx = 8,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_cts_amclk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_AUD_CLK_CNTL,
+		.bit_idx = 8,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "cts_amclk_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -873,13 +879,14 @@ static struct clk_divider gxbb_cts_mclk_i958_div = {
 	},
 };
 
-static struct clk_gate gxbb_cts_mclk_i958 = {
-	.reg = (void *)HHI_AUD_CLK_CNTL2,
-	.bit_idx = 24,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_cts_mclk_i958 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.bit_idx = 24,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_mclk_i958",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "cts_mclk_i958_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -918,13 +925,14 @@ static struct clk_divider gxbb_32k_clk_div = {
 	},
 };
 
-static struct clk_gate gxbb_32k_clk = {
-	.reg = (void *)HHI_32K_CLK_CNTL,
-	.bit_idx = 15,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_32k_clk = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_32K_CLK_CNTL,
+		.bit_idx = 15,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "32k_clk_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -990,13 +998,14 @@ static struct clk_divider gxbb_sd_emmc_a_clk0_div = {
 	},
 };
 
-static struct clk_gate gxbb_sd_emmc_a_clk0 = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.bit_idx = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sd_emmc_a_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.bit_idx = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_a_clk0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "sd_emmc_a_clk0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1033,13 +1042,14 @@ static struct clk_divider gxbb_sd_emmc_b_clk0_div = {
 	},
 };
 
-static struct clk_gate gxbb_sd_emmc_b_clk0 = {
-	.reg = (void *)HHI_SD_EMMC_CLK_CNTL,
-	.bit_idx = 23,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sd_emmc_b_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_SD_EMMC_CLK_CNTL,
+		.bit_idx = 23,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_b_clk0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "sd_emmc_b_clk0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1076,13 +1086,14 @@ static struct clk_divider gxbb_sd_emmc_c_clk0_div = {
 	},
 };
 
-static struct clk_gate gxbb_sd_emmc_c_clk0 = {
-	.reg = (void *)HHI_NAND_CLK_CNTL,
-	.bit_idx = 7,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_sd_emmc_c_clk0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_NAND_CLK_CNTL,
+		.bit_idx = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sd_emmc_c_clk0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "sd_emmc_c_clk0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
@@ -1129,13 +1140,14 @@ static struct clk_divider gxbb_vpu_0_div = {
 	},
 };
 
-static struct clk_gate gxbb_vpu_0 = {
-	.reg = (void *)HHI_VPU_CLK_CNTL,
-	.bit_idx = 8,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vpu_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.bit_idx = 8,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "vpu_0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "vpu_0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
@@ -1175,13 +1187,14 @@ static struct clk_divider gxbb_vpu_1_div = {
 	},
 };
 
-static struct clk_gate gxbb_vpu_1 = {
-	.reg = (void *)HHI_VPU_CLK_CNTL,
-	.bit_idx = 24,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vpu_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VPU_CLK_CNTL,
+		.bit_idx = 24,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "vpu_1",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "vpu_1_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
@@ -1246,13 +1259,14 @@ static struct clk_divider gxbb_vapb_0_div = {
 	},
 };
 
-static struct clk_gate gxbb_vapb_0 = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.bit_idx = 8,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vapb_0 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.bit_idx = 8,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "vapb_0",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "vapb_0_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
@@ -1292,13 +1306,14 @@ static struct clk_divider gxbb_vapb_1_div = {
 	},
 };
 
-static struct clk_gate gxbb_vapb_1 = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.bit_idx = 24,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vapb_1 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.bit_idx = 24,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "vapb_1",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "vapb_1_div" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
@@ -1323,13 +1338,14 @@ static struct clk_mux gxbb_vapb_sel = {
 	},
 };
 
-static struct clk_gate gxbb_vapb = {
-	.reg = (void *)HHI_VAPBCLK_CNTL,
-	.bit_idx = 30,
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_vapb = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_VAPBCLK_CNTL,
+		.bit_idx = 30,
+	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "vapb",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "vapb_sel" },
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
@@ -1744,7 +1760,48 @@ static struct meson_clk_mpll *const gxbb_clk_mplls[] = {
 	&gxbb_mpll2,
 };
 
-static struct clk_gate *const gxbb_clk_gates[] = {
+static struct clk_mux *const gxbb_clk_muxes[] = {
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
+};
+
+static struct clk_divider *const gxbb_clk_dividers[] = {
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
+};
+
+static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
+	&gxbb_cts_amclk_div,
+};
+
+static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_clk81,
 	&gxbb_ddr,
 	&gxbb_dos,
@@ -1843,50 +1900,7 @@ static struct clk_gate *const gxbb_clk_gates[] = {
 	&gxbb_vapb,
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
-static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
-	&gxbb_cts_amclk_div,
-};
-
 struct clkc_data {
-	struct clk_gate *const *clk_gates;
-	unsigned int clk_gates_count;
 	struct meson_clk_mpll *const *clk_mplls;
 	unsigned int clk_mplls_count;
 	struct meson_clk_pll *const *clk_plls;
@@ -1897,12 +1911,12 @@ struct clkc_data {
 	unsigned int clk_dividers_count;
 	struct meson_clk_audio_divider *const *clk_audio_dividers;
 	unsigned int clk_audio_dividers_count;
+	struct clk_regmap *const *clk_regmaps;
+	unsigned int clk_regmaps_count;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
 static const struct clkc_data gxbb_clkc_data = {
-	.clk_gates = gxbb_clk_gates,
-	.clk_gates_count = ARRAY_SIZE(gxbb_clk_gates),
 	.clk_mplls = gxbb_clk_mplls,
 	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
 	.clk_plls = gxbb_clk_plls,
@@ -1917,8 +1931,6 @@ static const struct clkc_data gxbb_clkc_data = {
 };
 
 static const struct clkc_data gxl_clkc_data = {
-	.clk_gates = gxbb_clk_gates,
-	.clk_gates_count = ARRAY_SIZE(gxbb_clk_gates),
 	.clk_mplls = gxbb_clk_mplls,
 	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
 	.clk_plls = gxl_clk_plls,
@@ -1979,11 +1991,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_mplls_count; i++)
 		clkc_data->clk_mplls[i]->base = clk_base;
 
-	/* Populate base address for gates */
-	for (i = 0; i < clkc_data->clk_gates_count; i++)
-		clkc_data->clk_gates[i]->reg = clk_base +
-			(u64)clkc_data->clk_gates[i]->reg;
-
 	/* Populate base address for muxes */
 	for (i = 0; i < clkc_data->clk_muxes_count; i++)
 		clkc_data->clk_muxes[i]->reg = clk_base +
@@ -1998,6 +2005,9 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_audio_dividers_count; i++)
 		clkc_data->clk_audio_dividers[i]->base = clk_base;
 
+	/* Populate regmap for the common regmap backed clocks */
+	for (i = 0; i < ARRAY_SIZE(gx_clk_regmaps); i++)
+		gx_clk_regmaps[i]->map = map;
 
 	/* Register all clks */
 	for (i = 0; i < clkc_data->hw_onecell_data->num; i++) {
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 0981e970de3d..835dbb1d2c9d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -32,6 +32,7 @@
 
 #include "clkc.h"
 #include "meson8b.h"
+#include "clk-regmap.h"
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
@@ -406,13 +407,14 @@ struct clk_divider meson8b_mpeg_clk_div = {
 	},
 };
 
-struct clk_gate meson8b_clk81 = {
-	.reg = (void *)HHI_MPEG_CLK_CNTL,
-	.bit_idx = 7,
-	.lock = &meson_clk_lock,
+struct clk_regmap meson8b_clk81 = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = HHI_MPEG_CLK_CNTL,
+		.bit_idx = 7,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "clk81",
-		.ops = &clk_gate_ops,
+		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "mpeg_clk_div" },
 		.num_parents = 1,
 		.flags = (CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
@@ -617,7 +619,15 @@ static struct meson_clk_mpll *const meson8b_clk_mplls[] = {
 	&meson8b_mpll2,
 };
 
-static struct clk_gate *const meson8b_clk_gates[] = {
+static struct clk_mux *const meson8b_clk_muxes[] = {
+	&meson8b_mpeg_clk_sel,
+};
+
+static struct clk_divider *const meson8b_clk_dividers[] = {
+	&meson8b_mpeg_clk_div,
+};
+
+static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_clk81,
 	&meson8b_ddr,
 	&meson8b_dos,
@@ -698,14 +708,6 @@ static struct clk_gate *const meson8b_clk_gates[] = {
 	&meson8b_ao_iface,
 };
 
-static struct clk_mux *const meson8b_clk_muxes[] = {
-	&meson8b_mpeg_clk_sel,
-};
-
-static struct clk_divider *const meson8b_clk_dividers[] = {
-	&meson8b_mpeg_clk_div,
-};
-
 static const struct meson8b_clk_reset_line {
 	u32 reg;
 	u8 bit_idx;
@@ -837,11 +839,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 	/* Populate the base address for CPU clk */
 	meson8b_cpu_clk.base = clk_base;
 
-	/* Populate base address for gates */
-	for (i = 0; i < ARRAY_SIZE(meson8b_clk_gates); i++)
-		meson8b_clk_gates[i]->reg = clk_base +
-			(u32)meson8b_clk_gates[i]->reg;
-
 	/* Populate base address for muxes */
 	for (i = 0; i < ARRAY_SIZE(meson8b_clk_muxes); i++)
 		meson8b_clk_muxes[i]->reg = clk_base +
@@ -852,6 +849,10 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 		meson8b_clk_dividers[i]->reg = clk_base +
 			(u32)meson8b_clk_dividers[i]->reg;
 
+	/* Populate regmap for the regmap backed clocks */
+	for (i = 0; i < ARRAY_SIZE(meson8b_clk_regmaps); i++)
+		meson8b_clk_regmaps[i]->map = map;
+
 	/*
 	 * register all clks
 	 * CLKID_UNUSED = 0, so skip it and start with CLKID_XTAL = 1
-- 
2.14.3
