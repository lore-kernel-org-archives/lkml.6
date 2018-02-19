Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeBSLXK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:23:10 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43354 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeBSLWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:22:01 -0500
X-Google-Smtp-Source: AH8x22500DCGb3W9otnEMfkbFZQ8ATpdRF7PEM+ezTrGIgADAbPjyZ1aPhnPFoJHXPSkKQmZ9FyHow==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] clk: meson: axg: add hifi pll clock
Date: Mon, 19 Feb 2018 12:21:43 +0100
Message-Id: <20180219112146.21746-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180219112146.21746-1-jbrunet@baylibre.com>
References: <20180219112146.21746-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hifi pll to the axg clock controller. This clock maybe used as an
input of the axg audio clock controller. It uses the same settings table
as the gp0 pll but has a frac parameter allowing more precision.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/axg.h |  2 +-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 892572a2d70f..ed4a645753c4 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -245,6 +245,59 @@ static struct clk_regmap axg_gp0_pll = {
 	},
 };
 
+const struct reg_sequence axg_hifi_init_regs[] = {
+	{ .reg = HHI_HIFI_PLL_CNTL1,	.def = 0xc084b000 },
+	{ .reg = HHI_HIFI_PLL_CNTL2,	.def = 0xb75020be },
+	{ .reg = HHI_HIFI_PLL_CNTL3,	.def = 0x0a6a3a88 },
+	{ .reg = HHI_HIFI_PLL_CNTL4,	.def = 0xc000004d },
+	{ .reg = HHI_HIFI_PLL_CNTL5,	.def = 0x00058000 },
+	{ .reg = HHI_HIFI_PLL_CNTL,	.def = 0x40010250 },
+};
+
+static struct clk_regmap axg_hifi_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_HIFI_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_HIFI_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_HIFI_PLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.frac = {
+			.reg_off = HHI_HIFI_PLL_CNTL5,
+			.shift   = 0,
+			.width   = 13,
+		},
+		.l = {
+			.reg_off = HHI_HIFI_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_HIFI_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = axg_gp0_pll_rate_table,
+		.init_regs = axg_hifi_init_regs,
+		.init_count = ARRAY_SIZE(axg_hifi_init_regs),
+		.flags = CLK_MESON_PLL_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "hifi_pll",
+		.ops = &meson_clk_pll_ops,
+		.parent_names = (const char *[]){ "xtal" },
+		.num_parents = 1,
+	},
+};
 
 static struct clk_fixed_factor axg_fclk_div2 = {
 	.mult = 1,
@@ -767,6 +820,7 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
 		[CLKID_MPLL1_DIV]		= &axg_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]		= &axg_mpll2_div.hw,
 		[CLKID_MPLL3_DIV]		= &axg_mpll3_div.hw,
+		[CLKID_HIFI_PLL]		= &axg_hifi_pll.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -838,6 +892,7 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_fixed_pll,
 	&axg_sys_pll,
 	&axg_gp0_pll,
+	&axg_hifi_pll,
 };
 
 static const struct of_device_id clkc_match_table[] = {
diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
index 4c1502a8b8c9..4916c7045c48 100644
--- a/drivers/clk/meson/axg.h
+++ b/drivers/clk/meson/axg.h
@@ -122,7 +122,7 @@
 #define CLKID_MPLL2_DIV				67
 #define CLKID_MPLL3_DIV				68
 
-#define NR_CLKS					69
+#define NR_CLKS					70
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/axg-clkc.h>
-- 
2.14.3
