Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeAaSLj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:11:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40105 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753807AbeAaSKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:05 -0500
X-Google-Smtp-Source: AH8x2262R01dc3FoWP2eKACebRfVJSoc55fbBWOs2eqSIhG/alNZo0oqciqsjNiZ79/7usoftbGiFQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] clk: meson: migrate the audio divider clock to clk_regmap
Date: Wed, 31 Jan 2018 19:09:40 +0100
Message-Id: <20180131180945.18025-15-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework meson audio divider driver to use clk_regmap and move gxbb
clock using meson_clk_audio_divider to clk_regmap.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-audio-divider.c | 63 +++++++++++------------------------
 drivers/clk/meson/clkc.h              |  5 +--
 drivers/clk/meson/gxbb.c              | 30 +++++------------
 3 files changed, 30 insertions(+), 68 deletions(-)

diff --git a/drivers/clk/meson/clk-audio-divider.c b/drivers/clk/meson/clk-audio-divider.c
index 6c07db06642d..f7ab5b1db342 100644
--- a/drivers/clk/meson/clk-audio-divider.c
+++ b/drivers/clk/meson/clk-audio-divider.c
@@ -28,8 +28,11 @@
 #include <linux/clk-provider.h>
 #include "clkc.h"
 
-#define to_meson_clk_audio_divider(_hw) container_of(_hw, \
-				struct meson_clk_audio_divider, hw)
+static inline struct meson_clk_audio_div_data *
+meson_clk_audio_div_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_audio_div_data *)clk->data;
+}
 
 static int _div_round(unsigned long parent_rate, unsigned long rate,
 		      unsigned long flags)
@@ -45,15 +48,9 @@ static int _get_val(unsigned long parent_rate, unsigned long rate)
 	return DIV_ROUND_UP_ULL((u64)parent_rate, rate) - 1;
 }
 
-static int _valid_divider(struct clk_hw *hw, int divider)
+static int _valid_divider(unsigned int width, int divider)
 {
-	struct meson_clk_audio_divider *adiv =
-		to_meson_clk_audio_divider(hw);
-	int max_divider;
-	u8 width;
-
-	width = adiv->div.width;
-	max_divider = 1 << width;
+	int max_divider = 1 << width;
 
 	return clamp(divider, 1, max_divider);
 }
@@ -61,14 +58,11 @@ static int _valid_divider(struct clk_hw *hw, int divider)
 static unsigned long audio_divider_recalc_rate(struct clk_hw *hw,
 					       unsigned long parent_rate)
 {
-	struct meson_clk_audio_divider *adiv =
-		to_meson_clk_audio_divider(hw);
-	struct parm *p;
-	unsigned long reg, divider;
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
+	unsigned long divider;
 
-	p = &adiv->div;
-	reg = readl(adiv->base + p->reg_off);
-	divider = PARM_GET(p->width, p->shift, reg) + 1;
+	divider = meson_parm_read(clk->map, &adiv->div);
 
 	return DIV_ROUND_UP_ULL((u64)parent_rate, divider);
 }
@@ -77,14 +71,14 @@ static long audio_divider_round_rate(struct clk_hw *hw,
 				     unsigned long rate,
 				     unsigned long *parent_rate)
 {
-	struct meson_clk_audio_divider *adiv =
-		to_meson_clk_audio_divider(hw);
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
 	unsigned long max_prate;
 	int divider;
 
 	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
 		divider = _div_round(*parent_rate, rate, adiv->flags);
-		divider = _valid_divider(hw, divider);
+		divider = _valid_divider(adiv->div.width, divider);
 		return DIV_ROUND_UP_ULL((u64)*parent_rate, divider);
 	}
 
@@ -93,7 +87,7 @@ static long audio_divider_round_rate(struct clk_hw *hw,
 
 	/* Get the corresponding rounded down divider */
 	divider = max_prate / rate;
-	divider = _valid_divider(hw, divider);
+	divider = _valid_divider(adiv->div.width, divider);
 
 	/* Get actual rate of the parent */
 	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
@@ -106,28 +100,11 @@ static int audio_divider_set_rate(struct clk_hw *hw,
 				  unsigned long rate,
 				  unsigned long parent_rate)
 {
-	struct meson_clk_audio_divider *adiv =
-		to_meson_clk_audio_divider(hw);
-	struct parm *p;
-	unsigned long reg, flags = 0;
-	int val;
-
-	val = _get_val(parent_rate, rate);
-
-	if (adiv->lock)
-		spin_lock_irqsave(adiv->lock, flags);
-	else
-		__acquire(adiv->lock);
-
-	p = &adiv->div;
-	reg = readl(adiv->base + p->reg_off);
-	reg = PARM_SET(p->width, p->shift, reg, val);
-	writel(reg, adiv->base + p->reg_off);
-
-	if (adiv->lock)
-		spin_unlock_irqrestore(adiv->lock, flags);
-	else
-		__release(adiv->lock);
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_audio_div_data *adiv = meson_clk_audio_div_data(clk);
+	int val = _get_val(parent_rate, rate);
+
+	meson_parm_write(clk->map, &adiv->div, val);
 
 	return 0;
 }
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 08a1ebfc65dc..a4a526cbca4c 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -142,12 +142,9 @@ struct meson_clk_mpll_data {
 	spinlock_t *lock;
 };
 
-struct meson_clk_audio_divider {
-	struct clk_hw hw;
-	void __iomem *base;
+struct meson_clk_audio_div_data {
 	struct parm div;
 	u8 flags;
-	spinlock_t *lock;
 };
 
 #define MESON_GATE(_name, _reg, _bit)					\
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index d2724a7ce9e7..196557f11608 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -826,14 +826,15 @@ static struct clk_regmap gxbb_cts_amclk_sel = {
 	},
 };
 
-static struct meson_clk_audio_divider gxbb_cts_amclk_div = {
-	.div = {
-		.reg_off = HHI_AUD_CLK_CNTL,
-		.shift   = 0,
-		.width   = 8,
+static struct clk_regmap gxbb_cts_amclk_div = {
+	.data = &(struct meson_clk_audio_div_data){
+		.div = {
+			.reg_off = HHI_AUD_CLK_CNTL,
+			.shift   = 0,
+			.width   = 8,
+		},
+		.flags = CLK_DIVIDER_ROUND_CLOSEST,
 	},
-	.flags = CLK_DIVIDER_ROUND_CLOSEST,
-	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "cts_amclk_div",
 		.ops = &meson_clk_audio_divider_ops,
@@ -1777,10 +1778,6 @@ static struct meson_clk_pll *const gxl_clk_plls[] = {
 	&gxl_gp0_pll,
 };
 
-static struct meson_clk_audio_divider *const gxbb_audio_dividers[] = {
-	&gxbb_cts_amclk_div,
-};
-
 static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_clk81,
 	&gxbb_ddr,
@@ -1912,29 +1909,24 @@ static struct clk_regmap *const gx_clk_regmaps[] = {
 	&gxbb_mpll0,
 	&gxbb_mpll1,
 	&gxbb_mpll2,
+	&gxbb_cts_amclk_div,
 };
 
 struct clkc_data {
 	struct meson_clk_pll *const *clk_plls;
 	unsigned int clk_plls_count;
-	struct meson_clk_audio_divider *const *clk_audio_dividers;
-	unsigned int clk_audio_dividers_count;
 	struct clk_hw_onecell_data *hw_onecell_data;
 };
 
 static const struct clkc_data gxbb_clkc_data = {
 	.clk_plls = gxbb_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(gxbb_clk_plls),
-	.clk_audio_dividers = gxbb_audio_dividers,
-	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
 	.hw_onecell_data = &gxbb_hw_onecell_data,
 };
 
 static const struct clkc_data gxl_clkc_data = {
 	.clk_plls = gxl_clk_plls,
 	.clk_plls_count = ARRAY_SIZE(gxl_clk_plls),
-	.clk_audio_dividers = gxbb_audio_dividers,
-	.clk_audio_dividers_count = ARRAY_SIZE(gxbb_audio_dividers),
 	.hw_onecell_data = &gxl_hw_onecell_data,
 };
 
@@ -1981,10 +1973,6 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	for (i = 0; i < clkc_data->clk_plls_count; i++)
 		clkc_data->clk_plls[i]->base = clk_base;
 
-	/* Populate base address for the audio dividers */
-	for (i = 0; i < clkc_data->clk_audio_dividers_count; i++)
-		clkc_data->clk_audio_dividers[i]->base = clk_base;
-
 	/* Populate regmap for the common regmap backed clocks */
 	for (i = 0; i < ARRAY_SIZE(gx_clk_regmaps); i++)
 		gx_clk_regmaps[i]->map = map;
-- 
2.14.3
