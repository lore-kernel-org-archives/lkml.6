Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeBFEJe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:09:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeBFEJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:09:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7766060300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org
Cc: sricharan@codeaurora.org
Subject: [PATCH v6 02/15] clk: mux: Split out register accessors for reuse
Date: Tue,  6 Feb 2018 09:38:15 +0530
Message-Id: <1517890108-8140-3-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

We want to reuse the logic in clk-mux.c for other clock drivers
that don't use readl as register accessors. Fortunately, there
really isn't much to the mux code besides the table indirection
and quirk flags if you assume any bit shifting and masking has
been done already. Pull that logic out into reusable functions
that operate on an optional table and some flags so that other
drivers can use the same logic.

[Sricharan: Rebased for mainline]
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-mux.c        | 75 +++++++++++++++++++++++++++-----------------
 include/linux/clk-provider.h |  9 ++++--
 2 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 39cabe1..22ebf99 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -26,35 +26,24 @@
  * parent - parent is adjustable through clk_set_parent
  */
 
-static u8 clk_mux_get_parent(struct clk_hw *hw)
+unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
+				unsigned int *table, unsigned long flags)
 {
-	struct clk_mux *mux = to_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
-	u32 val;
-
-	/*
-	 * FIXME need a mux-specific flag to determine if val is bitwise or numeric
-	 * e.g. sys_clkin_ck's clksel field is 3 bits wide, but ranges from 0x1
-	 * to 0x7 (index starts at one)
-	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
-	 * val = 0x4 really means "bit 2, index starts at bit 0"
-	 */
-	val = clk_readl(mux->reg) >> mux->shift;
-	val &= mux->mask;
 
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
@@ -62,23 +51,53 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(clk_mux_get_parent);
 
-static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+static u8 _clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
-	unsigned long flags = 0;
 
-	if (mux->table) {
-		index = mux->table[index];
+	/*
+	 * FIXME need a mux-specific flag to determine if val is bitwise or
+	 * numeric e.g. sys_clkin_ck's clksel field is 3 bits wide,
+	 * but ranges from 0x1 to 0x7 (index starts at one)
+	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
+	 * val = 0x4 really means "bit 2, index starts at bit 0"
+	 */
+	val = clk_readl(mux->reg) >> mux->shift;
+	val &= mux->mask;
+
+	return clk_mux_get_parent(hw, val, mux->table, mux->flags);
+}
+
+unsigned int clk_mux_reindex(u8 index, unsigned int *table,
+			     unsigned long flags)
+{
+	unsigned int val = index;
+
+	if (table) {
+		val = table[val];
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
+EXPORT_SYMBOL_GPL(clk_mux_reindex);
+
+static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val;
+	unsigned long flags = 0;
+
+	index = clk_mux_reindex(index, mux->table, mux->flags);
+
 	if (mux->lock)
 		spin_lock_irqsave(mux->lock, flags);
 	else
@@ -102,14 +121,14 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 }
 
 const struct clk_ops clk_mux_ops = {
-	.get_parent = clk_mux_get_parent,
+	.get_parent = _clk_mux_get_parent,
 	.set_parent = clk_mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ops);
 
 const struct clk_ops clk_mux_ro_ops = {
-	.get_parent = clk_mux_get_parent,
+	.get_parent = _clk_mux_get_parent,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
@@ -117,7 +136,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		u8 clk_mux_flags, unsigned int *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk_hw *hw;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index f711be6..4cd6728 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -470,7 +470,7 @@ struct clk_hw *clk_hw_register_divider_table(struct device *dev,
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
-	u32		*table;
+	unsigned int	*table;
 	u32		mask;
 	u8		shift;
 	u8		flags;
@@ -488,6 +488,11 @@ struct clk_mux {
 extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
 
+unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
+				unsigned int *table, unsigned long flags);
+unsigned int clk_mux_reindex(u8 index, unsigned int *table,
+			     unsigned long flags);
+
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
@@ -508,7 +513,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		u8 clk_mux_flags, unsigned int *table, spinlock_t *lock);
 
 void clk_unregister_mux(struct clk *clk);
 void clk_hw_unregister_mux(struct clk_hw *hw);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
