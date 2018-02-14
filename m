Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030441AbeBNNoW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:44:22 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46788 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030398AbeBNNnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:43:53 -0500
X-Google-Smtp-Source: AH8x226Dtf302JI6m3Mf9BwXZ1Nz/M8BuackjqNllgGeQxCC3xBv5fjLAqFKl6UxYUPkcyKtSFdHxw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] clk: divider: read-only divider can propagate rate change
Date: Wed, 14 Feb 2018 14:43:39 +0100
Message-Id: <20180214134340.17242-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a divider clock has CLK_DIVIDER_READ_ONLY set, it means that the
register shall be left un-touched, but it does not mean the clock
should stop rate propagation if CLK_SET_RATE_PARENT is set

This is properly handled in qcom clk-regmap-divider but it was not in
the generic divider

To fix this situation, introduce a new helper function
divider_ro_round_rate, on the same model as divider_round_rate.

Fixes: e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-divider.c    | 36 ++++++++++++++++++++++++++++++------
 include/linux/clk-provider.h | 15 +++++++++++++++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 3c98d2650fa3..b6234a5da12d 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -342,19 +342,43 @@ long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 }
 EXPORT_SYMBOL_GPL(divider_round_rate_parent);
 
+long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
+				  unsigned long rate, unsigned long *prate,
+				  const struct clk_div_table *table, u8 width,
+				  unsigned long flags, unsigned int val)
+{
+	int div;
+
+	div = _get_div(table, val, flags, width);
+
+	/* Even a read-only clock can propagate a rate change */
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+		if (!parent)
+			return -EINVAL;
+
+		*prate = clk_hw_round_rate(parent, rate * div);
+	}
+
+	return DIV_ROUND_UP_ULL((u64)*prate, div);
+}
+EXPORT_SYMBOL_GPL(divider_ro_round_rate_parent);
+
+
 static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *prate)
 {
 	struct clk_divider *divider = to_clk_divider(hw);
-	int bestdiv;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
-		bestdiv = clk_readl(divider->reg) >> divider->shift;
-		bestdiv &= clk_div_mask(divider->width);
-		bestdiv = _get_div(divider->table, bestdiv, divider->flags,
-			divider->width);
-		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+		u32 val;
+
+		val = clk_readl(divider->reg) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+
+		return divider_ro_round_rate(hw, rate, prate, divider->table,
+					     divider->width, divider->flags,
+					     val);
 	}
 
 	return divider_round_rate(hw, rate, prate, divider->table,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index cb18526d69cb..210a890008f9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -420,6 +420,10 @@ long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 			       unsigned long rate, unsigned long *prate,
 			       const struct clk_div_table *table,
 			       u8 width, unsigned long flags);
+long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
+				  unsigned long rate, unsigned long *prate,
+				  const struct clk_div_table *table, u8 width,
+				  unsigned long flags, unsigned int val);
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		const struct clk_div_table *table, u8 width,
 		unsigned long flags);
@@ -780,6 +784,17 @@ static inline long divider_round_rate(struct clk_hw *hw, unsigned long rate,
 					 rate, prate, table, width, flags);
 }
 
+static inline long divider_ro_round_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long *prate,
+					 const struct clk_div_table *table,
+					 u8 width, unsigned long flags,
+					 unsigned int val)
+{
+	return divider_ro_round_rate_parent(hw, clk_hw_get_parent(hw),
+					    rate, prate, table, width, flags,
+					    val);
+}
+
 /*
  * FIXME clock api without lock protection
  */
-- 
2.14.3
