Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753972AbeAaSLl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:11:41 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35253 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753717AbeAaSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:05 -0500
X-Google-Smtp-Source: AH8x224CwwwnUHFcqh39kbc1mipsvQqiKne4vfXg8NK6Tr3mLh610cL7eVm6vJyhRB7LKBkaXsXpXw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] clk: meson: migrate mplls clocks to clk_regmap
Date: Wed, 31 Jan 2018 19:09:39 +0100
Message-Id: <20180131180945.18025-14-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework meson mpll driver to use clk_regmap and move meson8b, gxbb
and axg clocks using meson_clk_mpll to clk_regmap

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c      | 245 +++++++++++++++++++++----------------------
 drivers/clk/meson/clk-mpll.c | 102 +++++++-----------
 drivers/clk/meson/clkc.h     |   4 +-
 drivers/clk/meson/gxbb.c     | 161 ++++++++++++++--------------
 drivers/clk/meson/meson8b.c  | 155 ++++++++++++++-------------
 5 files changed, 313 insertions(+), 354 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 6ce413a9d0dd..5c753be71b45 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -267,38 +267,40 @@ static struct clk_fixed_factor axg_fclk_div7 = {
 	},
 };
 
-static struct meson_clk_mpll axg_mpll0 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 15,
-		.width	 = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 14,
-		.width	 = 1,
+static struct clk_regmap axg_mpll0 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 15,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 14,
+			.width	 = 1,
+		},
+		.ssen = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 25,
+			.width	 = 1,
+		},
+		.misc = {
+			.reg_off = HHI_PLL_TOP_MISC,
+			.shift   = 0,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.ssen = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 25,
-		.width	 = 1,
-	},
-	.misc = {
-		.reg_off = HHI_PLL_TOP_MISC,
-		.shift   = 0,
-		.width	 = 1,
-	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &meson_clk_mpll_ops,
@@ -307,33 +309,35 @@ static struct meson_clk_mpll axg_mpll0 = {
 	},
 };
 
-static struct meson_clk_mpll axg_mpll1 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 0,
-		.width   = 14,
+static struct clk_regmap axg_mpll1 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 15,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 14,
+			.width	 = 1,
+		},
+		.misc = {
+			.reg_off = HHI_PLL_TOP_MISC,
+			.shift   = 1,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 15,
-		.width	 = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 14,
-		.width	 = 1,
-	},
-	.misc = {
-		.reg_off = HHI_PLL_TOP_MISC,
-		.shift   = 1,
-		.width	 = 1,
-	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1",
 		.ops = &meson_clk_mpll_ops,
@@ -342,33 +346,35 @@ static struct meson_clk_mpll axg_mpll1 = {
 	},
 };
 
-static struct meson_clk_mpll axg_mpll2 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 15,
-		.width	 = 1,
+static struct clk_regmap axg_mpll2 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 15,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 14,
+			.width	 = 1,
+		},
+		.misc = {
+			.reg_off = HHI_PLL_TOP_MISC,
+			.shift   = 2,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 14,
-		.width	 = 1,
-	},
-	.misc = {
-		.reg_off = HHI_PLL_TOP_MISC,
-		.shift   = 2,
-		.width	 = 1,
-	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2",
 		.ops = &meson_clk_mpll_ops,
@@ -377,33 +383,35 @@ static struct meson_clk_mpll axg_mpll2 = {
 	},
 };
 
-static struct meson_clk_mpll axg_mpll3 = {
-	.sdm = {
-		.reg_off = HHI_MPLL3_CNTL0,
-		.shift   = 12,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL3_CNTL0,
-		.shift   = 11,
-		.width	 = 1,
+static struct clk_regmap axg_mpll3 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL3_CNTL0,
+			.shift   = 12,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL3_CNTL0,
+			.shift   = 11,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL3_CNTL0,
+			.shift   = 2,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL3_CNTL0,
+			.shift   = 0,
+			.width	 = 1,
+		},
+		.misc = {
+			.reg_off = HHI_PLL_TOP_MISC,
+			.shift   = 3,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.n2 = {
-		.reg_off = HHI_MPLL3_CNTL0,
-		.shift   = 2,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL3_CNTL0,
-		.shift   = 0,
-		.width	 = 1,
-	},
-	.misc = {
-		.reg_off = HHI_PLL_TOP_MISC,
-		.shift   = 3,
-		.width	 = 1,
-	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll3",
 		.ops = &meson_clk_mpll_ops,
@@ -698,13 +706,6 @@ static struct meson_clk_pll *const axg_clk_plls[] = {
 	&axg_gp0_pll,
 };
 
-static struct meson_clk_mpll *const axg_clk_mplls[] = {
-	&axg_mpll0,
-	&axg_mpll1,
-	&axg_mpll2,
-	&axg_mpll3,
-};
-
 static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_clk81,
 	&axg_ddr,
@@ -759,19 +760,19 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
 	&axg_mpeg_clk_sel,
 	&axg_sd_emmc_b_clk0_sel,
 	&axg_sd_emmc_c_clk0_sel,
+	&axg_mpll0,
+	&axg_mpll1,
+	&axg_mpll2,
+	&axg_mpll3,
 };
 
 struct clkc_data {
-	struct meson_clk_mpll *const *clk_mplls;
-	unsigned int clk_mplls_count;
 	struct meson_clk_pll *const *clk_plls;
 	unsigned int clk_plls_count;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
 static const struct clkc_data axg_clkc_data = {
-	.clk_mplls = axg_clk_mplls,
-	.clk_mplls_count = ARRAY_SIZE(axg_clk_mplls),
 	.clk_plls = axg_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(axg_clk_plls),
 	.hw_onecell_data = &axg_hw_onecell_data,
@@ -820,10 +821,6 @@ static int axg_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_plls_count; i++)
 		clkc_data->clk_plls[i]->base = clk_base;
 
-	/* Populate base address for MPLLs */
-	for (i = 0; i < clkc_data->clk_mplls_count; i++)
-		clkc_data->clk_mplls[i]->base = clk_base;
-
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(axg_clk_regmaps); i++)
 		axg_clk_regmaps[i]->map = map;
diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index 6d79d6daadc4..66998ff47635 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -68,11 +68,15 @@
 #define N2_MIN	4
 #define N2_MAX	511
 
-#define to_meson_clk_mpll(_hw) container_of(_hw, struct meson_clk_mpll, hw)
+static inline struct meson_clk_mpll_data *
+meson_clk_mpll_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_mpll_data *)clk->data;
+}
 
 static long rate_from_params(unsigned long parent_rate,
-				      unsigned long sdm,
-				      unsigned long n2)
+			     unsigned int sdm,
+			     unsigned int n2)
 {
 	unsigned long divisor = (SDM_DEN * n2) + sdm;
 
@@ -84,8 +88,8 @@ static long rate_from_params(unsigned long parent_rate,
 
 static void params_from_rate(unsigned long requested_rate,
 			     unsigned long parent_rate,
-			     unsigned long *sdm,
-			     unsigned long *n2)
+			     unsigned int *sdm,
+			     unsigned int *n2)
 {
 	uint64_t div = parent_rate;
 	unsigned long rem = do_div(div, requested_rate);
@@ -105,31 +109,23 @@ static void params_from_rate(unsigned long requested_rate,
 static unsigned long mpll_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
-	struct meson_clk_mpll *mpll = to_meson_clk_mpll(hw);
-	struct parm *p;
-	unsigned long reg, sdm, n2;
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
+	unsigned int sdm, n2;
 	long rate;
 
-	p = &mpll->sdm;
-	reg = readl(mpll->base + p->reg_off);
-	sdm = PARM_GET(p->width, p->shift, reg);
-
-	p = &mpll->n2;
-	reg = readl(mpll->base + p->reg_off);
-	n2 = PARM_GET(p->width, p->shift, reg);
+	sdm = meson_parm_read(clk->map, &mpll->sdm);
+	n2 = meson_parm_read(clk->map, &mpll->n2);
 
 	rate = rate_from_params(parent_rate, sdm, n2);
-	if (rate < 0)
-		return 0;
-
-	return rate;
+	return rate < 0 ? 0 : rate;
 }
 
 static long mpll_round_rate(struct clk_hw *hw,
 			    unsigned long rate,
 			    unsigned long *parent_rate)
 {
-	unsigned long sdm, n2;
+	unsigned int sdm, n2;
 
 	params_from_rate(rate, *parent_rate, &sdm, &n2);
 	return rate_from_params(*parent_rate, sdm, n2);
@@ -139,9 +135,9 @@ static int mpll_set_rate(struct clk_hw *hw,
 			 unsigned long rate,
 			 unsigned long parent_rate)
 {
-	struct meson_clk_mpll *mpll = to_meson_clk_mpll(hw);
-	struct parm *p;
-	unsigned long reg, sdm, n2;
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
+	unsigned int sdm, n2;
 	unsigned long flags = 0;
 
 	params_from_rate(rate, parent_rate, &sdm, &n2);
@@ -151,34 +147,20 @@ static int mpll_set_rate(struct clk_hw *hw,
 	else
 		__acquire(mpll->lock);
 
-	p = &mpll->sdm;
-	reg = readl(mpll->base + p->reg_off);
-	reg = PARM_SET(p->width, p->shift, reg, sdm);
-	writel(reg, mpll->base + p->reg_off);
-
-	p = &mpll->sdm_en;
-	reg = readl(mpll->base + p->reg_off);
-	reg = PARM_SET(p->width, p->shift, reg, 1);
-	writel(reg, mpll->base + p->reg_off);
-
-	p = &mpll->ssen;
-	if (p->width != 0) {
-		reg = readl(mpll->base + p->reg_off);
-		reg = PARM_SET(p->width, p->shift, reg, 1);
-		writel(reg, mpll->base + p->reg_off);
-	}
+	/* Enable and set the fractional part */
+	meson_parm_write(clk->map, &mpll->sdm, sdm);
+	meson_parm_write(clk->map, &mpll->sdm_en, 1);
 
-	p = &mpll->n2;
-	reg = readl(mpll->base + p->reg_off);
-	reg = PARM_SET(p->width, p->shift, reg, n2);
-	writel(reg, mpll->base + p->reg_off);
+	/* Set additional fractional part enable if required */
+	if (MESON_PARM_APPLICABLE(&mpll->ssen))
+		meson_parm_write(clk->map, &mpll->ssen, 1);
 
-	p = &mpll->misc;
-	if (p->width != 0) {
-		reg = readl(mpll->base + p->reg_off);
-		reg = PARM_SET(p->width, p->shift, reg, 1);
-		writel(reg, mpll->base + p->reg_off);
-	}
+	/* Set the integer divider part */
+	meson_parm_write(clk->map, &mpll->n2, n2);
+
+	/* Set the magic misc bit if required */
+	if (MESON_PARM_APPLICABLE(&mpll->misc))
+		meson_parm_write(clk->map, &mpll->misc, 1);
 
 	if (mpll->lock)
 		spin_unlock_irqrestore(mpll->lock, flags);
@@ -190,9 +172,8 @@ static int mpll_set_rate(struct clk_hw *hw,
 
 static void mpll_enable_core(struct clk_hw *hw, int enable)
 {
-	struct meson_clk_mpll *mpll = to_meson_clk_mpll(hw);
-	struct parm *p;
-	unsigned long reg;
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
 	unsigned long flags = 0;
 
 	if (mpll->lock)
@@ -200,10 +181,7 @@ static void mpll_enable_core(struct clk_hw *hw, int enable)
 	else
 		__acquire(mpll->lock);
 
-	p = &mpll->en;
-	reg = readl(mpll->base + p->reg_off);
-	reg = PARM_SET(p->width, p->shift, reg, enable ? 1 : 0);
-	writel(reg, mpll->base + p->reg_off);
+	meson_parm_write(clk->map, &mpll->en, enable ? 1 : 0);
 
 	if (mpll->lock)
 		spin_unlock_irqrestore(mpll->lock, flags);
@@ -226,16 +204,10 @@ static void mpll_disable(struct clk_hw *hw)
 
 static int mpll_is_enabled(struct clk_hw *hw)
 {
-	struct meson_clk_mpll *mpll = to_meson_clk_mpll(hw);
-	struct parm *p;
-	unsigned long reg;
-	int en;
-
-	p = &mpll->en;
-	reg = readl(mpll->base + p->reg_off);
-	en = PARM_GET(p->width, p->shift, reg);
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
 
-	return en;
+	return meson_parm_read(clk->map, &mpll->en);
 }
 
 const struct clk_ops meson_clk_mpll_ro_ops = {
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 8edc25297422..08a1ebfc65dc 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -132,9 +132,7 @@ struct meson_clk_cpu {
 int meson_clk_cpu_notifier_cb(struct notifier_block *nb, unsigned long event,
 		void *data);
 
-struct meson_clk_mpll {
-	struct clk_hw hw;
-	void __iomem *base;
+struct meson_clk_mpll_data {
 	struct parm sdm;
 	struct parm sdm_en;
 	struct parm n2;
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index d9f426265774..d2724a7ce9e7 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -482,33 +482,35 @@ static struct clk_fixed_factor gxbb_fclk_div7 = {
 	},
 };
 
-static struct meson_clk_mpll gxbb_mpll0 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 15,
-		.width	 = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 14,
-		.width	 = 1,
-	},
-	.ssen = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 25,
-		.width	 = 1,
+static struct clk_regmap gxbb_mpll0 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 15,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 14,
+			.width	 = 1,
+		},
+		.ssen = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 25,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &meson_clk_mpll_ops,
@@ -517,28 +519,30 @@ static struct meson_clk_mpll gxbb_mpll0 = {
 	},
 };
 
-static struct meson_clk_mpll gxbb_mpll1 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 15,
-		.width	 = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 14,
-		.width	 = 1,
+static struct clk_regmap gxbb_mpll1 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 15,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 14,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1",
 		.ops = &meson_clk_mpll_ops,
@@ -547,28 +551,30 @@ static struct meson_clk_mpll gxbb_mpll1 = {
 	},
 };
 
-static struct meson_clk_mpll gxbb_mpll2 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 15,
-		.width	 = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 14,
-		.width	 = 1,
+static struct clk_regmap gxbb_mpll2 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 15,
+			.width	 = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 14,
+			.width	 = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2",
 		.ops = &meson_clk_mpll_ops,
@@ -1771,12 +1777,6 @@ static struct meson_clk_pll *const gxl_clk_plls[] = {
 	&gxl_gp0_pll,
 };
 
-static struct meson_clk_mpll *const gxbb_clk_mplls[] = {
-	&gxbb_mpll0,
-	&gxbb_mpll1,
-	&gxbb_mpll2,
-};
-
 static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
 	&gxbb_cts_amclk_div,
 };
@@ -1909,11 +1909,12 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_vapb_0_sel,
 	&gxbb_vapb_1_sel,
 	&gxbb_vapb_sel,
+	&gxbb_mpll0,
+	&gxbb_mpll1,
+	&gxbb_mpll2,
 };
 
 struct clkc_data {
-	struct meson_clk_mpll *const *clk_mplls;
-	unsigned int clk_mplls_count;
 	struct meson_clk_pll *const *clk_plls;
 	unsigned int clk_plls_count;
 	struct meson_clk_audio_divider *const *clk_audio_dividers;
@@ -1922,8 +1923,6 @@ struct clkc_data {
 };
 
 static const struct clkc_data gxbb_clkc_data = {
-	.clk_mplls = gxbb_clk_mplls,
-	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
 	.clk_plls = gxbb_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(gxbb_clk_plls),
 	.clk_audio_dividers = gxbb_audio_dividers,
@@ -1932,8 +1931,6 @@ static const struct clkc_data gxbb_clkc_data = {
 };
 
 static const struct clkc_data gxl_clkc_data = {
-	.clk_mplls = gxbb_clk_mplls,
-	.clk_mplls_count = ARRAY_SIZE(gxbb_clk_mplls),
 	.clk_plls = gxl_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(gxl_clk_plls),
 	.clk_audio_dividers = gxbb_audio_dividers,
@@ -1984,10 +1981,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_plls_count; i++)
 		clkc_data->clk_plls[i]->base = clk_base;
 
-	/* Populate base address for MPLLs */
-	for (i = 0; i < clkc_data->clk_mplls_count; i++)
-		clkc_data->clk_mplls[i]->base = clk_base;
-
 	/* Populate base address for the audio dividers */
 	for (i = 0; i < clkc_data->clk_audio_dividers_count; i++)
 		clkc_data->clk_audio_dividers[i]->base = clk_base;
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index e643f7556f5e..4bb51c8f3102 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -257,33 +257,35 @@ static struct clk_fixed_factor meson8b_fclk_div7 = {
 	},
 };
 
-static struct meson_clk_mpll meson8b_mpll0 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 15,
-		.width   = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL7,
-		.shift   = 14,
-		.width   = 1,
-	},
-	.ssen = {
-		.reg_off = HHI_MPLL_CNTL,
-		.shift   = 25,
-		.width   = 1,
+static struct clk_regmap meson8b_mpll0 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 15,
+			.width   = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL7,
+			.shift   = 14,
+			.width   = 1,
+		},
+		.ssen = {
+			.reg_off = HHI_MPLL_CNTL,
+			.shift   = 25,
+			.width   = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll0",
 		.ops = &meson_clk_mpll_ops,
@@ -292,28 +294,30 @@ static struct meson_clk_mpll meson8b_mpll0 = {
 	},
 };
 
-static struct meson_clk_mpll meson8b_mpll1 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 15,
-		.width   = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 16,
-		.width   = 9,
+static struct clk_regmap meson8b_mpll1 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 15,
+			.width   = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL8,
+			.shift   = 14,
+			.width   = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL8,
-		.shift   = 14,
-		.width   = 1,
-	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll1",
 		.ops = &meson_clk_mpll_ops,
@@ -322,28 +326,30 @@ static struct meson_clk_mpll meson8b_mpll1 = {
 	},
 };
 
-static struct meson_clk_mpll meson8b_mpll2 = {
-	.sdm = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 0,
-		.width   = 14,
-	},
-	.sdm_en = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 15,
-		.width   = 1,
-	},
-	.n2 = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 16,
-		.width   = 9,
-	},
-	.en = {
-		.reg_off = HHI_MPLL_CNTL9,
-		.shift   = 14,
-		.width   = 1,
+static struct clk_regmap meson8b_mpll2 = {
+	.data = &(struct meson_clk_mpll_data){
+		.sdm = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 0,
+			.width   = 14,
+		},
+		.sdm_en = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 15,
+			.width   = 1,
+		},
+		.n2 = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 16,
+			.width   = 9,
+		},
+		.en = {
+			.reg_off = HHI_MPLL_CNTL9,
+			.shift   = 14,
+			.width   = 1,
+		},
+		.lock = &meson_clk_lock,
 	},
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "mpll2",
 		.ops = &meson_clk_mpll_ops,
@@ -613,12 +619,6 @@ static struct meson_clk_pll *const meson8b_clk_plls[] = {
 	&meson8b_sys_pll,
 };
 
-static struct meson_clk_mpll *const meson8b_clk_mplls[] = {
-	&meson8b_mpll0,
-	&meson8b_mpll1,
-	&meson8b_mpll2,
-};
-
 static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_clk81,
 	&meson8b_ddr,
@@ -700,6 +700,9 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_ao_iface,
 	&meson8b_mpeg_clk_div,
 	&meson8b_mpeg_clk_sel,
+	&meson8b_mpll0,
+	&meson8b_mpll1,
+	&meson8b_mpll2,
 };
 
 static const struct meson8b_clk_reset_line {
@@ -826,10 +829,6 @@ static int meson8b_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(meson8b_clk_plls); i++)
 		meson8b_clk_plls[i]->base = clk_base;
 
-	/* Populate base address for MPLLs */
-	for (i = 0; i < ARRAY_SIZE(meson8b_clk_mplls); i++)
-		meson8b_clk_mplls[i]->base = clk_base;
-
 	/* Populate the base address for CPU clk */
 	meson8b_cpu_clk.base = clk_base;
 
-- 
2.14.3
