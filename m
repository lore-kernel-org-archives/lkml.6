Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbeFBFGs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 01:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeFBFGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 01:06:45 -0400
From: sboyd@kernel.org
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] clk: Return void from debug_init op
Date: Fri,  1 Jun 2018 22:06:43 -0700
Message-Id: <20180602050643.87253-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

We only have two users of the debug_init hook, and we recently stopped
caring about the return value from that op. Finish that off by changing
the clk_op to return void instead of int because it doesn't matter if
debugfs fails or not.

Cc: Eric Anholt <eric@anholt.net>
Cc: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/clk.txt         |  2 +-
 drivers/clk/bcm/clk-bcm2835.c | 25 +++++++++++--------------
 drivers/clk/davinci/pll.c     |  8 +++-----
 include/linux/clk-provider.h  |  2 +-
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index 511628bb3d3a..593cca5058b1 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -96,7 +96,7 @@ the operations defined in clk-provider.h::
 		int		(*get_phase)(struct clk_hw *hw);
 		int		(*set_phase)(struct clk_hw *hw, int degrees);
 		void		(*init)(struct clk_hw *hw);
-		int		(*debug_init)(struct clk_hw *hw,
+		void		(*debug_init)(struct clk_hw *hw,
 					      struct dentry *dentry);
 	};
 
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 1329440af59f..0bd62efc07f8 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -394,7 +394,7 @@ static unsigned long bcm2835_measure_tcnt_mux(struct bcm2835_cprman *cprman,
 	return count * 1000;
 }
 
-static int bcm2835_debugfs_regset(struct bcm2835_cprman *cprman, u32 base,
+static void bcm2835_debugfs_regset(struct bcm2835_cprman *cprman, u32 base,
 				  struct debugfs_reg32 *regs, size_t nregs,
 				  struct dentry *dentry)
 {
@@ -402,15 +402,13 @@ static int bcm2835_debugfs_regset(struct bcm2835_cprman *cprman, u32 base,
 
 	regset = devm_kzalloc(cprman->dev, sizeof(*regset), GFP_KERNEL);
 	if (!regset)
-		return -ENOMEM;
+		return;
 
 	regset->regs = regs;
 	regset->nregs = nregs;
 	regset->base = cprman->regs + base;
 
 	debugfs_create_regset32("regdump", S_IRUGO, dentry, regset);
-
-	return 0;
 }
 
 struct bcm2835_pll_data {
@@ -728,7 +726,7 @@ static int bcm2835_pll_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static int bcm2835_pll_debug_init(struct clk_hw *hw,
+static void bcm2835_pll_debug_init(struct clk_hw *hw,
 				  struct dentry *dentry)
 {
 	struct bcm2835_pll *pll = container_of(hw, struct bcm2835_pll, hw);
@@ -738,7 +736,7 @@ static int bcm2835_pll_debug_init(struct clk_hw *hw,
 
 	regs = devm_kzalloc(cprman->dev, 7 * sizeof(*regs), GFP_KERNEL);
 	if (!regs)
-		return -ENOMEM;
+		return;
 
 	regs[0].name = "cm_ctrl";
 	regs[0].offset = data->cm_ctrl_reg;
@@ -755,7 +753,7 @@ static int bcm2835_pll_debug_init(struct clk_hw *hw,
 	regs[6].name = "ana3";
 	regs[6].offset = data->ana_reg_base + 3 * 4;
 
-	return bcm2835_debugfs_regset(cprman, 0, regs, 7, dentry);
+	bcm2835_debugfs_regset(cprman, 0, regs, 7, dentry);
 }
 
 static const struct clk_ops bcm2835_pll_clk_ops = {
@@ -859,8 +857,8 @@ static int bcm2835_pll_divider_set_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static int bcm2835_pll_divider_debug_init(struct clk_hw *hw,
-					  struct dentry *dentry)
+static void bcm2835_pll_divider_debug_init(struct clk_hw *hw,
+					   struct dentry *dentry)
 {
 	struct bcm2835_pll_divider *divider = bcm2835_pll_divider_from_hw(hw);
 	struct bcm2835_cprman *cprman = divider->cprman;
@@ -869,14 +867,14 @@ static int bcm2835_pll_divider_debug_init(struct clk_hw *hw,
 
 	regs = devm_kzalloc(cprman->dev, 7 * sizeof(*regs), GFP_KERNEL);
 	if (!regs)
-		return -ENOMEM;
+		return;
 
 	regs[0].name = "cm";
 	regs[0].offset = data->cm_reg;
 	regs[1].name = "a2w";
 	regs[1].offset = data->a2w_reg;
 
-	return bcm2835_debugfs_regset(cprman, 0, regs, 2, dentry);
+	bcm2835_debugfs_regset(cprman, 0, regs, 2, dentry);
 }
 
 static const struct clk_ops bcm2835_pll_divider_clk_ops = {
@@ -1252,15 +1250,14 @@ static struct debugfs_reg32 bcm2835_debugfs_clock_reg32[] = {
 	},
 };
 
-static int bcm2835_clock_debug_init(struct clk_hw *hw,
+static void bcm2835_clock_debug_init(struct clk_hw *hw,
 				    struct dentry *dentry)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 
-	return bcm2835_debugfs_regset(
-		cprman, data->ctl_reg,
+	bcm2835_debugfs_regset(cprman, data->ctl_reg,
 		bcm2835_debugfs_clock_reg32,
 		ARRAY_SIZE(bcm2835_debugfs_clock_reg32),
 		dentry);
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index bb9594703d4a..5a5b853dde8a 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -190,7 +190,7 @@ static int davinci_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 #ifdef CONFIG_DEBUG_FS
-static int davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry);
+static void davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry);
 #else
 #define davinci_pll_debug_init NULL
 #endif
@@ -874,21 +874,19 @@ static const struct debugfs_reg32 davinci_pll_regs[] = {
 	DEBUG_REG(PLLDIV9),
 };
 
-static int davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
+static void davinci_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
 {
 	struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
 	struct debugfs_regset32 *regset;
 
 	regset = kzalloc(sizeof(*regset), GFP_KERNEL);
 	if (!regset)
-		return -ENOMEM;
+		return;
 
 	regset->regs = davinci_pll_regs;
 	regset->nregs = ARRAY_SIZE(davinci_pll_regs);
 	regset->base = pll->base;
 
 	debugfs_create_regset32("registers", 0400, dentry, regset);
-
-	return 0;
 }
 #endif
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 00e55d4d07f1..a4dc15afbdaf 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -218,7 +218,7 @@ struct clk_ops {
 	int		(*get_phase)(struct clk_hw *hw);
 	int		(*set_phase)(struct clk_hw *hw, int degrees);
 	void		(*init)(struct clk_hw *hw);
-	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
+	void		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
 
 /**
-- 
Sent by a computer through tubes
