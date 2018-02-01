Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeBARnS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:43:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeBARnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:43:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4ED866037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date: Thu, 1 Feb 2018 09:43:07 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v5 00/10] clk: implement clock rate protection mechanism
Message-ID: <20180201174307.GC23162@codeaurora.org>
References: <20171201215200.23523-1-jbrunet@baylibre.com>
 <151373031022.33554.13905466641279532222@resonance>
 <20171222021520.GO7997@codeaurora.org>
 <1517217778.3153.1.camel@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517217778.3153.1.camel@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29, Jerome Brunet wrote:
> On Thu, 2017-12-21 at 18:15 -0800, Stephen Boyd wrote:
> > On 12/19, Michael Turquette wrote:
> > > Quoting Jerome Brunet (2017-12-01 13:51:50)
> > > > This Patchset is related the RFC [0] and the discussion around
> > > > CLK_SET_RATE_GATE available here [1]
> > > > 
> > > > This patchset introduce clock protection to the CCF core. This can then
> > > > be used for:
> > > > 
> > > > * Provide a way for a consumer to claim exclusivity over the rate control
> > > >   of a provider. Some clock consumers require that a clock rate must not
> > > >   deviate from its selected frequency. There can be several reasons for
> > > >   this, not least of which is that some hardware may not be able to
> > > >   handle or recover from a glitch caused by changing the clock rate while
> > > >   the hardware is in operation. For such HW, The ability to get exclusive
> > > >   control of a clock's rate, and release that exclusivity, could be seen
> > > >   as a fundamental clock rate control primitive. The exclusivity is not
> > > >   preemptible, so when claimed more than once, is rate is effectively
> > > >   locked.
> > > > 
> > > > * Provide a similar functionality to providers themselves, fixing
> > > >   CLK_SET_RATE_GATE flag (enforce clock gating along the tree). While
> > > >   there might still be a few platforms relying the broken implementation,
> > > >   tests done has shown this change to be pretty safe.
> > > 
> > > Applied to clk-protect-rate, with the exception that I did not apply
> > > "clk: fix CLK_SET_RATE_GATE with clock rate protection" as it breaks
> > > qcom clk code.
> > > 
> > > Stephen, do you plan to fix up the qcom clock code so that the
> > > SET_RATE_GATE improvement can go in?
> > > 
> > 
> > I started working on it a while back. Let's see if I can finish
> > it off this weekend.
> > 
> 
> Hi Stephen,
> 
> Have you been able find something to fix the qcom code regarding this issue ?
> 

This is what I have. I'm unhappy with a few things. First, I made
a spinlock for each clk, which is overkill. Most likely, just a
single spinlock is needed per clk-controller device. Second, I
haven't finished off the branch/gate part, so gating/ungating of
branches needs to be locked as well to prevent branches from
turning on while rates change. And finally, the 'branches' list is
duplicating a bunch of information about the child clks of an
RCG, so it feels like we need a core framework API to enable and
disable clks forcibly while remembering what is enabled/disabled
or at least to walk the clk tree and call some function.

The spinlock per clk-controller is duplicating the regmap lock we
already have, so we may want a regmap API to grab the lock, and
then another regmap API to do reads/writes without grabbing the
lock, and then finally release the lock with a regmap unlock API.
This part is mostly an optimization, but it would be nice to have
so that multiple writes could be done in sequence. This way, the
RCG code could do the special locking sequence and the branch
code could do the fire and forget single bit update.

----8<----

 drivers/clk/qcom/clk-rcg.c      | 117 +++++++++++++++++++++++++++++++++++-----
 drivers/clk/qcom/clk-rcg.h      |  20 ++++++-
 drivers/clk/qcom/gcc-ipq806x.c  |  57 +++++++++++---------
 drivers/clk/qcom/gcc-mdm9615.c  |  41 +++++++-------
 drivers/clk/qcom/gcc-msm8660.c  |  72 ++++++++++++-------------
 drivers/clk/qcom/gcc-msm8960.c  |  83 ++++++++++++++--------------
 drivers/clk/qcom/lcc-ipq806x.c  |   6 +--
 drivers/clk/qcom/lcc-mdm9615.c  |   8 +--
 drivers/clk/qcom/lcc-msm8960.c  |   8 +--
 drivers/clk/qcom/mmcc-msm8960.c |  20 +++++++
 10 files changed, 282 insertions(+), 150 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index 67ce7c146a6a..7748187cb21c 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -99,7 +99,7 @@ static u8 clk_dyn_rcg_get_parent(struct clk_hw *hw)
 	return 0;
 }
 
-static int clk_rcg_set_parent(struct clk_hw *hw, u8 index)
+static int clk_rcg_set_parent_nolock(struct clk_hw *hw, u8 index)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
 	u32 ns;
@@ -111,6 +111,50 @@ static int clk_rcg_set_parent(struct clk_hw *hw, u8 index)
 	return 0;
 }
 
+static void clk_rcg_force_off(struct clk_rcg *rcg)
+{
+	struct rcg_branch_map *branch = rcg->branches;
+	const struct rcg_branch_map *end = branch + rcg->num_branches;
+
+	while (branch < end) {
+		regmap_update_bits_check(rcg->clkr.regmap, branch->reg,
+					 branch->mask, 0, &branch->was_enabled);
+		branch++;
+	}
+}
+
+static void clk_rcg_force_on(struct clk_rcg *rcg)
+{
+	struct rcg_branch_map *branch = rcg->branches;
+	const struct rcg_branch_map *end = branch + rcg->num_branches;
+
+	while (branch < end) {
+		if (branch->was_enabled) {
+			regmap_update_bits(rcg->clkr.regmap, branch->reg,
+					   branch->mask, branch->mask);
+			branch->was_enabled = false;
+		}
+		branch++;
+	}
+}
+
+static int clk_rcg_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_rcg *rcg = to_clk_rcg(hw);
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&rcg->lock, flags);
+
+	clk_rcg_force_off(rcg);
+	ret = clk_rcg_set_parent_nolock(hw, index);
+	clk_rcg_force_on(rcg);
+
+	spin_unlock_irqrestore(&rcg->lock, flags);
+
+	return ret;
+}
+
 static u32 md_to_m(struct mn *mn, u32 md)
 {
 	md >>= mn->m_val_shift;
@@ -479,7 +523,8 @@ static int clk_rcg_bypass_determine_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static int __clk_rcg_set_rate(struct clk_rcg *rcg, const struct freq_tbl *f)
+static int
+clk_rcg_set_rate_nolock(struct clk_rcg *rcg, const struct freq_tbl *f)
 {
 	u32 ns, md, ctl;
 	struct mn *mn = &rcg->mn;
@@ -521,6 +566,22 @@ static int __clk_rcg_set_rate(struct clk_rcg *rcg, const struct freq_tbl *f)
 	return 0;
 }
 
+static int __clk_rcg_set_rate(struct clk_rcg *rcg, const struct freq_tbl *f)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcg->lock, flags);
+
+	clk_rcg_force_off(rcg);
+	ret = clk_rcg_set_rate_nolock(rcg, f);
+	clk_rcg_force_on(rcg);
+
+	spin_unlock_irqrestore(&rcg->lock, flags);
+
+	return ret;
+}
+
 static int clk_rcg_set_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
 {
@@ -763,7 +824,7 @@ static int clk_rcg_lcc_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	/* Switch to XO to avoid glitches */
 	regmap_update_bits(rcg->clkr.regmap, rcg->ns_reg, gfm, 0);
-	ret = __clk_rcg_set_rate(rcg, f);
+	ret = clk_rcg_set_rate_nolock(rcg, f);
 	/* Switch back to M/N if it's clocking */
 	if (__clk_is_enabled(hw->clk))
 		regmap_update_bits(rcg->clkr.regmap, rcg->ns_reg, gfm, gfm);
@@ -813,9 +874,37 @@ static int clk_dyn_rcg_set_rate_and_parent(struct clk_hw *hw,
 	return __clk_dyn_rcg_set_rate(hw, rate);
 }
 
+/*
+ * These enable/disable functions grab the lock to synchronize with
+ * clk_rcg_set_rate() and clk_rcg_set_parent() disabling all branches and the
+ * rcg itself.
+ */
+static int clk_rcg_enable(struct clk_hw *hw)
+{
+	struct clk_rcg *rcg = to_clk_rcg(hw);
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcg->lock, flags);
+	ret = clk_enable_regmap(hw);
+	spin_unlock_irqrestore(&rcg->lock, flags);
+
+	return ret;
+}
+
+static void clk_rcg_disable(struct clk_hw *hw)
+{
+	struct clk_rcg *rcg = to_clk_rcg(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcg->lock, flags);
+	clk_disable_regmap(hw);
+	spin_unlock_irqrestore(&rcg->lock, flags);
+}
+
 const struct clk_ops clk_rcg_ops = {
-	.enable = clk_enable_regmap,
-	.disable = clk_disable_regmap,
+	.enable = clk_rcg_enable,
+	.disable = clk_rcg_disable,
 	.get_parent = clk_rcg_get_parent,
 	.set_parent = clk_rcg_set_parent,
 	.recalc_rate = clk_rcg_recalc_rate,
@@ -825,8 +914,8 @@ const struct clk_ops clk_rcg_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg_ops);
 
 const struct clk_ops clk_rcg_bypass_ops = {
-	.enable = clk_enable_regmap,
-	.disable = clk_disable_regmap,
+	.enable = clk_rcg_enable,
+	.disable = clk_rcg_disable,
 	.get_parent = clk_rcg_get_parent,
 	.set_parent = clk_rcg_set_parent,
 	.recalc_rate = clk_rcg_recalc_rate,
@@ -836,8 +925,8 @@ const struct clk_ops clk_rcg_bypass_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg_bypass_ops);
 
 const struct clk_ops clk_rcg_bypass2_ops = {
-	.enable = clk_enable_regmap,
-	.disable = clk_disable_regmap,
+	.enable = clk_rcg_enable,
+	.disable = clk_rcg_disable,
 	.get_parent = clk_rcg_get_parent,
 	.set_parent = clk_rcg_set_parent,
 	.recalc_rate = clk_rcg_recalc_rate,
@@ -848,8 +937,8 @@ const struct clk_ops clk_rcg_bypass2_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg_bypass2_ops);
 
 const struct clk_ops clk_rcg_pixel_ops = {
-	.enable = clk_enable_regmap,
-	.disable = clk_disable_regmap,
+	.enable = clk_rcg_enable,
+	.disable = clk_rcg_disable,
 	.get_parent = clk_rcg_get_parent,
 	.set_parent = clk_rcg_set_parent,
 	.recalc_rate = clk_rcg_recalc_rate,
@@ -860,8 +949,8 @@ const struct clk_ops clk_rcg_pixel_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg_pixel_ops);
 
 const struct clk_ops clk_rcg_esc_ops = {
-	.enable = clk_enable_regmap,
-	.disable = clk_disable_regmap,
+	.enable = clk_rcg_enable,
+	.disable = clk_rcg_disable,
 	.get_parent = clk_rcg_get_parent,
 	.set_parent = clk_rcg_set_parent,
 	.recalc_rate = clk_rcg_recalc_rate,
@@ -875,7 +964,7 @@ const struct clk_ops clk_rcg_lcc_ops = {
 	.enable = clk_rcg_lcc_enable,
 	.disable = clk_rcg_lcc_disable,
 	.get_parent = clk_rcg_get_parent,
-	.set_parent = clk_rcg_set_parent,
+	.set_parent = clk_rcg_set_parent_nolock,
 	.recalc_rate = clk_rcg_recalc_rate,
 	.determine_rate = clk_rcg_determine_rate,
 	.set_rate = clk_rcg_lcc_set_rate,
diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index a2495457e564..3d9c502f91f5 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -15,6 +15,7 @@
 #define __QCOM_CLK_RCG_H__
 
 #include <linux/clk-provider.h>
+#include <linux/spinlock.h>
 #include "clk-regmap.h"
 
 struct freq_tbl {
@@ -78,6 +79,18 @@ struct src_sel {
 	const struct parent_map	*parent_map;
 };
 
+/**
+ * struct rcg_branch_map - branches under rcg that need to be force off/on
+ * @reg: Address of branch control
+ * @mask: Enable mask to enable branch
+ * @was_enabled: Indicates if the branch was enabled before forcing off
+ */
+struct rcg_branch_map {
+	u32 reg;
+	u32 mask;
+	bool was_enabled;
+};
+
 /**
  * struct clk_rcg - root clock generator
  *
@@ -88,8 +101,8 @@ struct src_sel {
  * @s: source selector
  * @freq_tbl: frequency table
  * @clkr: regmap clock handle
- * @lock: register lock
- *
+ * @lock: register lock for this RCG and its children to protect set_rate/parent
+ * @branches: list of registers to turn off when changing rate/parent
  */
 struct clk_rcg {
 	u32		ns_reg;
@@ -100,6 +113,9 @@ struct clk_rcg {
 	struct src_sel	s;
 
 	const struct freq_tbl	*freq_tbl;
+	spinlock_t		lock;
+	struct rcg_branch_map	*branches;
+	unsigned int		num_branches;
 
 	struct clk_regmap	clkr;
 };
diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 28eb200d0f1e..644672bc07f6 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -266,6 +266,8 @@ static struct freq_tbl clk_tbl_gsbi_uart[] = {
 	{ }
 };
 
+static struct rcg_branch_map gsbi1_uart_branch = { 0x29d4, BIT(9) };
+
 static struct clk_rcg gsbi1_uart_src = {
 	.ns_reg = 0x29d4,
 	.md_reg = 0x29d0,
@@ -286,6 +288,9 @@ static struct clk_rcg gsbi1_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_uart_src.lock),
+	.branches = &gsbi1_uart_branch,
+	.num_branches = 1,
 	.clkr = {
 		.enable_reg = 0x29d4,
 		.enable_mask = BIT(11),
@@ -294,7 +299,6 @@ static struct clk_rcg gsbi1_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -337,6 +341,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x29f4,
 		.enable_mask = BIT(11),
@@ -345,7 +350,6 @@ static struct clk_rcg gsbi2_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -388,6 +392,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a34,
 		.enable_mask = BIT(11),
@@ -396,7 +401,6 @@ static struct clk_rcg gsbi4_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -439,6 +443,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a54,
 		.enable_mask = BIT(11),
@@ -447,7 +452,6 @@ static struct clk_rcg gsbi5_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -490,6 +494,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi6_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a74,
 		.enable_mask = BIT(11),
@@ -498,7 +503,6 @@ static struct clk_rcg gsbi6_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -541,6 +545,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi7_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a94,
 		.enable_mask = BIT(11),
@@ -549,7 +554,6 @@ static struct clk_rcg gsbi7_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -605,6 +609,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29cc,
 		.enable_mask = BIT(11),
@@ -613,7 +618,6 @@ static struct clk_rcg gsbi1_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -654,6 +658,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29ec,
 		.enable_mask = BIT(11),
@@ -662,7 +667,6 @@ static struct clk_rcg gsbi2_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -703,6 +707,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a2c,
 		.enable_mask = BIT(11),
@@ -711,7 +716,6 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -752,6 +756,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a4c,
 		.enable_mask = BIT(11),
@@ -760,7 +765,6 @@ static struct clk_rcg gsbi5_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -801,6 +805,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi6_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a6c,
 		.enable_mask = BIT(11),
@@ -809,7 +814,6 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -850,6 +854,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi7_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a8c,
 		.enable_mask = BIT(11),
@@ -858,7 +863,6 @@ static struct clk_rcg gsbi7_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1000,6 +1004,7 @@ static struct clk_rcg gp0_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp0_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d24,
 		.enable_mask = BIT(11),
@@ -1008,7 +1013,6 @@ static struct clk_rcg gp0_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	}
 };
@@ -1049,6 +1053,7 @@ static struct clk_rcg gp1_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp1_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d44,
 		.enable_mask = BIT(11),
@@ -1057,7 +1062,6 @@ static struct clk_rcg gp1_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1098,6 +1102,7 @@ static struct clk_rcg gp2_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp2_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d64,
 		.enable_mask = BIT(11),
@@ -1106,7 +1111,6 @@ static struct clk_rcg gp2_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1152,6 +1156,7 @@ static struct clk_rcg prng_src = {
 		.src_sel_shift = 0,
 		.parent_map = gcc_pxo_pll8_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&prng_src.lock),
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
@@ -1212,6 +1217,7 @@ static struct clk_rcg sdc1_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc1_src.lock),
 	.clkr = {
 		.enable_reg = 0x282c,
 		.enable_mask = BIT(11),
@@ -1220,7 +1226,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1261,6 +1266,7 @@ static struct clk_rcg sdc3_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc3_src.lock),
 	.clkr = {
 		.enable_reg = 0x286c,
 		.enable_mask = BIT(11),
@@ -1269,7 +1275,6 @@ static struct clk_rcg sdc3_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1345,6 +1350,7 @@ static struct clk_rcg tsif_ref_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_tsif_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&tsif_ref_src.lock),
 	.clkr = {
 		.enable_reg = 0x2710,
 		.enable_mask = BIT(11),
@@ -1353,7 +1359,6 @@ static struct clk_rcg tsif_ref_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1508,6 +1513,7 @@ static struct clk_rcg pcie_ref_src = {
 		.parent_map = gcc_pxo_pll3_map,
 	},
 	.freq_tbl = clk_tbl_pcie_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&pcie_ref_src.lock),
 	.clkr = {
 		.enable_reg = 0x3860,
 		.enable_mask = BIT(11),
@@ -1516,7 +1522,6 @@ static struct clk_rcg pcie_ref_src = {
 			.parent_names = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -1600,6 +1605,7 @@ static struct clk_rcg pcie1_ref_src = {
 		.parent_map = gcc_pxo_pll3_map,
 	},
 	.freq_tbl = clk_tbl_pcie_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&pcie1_ref_src.lock),
 	.clkr = {
 		.enable_reg = 0x3aa0,
 		.enable_mask = BIT(11),
@@ -1608,7 +1614,6 @@ static struct clk_rcg pcie1_ref_src = {
 			.parent_names = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -1692,6 +1697,7 @@ static struct clk_rcg pcie2_ref_src = {
 		.parent_map = gcc_pxo_pll3_map,
 	},
 	.freq_tbl = clk_tbl_pcie_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&pcie2_ref_src.lock),
 	.clkr = {
 		.enable_reg = 0x3ae0,
 		.enable_mask = BIT(11),
@@ -1700,7 +1706,6 @@ static struct clk_rcg pcie2_ref_src = {
 			.parent_names = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -1789,6 +1794,7 @@ static struct clk_rcg sata_ref_src = {
 		.parent_map = gcc_pxo_pll3_sata_map,
 	},
 	.freq_tbl = clk_tbl_sata_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&sata_ref_src.lock),
 	.clkr = {
 		.enable_reg = 0x2c08,
 		.enable_mask = BIT(7),
@@ -1797,7 +1803,6 @@ static struct clk_rcg sata_ref_src = {
 			.parent_names = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -1926,6 +1931,7 @@ static struct clk_rcg usb30_master_clk_src = {
 		.parent_map = gcc_pxo_pll8_pll0,
 	},
 	.freq_tbl = clk_tbl_usb30_master,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb30_master_clk_src.lock),
 	.clkr = {
 		.enable_reg = 0x3b2c,
 		.enable_mask = BIT(11),
@@ -1934,7 +1940,6 @@ static struct clk_rcg usb30_master_clk_src = {
 			.parent_names = gcc_pxo_pll8_pll0_map,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -1996,6 +2001,7 @@ static struct clk_rcg usb30_utmi_clk = {
 		.parent_map = gcc_pxo_pll8_pll0,
 	},
 	.freq_tbl = clk_tbl_usb30_utmi,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb30_utmi_clk.lock),
 	.clkr = {
 		.enable_reg = 0x3b44,
 		.enable_mask = BIT(11),
@@ -2004,7 +2010,6 @@ static struct clk_rcg usb30_utmi_clk = {
 			.parent_names = gcc_pxo_pll8_pll0_map,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -2066,6 +2071,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 		.parent_map = gcc_pxo_pll8_pll0,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hs1_xcvr_clk_src.lock),
 	.clkr = {
 		.enable_reg = 0x2968,
 		.enable_mask = BIT(11),
@@ -2074,7 +2080,6 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 			.parent_names = gcc_pxo_pll8_pll0_map,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -2130,6 +2135,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 		.parent_map = gcc_pxo_pll8_pll0,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_fs1_xcvr_clk_src.lock),
 	.clkr = {
 		.enable_reg = 0x2968,
 		.enable_mask = BIT(11),
@@ -2138,7 +2144,6 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 			.parent_names = gcc_pxo_pll8_pll0_map,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
diff --git a/drivers/clk/qcom/gcc-mdm9615.c b/drivers/clk/qcom/gcc-mdm9615.c
index b99dd406e907..be61d6cfe7e0 100644
--- a/drivers/clk/qcom/gcc-mdm9615.c
+++ b/drivers/clk/qcom/gcc-mdm9615.c
@@ -209,6 +209,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x29d4,
 		.enable_mask = BIT(11),
@@ -217,7 +218,6 @@ static struct clk_rcg gsbi1_uart_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -260,6 +260,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x29f4,
 		.enable_mask = BIT(11),
@@ -268,7 +269,6 @@ static struct clk_rcg gsbi2_uart_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -311,6 +311,7 @@ static struct clk_rcg gsbi3_uart_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi3_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a14,
 		.enable_mask = BIT(11),
@@ -319,7 +320,6 @@ static struct clk_rcg gsbi3_uart_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -362,6 +362,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a34,
 		.enable_mask = BIT(11),
@@ -370,7 +371,6 @@ static struct clk_rcg gsbi4_uart_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -413,6 +413,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a54,
 		.enable_mask = BIT(11),
@@ -421,7 +422,6 @@ static struct clk_rcg gsbi5_uart_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -476,6 +476,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29cc,
 		.enable_mask = BIT(11),
@@ -484,7 +485,6 @@ static struct clk_rcg gsbi1_qup_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -525,6 +525,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29ec,
 		.enable_mask = BIT(11),
@@ -533,7 +534,6 @@ static struct clk_rcg gsbi2_qup_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -574,6 +574,7 @@ static struct clk_rcg gsbi3_qup_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi3_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a0c,
 		.enable_mask = BIT(11),
@@ -582,7 +583,6 @@ static struct clk_rcg gsbi3_qup_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -623,6 +623,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a2c,
 		.enable_mask = BIT(11),
@@ -631,7 +632,6 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -672,6 +672,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a4c,
 		.enable_mask = BIT(11),
@@ -680,7 +681,6 @@ static struct clk_rcg gsbi5_qup_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -727,6 +727,7 @@ static struct clk_rcg gp0_src = {
 		.parent_map = gcc_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp0_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d24,
 		.enable_mask = BIT(11),
@@ -735,7 +736,6 @@ static struct clk_rcg gp0_src = {
 			.parent_names = gcc_cxo,
 			.num_parents = 1,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	}
 };
@@ -776,6 +776,7 @@ static struct clk_rcg gp1_src = {
 		.parent_map = gcc_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp1_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d44,
 		.enable_mask = BIT(11),
@@ -784,7 +785,6 @@ static struct clk_rcg gp1_src = {
 			.parent_names = gcc_cxo,
 			.num_parents = 1,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -825,6 +825,7 @@ static struct clk_rcg gp2_src = {
 		.parent_map = gcc_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp2_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d64,
 		.enable_mask = BIT(11),
@@ -833,7 +834,6 @@ static struct clk_rcg gp2_src = {
 			.parent_names = gcc_cxo,
 			.num_parents = 1,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -879,6 +879,7 @@ static struct clk_rcg prng_src = {
 		.src_sel_shift = 0,
 		.parent_map = gcc_cxo_pll8_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&prng_src.lock),
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
@@ -939,6 +940,7 @@ static struct clk_rcg sdc1_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc1_src.lock),
 	.clkr = {
 		.enable_reg = 0x282c,
 		.enable_mask = BIT(11),
@@ -947,7 +949,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -988,6 +989,7 @@ static struct clk_rcg sdc2_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc2_src.lock),
 	.clkr = {
 		.enable_reg = 0x284c,
 		.enable_mask = BIT(11),
@@ -996,7 +998,6 @@ static struct clk_rcg sdc2_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1042,6 +1043,7 @@ static struct clk_rcg usb_hs1_xcvr_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hs1_xcvr_src.lock),
 	.clkr = {
 		.enable_reg = 0x290c,
 		.enable_mask = BIT(11),
@@ -1050,7 +1052,6 @@ static struct clk_rcg usb_hs1_xcvr_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1091,6 +1092,7 @@ static struct clk_rcg usb_hsic_xcvr_fs_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hsic_xcvr_fs_src.lock),
 	.clkr = {
 		.enable_reg = 0x2928,
 		.enable_mask = BIT(11),
@@ -1099,7 +1101,6 @@ static struct clk_rcg usb_hsic_xcvr_fs_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1146,6 +1147,7 @@ static struct clk_rcg usb_hs1_system_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb_hs1_system,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hs1_system_src.lock),
 	.clkr = {
 		.enable_reg = 0x36a4,
 		.enable_mask = BIT(11),
@@ -1154,7 +1156,6 @@ static struct clk_rcg usb_hs1_system_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1201,6 +1202,7 @@ static struct clk_rcg usb_hsic_system_src = {
 		.parent_map = gcc_cxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb_hsic_system,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hsic_system_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b58,
 		.enable_mask = BIT(11),
@@ -1209,7 +1211,6 @@ static struct clk_rcg usb_hsic_system_src = {
 			.parent_names = gcc_cxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1256,6 +1257,7 @@ static struct clk_rcg usb_hsic_hsic_src = {
 		.parent_map = gcc_cxo_pll14_map,
 	},
 	.freq_tbl = clk_tbl_usb_hsic_hsic,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hsic_hsic_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b50,
 		.enable_mask = BIT(11),
@@ -1264,7 +1266,6 @@ static struct clk_rcg usb_hsic_hsic_src = {
 			.parent_names = gcc_cxo_pll14,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
diff --git a/drivers/clk/qcom/gcc-msm8660.c b/drivers/clk/qcom/gcc-msm8660.c
index c347a0d44bc8..05157636a8da 100644
--- a/drivers/clk/qcom/gcc-msm8660.c
+++ b/drivers/clk/qcom/gcc-msm8660.c
@@ -125,6 +125,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x29d4,
 		.enable_mask = BIT(11),
@@ -133,7 +134,6 @@ static struct clk_rcg gsbi1_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -176,6 +176,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x29f4,
 		.enable_mask = BIT(11),
@@ -184,7 +185,6 @@ static struct clk_rcg gsbi2_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -227,6 +227,7 @@ static struct clk_rcg gsbi3_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi3_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a14,
 		.enable_mask = BIT(11),
@@ -235,7 +236,6 @@ static struct clk_rcg gsbi3_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -278,6 +278,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a34,
 		.enable_mask = BIT(11),
@@ -286,7 +287,6 @@ static struct clk_rcg gsbi4_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -329,6 +329,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a54,
 		.enable_mask = BIT(11),
@@ -337,7 +338,6 @@ static struct clk_rcg gsbi5_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -380,6 +380,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi6_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a74,
 		.enable_mask = BIT(11),
@@ -388,7 +389,6 @@ static struct clk_rcg gsbi6_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -431,6 +431,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi7_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a94,
 		.enable_mask = BIT(11),
@@ -439,7 +440,6 @@ static struct clk_rcg gsbi7_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -482,6 +482,7 @@ static struct clk_rcg gsbi8_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi8_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2ab4,
 		.enable_mask = BIT(11),
@@ -490,7 +491,6 @@ static struct clk_rcg gsbi8_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -531,6 +531,7 @@ static struct clk_rcg gsbi9_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi9_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2ad4,
 		.enable_mask = BIT(11),
@@ -539,7 +540,6 @@ static struct clk_rcg gsbi9_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -580,6 +580,7 @@ static struct clk_rcg gsbi10_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi10_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2af4,
 		.enable_mask = BIT(11),
@@ -588,7 +589,6 @@ static struct clk_rcg gsbi10_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -629,6 +629,7 @@ static struct clk_rcg gsbi11_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi11_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b14,
 		.enable_mask = BIT(11),
@@ -637,7 +638,6 @@ static struct clk_rcg gsbi11_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -678,6 +678,7 @@ static struct clk_rcg gsbi12_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi12_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b34,
 		.enable_mask = BIT(11),
@@ -686,7 +687,6 @@ static struct clk_rcg gsbi12_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -740,6 +740,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29cc,
 		.enable_mask = BIT(11),
@@ -748,7 +749,6 @@ static struct clk_rcg gsbi1_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -789,6 +789,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29ec,
 		.enable_mask = BIT(11),
@@ -797,7 +798,6 @@ static struct clk_rcg gsbi2_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -838,6 +838,7 @@ static struct clk_rcg gsbi3_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi3_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a0c,
 		.enable_mask = BIT(11),
@@ -846,7 +847,6 @@ static struct clk_rcg gsbi3_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -887,6 +887,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a2c,
 		.enable_mask = BIT(11),
@@ -895,7 +896,6 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -936,6 +936,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a4c,
 		.enable_mask = BIT(11),
@@ -944,7 +945,6 @@ static struct clk_rcg gsbi5_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -985,6 +985,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi6_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a6c,
 		.enable_mask = BIT(11),
@@ -993,7 +994,6 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1034,6 +1034,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi7_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a8c,
 		.enable_mask = BIT(11),
@@ -1042,7 +1043,6 @@ static struct clk_rcg gsbi7_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1083,6 +1083,7 @@ static struct clk_rcg gsbi8_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi8_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2aac,
 		.enable_mask = BIT(11),
@@ -1091,7 +1092,6 @@ static struct clk_rcg gsbi8_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1132,6 +1132,7 @@ static struct clk_rcg gsbi9_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi9_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2acc,
 		.enable_mask = BIT(11),
@@ -1140,7 +1141,6 @@ static struct clk_rcg gsbi9_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1181,6 +1181,7 @@ static struct clk_rcg gsbi10_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi10_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2aec,
 		.enable_mask = BIT(11),
@@ -1189,7 +1190,6 @@ static struct clk_rcg gsbi10_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1230,6 +1230,7 @@ static struct clk_rcg gsbi11_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi11_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b0c,
 		.enable_mask = BIT(11),
@@ -1238,7 +1239,6 @@ static struct clk_rcg gsbi11_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1279,6 +1279,7 @@ static struct clk_rcg gsbi12_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi12_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b2c,
 		.enable_mask = BIT(11),
@@ -1287,7 +1288,6 @@ static struct clk_rcg gsbi12_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1341,6 +1341,7 @@ static struct clk_rcg gp0_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp0_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d24,
 		.enable_mask = BIT(11),
@@ -1349,7 +1350,6 @@ static struct clk_rcg gp0_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	}
 };
@@ -1390,6 +1390,7 @@ static struct clk_rcg gp1_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp1_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d44,
 		.enable_mask = BIT(11),
@@ -1398,7 +1399,6 @@ static struct clk_rcg gp1_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1439,6 +1439,7 @@ static struct clk_rcg gp2_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp2_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d64,
 		.enable_mask = BIT(11),
@@ -1447,7 +1448,6 @@ static struct clk_rcg gp2_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1550,6 +1550,7 @@ static struct clk_rcg sdc1_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc1_src.lock),
 	.clkr = {
 		.enable_reg = 0x282c,
 		.enable_mask = BIT(11),
@@ -1558,7 +1559,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1599,6 +1599,7 @@ static struct clk_rcg sdc2_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc2_src.lock),
 	.clkr = {
 		.enable_reg = 0x284c,
 		.enable_mask = BIT(11),
@@ -1607,7 +1608,6 @@ static struct clk_rcg sdc2_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1648,6 +1648,7 @@ static struct clk_rcg sdc3_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc3_src.lock),
 	.clkr = {
 		.enable_reg = 0x286c,
 		.enable_mask = BIT(11),
@@ -1656,7 +1657,6 @@ static struct clk_rcg sdc3_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1697,6 +1697,7 @@ static struct clk_rcg sdc4_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc4_src.lock),
 	.clkr = {
 		.enable_reg = 0x288c,
 		.enable_mask = BIT(11),
@@ -1705,7 +1706,6 @@ static struct clk_rcg sdc4_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1746,6 +1746,7 @@ static struct clk_rcg sdc5_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc5_src.lock),
 	.clkr = {
 		.enable_reg = 0x28ac,
 		.enable_mask = BIT(11),
@@ -1754,7 +1755,6 @@ static struct clk_rcg sdc5_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1800,6 +1800,7 @@ static struct clk_rcg tsif_ref_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_tsif_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&tsif_ref_src.lock),
 	.clkr = {
 		.enable_reg = 0x2710,
 		.enable_mask = BIT(11),
@@ -1808,7 +1809,6 @@ static struct clk_rcg tsif_ref_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1854,6 +1854,7 @@ static struct clk_rcg usb_hs1_xcvr_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hs1_xcvr_src.lock),
 	.clkr = {
 		.enable_reg = 0x290c,
 		.enable_mask = BIT(11),
@@ -1862,7 +1863,6 @@ static struct clk_rcg usb_hs1_xcvr_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1903,6 +1903,7 @@ static struct clk_rcg usb_fs1_xcvr_fs_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_fs1_xcvr_fs_src.lock),
 	.clkr = {
 		.enable_reg = 0x2968,
 		.enable_mask = BIT(11),
@@ -1911,7 +1912,6 @@ static struct clk_rcg usb_fs1_xcvr_fs_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1970,6 +1970,7 @@ static struct clk_rcg usb_fs2_xcvr_fs_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_fs2_xcvr_fs_src.lock),
 	.clkr = {
 		.enable_reg = 0x2988,
 		.enable_mask = BIT(11),
@@ -1978,7 +1979,6 @@ static struct clk_rcg usb_fs2_xcvr_fs_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index eb551c75fba6..b34e24dae37c 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -192,6 +192,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x29d4,
 		.enable_mask = BIT(11),
@@ -200,7 +201,6 @@ static struct clk_rcg gsbi1_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -243,6 +243,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x29f4,
 		.enable_mask = BIT(11),
@@ -251,7 +252,6 @@ static struct clk_rcg gsbi2_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -294,6 +294,7 @@ static struct clk_rcg gsbi3_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi3_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a14,
 		.enable_mask = BIT(11),
@@ -302,7 +303,6 @@ static struct clk_rcg gsbi3_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -345,6 +345,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a34,
 		.enable_mask = BIT(11),
@@ -353,7 +354,6 @@ static struct clk_rcg gsbi4_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -396,6 +396,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a54,
 		.enable_mask = BIT(11),
@@ -404,7 +405,6 @@ static struct clk_rcg gsbi5_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -447,6 +447,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi6_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a74,
 		.enable_mask = BIT(11),
@@ -455,7 +456,6 @@ static struct clk_rcg gsbi6_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -498,6 +498,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi7_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a94,
 		.enable_mask = BIT(11),
@@ -506,7 +507,6 @@ static struct clk_rcg gsbi7_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -549,6 +549,7 @@ static struct clk_rcg gsbi8_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi8_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2ab4,
 		.enable_mask = BIT(11),
@@ -557,7 +558,6 @@ static struct clk_rcg gsbi8_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -598,6 +598,7 @@ static struct clk_rcg gsbi9_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi9_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2ad4,
 		.enable_mask = BIT(11),
@@ -606,7 +607,6 @@ static struct clk_rcg gsbi9_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -647,6 +647,7 @@ static struct clk_rcg gsbi10_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi10_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2af4,
 		.enable_mask = BIT(11),
@@ -655,7 +656,6 @@ static struct clk_rcg gsbi10_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -696,6 +696,7 @@ static struct clk_rcg gsbi11_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi11_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b14,
 		.enable_mask = BIT(11),
@@ -704,7 +705,6 @@ static struct clk_rcg gsbi11_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -745,6 +745,7 @@ static struct clk_rcg gsbi12_uart_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_uart,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi12_uart_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b34,
 		.enable_mask = BIT(11),
@@ -753,7 +754,6 @@ static struct clk_rcg gsbi12_uart_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -807,6 +807,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi1_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29cc,
 		.enable_mask = BIT(11),
@@ -815,7 +816,6 @@ static struct clk_rcg gsbi1_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -856,6 +856,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi2_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x29ec,
 		.enable_mask = BIT(11),
@@ -864,7 +865,6 @@ static struct clk_rcg gsbi2_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -905,6 +905,7 @@ static struct clk_rcg gsbi3_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi3_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a0c,
 		.enable_mask = BIT(11),
@@ -913,7 +914,6 @@ static struct clk_rcg gsbi3_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -954,6 +954,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi4_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a2c,
 		.enable_mask = BIT(11),
@@ -962,7 +963,6 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1003,6 +1003,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi5_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a4c,
 		.enable_mask = BIT(11),
@@ -1011,7 +1012,6 @@ static struct clk_rcg gsbi5_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1052,6 +1052,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi6_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a6c,
 		.enable_mask = BIT(11),
@@ -1060,7 +1061,6 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1101,6 +1101,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi7_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2a8c,
 		.enable_mask = BIT(11),
@@ -1109,7 +1110,6 @@ static struct clk_rcg gsbi7_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1150,6 +1150,7 @@ static struct clk_rcg gsbi8_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi8_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2aac,
 		.enable_mask = BIT(11),
@@ -1158,7 +1159,6 @@ static struct clk_rcg gsbi8_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1199,6 +1199,7 @@ static struct clk_rcg gsbi9_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi9_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2acc,
 		.enable_mask = BIT(11),
@@ -1207,7 +1208,6 @@ static struct clk_rcg gsbi9_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1248,6 +1248,7 @@ static struct clk_rcg gsbi10_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi10_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2aec,
 		.enable_mask = BIT(11),
@@ -1256,7 +1257,6 @@ static struct clk_rcg gsbi10_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1297,6 +1297,7 @@ static struct clk_rcg gsbi11_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi11_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b0c,
 		.enable_mask = BIT(11),
@@ -1305,7 +1306,6 @@ static struct clk_rcg gsbi11_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1346,6 +1346,7 @@ static struct clk_rcg gsbi12_qup_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_gsbi_qup,
+	.lock = __SPIN_LOCK_UNLOCKED(&gsbi12_qup_src.lock),
 	.clkr = {
 		.enable_reg = 0x2b2c,
 		.enable_mask = BIT(11),
@@ -1354,7 +1355,6 @@ static struct clk_rcg gsbi12_qup_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	},
 };
@@ -1408,6 +1408,7 @@ static struct clk_rcg gp0_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp0_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d24,
 		.enable_mask = BIT(11),
@@ -1416,7 +1417,6 @@ static struct clk_rcg gp0_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
 		},
 	}
 };
@@ -1457,6 +1457,7 @@ static struct clk_rcg gp1_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp1_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d44,
 		.enable_mask = BIT(11),
@@ -1465,7 +1466,6 @@ static struct clk_rcg gp1_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1506,6 +1506,7 @@ static struct clk_rcg gp2_src = {
 		.parent_map = gcc_pxo_pll8_cxo_map,
 	},
 	.freq_tbl = clk_tbl_gp,
+	.lock = __SPIN_LOCK_UNLOCKED(&gp2_src.lock),
 	.clkr = {
 		.enable_reg = 0x2d64,
 		.enable_mask = BIT(11),
@@ -1514,7 +1515,6 @@ static struct clk_rcg gp2_src = {
 			.parent_names = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1560,6 +1560,7 @@ static struct clk_rcg prng_src = {
 		.src_sel_shift = 0,
 		.parent_map = gcc_pxo_pll8_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&prng_src.lock),
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
@@ -1620,6 +1621,7 @@ static struct clk_rcg sdc1_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc1_src.lock),
 	.clkr = {
 		.enable_reg = 0x282c,
 		.enable_mask = BIT(11),
@@ -1628,7 +1630,6 @@ static struct clk_rcg sdc1_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1669,6 +1670,7 @@ static struct clk_rcg sdc2_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc2_src.lock),
 	.clkr = {
 		.enable_reg = 0x284c,
 		.enable_mask = BIT(11),
@@ -1677,7 +1679,6 @@ static struct clk_rcg sdc2_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1718,6 +1719,7 @@ static struct clk_rcg sdc3_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc3_src.lock),
 	.clkr = {
 		.enable_reg = 0x286c,
 		.enable_mask = BIT(11),
@@ -1726,7 +1728,6 @@ static struct clk_rcg sdc3_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1767,6 +1768,7 @@ static struct clk_rcg sdc4_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc4_src.lock),
 	.clkr = {
 		.enable_reg = 0x288c,
 		.enable_mask = BIT(11),
@@ -1775,7 +1777,6 @@ static struct clk_rcg sdc4_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1816,6 +1817,7 @@ static struct clk_rcg sdc5_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_sdc,
+	.lock = __SPIN_LOCK_UNLOCKED(&sdc5_src.lock),
 	.clkr = {
 		.enable_reg = 0x28ac,
 		.enable_mask = BIT(11),
@@ -1824,7 +1826,6 @@ static struct clk_rcg sdc5_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1870,6 +1871,7 @@ static struct clk_rcg tsif_ref_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_tsif_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&tsif_ref_src.lock),
 	.clkr = {
 		.enable_reg = 0x2710,
 		.enable_mask = BIT(11),
@@ -1878,7 +1880,6 @@ static struct clk_rcg tsif_ref_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1924,6 +1925,7 @@ static struct clk_rcg usb_hs1_xcvr_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hs1_xcvr_src.lock),
 	.clkr = {
 		.enable_reg = 0x290c,
 		.enable_mask = BIT(11),
@@ -1932,7 +1934,6 @@ static struct clk_rcg usb_hs1_xcvr_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -1973,6 +1974,7 @@ static struct clk_rcg usb_hs3_xcvr_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hs3_xcvr_src.lock),
 	.clkr = {
 		.enable_reg = 0x370c,
 		.enable_mask = BIT(11),
@@ -1981,7 +1983,6 @@ static struct clk_rcg usb_hs3_xcvr_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -2022,6 +2023,7 @@ static struct clk_rcg usb_hs4_xcvr_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hs4_xcvr_src.lock),
 	.clkr = {
 		.enable_reg = 0x372c,
 		.enable_mask = BIT(11),
@@ -2030,7 +2032,6 @@ static struct clk_rcg usb_hs4_xcvr_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -2071,6 +2072,7 @@ static struct clk_rcg usb_hsic_xcvr_fs_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_hsic_xcvr_fs_src.lock),
 	.clkr = {
 		.enable_reg = 0x2928,
 		.enable_mask = BIT(11),
@@ -2079,7 +2081,6 @@ static struct clk_rcg usb_hsic_xcvr_fs_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -2166,6 +2167,7 @@ static struct clk_rcg usb_fs1_xcvr_fs_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_fs1_xcvr_fs_src.lock),
 	.clkr = {
 		.enable_reg = 0x2968,
 		.enable_mask = BIT(11),
@@ -2174,7 +2176,6 @@ static struct clk_rcg usb_fs1_xcvr_fs_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -2233,6 +2234,7 @@ static struct clk_rcg usb_fs2_xcvr_fs_src = {
 		.parent_map = gcc_pxo_pll8_map,
 	},
 	.freq_tbl = clk_tbl_usb,
+	.lock = __SPIN_LOCK_UNLOCKED(&usb_fs2_xcvr_fs_src.lock),
 	.clkr = {
 		.enable_reg = 0x2988,
 		.enable_mask = BIT(11),
@@ -2241,7 +2243,6 @@ static struct clk_rcg usb_fs2_xcvr_fs_src = {
 			.parent_names = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	}
 };
@@ -2721,6 +2722,7 @@ static struct clk_rcg ce3_src = {
 		.parent_map = gcc_pxo_pll8_pll3_map,
 	},
 	.freq_tbl = clk_tbl_ce3,
+	.lock = __SPIN_LOCK_UNLOCKED(&ce3_src.lock),
 	.clkr = {
 		.enable_reg = 0x36c0,
 		.enable_mask = BIT(7),
@@ -2729,7 +2731,6 @@ static struct clk_rcg ce3_src = {
 			.parent_names = gcc_pxo_pll8_pll3,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -2783,6 +2784,7 @@ static struct clk_rcg sata_clk_src = {
 		.parent_map = gcc_pxo_pll8_pll3_map,
 	},
 	.freq_tbl = clk_tbl_sata_ref,
+	.lock = __SPIN_LOCK_UNLOCKED(&sata_clk_src.lock),
 	.clkr = {
 		.enable_reg = 0x2c08,
 		.enable_mask = BIT(7),
@@ -2791,7 +2793,6 @@ static struct clk_rcg sata_clk_src = {
 			.parent_names = gcc_pxo_pll8_pll3,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 977e98eadbeb..b4f3e9d68f68 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -133,6 +133,7 @@ static struct clk_rcg mi2s_osr_src = {
 		.parent_map = lcc_pxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_aif_mi2s,
+	.lock = __SPIN_LOCK_UNLOCKED(&mi2s_osr_src.lock),
 	.clkr = {
 		.enable_reg = 0x48,
 		.enable_mask = BIT(9),
@@ -141,7 +142,6 @@ static struct clk_rcg mi2s_osr_src = {
 			.parent_names = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -247,6 +247,7 @@ static struct clk_rcg pcm_src = {
 		.parent_map = lcc_pxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_pcm,
+	.lock = __SPIN_LOCK_UNLOCKED(&pcm_src.lock),
 	.clkr = {
 		.enable_reg = 0x54,
 		.enable_mask = BIT(9),
@@ -255,7 +256,6 @@ static struct clk_rcg pcm_src = {
 			.parent_names = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -327,6 +327,7 @@ static struct clk_rcg spdif_src = {
 		.parent_map = lcc_pxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_aif_osr,
+	.lock = __SPIN_LOCK_UNLOCKED(&spdif_src.lock),
 	.clkr = {
 		.enable_reg = 0xcc,
 		.enable_mask = BIT(9),
@@ -335,7 +336,6 @@ static struct clk_rcg spdif_src = {
 			.parent_names = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
diff --git a/drivers/clk/qcom/lcc-mdm9615.c b/drivers/clk/qcom/lcc-mdm9615.c
index 3237ef4c1197..782b9896d792 100644
--- a/drivers/clk/qcom/lcc-mdm9615.c
+++ b/drivers/clk/qcom/lcc-mdm9615.c
@@ -116,6 +116,7 @@ static struct clk_rcg mi2s_osr_src = {
 		.parent_map = lcc_cxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_aif_osr_393,
+	.lock = __SPIN_LOCK_UNLOCKED(&mi2s_osr_src.lock),
 	.clkr = {
 		.enable_reg = 0x48,
 		.enable_mask = BIT(9),
@@ -124,7 +125,6 @@ static struct clk_rcg mi2s_osr_src = {
 			.parent_names = lcc_cxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -222,6 +222,7 @@ static struct clk_rcg prefix##_osr_src = {			\
 		.parent_map = lcc_cxo_pll4_map,			\
 	},							\
 	.freq_tbl = clk_tbl_aif_osr_393,			\
+	.lock = __SPIN_LOCK_UNLOCKED(&prefix.lock),		\
 	.clkr = {						\
 		.enable_reg = _ns,				\
 		.enable_mask = BIT(9),				\
@@ -230,7 +231,6 @@ static struct clk_rcg prefix##_osr_src = {			\
 			.parent_names = lcc_cxo_pll4,		\
 			.num_parents = 2,			\
 			.ops = &clk_rcg_ops,			\
-			.flags = CLK_SET_RATE_GATE,		\
 		},						\
 	},							\
 };								\
@@ -366,6 +366,7 @@ static struct clk_rcg pcm_src = {
 		.parent_map = lcc_cxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_pcm_393,
+	.lock = __SPIN_LOCK_UNLOCKED(&pcm_src.lock),
 	.clkr = {
 		.enable_reg = 0x54,
 		.enable_mask = BIT(9),
@@ -374,7 +375,6 @@ static struct clk_rcg pcm_src = {
 			.parent_names = lcc_cxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -434,6 +434,7 @@ static struct clk_rcg slimbus_src = {
 		.parent_map = lcc_cxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_aif_osr_393,
+	.lock = __SPIN_LOCK_UNLOCKED(&slimbus_src.lock),
 	.clkr = {
 		.enable_reg = 0xcc,
 		.enable_mask = BIT(9),
@@ -442,7 +443,6 @@ static struct clk_rcg slimbus_src = {
 			.parent_names = lcc_cxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
diff --git a/drivers/clk/qcom/lcc-msm8960.c b/drivers/clk/qcom/lcc-msm8960.c
index 4fcf9d1d233c..7cdd2a7b0a31 100644
--- a/drivers/clk/qcom/lcc-msm8960.c
+++ b/drivers/clk/qcom/lcc-msm8960.c
@@ -114,6 +114,7 @@ static struct clk_rcg mi2s_osr_src = {
 		.parent_map = lcc_pxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_aif_osr_393,
+	.lock = __SPIN_LOCK_UNLOCKED(&mi2s_osr_src.lock),
 	.clkr = {
 		.enable_reg = 0x48,
 		.enable_mask = BIT(9),
@@ -122,7 +123,6 @@ static struct clk_rcg mi2s_osr_src = {
 			.parent_names = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -220,6 +220,7 @@ static struct clk_rcg prefix##_osr_src = {			\
 		.parent_map = lcc_pxo_pll4_map,			\
 	},							\
 	.freq_tbl = clk_tbl_aif_osr_393,			\
+	.lock = __SPIN_LOCK_UNLOCKED(&prefix.lock),		\
 	.clkr = {						\
 		.enable_reg = _ns,				\
 		.enable_mask = BIT(9),				\
@@ -228,7 +229,6 @@ static struct clk_rcg prefix##_osr_src = {			\
 			.parent_names = lcc_pxo_pll4,		\
 			.num_parents = 2,			\
 			.ops = &clk_rcg_ops,			\
-			.flags = CLK_SET_RATE_GATE,		\
 		},						\
 	},							\
 };								\
@@ -364,6 +364,7 @@ static struct clk_rcg pcm_src = {
 		.parent_map = lcc_pxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_pcm_393,
+	.lock = __SPIN_LOCK_UNLOCKED(&pcm_src.lock),
 	.clkr = {
 		.enable_reg = 0x54,
 		.enable_mask = BIT(9),
@@ -372,7 +373,6 @@ static struct clk_rcg pcm_src = {
 			.parent_names = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
@@ -432,6 +432,7 @@ static struct clk_rcg slimbus_src = {
 		.parent_map = lcc_pxo_pll4_map,
 	},
 	.freq_tbl = clk_tbl_aif_osr_393,
+	.lock = __SPIN_LOCK_UNLOCKED(&slimbus_src.lock),
 	.clkr = {
 		.enable_reg = 0xcc,
 		.enable_mask = BIT(9),
@@ -440,7 +441,6 @@ static struct clk_rcg slimbus_src = {
 			.parent_names = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-msm8960.c
index 7f21421c87d6..52e5f877f851 100644
--- a/drivers/clk/qcom/mmcc-msm8960.c
+++ b/drivers/clk/qcom/mmcc-msm8960.c
@@ -195,6 +195,7 @@ static struct clk_rcg camclk0_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_cam,
+	.lock = __SPIN_LOCK_UNLOCKED(&camclk0_src.lock),
 	.clkr = {
 		.enable_reg = 0x0140,
 		.enable_mask = BIT(2),
@@ -244,6 +245,7 @@ static struct clk_rcg camclk1_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_cam,
+	.lock = __SPIN_LOCK_UNLOCKED(&camclk1_src.lock),
 	.clkr = {
 		.enable_reg = 0x0154,
 		.enable_mask = BIT(2),
@@ -293,6 +295,7 @@ static struct clk_rcg camclk2_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_cam,
+	.lock = __SPIN_LOCK_UNLOCKED(&camclk2_src.lock),
 	.clkr = {
 		.enable_reg = 0x0220,
 		.enable_mask = BIT(2),
@@ -348,6 +351,7 @@ static struct clk_rcg csi0_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_csi,
+	.lock = __SPIN_LOCK_UNLOCKED(&csi0_src.lock),
 	.clkr = {
 		.enable_reg = 0x0040,
 		.enable_mask = BIT(2),
@@ -412,6 +416,7 @@ static struct clk_rcg csi1_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_csi,
+	.lock = __SPIN_LOCK_UNLOCKED(&csi1_src.lock),
 	.clkr = {
 		.enable_reg = 0x0024,
 		.enable_mask = BIT(2),
@@ -476,6 +481,7 @@ static struct clk_rcg csi2_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_csi,
+	.lock = __SPIN_LOCK_UNLOCKED(&csi2_src.lock),
 	.clkr = {
 		.enable_reg = 0x022c,
 		.enable_mask = BIT(2),
@@ -728,6 +734,7 @@ static struct clk_rcg csiphytimer_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_csiphytimer,
+	.lock = __SPIN_LOCK_UNLOCKED(&csiphytimer_src.lock),
 	.clkr = {
 		.enable_reg = 0x0160,
 		.enable_mask = BIT(2),
@@ -1156,6 +1163,7 @@ static struct clk_rcg ijpeg_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_ijpeg,
+	.lock = __SPIN_LOCK_UNLOCKED(&ijpeg_src.lock),
 	.clkr = {
 		.enable_reg = 0x0098,
 		.enable_mask = BIT(2),
@@ -1204,6 +1212,7 @@ static struct clk_rcg jpegd_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_jpegd,
+	.lock = __SPIN_LOCK_UNLOCKED(&jpegd_src.lock),
 	.clkr = {
 		.enable_reg = 0x00a4,
 		.enable_mask = BIT(2),
@@ -1446,6 +1455,7 @@ static struct clk_rcg tv_src = {
 		.parent_map = mmcc_pxo_hdmi_map,
 	},
 	.freq_tbl = clk_tbl_tv,
+	.lock = __SPIN_LOCK_UNLOCKED(&tv_src.lock),
 	.clkr = {
 		.enable_reg = 0x00ec,
 		.enable_mask = BIT(2),
@@ -1668,6 +1678,7 @@ static struct clk_rcg vpe_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_vpe,
+	.lock = __SPIN_LOCK_UNLOCKED(&vpe_src.lock),
 	.clkr = {
 		.enable_reg = 0x0110,
 		.enable_mask = BIT(2),
@@ -1736,6 +1747,7 @@ static struct clk_rcg vfe_src = {
 		.parent_map = mmcc_pxo_pll8_pll2_map,
 	},
 	.freq_tbl = clk_tbl_vfe,
+	.lock = __SPIN_LOCK_UNLOCKED(&vfe_src.lock),
 	.clkr = {
 		.enable_reg = 0x0104,
 		.enable_mask = BIT(2),
@@ -2070,6 +2082,7 @@ static struct clk_rcg dsi1_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi2_dsi1_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi1_src.lock),
 	.clkr = {
 		.enable_reg = 0x004c,
 		.enable_mask = BIT(2),
@@ -2118,6 +2131,7 @@ static struct clk_rcg dsi2_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi2_dsi1_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi1_src.lock),
 	.clkr = {
 		.enable_reg = 0x003c,
 		.enable_mask = BIT(2),
@@ -2157,6 +2171,7 @@ static struct clk_rcg dsi1_byte_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi1_dsi2_byte_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi1_src.lock),
 	.clkr = {
 		.enable_reg = 0x0090,
 		.enable_mask = BIT(2),
@@ -2196,6 +2211,7 @@ static struct clk_rcg dsi2_byte_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi1_dsi2_byte_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi2_byte_src.lock),
 	.clkr = {
 		.enable_reg = 0x0130,
 		.enable_mask = BIT(2),
@@ -2235,6 +2251,7 @@ static struct clk_rcg dsi1_esc_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi1_dsi2_byte_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi1_esc_src.lock),
 	.clkr = {
 		.enable_reg = 0x00cc,
 		.enable_mask = BIT(2),
@@ -2273,6 +2290,7 @@ static struct clk_rcg dsi2_esc_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi1_dsi2_byte_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi2_esc_src.lock),
 	.clkr = {
 		.enable_reg = 0x013c,
 		.enable_mask = BIT(2),
@@ -2320,6 +2338,7 @@ static struct clk_rcg dsi1_pixel_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi2_dsi1_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi1_pixel_src.lock),
 	.clkr = {
 		.enable_reg = 0x0130,
 		.enable_mask = BIT(2),
@@ -2367,6 +2386,7 @@ static struct clk_rcg dsi2_pixel_src = {
 		.src_sel_shift = 0,
 		.parent_map = mmcc_pxo_dsi2_dsi1_map,
 	},
+	.lock = __SPIN_LOCK_UNLOCKED(&dsi2_pixel_src.lock),
 	.clkr = {
 		.enable_reg = 0x0094,
 		.enable_mask = BIT(2),

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
