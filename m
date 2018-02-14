Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030505AbeBNNsX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:48:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34372 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030254AbeBNNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:43:46 -0500
X-Google-Smtp-Source: AH8x227mci4Te4EHW1Lv/t9m6X1yAfNkrB//h+BNDC+h96/+dNOfuKCQece2PNSv1o0jiAan0Njdxg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] clk: divider: export clk_div_mask() helper
Date: Wed, 14 Feb 2018 14:43:33 +0100
Message-Id: <20180214134340.17242-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export clk_div_mask() in clk-provider header so every clock providers
derived from the generic clock divider may share the definition instead
of redefining it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

I have 's/div_mask/clk_div_mask' to avoid the conflict with
tegra's divider, which also defines the macro div_mask() but does not
actually derives from the generic divider.

 drivers/clk/clk-divider.c    | 24 +++++++++++-------------
 include/linux/clk-provider.h |  1 +
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index b49942b9fe50..3c98d2650fa3 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -28,12 +28,10 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
-#define div_mask(width)	((1 << (width)) - 1)
-
 static unsigned int _get_table_maxdiv(const struct clk_div_table *table,
 				      u8 width)
 {
-	unsigned int maxdiv = 0, mask = div_mask(width);
+	unsigned int maxdiv = 0, mask = clk_div_mask(width);
 	const struct clk_div_table *clkt;
 
 	for (clkt = table; clkt->div; clkt++)
@@ -57,12 +55,12 @@ static unsigned int _get_maxdiv(const struct clk_div_table *table, u8 width,
 				unsigned long flags)
 {
 	if (flags & CLK_DIVIDER_ONE_BASED)
-		return div_mask(width);
+		return clk_div_mask(width);
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
-		return 1 << div_mask(width);
+		return 1 << clk_div_mask(width);
 	if (table)
 		return _get_table_maxdiv(table, width);
-	return div_mask(width) + 1;
+	return clk_div_mask(width) + 1;
 }
 
 static unsigned int _get_table_div(const struct clk_div_table *table,
@@ -84,7 +82,7 @@ static unsigned int _get_div(const struct clk_div_table *table,
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		return 1 << val;
 	if (flags & CLK_DIVIDER_MAX_AT_ZERO)
-		return val ? val : div_mask(width) + 1;
+		return val ? val : clk_div_mask(width) + 1;
 	if (table)
 		return _get_table_div(table, val);
 	return val + 1;
@@ -109,7 +107,7 @@ static unsigned int _get_val(const struct clk_div_table *table,
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		return __ffs(div);
 	if (flags & CLK_DIVIDER_MAX_AT_ZERO)
-		return (div == div_mask(width) + 1) ? 0 : div;
+		return (div == clk_div_mask(width) + 1) ? 0 : div;
 	if (table)
 		return  _get_table_val(table, div);
 	return div - 1;
@@ -141,7 +139,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	unsigned int val;
 
 	val = clk_readl(divider->reg) >> divider->shift;
-	val &= div_mask(divider->width);
+	val &= clk_div_mask(divider->width);
 
 	return divider_recalc_rate(hw, parent_rate, val, divider->table,
 				   divider->flags, divider->width);
@@ -353,7 +351,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
 		bestdiv = clk_readl(divider->reg) >> divider->shift;
-		bestdiv &= div_mask(divider->width);
+		bestdiv &= clk_div_mask(divider->width);
 		bestdiv = _get_div(divider->table, bestdiv, divider->flags,
 			divider->width);
 		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
@@ -376,7 +374,7 @@ int divider_get_val(unsigned long rate, unsigned long parent_rate,
 
 	value = _get_val(table, div, flags, width);
 
-	return min_t(unsigned int, value, div_mask(width));
+	return min_t(unsigned int, value, clk_div_mask(width));
 }
 EXPORT_SYMBOL_GPL(divider_get_val);
 
@@ -399,10 +397,10 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 		__acquire(divider->lock);
 
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
-		val = div_mask(divider->width) << (divider->shift + 16);
+		val = clk_div_mask(divider->width) << (divider->shift + 16);
 	} else {
 		val = clk_readl(divider->reg);
-		val &= ~(div_mask(divider->width) << divider->shift);
+		val &= ~(clk_div_mask(divider->width) << divider->shift);
 	}
 	val |= (u32)value << divider->shift;
 	clk_writel(val, divider->reg);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f711be6e8c44..d8ba26d03332 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -399,6 +399,7 @@ struct clk_divider {
 	spinlock_t	*lock;
 };
 
+#define clk_div_mask(width)	((1 << (width)) - 1)
 #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
 
 #define CLK_DIVIDER_ONE_BASED		BIT(0)
-- 
2.14.3
