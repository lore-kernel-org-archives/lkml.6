Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030392AbeBNNnu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:43:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37055 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030362AbeBNNns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:43:48 -0500
X-Google-Smtp-Source: AH8x224Bv7gKcOB7ESNmiyBmtE+56FTCfRaquXayAnz/2w4rR+p0RtBpj4keTnOqOoI+XgLIgbkpdA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] clk: mux: add helper function for index/value translation
Date: Wed, 14 Feb 2018 14:43:34 +0100
Message-Id: <20180214134340.17242-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214134340.17242-1-jbrunet@baylibre.com>
References: <20180214134340.17242-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helper functions for the translation between parent index and
register value in the generic multiplexer function. The purpose of
this change is avoid duplicating the code in other clock providers,
using the same generic logic.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/clk-mux.c        | 75 +++++++++++++++++++++++++-------------------
 include/linux/clk-provider.h |  4 +++
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 39cabe157163..ac4a042f8658 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -26,35 +26,24 @@
  * parent - parent is adjustable through clk_set_parent
  */
 
-static u8 clk_mux_get_parent(struct clk_hw *hw)
+int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
+			 unsigned int val)
 {
-	struct clk_mux *mux = to_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
-	u32 val;
 
-	/*
-	 * FIXME need a mux-specific flag to determine if val is bitwise or numeric
-	 * e.g. sys_clkin_ck's clksel field is 3 bits wide, but ranges from 0x1
-	 * to 0x7 (index starts at one)
-	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
-	 * val = 0x4 really means "bit 2, index starts at bit 0"
-	 */
-	val = clk_readl(mux->reg) >> mux->shift;
-	val &= mux->mask;
-
-	if (mux->table) {
+	if (table) {
 		int i;
 
 		for (i = 0; i < num_parents; i++)
-			if (mux->table[i] == val)
+			if (table[i] == val)
 				return i;
 		return -EINVAL;
 	}
 
-	if (val && (mux->flags & CLK_MUX_INDEX_BIT))
+	if (val && (flags & CLK_MUX_INDEX_BIT))
 		val = ffs(val) - 1;
 
-	if (val && (mux->flags & CLK_MUX_INDEX_ONE))
+	if (val && (flags & CLK_MUX_INDEX_ONE))
 		val--;
 
 	if (val >= num_parents)
@@ -62,36 +51,58 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(clk_mux_val_to_index);
 
-static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 index)
 {
-	struct clk_mux *mux = to_clk_mux(hw);
-	u32 val;
-	unsigned long flags = 0;
+	unsigned int val = index;
 
-	if (mux->table) {
-		index = mux->table[index];
+	if (table) {
+		val = table[index];
 	} else {
-		if (mux->flags & CLK_MUX_INDEX_BIT)
-			index = 1 << index;
+		if (flags & CLK_MUX_INDEX_BIT)
+			val = 1 << index;
 
-		if (mux->flags & CLK_MUX_INDEX_ONE)
-			index++;
+		if (flags & CLK_MUX_INDEX_ONE)
+			val++;
 	}
 
+	return val;
+}
+EXPORT_SYMBOL_GPL(clk_mux_index_to_val);
+
+static u8 clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val;
+
+	val = clk_readl(mux->reg) >> mux->shift;
+	val &= mux->mask;
+
+	return clk_mux_val_to_index(hw, mux->table, mux->flags, val);
+}
+
+static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val = clk_mux_index_to_val(mux->table, mux->flags, index);
+	unsigned long flags = 0;
+	u32 reg;
+
 	if (mux->lock)
 		spin_lock_irqsave(mux->lock, flags);
 	else
 		__acquire(mux->lock);
 
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
-		val = mux->mask << (mux->shift + 16);
+		reg = mux->mask << (mux->shift + 16);
 	} else {
-		val = clk_readl(mux->reg);
-		val &= ~(mux->mask << mux->shift);
+		reg = clk_readl(mux->reg);
+		reg &= ~(mux->mask << mux->shift);
 	}
-	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
+	val = val << mux->shift;
+	reg |= val;
+	clk_writel(reg, mux->reg);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index d8ba26d03332..fe720d679c31 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -511,6 +511,10 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
+int clk_mux_val_to_index(struct clk_hw *hw, u32 *table, unsigned int flags,
+			 unsigned int val);
+unsigned int clk_mux_index_to_val(u32 *table, unsigned int flags, u8 index);
+
 void clk_unregister_mux(struct clk *clk);
 void clk_hw_unregister_mux(struct clk_hw *hw);
 
-- 
2.14.3
