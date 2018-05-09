Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935381AbeEIR3X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:29:23 -0400
Received: from vern.gendns.com ([206.190.152.46]:52085 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965835AbeEIR1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:15 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v10 23/27] ARM: davinci: remove legacy clocks
Date: Wed,  9 May 2018 12:26:02 -0500
Message-Id: <20180509172606.29387-24-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the unused legacy clock code from arch/arm/mach-davinci/.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v10 changes:
- none

v9 changes:
- none

v8 changes:
- none

v7 changes:
- rebased
- add davinci prefix to commit message

v6 changes:
- rebased


 arch/arm/mach-davinci/clock.c               | 745 --------------------
 arch/arm/mach-davinci/clock.h               |  72 --
 arch/arm/mach-davinci/common.c              |   2 -
 arch/arm/mach-davinci/devices.c             |   1 -
 arch/arm/mach-davinci/include/mach/clock.h  |   3 -
 arch/arm/mach-davinci/include/mach/common.h |   2 -
 arch/arm/mach-davinci/psc.c                 | 137 ----
 arch/arm/mach-davinci/psc.h                 |  10 -
 arch/arm/mach-davinci/time.c                |   2 -
 9 files changed, 974 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/clock.c
 delete mode 100644 arch/arm/mach-davinci/psc.c

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
deleted file mode 100644
index f77a4f766050..000000000000
--- a/arch/arm/mach-davinci/clock.c
+++ /dev/null
@@ -1,745 +0,0 @@
-/*
- * Clock and PLL control for DaVinci devices
- *
- * Copyright (C) 2006-2007 Texas Instruments.
- * Copyright (C) 2008-2009 Deep Root Systems, LLC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/mutex.h>
-#include <linux/io.h>
-#include <linux/delay.h>
-
-#include <mach/hardware.h>
-
-#include <mach/clock.h>
-#include "psc.h"
-#include <mach/cputype.h>
-#include "clock.h"
-
-static LIST_HEAD(clocks);
-static DEFINE_MUTEX(clocks_mutex);
-static DEFINE_SPINLOCK(clockfw_lock);
-
-void davinci_clk_enable(struct clk *clk)
-{
-	if (clk->parent)
-		davinci_clk_enable(clk->parent);
-	if (clk->usecount++ == 0) {
-		if (clk->flags & CLK_PSC)
-			davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
-					   true, clk->flags);
-		else if (clk->clk_enable)
-			clk->clk_enable(clk);
-	}
-}
-
-void davinci_clk_disable(struct clk *clk)
-{
-	if (WARN_ON(clk->usecount == 0))
-		return;
-	if (--clk->usecount == 0) {
-		if (!(clk->flags & CLK_PLL) && (clk->flags & CLK_PSC))
-			davinci_psc_config(clk->domain, clk->gpsc, clk->lpsc,
-					   false, clk->flags);
-		else if (clk->clk_disable)
-			clk->clk_disable(clk);
-	}
-	if (clk->parent)
-		davinci_clk_disable(clk->parent);
-}
-
-int davinci_clk_reset(struct clk *clk, bool reset)
-{
-	unsigned long flags;
-
-	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (clk->flags & CLK_PSC)
-		davinci_psc_reset(clk->gpsc, clk->lpsc, reset);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(davinci_clk_reset);
-
-int davinci_clk_reset_assert(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk) || !clk->reset)
-		return -EINVAL;
-
-	return clk->reset(clk, true);
-}
-EXPORT_SYMBOL(davinci_clk_reset_assert);
-
-int davinci_clk_reset_deassert(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk) || !clk->reset)
-		return -EINVAL;
-
-	return clk->reset(clk, false);
-}
-EXPORT_SYMBOL(davinci_clk_reset_deassert);
-
-int clk_enable(struct clk *clk)
-{
-	unsigned long flags;
-
-	if (!clk)
-		return 0;
-	else if (IS_ERR(clk))
-		return -EINVAL;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	davinci_clk_enable(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
-
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	davinci_clk_disable(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return 0;
-
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return 0;
-
-	if (clk->round_rate)
-		return clk->round_rate(clk, rate);
-
-	return clk->rate;
-}
-EXPORT_SYMBOL(clk_round_rate);
-
-/* Propagate rate to children */
-static void propagate_rate(struct clk *root)
-{
-	struct clk *clk;
-
-	list_for_each_entry(clk, &root->children, childnode) {
-		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
-		propagate_rate(clk);
-	}
-}
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (!clk)
-		return 0;
-	else if (IS_ERR(clk))
-		return -EINVAL;
-
-	if (clk->set_rate)
-		ret = clk->set_rate(clk, rate);
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (ret == 0) {
-		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
-		propagate_rate(clk);
-	}
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
-
-int clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	unsigned long flags;
-
-	if (!clk)
-		return 0;
-	else if (IS_ERR(clk))
-		return -EINVAL;
-
-	/* Cannot change parent on enabled clock */
-	if (WARN_ON(clk->usecount))
-		return -EINVAL;
-
-	mutex_lock(&clocks_mutex);
-	if (clk->set_parent) {
-		int ret = clk->set_parent(clk, parent);
-
-		if (ret) {
-			mutex_unlock(&clocks_mutex);
-			return ret;
-		}
-	}
-	clk->parent = parent;
-	list_del_init(&clk->childnode);
-	list_add(&clk->childnode, &clk->parent->children);
-	mutex_unlock(&clocks_mutex);
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (clk->recalc)
-		clk->rate = clk->recalc(clk);
-	propagate_rate(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_set_parent);
-
-struct clk *clk_get_parent(struct clk *clk)
-{
-	if (!clk)
-		return NULL;
-
-	return clk->parent;
-}
-EXPORT_SYMBOL(clk_get_parent);
-
-int clk_register(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return -EINVAL;
-
-	if (WARN(clk->parent && !clk->parent->rate,
-			"CLK: %s parent %s has no rate!\n",
-			clk->name, clk->parent->name))
-		return -EINVAL;
-
-	INIT_LIST_HEAD(&clk->children);
-
-	mutex_lock(&clocks_mutex);
-	list_add_tail(&clk->node, &clocks);
-	if (clk->parent) {
-		if (clk->set_parent) {
-			int ret = clk->set_parent(clk, clk->parent);
-
-			if (ret) {
-				mutex_unlock(&clocks_mutex);
-				return ret;
-			}
-		}
-		list_add_tail(&clk->childnode, &clk->parent->children);
-	}
-	mutex_unlock(&clocks_mutex);
-
-	/* If rate is already set, use it */
-	if (clk->rate)
-		return 0;
-
-	/* Else, see if there is a way to calculate it */
-	if (clk->recalc)
-		clk->rate = clk->recalc(clk);
-
-	/* Otherwise, default to parent rate */
-	else if (clk->parent)
-		clk->rate = clk->parent->rate;
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_register);
-
-void clk_unregister(struct clk *clk)
-{
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	mutex_lock(&clocks_mutex);
-	list_del(&clk->node);
-	list_del(&clk->childnode);
-	mutex_unlock(&clocks_mutex);
-}
-EXPORT_SYMBOL(clk_unregister);
-
-#ifdef CONFIG_DAVINCI_RESET_CLOCKS
-/*
- * Disable any unused clocks left on by the bootloader
- */
-int __init davinci_clk_disable_unused(void)
-{
-	struct clk *ck;
-
-	spin_lock_irq(&clockfw_lock);
-	list_for_each_entry(ck, &clocks, node) {
-		if (ck->usecount > 0)
-			continue;
-		if (!(ck->flags & CLK_PSC))
-			continue;
-
-		/* ignore if in Disabled or SwRstDisable states */
-		if (!davinci_psc_is_clk_active(ck->gpsc, ck->lpsc))
-			continue;
-
-		pr_debug("Clocks: disable unused %s\n", ck->name);
-
-		davinci_psc_config(ck->domain, ck->gpsc, ck->lpsc,
-				false, ck->flags);
-	}
-	spin_unlock_irq(&clockfw_lock);
-
-	return 0;
-}
-#endif
-
-static unsigned long clk_sysclk_recalc(struct clk *clk)
-{
-	u32 v, plldiv;
-	struct pll_data *pll;
-	unsigned long rate = clk->rate;
-
-	/* If this is the PLL base clock, no more calculations needed */
-	if (clk->pll_data)
-		return rate;
-
-	if (WARN_ON(!clk->parent))
-		return rate;
-
-	rate = clk->parent->rate;
-
-	/* Otherwise, the parent must be a PLL */
-	if (WARN_ON(!clk->parent->pll_data))
-		return rate;
-
-	pll = clk->parent->pll_data;
-
-	/* If pre-PLL, source clock is before the multiplier and divider(s) */
-	if (clk->flags & PRE_PLL)
-		rate = pll->input_rate;
-
-	if (!clk->div_reg)
-		return rate;
-
-	v = __raw_readl(pll->base + clk->div_reg);
-	if (v & PLLDIV_EN) {
-		plldiv = (v & pll->div_ratio_mask) + 1;
-		if (plldiv)
-			rate /= plldiv;
-	}
-
-	return rate;
-}
-
-int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned v;
-	struct pll_data *pll;
-	unsigned long input;
-	unsigned ratio = 0;
-
-	/* If this is the PLL base clock, wrong function to call */
-	if (clk->pll_data)
-		return -EINVAL;
-
-	/* There must be a parent... */
-	if (WARN_ON(!clk->parent))
-		return -EINVAL;
-
-	/* ... the parent must be a PLL... */
-	if (WARN_ON(!clk->parent->pll_data))
-		return -EINVAL;
-
-	/* ... and this clock must have a divider. */
-	if (WARN_ON(!clk->div_reg))
-		return -EINVAL;
-
-	pll = clk->parent->pll_data;
-
-	input = clk->parent->rate;
-
-	/* If pre-PLL, source clock is before the multiplier and divider(s) */
-	if (clk->flags & PRE_PLL)
-		input = pll->input_rate;
-
-	if (input > rate) {
-		/*
-		 * Can afford to provide an output little higher than requested
-		 * only if maximum rate supported by hardware on this sysclk
-		 * is known.
-		 */
-		if (clk->maxrate) {
-			ratio = DIV_ROUND_CLOSEST(input, rate);
-			if (input / ratio > clk->maxrate)
-				ratio = 0;
-		}
-
-		if (ratio == 0)
-			ratio = DIV_ROUND_UP(input, rate);
-
-		ratio--;
-	}
-
-	if (ratio > pll->div_ratio_mask)
-		return -EINVAL;
-
-	do {
-		v = __raw_readl(pll->base + PLLSTAT);
-	} while (v & PLLSTAT_GOSTAT);
-
-	v = __raw_readl(pll->base + clk->div_reg);
-	v &= ~pll->div_ratio_mask;
-	v |= ratio | PLLDIV_EN;
-	__raw_writel(v, pll->base + clk->div_reg);
-
-	v = __raw_readl(pll->base + PLLCMD);
-	v |= PLLCMD_GOSET;
-	__raw_writel(v, pll->base + PLLCMD);
-
-	do {
-		v = __raw_readl(pll->base + PLLSTAT);
-	} while (v & PLLSTAT_GOSTAT);
-
-	return 0;
-}
-EXPORT_SYMBOL(davinci_set_sysclk_rate);
-
-static unsigned long clk_leafclk_recalc(struct clk *clk)
-{
-	if (WARN_ON(!clk->parent))
-		return clk->rate;
-
-	return clk->parent->rate;
-}
-
-int davinci_simple_set_rate(struct clk *clk, unsigned long rate)
-{
-	clk->rate = rate;
-	return 0;
-}
-
-static unsigned long clk_pllclk_recalc(struct clk *clk)
-{
-	u32 ctrl, mult = 1, prediv = 1, postdiv = 1;
-	u8 bypass;
-	struct pll_data *pll = clk->pll_data;
-	unsigned long rate = clk->rate;
-
-	ctrl = __raw_readl(pll->base + PLLCTL);
-	rate = pll->input_rate = clk->parent->rate;
-
-	if (ctrl & PLLCTL_PLLEN) {
-		bypass = 0;
-		mult = __raw_readl(pll->base + PLLM);
-		if (cpu_is_davinci_dm365())
-			mult = 2 * (mult & PLLM_PLLM_MASK);
-		else
-			mult = (mult & PLLM_PLLM_MASK) + 1;
-	} else
-		bypass = 1;
-
-	if (pll->flags & PLL_HAS_PREDIV) {
-		prediv = __raw_readl(pll->base + PREDIV);
-		if (prediv & PLLDIV_EN)
-			prediv = (prediv & pll->div_ratio_mask) + 1;
-		else
-			prediv = 1;
-	}
-
-	/* pre-divider is fixed, but (some?) chips won't report that */
-	if (cpu_is_davinci_dm355() && pll->num == 1)
-		prediv = 8;
-
-	if (pll->flags & PLL_HAS_POSTDIV) {
-		postdiv = __raw_readl(pll->base + POSTDIV);
-		if (postdiv & PLLDIV_EN)
-			postdiv = (postdiv & pll->div_ratio_mask) + 1;
-		else
-			postdiv = 1;
-	}
-
-	if (!bypass) {
-		rate /= prediv;
-		rate *= mult;
-		rate /= postdiv;
-	}
-
-	pr_debug("PLL%d: input = %lu MHz [ ",
-		 pll->num, clk->parent->rate / 1000000);
-	if (bypass)
-		pr_debug("bypass ");
-	if (prediv > 1)
-		pr_debug("/ %d ", prediv);
-	if (mult > 1)
-		pr_debug("* %d ", mult);
-	if (postdiv > 1)
-		pr_debug("/ %d ", postdiv);
-	pr_debug("] --> %lu MHz output.\n", rate / 1000000);
-
-	return rate;
-}
-
-/**
- * davinci_set_pllrate - set the output rate of a given PLL.
- *
- * Note: Currently tested to work with OMAP-L138 only.
- *
- * @pll: pll whose rate needs to be changed.
- * @prediv: The pre divider value. Passing 0 disables the pre-divider.
- * @pllm: The multiplier value. Passing 0 leads to multiply-by-one.
- * @postdiv: The post divider value. Passing 0 disables the post-divider.
- */
-int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
-					unsigned int mult, unsigned int postdiv)
-{
-	u32 ctrl;
-	unsigned int locktime;
-	unsigned long flags;
-
-	if (pll->base == NULL)
-		return -EINVAL;
-
-	/*
-	 *  PLL lock time required per OMAP-L138 datasheet is
-	 * (2000 * prediv)/sqrt(pllm) OSCIN cycles. We approximate sqrt(pllm)
-	 * as 4 and OSCIN cycle as 25 MHz.
-	 */
-	if (prediv) {
-		locktime = ((2000 * prediv) / 100);
-		prediv = (prediv - 1) | PLLDIV_EN;
-	} else {
-		locktime = PLL_LOCK_TIME;
-	}
-	if (postdiv)
-		postdiv = (postdiv - 1) | PLLDIV_EN;
-	if (mult)
-		mult = mult - 1;
-
-	/* Protect against simultaneous calls to PLL setting seqeunce */
-	spin_lock_irqsave(&clockfw_lock, flags);
-
-	ctrl = __raw_readl(pll->base + PLLCTL);
-
-	/* Switch the PLL to bypass mode */
-	ctrl &= ~(PLLCTL_PLLENSRC | PLLCTL_PLLEN);
-	__raw_writel(ctrl, pll->base + PLLCTL);
-
-	udelay(PLL_BYPASS_TIME);
-
-	/* Reset and enable PLL */
-	ctrl &= ~(PLLCTL_PLLRST | PLLCTL_PLLDIS);
-	__raw_writel(ctrl, pll->base + PLLCTL);
-
-	if (pll->flags & PLL_HAS_PREDIV)
-		__raw_writel(prediv, pll->base + PREDIV);
-
-	__raw_writel(mult, pll->base + PLLM);
-
-	if (pll->flags & PLL_HAS_POSTDIV)
-		__raw_writel(postdiv, pll->base + POSTDIV);
-
-	udelay(PLL_RESET_TIME);
-
-	/* Bring PLL out of reset */
-	ctrl |= PLLCTL_PLLRST;
-	__raw_writel(ctrl, pll->base + PLLCTL);
-
-	udelay(locktime);
-
-	/* Remove PLL from bypass mode */
-	ctrl |= PLLCTL_PLLEN;
-	__raw_writel(ctrl, pll->base + PLLCTL);
-
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(davinci_set_pllrate);
-
-/**
- * davinci_set_refclk_rate() - Set the reference clock rate
- * @rate:	The new rate.
- *
- * Sets the reference clock rate to a given value. This will most likely
- * result in the entire clock tree getting updated.
- *
- * This is used to support boards which use a reference clock different
- * than that used by default in <soc>.c file. The reference clock rate
- * should be updated early in the boot process; ideally soon after the
- * clock tree has been initialized once with the default reference clock
- * rate (davinci_clk_init()).
- *
- * Returns 0 on success, error otherwise.
- */
-int davinci_set_refclk_rate(unsigned long rate)
-{
-	struct clk *refclk;
-
-	refclk = clk_get(NULL, "ref");
-	if (IS_ERR(refclk)) {
-		pr_err("%s: failed to get reference clock\n", __func__);
-		return PTR_ERR(refclk);
-	}
-
-	clk_set_rate(refclk, rate);
-
-	clk_put(refclk);
-
-	return 0;
-}
-
-int __init davinci_clk_init(struct clk_lookup *clocks)
-{
-	struct clk_lookup *c;
-	struct clk *clk;
-	size_t num_clocks = 0;
-
-	for (c = clocks; c->clk; c++) {
-		clk = c->clk;
-
-		if (!clk->recalc) {
-
-			/* Check if clock is a PLL */
-			if (clk->pll_data)
-				clk->recalc = clk_pllclk_recalc;
-
-			/* Else, if it is a PLL-derived clock */
-			else if (clk->flags & CLK_PLL)
-				clk->recalc = clk_sysclk_recalc;
-
-			/* Otherwise, it is a leaf clock (PSC clock) */
-			else if (clk->parent)
-				clk->recalc = clk_leafclk_recalc;
-		}
-
-		if (clk->pll_data) {
-			struct pll_data *pll = clk->pll_data;
-
-			if (!pll->div_ratio_mask)
-				pll->div_ratio_mask = PLLDIV_RATIO_MASK;
-
-			if (pll->phys_base && !pll->base) {
-				pll->base = ioremap(pll->phys_base, SZ_4K);
-				WARN_ON(!pll->base);
-			}
-		}
-
-		if (clk->recalc)
-			clk->rate = clk->recalc(clk);
-
-		if (clk->lpsc)
-			clk->flags |= CLK_PSC;
-
-		if (clk->flags & PSC_LRST)
-			clk->reset = davinci_clk_reset;
-
-		clk_register(clk);
-		num_clocks++;
-
-		/* Turn on clocks that Linux doesn't otherwise manage */
-		if (clk->flags & ALWAYS_ENABLED)
-			clk_enable(clk);
-	}
-
-	clkdev_add_table(clocks, num_clocks);
-
-	return 0;
-}
-
-#ifdef CONFIG_DEBUG_FS
-
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
-
-#define CLKNAME_MAX	10		/* longest clock name */
-#define NEST_DELTA	2
-#define NEST_MAX	4
-
-static void
-dump_clock(struct seq_file *s, unsigned nest, struct clk *parent)
-{
-	char		*state;
-	char		buf[CLKNAME_MAX + NEST_DELTA * NEST_MAX];
-	struct clk	*clk;
-	unsigned	i;
-
-	if (parent->flags & CLK_PLL)
-		state = "pll";
-	else if (parent->flags & CLK_PSC)
-		state = "psc";
-	else
-		state = "";
-
-	/* <nest spaces> name <pad to end> */
-	memset(buf, ' ', sizeof(buf) - 1);
-	buf[sizeof(buf) - 1] = 0;
-	i = strlen(parent->name);
-	memcpy(buf + nest, parent->name,
-			min(i, (unsigned)(sizeof(buf) - 1 - nest)));
-
-	seq_printf(s, "%s users=%2d %-3s %9ld Hz\n",
-		   buf, parent->usecount, state, clk_get_rate(parent));
-	/* REVISIT show device associations too */
-
-	/* cost is now small, but not linear... */
-	list_for_each_entry(clk, &parent->children, childnode) {
-		dump_clock(s, nest + NEST_DELTA, clk);
-	}
-}
-
-static int davinci_ck_show(struct seq_file *m, void *v)
-{
-	struct clk *clk;
-
-	/*
-	 * Show clock tree; We trust nonzero usecounts equate to PSC enables...
-	 */
-	mutex_lock(&clocks_mutex);
-	list_for_each_entry(clk, &clocks, node)
-		if (!clk->parent)
-			dump_clock(m, 0, clk);
-	mutex_unlock(&clocks_mutex);
-
-	return 0;
-}
-
-static int davinci_ck_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, davinci_ck_show, NULL);
-}
-
-static const struct file_operations davinci_ck_operations = {
-	.open		= davinci_ck_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int __init davinci_clk_debugfs_init(void)
-{
-	debugfs_create_file("davinci_clocks", S_IFREG | S_IRUGO, NULL, NULL,
-						&davinci_ck_operations);
-	return 0;
-
-}
-device_initcall(davinci_clk_debugfs_init);
-#endif /* CONFIG_DEBUG_FS */
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 2d058568e004..307383472400 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -61,76 +61,4 @@
  */
 #define PLL_LOCK_TIME		20
 
-#ifndef __ASSEMBLER__
-
-#include <linux/list.h>
-#include <linux/clkdev.h>
-
-#define PLLSTAT_GOSTAT	BIT(0)
-#define PLLCMD_GOSET	BIT(0)
-
-struct pll_data {
-	u32 phys_base;
-	void __iomem *base;
-	u32 num;
-	u32 flags;
-	u32 input_rate;
-	u32 div_ratio_mask;
-};
-#define PLL_HAS_PREDIV          0x01
-#define PLL_HAS_POSTDIV         0x02
-
-struct clk {
-	struct list_head	node;
-	struct module		*owner;
-	const char		*name;
-	unsigned long		rate;
-	unsigned long		maxrate;	/* H/W supported max rate */
-	u8			usecount;
-	u8			lpsc;
-	u8			gpsc;
-	u8			domain;
-	u32			flags;
-	struct clk              *parent;
-	struct list_head	children; 	/* list of children */
-	struct list_head	childnode;	/* parent's child list node */
-	struct pll_data         *pll_data;
-	u32                     div_reg;
-	unsigned long (*recalc) (struct clk *);
-	int (*set_rate) (struct clk *clk, unsigned long rate);
-	int (*round_rate) (struct clk *clk, unsigned long rate);
-	int (*reset) (struct clk *clk, bool reset);
-	void (*clk_enable) (struct clk *clk);
-	void (*clk_disable) (struct clk *clk);
-	int (*set_parent) (struct clk *clk, struct clk *parent);
-};
-
-/* Clock flags: SoC-specific flags start at BIT(16) */
-#define ALWAYS_ENABLED		BIT(1)
-#define CLK_PSC			BIT(2)
-#define CLK_PLL			BIT(3) /* PLL-derived clock */
-#define PRE_PLL			BIT(4) /* source is before PLL mult/div */
-#define PSC_SWRSTDISABLE	BIT(5) /* Disable state is SwRstDisable */
-#define PSC_FORCE		BIT(6) /* Force module state transtition */
-#define PSC_LRST		BIT(8) /* Use local reset on enable/disable */
-
-#define CLK(dev, con, ck) 	\
-	{			\
-		.dev_id = dev,	\
-		.con_id = con,	\
-		.clk = ck,	\
-	}			\
-
-int davinci_clk_init(struct clk_lookup *clocks);
-int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
-				unsigned int mult, unsigned int postdiv);
-int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
-int davinci_set_refclk_rate(unsigned long rate);
-int davinci_simple_set_rate(struct clk *clk, unsigned long rate);
-int davinci_clk_reset(struct clk *clk, bool reset);
-void davinci_clk_enable(struct clk *clk);
-void davinci_clk_disable(struct clk *clk);
-
-#endif
-
 #endif
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index e03f95ccd95c..e1d0f0d841ff 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -20,8 +20,6 @@
 #include <mach/common.h>
 #include <mach/cputype.h>
 
-#include "clock.h"
-
 struct davinci_soc_info davinci_soc_info;
 EXPORT_SYMBOL(davinci_soc_info);
 
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 0edda4093e47..e8dbbb7479ab 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -26,7 +26,6 @@
 
 
 #include "davinci.h"
-#include "clock.h"
 
 #define DAVINCI_I2C_BASE	     0x01C21000
 #define DAVINCI_ATA_BASE	     0x01C66000
diff --git a/arch/arm/mach-davinci/include/mach/clock.h b/arch/arm/mach-davinci/include/mach/clock.h
index 3e8af6a0b64c..42ed4f2f5ce4 100644
--- a/arch/arm/mach-davinci/include/mach/clock.h
+++ b/arch/arm/mach-davinci/include/mach/clock.h
@@ -15,9 +15,6 @@
 
 struct clk;
 
-extern int clk_register(struct clk *clk);
-extern void clk_unregister(struct clk *clk);
-
 int davinci_clk_reset_assert(struct clk *c);
 int davinci_clk_reset_deassert(struct clk *c);
 
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index ded8f5f42725..b577e13a9c23 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -54,8 +54,6 @@ struct davinci_soc_info {
 	u32				jtag_id_reg;
 	struct davinci_id		*ids;
 	unsigned long			ids_num;
-	u32				*psc_bases;
-	unsigned long			psc_bases_num;
 	u32				pinmux_base;
 	const struct mux_config		*pinmux_pins;
 	unsigned long			pinmux_pins_num;
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
deleted file mode 100644
index e5dc6bfde5f3..000000000000
--- a/arch/arm/mach-davinci/psc.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * TI DaVinci Power and Sleep Controller (PSC)
- *
- * Copyright (C) 2006 Texas Instruments.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include <mach/cputype.h>
-#include "psc.h"
-
-#include "clock.h"
-
-/* Return nonzero iff the domain's clock is active */
-int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
-{
-	void __iomem *psc_base;
-	u32 mdstat;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
-
-	if (!soc_info->psc_bases || (ctlr >= soc_info->psc_bases_num)) {
-		pr_warn("PSC: Bad psc data: 0x%x[%d]\n",
-				(int)soc_info->psc_bases, ctlr);
-		return 0;
-	}
-
-	psc_base = ioremap(soc_info->psc_bases[ctlr], SZ_4K);
-	mdstat = __raw_readl(psc_base + MDSTAT + 4 * id);
-	iounmap(psc_base);
-
-	/* if clocked, state can be "Enable" or "SyncReset" */
-	return mdstat & BIT(12);
-}
-
-/* Control "reset" line associated with PSC domain */
-void davinci_psc_reset(unsigned int ctlr, unsigned int id, bool reset)
-{
-	u32 mdctl;
-	void __iomem *psc_base;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
-
-	if (!soc_info->psc_bases || (ctlr >= soc_info->psc_bases_num)) {
-		pr_warn("PSC: Bad psc data: 0x%x[%d]\n",
-				(int)soc_info->psc_bases, ctlr);
-		return;
-	}
-
-	psc_base = ioremap(soc_info->psc_bases[ctlr], SZ_4K);
-
-	mdctl = readl(psc_base + MDCTL + 4 * id);
-	if (reset)
-		mdctl &= ~MDCTL_LRST;
-	else
-		mdctl |= MDCTL_LRST;
-	writel(mdctl, psc_base + MDCTL + 4 * id);
-
-	iounmap(psc_base);
-}
-
-/* Enable or disable a PSC domain */
-void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, bool enable, u32 flags)
-{
-	u32 epcpr, ptcmd, ptstat, pdstat, pdctl, mdstat, mdctl;
-	void __iomem *psc_base;
-	struct davinci_soc_info *soc_info = &davinci_soc_info;
-	u32 next_state = PSC_STATE_ENABLE;
-
-	if (!soc_info->psc_bases || (ctlr >= soc_info->psc_bases_num)) {
-		pr_warn("PSC: Bad psc data: 0x%x[%d]\n",
-				(int)soc_info->psc_bases, ctlr);
-		return;
-	}
-
-	psc_base = ioremap(soc_info->psc_bases[ctlr], SZ_4K);
-
-	if (!enable) {
-		if (flags & PSC_SWRSTDISABLE)
-			next_state = PSC_STATE_SWRSTDISABLE;
-		else
-			next_state = PSC_STATE_DISABLE;
-	}
-
-	mdctl = __raw_readl(psc_base + MDCTL + 4 * id);
-	mdctl &= ~MDSTAT_STATE_MASK;
-	mdctl |= next_state;
-	if (flags & PSC_FORCE)
-		mdctl |= MDCTL_FORCE;
-	__raw_writel(mdctl, psc_base + MDCTL + 4 * id);
-
-	pdstat = __raw_readl(psc_base + PDSTAT + 4 * domain);
-	if ((pdstat & PDSTAT_STATE_MASK) == 0) {
-		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
-		pdctl |= PDCTL_NEXT;
-		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
-
-		ptcmd = 1 << domain;
-		__raw_writel(ptcmd, psc_base + PTCMD);
-
-		do {
-			epcpr = __raw_readl(psc_base + EPCPR);
-		} while ((((epcpr >> domain) & 1) == 0));
-
-		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
-		pdctl |= PDCTL_EPCGOOD;
-		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
-	} else {
-		ptcmd = 1 << domain;
-		__raw_writel(ptcmd, psc_base + PTCMD);
-	}
-
-	do {
-		ptstat = __raw_readl(psc_base + PTSTAT);
-	} while (!(((ptstat >> domain) & 1) == 0));
-
-	do {
-		mdstat = __raw_readl(psc_base + MDSTAT + 4 * id);
-	} while (!((mdstat & MDSTAT_STATE_MASK) == next_state));
-
-	iounmap(psc_base);
-}
diff --git a/arch/arm/mach-davinci/psc.h b/arch/arm/mach-davinci/psc.h
index b58707cf7033..68cd9d3fc82b 100644
--- a/arch/arm/mach-davinci/psc.h
+++ b/arch/arm/mach-davinci/psc.h
@@ -204,14 +204,4 @@
 #define PDCTL_NEXT		BIT(0)
 #define PDCTL_EPCGOOD		BIT(8)
 
-#ifndef __ASSEMBLER__
-
-extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id);
-extern void davinci_psc_reset(unsigned int ctlr, unsigned int id,
-		bool reset);
-extern void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, bool enable, u32 flags);
-
-#endif
-
 #endif /* __ASM_ARCH_PSC_H */
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 486896f309c5..7ea3db0ff062 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -27,8 +27,6 @@
 #include <mach/hardware.h>
 #include <mach/time.h>
 
-#include "clock.h"
-
 static struct clock_event_device clockevent_davinci;
 static unsigned int davinci_clock_tick_rate;
 
-- 
2.17.0
