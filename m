Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933439AbeBLPBS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:01:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53214 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932600AbeBLO7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:59:11 -0500
X-Google-Smtp-Source: AH8x226DCzh/lDnHtbYdPIbDY3G9G14fFJ4rhGxCW5fifqGBpj9IRhtBmZ2EFfD09IwounklUgPeLw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 17/19] clk: meson: rework meson8b cpu clock
Date: Mon, 12 Feb 2018 15:58:44 +0100
Message-Id: <20180212145846.19380-18-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212145846.19380-1-jbrunet@baylibre.com>
References: <20180212145846.19380-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of migrating meson cpu_clk to clk_regmap, like the other meson
clock drivers, we take advantage of the massive rework to get rid of it
completely, and solve (the first part) of the related FIXME notice.

As pointed out in the code comments, the cpu_clk should be modeled with
dividers and muxes it is made of, instead of one big composite clock.

The cpu_clk was not working correctly to enable dvfs on meson8b. It hangs
quite often when changing the cpu clock rate. This new implementation,
based on simple elements improves the situation but the platform will
still hang from time to time. This is not acceptable so, until we can
make the mechanism around the cpu clock stable, the cpu clock subtree
has been put in read-only mode, preventing any change of the cpu clock

The notifier and read-write operation will be added back when we have a
solution to the problem.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson8b.c | 173 +++++++++++++++++++++++++++++---------------
 drivers/clk/meson/meson8b.h |   7 +-
 2 files changed, 119 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 625d953511be..ea73b5de9672 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -99,20 +99,6 @@ static const struct pll_rate_table sys_pll_rate_table[] = {
 	{ /* sentinel */ },
 };
 
-static const struct clk_div_table cpu_div_table[] = {
-	{ .val = 1, .div = 1 },
-	{ .val = 2, .div = 2 },
-	{ .val = 3, .div = 3 },
-	{ .val = 2, .div = 4 },
-	{ .val = 3, .div = 6 },
-	{ .val = 4, .div = 8 },
-	{ .val = 5, .div = 10 },
-	{ .val = 6, .div = 12 },
-	{ .val = 7, .div = 14 },
-	{ .val = 8, .div = 16 },
-	{ /* sentinel */ },
-};
-
 static struct clk_fixed_rate meson8b_xtal = {
 	.fixed_rate = 24000000,
 	.hw.init = &(struct clk_init_data){
@@ -227,7 +213,7 @@ static struct clk_regmap meson8b_sys_pll = {
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
-		.ops = &meson_clk_pll_ops,
+		.ops = &meson_clk_pll_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
 		.flags = CLK_GET_RATE_NOCACHE,
@@ -417,23 +403,6 @@ static struct clk_regmap meson8b_mpll2 = {
 	},
 };
 
-/*
- * FIXME cpu clocks and the legacy composite clocks (e.g. clk81) are both PLL
- * post-dividers and should be modeled with their respective PLLs via the
- * forthcoming coordinated clock rates feature
- */
-static struct meson_clk_cpu meson8b_cpu_clk = {
-	.reg_off = HHI_SYS_CPU_CLK_CNTL1,
-	.div_table = cpu_div_table,
-	.clk_nb.notifier_call = meson_clk_cpu_notifier_cb,
-	.hw.init = &(struct clk_init_data){
-		.name = "cpu_clk",
-		.ops = &meson_clk_cpu_ops,
-		.parent_names = (const char *[]){ "sys_pll" },
-		.num_parents = 1,
-	},
-};
-
 static u32 mux_table_clk81[]	= { 6, 5, 7 };
 static struct clk_regmap meson8b_mpeg_clk_sel = {
 	.data = &(struct clk_regmap_mux_data){
@@ -486,6 +455,108 @@ struct clk_regmap meson8b_clk81 = {
 	},
 };
 
+struct clk_regmap meson8b_cpu_in_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x1,
+		.shift = 0,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_in_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "xtal", "sys_pll" },
+		.num_parents = 2,
+		.flags = (CLK_SET_RATE_PARENT |
+			  CLK_SET_RATE_NO_REPARENT),
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_div2 = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_div2",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_in_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_fixed_factor meson8b_cpu_div3 = {
+	.mult = 1,
+	.div = 3,
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_div3",
+		.ops = &clk_fixed_factor_ops,
+		.parent_names = (const char *[]){ "cpu_in_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct clk_div_table cpu_scale_table[] = {
+	{ .val = 2, .div = 4 },
+	{ .val = 3, .div = 6 },
+	{ .val = 4, .div = 8 },
+	{ .val = 5, .div = 10 },
+	{ .val = 6, .div = 12 },
+	{ .val = 7, .div = 14 },
+	{ .val = 8, .div = 16 },
+	{ /* sentinel */ },
+};
+
+struct clk_regmap meson8b_cpu_scale_div = {
+	.data = &(struct clk_regmap_div_data){
+		.offset =  HHI_SYS_CPU_CLK_CNTL1,
+		.shift = 20,
+		.width = 9,
+		.table = cpu_scale_table,
+		.flags = CLK_DIVIDER_ALLOW_ZERO,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_scale_div",
+		.ops = &clk_regmap_divider_ro_ops,
+		.parent_names = (const char *[]){ "cpu_in_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+struct clk_regmap meson8b_cpu_scale_out_sel = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x3,
+		.shift = 2,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_scale_out_sel",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]) { "cpu_in_sel",
+						   "cpu_div2",
+						   "cpu_div3",
+						   "cpu_scale_div" },
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+struct clk_regmap meson8b_cpu_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL0,
+		.mask = 0x1,
+		.shift = 7,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "xtal", "cpu_out_sel" },
+		.num_parents = 2,
+		.flags = (CLK_SET_RATE_PARENT |
+			  CLK_SET_RATE_NO_REPARENT),
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -670,6 +741,11 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_MPLL0_DIV]	    = &meson8b_mpll0_div.hw,
 		[CLKID_MPLL1_DIV]	    = &meson8b_mpll1_div.hw,
 		[CLKID_MPLL2_DIV]	    = &meson8b_mpll2_div.hw,
+		[CLKID_CPU_IN_SEL]	    = &meson8b_cpu_in_sel.hw,
+		[CLKID_CPU_DIV2]	    = &meson8b_cpu_div2.hw,
+		[CLKID_CPU_DIV3]	    = &meson8b_cpu_div3.hw,
+		[CLKID_CPU_SCALE_DIV]	    = &meson8b_cpu_scale_div.hw,
+		[CLKID_CPU_SCALE_OUT_SEL]   = &meson8b_cpu_scale_out_sel.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -765,6 +841,10 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_fixed_pll,
 	&meson8b_vid_pll,
 	&meson8b_sys_pll,
+	&meson8b_cpu_in_sel,
+	&meson8b_cpu_scale_div,
+	&meson8b_cpu_scale_out_sel,
+	&meson8b_cpu_clk,
 };
 
 static const struct meson8b_clk_reset_line {
@@ -875,8 +955,7 @@ static const struct regmap_config clkc_regmap_config = {
 static int meson8b_clkc_probe(struct platform_device *pdev)
 {
 	int ret, i;
-	struct clk_hw *parent_hw;
-	struct clk *parent_clk;
+	struct clk *clk;
 	struct device *dev = &pdev->dev;
 	struct regmap *map;
 
@@ -887,9 +966,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	/* Populate the base address for CPU clk */
-	meson8b_cpu_clk.base = clk_base;
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(meson8b_clk_regmaps); i++)
 		meson8b_clk_regmaps[i]->map = map;
@@ -908,29 +984,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	/*
-	 * Register CPU clk notifier
-	 *
-	 * FIXME this is wrong for a lot of reasons. First, the muxes should be
-	 * struct clk_hw objects. Second, we shouldn't program the muxes in
-	 * notifier handlers. The tricky programming sequence will be handled
-	 * by the forthcoming coordinated clock rates mechanism once that
-	 * feature is released.
-	 *
-	 * Furthermore, looking up the parent this way is terrible. At some
-	 * point we will stop allocating a default struct clk when registering
-	 * a new clk_hw, and this hack will no longer work. Releasing the ccr
-	 * feature before that time solves the problem :-)
-	 */
-	parent_hw = clk_hw_get_parent(&meson8b_cpu_clk.hw);
-	parent_clk = parent_hw->clk;
-	ret = clk_notifier_register(parent_clk, &meson8b_cpu_clk.clk_nb);
-	if (ret) {
-		pr_err("%s: failed to register clock notifier for cpu_clk\n",
-				__func__);
-		return ret;
-	}
-
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 					   &meson8b_hw_onecell_data);
 }
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index f2780508edec..73dae83d9932 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -72,8 +72,13 @@
 #define CLKID_MPLL0_DIV		96
 #define CLKID_MPLL1_DIV		97
 #define CLKID_MPLL2_DIV		98
+#define CLKID_CPU_IN_SEL	99
+#define CLKID_CPU_DIV2		100
+#define CLKID_CPU_DIV3		101
+#define CLKID_CPU_SCALE_DIV	102
+#define CLKID_CPU_SCALE_OUT_SEL	103
 
-#define CLK_NR_CLKS		99
+#define CLK_NR_CLKS		104
 
 /*
  * include the CLKID and RESETID that have
-- 
2.14.3
