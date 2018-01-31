Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeAaSKU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:10:20 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54627 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753870AbeAaSKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:10:10 -0500
X-Google-Smtp-Source: AH8x227Y/vWEPkvFxYkcNRuyvaLwSiKLrR1iPnJH5WiJLZwi93ct7ZwA/rV+RSXzAZgpSkbFgnSsjA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] clk: meson: remove obsolete cpu_clk
Date: Wed, 31 Jan 2018 19:09:44 +0100
Message-Id: <20180131180945.18025-19-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

meson8b cpu_clk has been replaced by a set of divider and mux clocks.
meson_cpu_clk is no longer used and can be removed

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile  |   2 +-
 drivers/clk/meson/clk-cpu.c | 178 --------------------------------------------
 drivers/clk/meson/clkc.h    |  11 ---
 3 files changed, 1 insertion(+), 190 deletions(-)
 delete mode 100644 drivers/clk/meson/clk-cpu.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 465086118d62..ffee82e60b7a 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-cpu.o clk-mpll.o clk-audio-divider.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-audio-divider.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o
diff --git a/drivers/clk/meson/clk-cpu.c b/drivers/clk/meson/clk-cpu.c
deleted file mode 100644
index f8b2b7efd016..000000000000
--- a/drivers/clk/meson/clk-cpu.c
+++ /dev/null
@@ -1,178 +0,0 @@
-/*
- * Copyright (c) 2015 Endless Mobile, Inc.
- * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-/*
- * CPU clock path:
- *
- *                           +-[/N]-----|3|
- *             MUX2  +--[/3]-+----------|2| MUX1
- * [sys_pll]---|1|   |--[/2]------------|1|-|1|
- *             | |---+------------------|0| | |----- [a5_clk]
- *          +--|0|                          | |
- * [xtal]---+-------------------------------|0|
- *
- *
- *
- */
-
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/slab.h>
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-
-#define MESON_CPU_CLK_CNTL1		0x00
-#define MESON_CPU_CLK_CNTL		0x40
-
-#define MESON_CPU_CLK_MUX1		BIT(7)
-#define MESON_CPU_CLK_MUX2		BIT(0)
-
-#define MESON_N_WIDTH			9
-#define MESON_N_SHIFT			20
-#define MESON_SEL_WIDTH			2
-#define MESON_SEL_SHIFT			2
-
-#include "clkc.h"
-
-#define to_meson_clk_cpu_hw(_hw) container_of(_hw, struct meson_clk_cpu, hw)
-#define to_meson_clk_cpu_nb(_nb) container_of(_nb, struct meson_clk_cpu, clk_nb)
-
-static long meson_clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
-{
-	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_hw(hw);
-
-	return divider_round_rate(hw, rate, prate, clk_cpu->div_table,
-				  MESON_N_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
-}
-
-static int meson_clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long parent_rate)
-{
-	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_hw(hw);
-	unsigned int div, sel, N = 0;
-	u32 reg;
-
-	div = DIV_ROUND_UP(parent_rate, rate);
-
-	if (div <= 3) {
-		sel = div - 1;
-	} else {
-		sel = 3;
-		N = div / 2;
-	}
-
-	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL1);
-	reg = PARM_SET(MESON_N_WIDTH, MESON_N_SHIFT, reg, N);
-	writel(reg, clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL1);
-
-	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL);
-	reg = PARM_SET(MESON_SEL_WIDTH, MESON_SEL_SHIFT, reg, sel);
-	writel(reg, clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL);
-
-	return 0;
-}
-
-static unsigned long meson_clk_cpu_recalc_rate(struct clk_hw *hw,
-					       unsigned long parent_rate)
-{
-	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_hw(hw);
-	unsigned int N, sel;
-	unsigned int div = 1;
-	u32 reg;
-
-	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL1);
-	N = PARM_GET(MESON_N_WIDTH, MESON_N_SHIFT, reg);
-
-	reg = readl(clk_cpu->base + clk_cpu->reg_off + MESON_CPU_CLK_CNTL);
-	sel = PARM_GET(MESON_SEL_WIDTH, MESON_SEL_SHIFT, reg);
-
-	if (sel < 3)
-		div = sel + 1;
-	else
-		div = 2 * N;
-
-	return parent_rate / div;
-}
-
-/* FIXME MUX1 & MUX2 should be struct clk_hw objects */
-static int meson_clk_cpu_pre_rate_change(struct meson_clk_cpu *clk_cpu,
-					 struct clk_notifier_data *ndata)
-{
-	u32 cpu_clk_cntl;
-
-	/* switch MUX1 to xtal */
-	cpu_clk_cntl = readl(clk_cpu->base + clk_cpu->reg_off
-				+ MESON_CPU_CLK_CNTL);
-	cpu_clk_cntl &= ~MESON_CPU_CLK_MUX1;
-	writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
-				+ MESON_CPU_CLK_CNTL);
-	udelay(100);
-
-	/* switch MUX2 to sys-pll */
-	cpu_clk_cntl |= MESON_CPU_CLK_MUX2;
-	writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
-				+ MESON_CPU_CLK_CNTL);
-
-	return 0;
-}
-
-/* FIXME MUX1 & MUX2 should be struct clk_hw objects */
-static int meson_clk_cpu_post_rate_change(struct meson_clk_cpu *clk_cpu,
-					  struct clk_notifier_data *ndata)
-{
-	u32 cpu_clk_cntl;
-
-	/* switch MUX1 to divisors' output */
-	cpu_clk_cntl = readl(clk_cpu->base + clk_cpu->reg_off
-				+ MESON_CPU_CLK_CNTL);
-	cpu_clk_cntl |= MESON_CPU_CLK_MUX1;
-	writel(cpu_clk_cntl, clk_cpu->base + clk_cpu->reg_off
-				+ MESON_CPU_CLK_CNTL);
-	udelay(100);
-
-	return 0;
-}
-
-/*
- * This clock notifier is called when the frequency of the of the parent
- * PLL clock is to be changed. We use the xtal input as temporary parent
- * while the PLL frequency is stabilized.
- */
-int meson_clk_cpu_notifier_cb(struct notifier_block *nb,
-				     unsigned long event, void *data)
-{
-	struct clk_notifier_data *ndata = data;
-	struct meson_clk_cpu *clk_cpu = to_meson_clk_cpu_nb(nb);
-	int ret = 0;
-
-	if (event == PRE_RATE_CHANGE)
-		ret = meson_clk_cpu_pre_rate_change(clk_cpu, ndata);
-	else if (event == POST_RATE_CHANGE)
-		ret = meson_clk_cpu_post_rate_change(clk_cpu, ndata);
-
-	return notifier_from_errno(ret);
-}
-
-const struct clk_ops meson_clk_cpu_ops = {
-	.recalc_rate	= meson_clk_cpu_recalc_rate,
-	.round_rate	= meson_clk_cpu_round_rate,
-	.set_rate	= meson_clk_cpu_set_rate,
-};
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index cc1a964cd4d7..8d8fe608cff4 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -101,17 +101,6 @@ struct meson_clk_pll_data {
 
 #define to_meson_clk_pll(_hw) container_of(_hw, struct meson_clk_pll, hw)
 
-struct meson_clk_cpu {
-	struct clk_hw hw;
-	void __iomem *base;
-	u16 reg_off;
-	struct notifier_block clk_nb;
-	const struct clk_div_table *div_table;
-};
-
-int meson_clk_cpu_notifier_cb(struct notifier_block *nb, unsigned long event,
-		void *data);
-
 struct meson_clk_mpll_data {
 	struct parm sdm;
 	struct parm sdm_en;
-- 
2.14.3
