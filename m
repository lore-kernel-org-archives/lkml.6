Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeAaSLV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:11:21 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51004 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbeAaSKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:07 -0500
X-Google-Smtp-Source: AH8x227FiUF6p9ESkmk0ibZWdVRWCVBvKJHz2BN4wJLMIi7emoTb6L7oLt+otSb1yUOGlFhJPXPQbw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] clk: meson: migrate plls clocks to clk_regmap
Date: Wed, 31 Jan 2018 19:09:41 +0100
Message-Id: <20180131180945.18025-16-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework meson pll driver to use clk_regmap and move meson8b, gxbb and
axg's clock using meson_clk_pll to clk_regmap.

This rework is not just about clk_regmap, there a serious clean-up of
the driver code:
* Add lock and reset field: Previously inferred from the n field.
* Simplify the reset logic: Code seemed to apply reset differently but
  in fact it always the same -> assert reset, apply params, de-assert
  reset. The 2 lock checking loops have been kept for now, as they
  seem to be necessary.
* Do the sequence of init register pokes only at .init() instead of in
  .set_rate(). Redoing the init on every set_rate() is not necessary

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c     | 213 +++++++++++-----------
 drivers/clk/meson/clk-pll.c | 243 ++++++++++---------------
 drivers/clk/meson/clkc.h    |  36 +---
 drivers/clk/meson/gxbb.c    | 424 +++++++++++++++++++++++++-------------------
 drivers/clk/meson/meson8b.c | 149 +++++++++-------
 5 files changed, 535 insertions(+), 530 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 5c753be71b45..df1f15bfd058 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -22,28 +22,39 @@
 
 static DEFINE_SPINLOCK(meson_clk_lock);
 
-static struct meson_clk_pll axg_fixed_pll = {
-	.m = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.frac = {
-		.reg_off = HHI_MPLL_CNTL2,
-		.shift   = 0,
-		.width   = 12,
-	},
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_fixed_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.frac = {
+			.reg_off = HHI_MPLL_CNTL2,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.l = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -52,23 +63,34 @@ static struct meson_clk_pll axg_fixed_pll = {
 	},
 };
 
-static struct meson_clk_pll axg_sys_pll = {
-	.m = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 10,
-		.width   = 2,
+static struct clk_regmap axg_sys_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 10,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -169,40 +191,47 @@ static const struct pll_rate_table axg_gp0_pll_rate_table[] = {
 	{ /* sentinel */ },
 };
 
-static struct pll_params_table axg_gp0_params_table[] = {
-	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x40010250),
-	PLL_PARAM(HHI_GP0_PLL_CNTL1, 0xc084a000),
-	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0xb75020be),
-	PLL_PARAM(HHI_GP0_PLL_CNTL3, 0x0a59a288),
-	PLL_PARAM(HHI_GP0_PLL_CNTL4, 0xc000004d),
-	PLL_PARAM(HHI_GP0_PLL_CNTL5, 0x00078000),
+const struct reg_sequence axg_gp0_init_regs[] = {
+	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
+	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084a000 },
+	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0xb75020be },
+	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
+	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
+	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
 };
 
-static struct meson_clk_pll axg_gp0_pll = {
-	.m = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.params = {
-		.params_table = axg_gp0_params_table,
-		.params_count =	ARRAY_SIZE(axg_gp0_params_table),
-		.no_init_reset = true,
-		.reset_lock_loop = true,
-	},
-	.rate_table = axg_gp0_pll_rate_table,
-	.rate_count = ARRAY_SIZE(axg_gp0_pll_rate_table),
-	.lock = &meson_clk_lock,
+static struct clk_regmap axg_gp0_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = axg_gp0_pll_rate_table,
+		.init_regs = axg_gp0_init_regs,
+		.init_count = ARRAY_SIZE(axg_gp0_init_regs),
+		.flags = CLK_MESON_PLL_LOCK_LOOP_RST,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
 		.ops = &meson_clk_pll_ops,
@@ -698,14 +727,7 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
 	.num = NR_CLKS,
 };
 
-/* Convenience tables to populate base addresses in .probe */
-
-static struct meson_clk_pll *const axg_clk_plls[] = {
-	&axg_fixed_pll,
-	&axg_sys_pll,
-	&axg_gp0_pll,
-};
-
+/* Convenience table to populate regmap in .probe */
 static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_clk81,
 	&axg_ddr,
@@ -764,22 +786,13 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_mpll1,
 	&axg_mpll2,
 	&axg_mpll3,
-};
-
-struct clkc_data {
-	struct meson_clk_pll *const *clk_plls;
-	unsigned int clk_plls_count;
-	struct clk_hw_onecell_data *hw_onecell_data;
-};
-
-static const struct clkc_data axg_clkc_data = {
-	.clk_plls = axg_clk_plls,
-	.clk_plls_count = ARRAY_SIZE(axg_clk_plls),
-	.hw_onecell_data = &axg_hw_onecell_data,
+	&axg_fixed_pll,
+	&axg_sys_pll,
+	&axg_gp0_pll,
 };
 
 static const struct of_device_id clkc_match_table[] = {
-	{ .compatible = "amlogic,axg-clkc", .data = &axg_clkc_data },
+	{ .compatible = "amlogic,axg-clkc" },
 	{}
 };
 
@@ -792,16 +805,11 @@ static const struct regmap_config clkc_regmap_config = {
 static int axg_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct clkc_data *clkc_data;
 	struct resource *res;
 	void __iomem *clk_base;
 	struct regmap *map;
 	int ret, i;
 
-	clkc_data = of_device_get_match_data(dev);
-	if (!clkc_data)
-		return -EINVAL;
-
 	/*  Generic clocks and PLLs */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -817,21 +825,16 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	/* Populate base address for PLLs */
-	for (i = 0; i < clkc_data->clk_plls_count; i++)
-		clkc_data->clk_plls[i]->base = clk_base;
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
 		axg_clk_regmaps[i]->map = map;
 
-	for (i = 0; i < clkc_data->hw_onecell_data->num; i++) {
+	for (i = 0; i < axg_hw_onecell_data.num; i++) {
 		/* array might be sparse */
-		if (!clkc_data->hw_onecell_data->hws[i])
+		if (!axg_hw_onecell_data.hws[i])
 			continue;
 
-		ret = devm_clk_hw_register(dev,
-					   clkc_data->hw_onecell_data->hws[i]);
+		ret = devm_clk_hw_register(dev, axg_hw_onecell_data.hws[i]);
 		if (ret) {
 			dev_err(dev, "Clock registration failed\n");
 			return ret;
@@ -839,7 +842,7 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	}
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					   clkc_data->hw_onecell_data);
+					   &axg_hw_onecell_data);
 }
 
 static struct platform_driver axg_driver = {
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 218c769c6d50..f3d909719111 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -42,52 +42,36 @@
 
 #include "clkc.h"
 
-#define MESON_PLL_RESET				BIT(29)
-#define MESON_PLL_LOCK				BIT(31)
-
-#define to_meson_clk_pll(_hw) container_of(_hw, struct meson_clk_pll, hw)
+static inline struct meson_clk_pll_data *
+meson_clk_pll_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_pll_data *)clk->data;
+}
 
 static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
-	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
-	struct parm *p;
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
 	u64 rate;
 	u16 n, m, frac = 0, od, od2 = 0, od3 = 0;
-	u32 reg;
-
-	p = &pll->n;
-	reg = readl(pll->base + p->reg_off);
-	n = PARM_GET(p->width, p->shift, reg);
 
-	p = &pll->m;
-	reg = readl(pll->base + p->reg_off);
-	m = PARM_GET(p->width, p->shift, reg);
+	n = meson_parm_read(clk->map, &pll->n);
+	m = meson_parm_read(clk->map, &pll->m);
+	od = meson_parm_read(clk->map, &pll->od);
 
-	p = &pll->od;
-	reg = readl(pll->base + p->reg_off);
-	od = PARM_GET(p->width, p->shift, reg);
+	if (MESON_PARM_APPLICABLE(&pll->od2))
+		od2 = meson_parm_read(clk->map, &pll->od2);
 
-	p = &pll->od2;
-	if (p->width) {
-		reg = readl(pll->base + p->reg_off);
-		od2 = PARM_GET(p->width, p->shift, reg);
-	}
-
-	p = &pll->od3;
-	if (p->width) {
-		reg = readl(pll->base + p->reg_off);
-		od3 = PARM_GET(p->width, p->shift, reg);
-	}
+	if (MESON_PARM_APPLICABLE(&pll->od3))
+		od3 = meson_parm_read(clk->map, &pll->od3);
 
 	rate = (u64)m * parent_rate;
 
-	p = &pll->frac;
-	if (p->width) {
-		reg = readl(pll->base + p->reg_off);
-		frac = PARM_GET(p->width, p->shift, reg);
+	if (MESON_PARM_APPLICABLE(&pll->frac)) {
+		frac = meson_parm_read(clk->map, &pll->frac);
 
-		rate += mul_u64_u32_shr(parent_rate, frac, p->width);
+		rate += mul_u64_u32_shr(parent_rate, frac, pll->frac.width);
 	}
 
 	return div_u64(rate, n) >> od >> od2 >> od3;
@@ -96,177 +80,136 @@ static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
 static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 				     unsigned long *parent_rate)
 {
-	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
-	const struct pll_rate_table *rate_table = pll->rate_table;
-	int i;
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+	const struct pll_rate_table *pllt;
 
 	/*
 	 * if the table is missing, just return the current rate
 	 * since we don't have the other available frequencies
 	 */
-	if (!rate_table)
+	if (!pll->table)
 		return meson_clk_pll_recalc_rate(hw, *parent_rate);
 
-	for (i = 0; i < pll->rate_count; i++) {
-		if (rate <= rate_table[i].rate)
-			return rate_table[i].rate;
+	for (pllt = pll->table; pllt->rate; pllt++) {
+		if (rate <= pllt->rate)
+			return pllt->rate;
 	}
 
 	/* else return the smallest value */
-	return rate_table[0].rate;
+	return pll->table[0].rate;
 }
 
-static const struct pll_rate_table *meson_clk_get_pll_settings(struct meson_clk_pll *pll,
-							       unsigned long rate)
+static const struct pll_rate_table *
+meson_clk_get_pll_settings(const struct pll_rate_table *table,
+			   unsigned long rate)
 {
-	const struct pll_rate_table *rate_table = pll->rate_table;
-	int i;
+	const struct pll_rate_table *pllt;
 
-	if (!rate_table)
+	if (!table)
 		return NULL;
 
-	for (i = 0; i < pll->rate_count; i++) {
-		if (rate == rate_table[i].rate)
-			return &rate_table[i];
+	for (pllt = table; pllt->rate; pllt++) {
+		if (rate == pllt->rate)
+			return pllt;
 	}
+
 	return NULL;
 }
 
-/* Specific wait loop for GXL/GXM GP0 PLL */
-static int meson_clk_pll_wait_lock_reset(struct meson_clk_pll *pll,
-					 struct parm *p_n)
+static int meson_clk_pll_wait_lock(struct clk_hw *hw)
 {
-	int delay = 100;
-	u32 reg;
-
-	while (delay > 0) {
-		reg = readl(pll->base + p_n->reg_off);
-		writel(reg | MESON_PLL_RESET, pll->base + p_n->reg_off);
-		udelay(10);
-		writel(reg & ~MESON_PLL_RESET, pll->base + p_n->reg_off);
-
-		/* This delay comes from AMLogic tree clk-gp0-gxl driver */
-		mdelay(1);
-
-		reg = readl(pll->base + p_n->reg_off);
-		if (reg & MESON_PLL_LOCK)
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+	int delay = pll->flags & CLK_MESON_PLL_LOCK_LOOP_RST ?
+		100 : 24000000;
+
+	do {
+		/* Specific wait loop for GXL/GXM GP0 PLL */
+		if (pll->flags & CLK_MESON_PLL_LOCK_LOOP_RST) {
+			/* Procedure taken from the vendor kernel */
+			meson_parm_write(clk->map, &pll->rst, 1);
+			udelay(10);
+			meson_parm_write(clk->map, &pll->rst, 0);
+			mdelay(1);
+		}
+
+		/* Is the clock locked now ? */
+		if (meson_parm_read(clk->map, &pll->l))
 			return 0;
-		delay--;
-	}
-	return -ETIMEDOUT;
-}
 
-static int meson_clk_pll_wait_lock(struct meson_clk_pll *pll,
-				   struct parm *p_n)
-{
-	int delay = 24000000;
-	u32 reg;
-
-	while (delay > 0) {
-		reg = readl(pll->base + p_n->reg_off);
-
-		if (reg & MESON_PLL_LOCK)
-			return 0;
 		delay--;
-	}
+	} while (delay > 0);
+
 	return -ETIMEDOUT;
 }
 
-static void meson_clk_pll_init_params(struct meson_clk_pll *pll)
+static void meson_clk_pll_init(struct clk_hw *hw)
 {
-	int i;
-
-	for (i = 0 ; i < pll->params.params_count ; ++i)
-		writel(pll->params.params_table[i].value,
-		       pll->base + pll->params.params_table[i].reg_off);
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	if (pll->init_count) {
+		meson_parm_write(clk->map, &pll->rst, 1);
+		regmap_multi_reg_write(clk->map, pll->init_regs,
+				       pll->init_count);
+		meson_parm_write(clk->map, &pll->rst, 0);
+	}
 }
 
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long parent_rate)
 {
-	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
-	struct parm *p;
-	const struct pll_rate_table *rate_set;
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+	const struct pll_rate_table *pllt;
 	unsigned long old_rate;
-	int ret = 0;
-	u32 reg;
 
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
 
 	old_rate = rate;
 
-	rate_set = meson_clk_get_pll_settings(pll, rate);
-	if (!rate_set)
+	pllt = meson_clk_get_pll_settings(pll->table, rate);
+	if (!pllt)
 		return -EINVAL;
 
-	/* Initialize the PLL in a clean state if specified */
-	if (pll->params.params_count)
-		meson_clk_pll_init_params(pll);
-
-	/* PLL reset */
-	p = &pll->n;
-	reg = readl(pll->base + p->reg_off);
-	/* If no_init_reset is provided, avoid resetting at this point */
-	if (!pll->params.no_init_reset)
-		writel(reg | MESON_PLL_RESET, pll->base + p->reg_off);
-
-	reg = PARM_SET(p->width, p->shift, reg, rate_set->n);
-	writel(reg, pll->base + p->reg_off);
-
-	p = &pll->m;
-	reg = readl(pll->base + p->reg_off);
-	reg = PARM_SET(p->width, p->shift, reg, rate_set->m);
-	writel(reg, pll->base + p->reg_off);
-
-	p = &pll->od;
-	reg = readl(pll->base + p->reg_off);
-	reg = PARM_SET(p->width, p->shift, reg, rate_set->od);
-	writel(reg, pll->base + p->reg_off);
-
-	p = &pll->od2;
-	if (p->width) {
-		reg = readl(pll->base + p->reg_off);
-		reg = PARM_SET(p->width, p->shift, reg, rate_set->od2);
-		writel(reg, pll->base + p->reg_off);
-	}
+	/* Put the pll in reset to write the params */
+	meson_parm_write(clk->map, &pll->rst, 1);
 
-	p = &pll->od3;
-	if (p->width) {
-		reg = readl(pll->base + p->reg_off);
-		reg = PARM_SET(p->width, p->shift, reg, rate_set->od3);
-		writel(reg, pll->base + p->reg_off);
-	}
+	meson_parm_write(clk->map, &pll->n, pllt->n);
+	meson_parm_write(clk->map, &pll->m, pllt->m);
+	meson_parm_write(clk->map, &pll->od, pllt->od);
 
-	p = &pll->frac;
-	if (p->width) {
-		reg = readl(pll->base + p->reg_off);
-		reg = PARM_SET(p->width, p->shift, reg, rate_set->frac);
-		writel(reg, pll->base + p->reg_off);
-	}
+	if (MESON_PARM_APPLICABLE(&pll->od2))
+		meson_parm_write(clk->map, &pll->od2, pllt->od2);
 
-	p = &pll->n;
-	/* If clear_reset_for_lock is provided, remove the reset bit here */
-	if (pll->params.clear_reset_for_lock) {
-		reg = readl(pll->base + p->reg_off);
-		writel(reg & ~MESON_PLL_RESET, pll->base + p->reg_off);
-	}
+	if (MESON_PARM_APPLICABLE(&pll->od3))
+		meson_parm_write(clk->map, &pll->od3, pllt->od3);
+
+	if (MESON_PARM_APPLICABLE(&pll->frac))
+		meson_parm_write(clk->map, &pll->frac, pllt->frac);
+
+	/* make sure the reset is cleared at this point */
+	meson_parm_write(clk->map, &pll->rst, 0);
 
-	/* If reset_lock_loop, use a special loop including resetting */
-	if (pll->params.reset_lock_loop)
-		ret = meson_clk_pll_wait_lock_reset(pll, p);
-	else
-		ret = meson_clk_pll_wait_lock(pll, p);
-	if (ret) {
+	if (meson_clk_pll_wait_lock(hw)) {
 		pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
 			__func__, old_rate);
+		/*
+		 * FIXME: Do we really need/want this HACK ?
+		 * It looks unsafe. what happens if the clock gets into a
+		 * broken state and we can't lock back on the old_rate ? Looks
+		 * like an infinite recursion is possible
+		 */
 		meson_clk_pll_set_rate(hw, old_rate, parent_rate);
 	}
 
-	return ret;
+	return 0;
 }
 
 const struct clk_ops meson_clk_pll_ops = {
+	.init		= meson_clk_pll_init,
 	.recalc_rate	= meson_clk_pll_recalc_rate,
 	.round_rate	= meson_clk_pll_round_rate,
 	.set_rate	= meson_clk_pll_set_rate,
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index a4a526cbca4c..f0d70eaffcf3 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -82,41 +82,21 @@ struct pll_rate_table {
 		.frac		= (_frac),				\
 	}								\
 
-struct pll_params_table {
-	unsigned int reg_off;
-	unsigned int value;
-};
-
-#define PLL_PARAM(_reg, _val)						\
-	{								\
-		.reg_off	= (_reg),				\
-		.value		= (_val),				\
-	}
-
-struct pll_setup_params {
-	struct pll_params_table *params_table;
-	unsigned int params_count;
-	/* Workaround for GP0, do not reset before configuring */
-	bool no_init_reset;
-	/* Workaround for GP0, unreset right before checking for lock */
-	bool clear_reset_for_lock;
-	/* Workaround for GXL GP0, reset in the lock checking loop */
-	bool reset_lock_loop;
-};
+#define CLK_MESON_PLL_LOCK_LOOP_RST	BIT(0)
 
-struct meson_clk_pll {
-	struct clk_hw hw;
-	void __iomem *base;
+struct meson_clk_pll_data {
 	struct parm m;
 	struct parm n;
 	struct parm frac;
 	struct parm od;
 	struct parm od2;
 	struct parm od3;
-	const struct pll_setup_params params;
-	const struct pll_rate_table *rate_table;
-	unsigned int rate_count;
-	spinlock_t *lock;
+	struct parm l;
+	struct parm rst;
+	const struct reg_sequence *init_regs;
+	unsigned int init_count;
+	const struct pll_rate_table *table;
+	u8 flags;
 };
 
 #define to_meson_clk_pll(_hw) container_of(_hw, struct meson_clk_pll, hw)
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 196557f11608..49f5716ce8b6 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -188,28 +188,39 @@ static const struct pll_rate_table gxl_gp0_pll_rate_table[] = {
 	{ /* sentinel */ },
 };
 
-static struct meson_clk_pll gxbb_fixed_pll = {
-	.m = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.frac = {
-		.reg_off = HHI_MPLL_CNTL2,
-		.shift   = 0,
-		.width   = 12,
-	},
-	.lock = &meson_clk_lock,
+static struct clk_regmap gxbb_fixed_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.frac = {
+			.reg_off = HHI_MPLL_CNTL2,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.l = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -230,38 +241,49 @@ static struct clk_fixed_factor gxbb_hdmi_pll_pre_mult = {
 	},
 };
 
-static struct meson_clk_pll gxbb_hdmi_pll = {
-	.m = {
-		.reg_off = HHI_HDMI_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_HDMI_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.frac = {
-		.reg_off = HHI_HDMI_PLL_CNTL2,
-		.shift   = 0,
-		.width   = 12,
-	},
-	.od = {
-		.reg_off = HHI_HDMI_PLL_CNTL2,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.od2 = {
-		.reg_off = HHI_HDMI_PLL_CNTL2,
-		.shift   = 22,
-		.width   = 2,
-	},
-	.od3 = {
-		.reg_off = HHI_HDMI_PLL_CNTL2,
-		.shift   = 18,
-		.width   = 2,
+static struct clk_regmap gxbb_hdmi_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.frac = {
+			.reg_off = HHI_HDMI_PLL_CNTL2,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.od = {
+			.reg_off = HHI_HDMI_PLL_CNTL2,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.od2 = {
+			.reg_off = HHI_HDMI_PLL_CNTL2,
+			.shift   = 22,
+			.width   = 2,
+		},
+		.od3 = {
+			.reg_off = HHI_HDMI_PLL_CNTL2,
+			.shift   = 18,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 28,
+			.width   = 1,
+		},
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -271,43 +293,55 @@ static struct meson_clk_pll gxbb_hdmi_pll = {
 	},
 };
 
-static struct meson_clk_pll gxl_hdmi_pll = {
-	.m = {
-		.reg_off = HHI_HDMI_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_HDMI_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
+static struct clk_regmap gxl_hdmi_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.frac = {
+			/*
+			 * On gxl, there is a register shift due to
+			 * HHI_HDMI_PLL_CNTL1 which does not exist on gxbb,
+			 * so we compute the register offset based on the PLL
+			 * base to get it right
+			 */
+			.reg_off = HHI_HDMI_PLL_CNTL + 4,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.od = {
+			.reg_off = HHI_HDMI_PLL_CNTL + 8,
+			.shift   = 21,
+			.width   = 2,
+		},
+		.od2 = {
+			.reg_off = HHI_HDMI_PLL_CNTL + 8,
+			.shift   = 23,
+			.width   = 2,
+		},
+		.od3 = {
+			.reg_off = HHI_HDMI_PLL_CNTL + 8,
+			.shift   = 19,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_HDMI_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
 	},
-	.frac = {
-		/*
-		 * On gxl, there is a register shift due to HHI_HDMI_PLL_CNTL1
-		 * which does not exist on gxbb, so we compute the register
-		 * offset based on the PLL base to get it right
-		 */
-		.reg_off = HHI_HDMI_PLL_CNTL + 4,
-		.shift   = 0,
-		.width   = 12,
-	},
-	.od = {
-		.reg_off = HHI_HDMI_PLL_CNTL + 8,
-		.shift   = 21,
-		.width   = 2,
-	},
-	.od2 = {
-		.reg_off = HHI_HDMI_PLL_CNTL + 8,
-		.shift   = 23,
-		.width   = 2,
-	},
-	.od3 = {
-		.reg_off = HHI_HDMI_PLL_CNTL + 8,
-		.shift   = 19,
-		.width   = 2,
-	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "hdmi_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -317,23 +351,34 @@ static struct meson_clk_pll gxl_hdmi_pll = {
 	},
 };
 
-static struct meson_clk_pll gxbb_sys_pll = {
-	.m = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 10,
-		.width   = 2,
+static struct clk_regmap gxbb_sys_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 10,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -343,38 +388,44 @@ static struct meson_clk_pll gxbb_sys_pll = {
 	},
 };
 
-struct pll_params_table gxbb_gp0_params_table[] = {
-	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x6a000228),
-	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0x69c80000),
-	PLL_PARAM(HHI_GP0_PLL_CNTL3, 0x0a5590c4),
-	PLL_PARAM(HHI_GP0_PLL_CNTL4, 0x0000500d),
+const struct reg_sequence gxbb_gp0_init_regs[] = {
+	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x6a000228 },
+	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0x69c80000 },
+	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a5590c4 },
+	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0x0000500d },
 };
 
-static struct meson_clk_pll gxbb_gp0_pll = {
-	.m = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.params = {
-		.params_table = gxbb_gp0_params_table,
-		.params_count =	ARRAY_SIZE(gxbb_gp0_params_table),
-		.no_init_reset = true,
-		.clear_reset_for_lock = true,
+static struct clk_regmap gxbb_gp0_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = gxbb_gp0_pll_rate_table,
+		.init_regs = gxbb_gp0_init_regs,
+		.init_count = ARRAY_SIZE(gxbb_gp0_init_regs),
 	},
-	.rate_table = gxbb_gp0_pll_rate_table,
-	.rate_count = ARRAY_SIZE(gxbb_gp0_pll_rate_table),
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
 		.ops = &meson_clk_pll_ops,
@@ -384,40 +435,47 @@ static struct meson_clk_pll gxbb_gp0_pll = {
 	},
 };
 
-struct pll_params_table gxl_gp0_params_table[] = {
-	PLL_PARAM(HHI_GP0_PLL_CNTL, 0x40010250),
-	PLL_PARAM(HHI_GP0_PLL_CNTL1, 0xc084a000),
-	PLL_PARAM(HHI_GP0_PLL_CNTL2, 0xb75020be),
-	PLL_PARAM(HHI_GP0_PLL_CNTL3, 0x0a59a288),
-	PLL_PARAM(HHI_GP0_PLL_CNTL4, 0xc000004d),
-	PLL_PARAM(HHI_GP0_PLL_CNTL5, 0x00078000),
+const struct reg_sequence gxl_gp0_init_regs[] = {
+	{ .reg = HHI_GP0_PLL_CNTL,	.def = 0x40010250 },
+	{ .reg = HHI_GP0_PLL_CNTL1,	.def = 0xc084a000 },
+	{ .reg = HHI_GP0_PLL_CNTL2,	.def = 0xb75020be },
+	{ .reg = HHI_GP0_PLL_CNTL3,	.def = 0x0a59a288 },
+	{ .reg = HHI_GP0_PLL_CNTL4,	.def = 0xc000004d },
+	{ .reg = HHI_GP0_PLL_CNTL5,	.def = 0x00078000 },
 };
 
-static struct meson_clk_pll gxl_gp0_pll = {
-	.m = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_GP0_PLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.params = {
-		.params_table = gxl_gp0_params_table,
-		.params_count =	ARRAY_SIZE(gxl_gp0_params_table),
-		.no_init_reset = true,
-		.reset_lock_loop = true,
+static struct clk_regmap gxl_gp0_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_GP0_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = gxl_gp0_pll_rate_table,
+		.init_regs = gxl_gp0_init_regs,
+		.init_count = ARRAY_SIZE(gxl_gp0_init_regs),
+		.flags = CLK_MESON_PLL_LOCK_LOOP_RST,
 	},
-	.rate_table = gxl_gp0_pll_rate_table,
-	.rate_count = ARRAY_SIZE(gxl_gp0_pll_rate_table),
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "gp0_pll",
 		.ops = &meson_clk_pll_ops,
@@ -1762,20 +1820,14 @@ static struct clk_hw_onecell_data gxl_hw_onecell_data = {
 	.num = NR_CLKS,
 };
 
-/* Convenience tables to populate base addresses in .probe */
-
-static struct meson_clk_pll *const gxbb_clk_plls[] = {
-	&gxbb_fixed_pll,
-	&gxbb_hdmi_pll,
-	&gxbb_sys_pll,
+static struct clk_regmap *const gxbb_clk_regmaps[] = {
 	&gxbb_gp0_pll,
+	&gxbb_hdmi_pll,
 };
 
-static struct meson_clk_pll *const gxl_clk_plls[] = {
-	&gxbb_fixed_pll,
-	&gxl_hdmi_pll,
-	&gxbb_sys_pll,
+static struct clk_regmap *const gxl_clk_regmaps[] = {
 	&gxl_gp0_pll,
+	&gxl_hdmi_pll,
 };
 
 static struct clk_regmap *const gx_clk_regmaps[] = {
@@ -1910,23 +1962,25 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_mpll1,
 	&gxbb_mpll2,
 	&gxbb_cts_amclk_div,
+	&gxbb_fixed_pll,
+	&gxbb_sys_pll,
 };
 
 struct clkc_data {
-	struct meson_clk_pll *const *clk_plls;
-	unsigned int clk_plls_count;
+	struct clk_regmap *const *regmap_clks;
+	unsigned int regmap_clks_count;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
 static const struct clkc_data gxbb_clkc_data = {
-	.clk_plls = gxbb_clk_plls,
-	.clk_plls_count = ARRAY_SIZE(gxbb_clk_plls),
+	.regmap_clks = gxbb_clk_regmaps,
+	.regmap_clks_count = ARRAY_SIZE(gxbb_clk_regmaps),
 	.hw_onecell_data = &gxbb_hw_onecell_data,
 };
 
 static const struct clkc_data gxl_clkc_data = {
-	.clk_plls = gxl_clk_plls,
-	.clk_plls_count = ARRAY_SIZE(gxl_clk_plls),
+	.regmap_clks = gxl_clk_regmaps,
+	.regmap_clks_count = ARRAY_SIZE(gxl_clk_regmaps),
 	.hw_onecell_data = &gxl_hw_onecell_data,
 };
 
@@ -1969,14 +2023,14 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	/* Populate base address for PLLs */
-	for (i = 0; i < clkc_data->clk_plls_count; i++)
-		clkc_data->clk_plls[i]->base = clk_base;
-
 	/* Populate regmap for the common regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(gx_clk_regmaps); i++)
 		gx_clk_regmaps[i]->map = map;
 
+	/* Populate regmap for soc specific clocks */
+	for (i = 0; i < clkc_data->regmap_clks_count; i++)
+		clkc_data->regmap_clks[i]->map = map;
+
 	/* Register all clks */
 	for (i = 0; i < clkc_data->hw_onecell_data->num; i++) {
 		/* array might be sparse */
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 4bb51c8f3102..4fd8253c54bb 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -122,23 +122,34 @@ static struct clk_fixed_rate meson8b_xtal = {
 	},
 };
 
-static struct meson_clk_pll meson8b_fixed_pll = {
-	.m = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.lock = &meson_clk_lock,
+static struct clk_regmap meson8b_fixed_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -148,23 +159,34 @@ static struct meson_clk_pll meson8b_fixed_pll = {
 	},
 };
 
-static struct meson_clk_pll meson8b_vid_pll = {
-	.m = {
-		.reg_off = HHI_VID_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_VID_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_VID_PLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
+static struct clk_regmap meson8b_vid_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_VID_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_VID_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_VID_PLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_VID_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_VID_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "vid_pll",
 		.ops = &meson_clk_pll_ro_ops,
@@ -174,25 +196,35 @@ static struct meson_clk_pll meson8b_vid_pll = {
 	},
 };
 
-static struct meson_clk_pll meson8b_sys_pll = {
-	.m = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 0,
-		.width   = 9,
-	},
-	.n = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 9,
-		.width   = 5,
-	},
-	.od = {
-		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 16,
-		.width   = 2,
-	},
-	.rate_table = sys_pll_rate_table,
-	.rate_count = ARRAY_SIZE(sys_pll_rate_table),
-	.lock = &meson_clk_lock,
+static struct clk_regmap meson8b_sys_pll = {
+	.data = &(struct meson_clk_pll_data){
+		.m = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 0,
+			.width   = 9,
+		},
+		.n = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 9,
+			.width   = 5,
+		},
+		.od = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 16,
+			.width   = 2,
+		},
+		.l = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 31,
+			.width   = 1,
+		},
+		.rst = {
+			.reg_off = HHI_SYS_PLL_CNTL,
+			.shift   = 29,
+			.width   = 1,
+		},
+		.table = sys_pll_rate_table,
+	},
 	.hw.init = &(struct clk_init_data){
 		.name = "sys_pll",
 		.ops = &meson_clk_pll_ops,
@@ -613,12 +645,6 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 	.num = CLK_NR_CLKS,
 };
 
-static struct meson_clk_pll *const meson8b_clk_plls[] = {
-	&meson8b_fixed_pll,
-	&meson8b_vid_pll,
-	&meson8b_sys_pll,
-};
-
 static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_clk81,
 	&meson8b_ddr,
@@ -703,6 +729,9 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_mpll0,
 	&meson8b_mpll1,
 	&meson8b_mpll2,
+	&meson8b_fixed_pll,
+	&meson8b_vid_pll,
+	&meson8b_sys_pll,
 };
 
 static const struct meson8b_clk_reset_line {
@@ -825,10 +854,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 	if (IS_ERR(map))
 		return PTR_ERR(map);
 
-	/* Populate base address for PLLs */
-	for (i = 0; i < ARRAY_SIZE(meson8b_clk_plls); i++)
-		meson8b_clk_plls[i]->base = clk_base;
-
 	/* Populate the base address for CPU clk */
 	meson8b_cpu_clk.base = clk_base;
 
-- 
2.14.3
