Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CC1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8DE24B30
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8DE24B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeGCLfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:35:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13034 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeGCLfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:35:42 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3b5f690000>; Tue, 03 Jul 2018 04:35:05 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 03 Jul 2018 04:35:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 03 Jul 2018 04:35:40 -0700
Received: from dhcp-10-21-25-168.Nvidia.com (10.21.25.201) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1347.2; Tue, 3 Jul 2018 11:35:38 +0000
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 2/3] clk: tegra: Add sdmmc mux divider clock
Date:   Tue, 3 Jul 2018 14:35:20 +0300
Message-ID: <1530617721-5767-2-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530617721-5767-1-git-send-email-avienamo@nvidia.com>
References: <1530617721-5767-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter De-Schrijver <pdeschrijver@nvidia.com>

Add a clock type to model the sdmmc switch divider clocks which have paths
to source clocks bypassing the divider (Low Jitter paths). These
are handled by selecting the lj path when the divider is 1 (ie the
rate is the parent rate), otherwise the normal path with divider
will be selected. Otherwise this clock behaves as a normal peripheral
clock.

Signed-off-by: Peter De-Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/clk/tegra/Makefile        |   1 +
 drivers/clk/tegra/clk-sdmmc-mux.c | 254 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/tegra/clk.h           |  27 ++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/clk/tegra/clk-sdmmc-mux.c

diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
index 6d4f563..916f65b 100644
--- a/drivers/clk/tegra/Makefile
+++ b/drivers/clk/tegra/Makefile
@@ -8,6 +8,7 @@ obj-y					+= clk-periph-fixed.o
 obj-y					+= clk-periph-gate.o
 obj-y					+= clk-pll.o
 obj-y					+= clk-pll-out.o
+obj-y					+= clk-sdmmc-mux.o
 obj-y					+= clk-super.o
 obj-y					+= clk-tegra-audio.o
 obj-y					+= clk-tegra-periph.o
diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
new file mode 100644
index 0000000..8e19cb3
--- /dev/null
+++ b/drivers/clk/tegra/clk-sdmmc-mux.c
@@ -0,0 +1,254 @@
+/*
+ * Copyright (c) 2018 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * based on clk-mux.c
+
+ * Copyright (C) 2011 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ * Copyright (C) 2011 Richard Zhao, Linaro <richard.zhao@linaro.org>
+ * Copyright (C) 2011-2012 Mike Turquette, Linaro Ltd <mturquette@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+#define DIV_MASK GENMASK(7, 0)
+#define MUX_SHIFT 29
+#define MUX_MASK GENMASK(MUX_SHIFT + 2, MUX_SHIFT)
+
+#define get_max_div(d) DIV_MASK
+#define get_div_field(val) ((val) & DIV_MASK)
+#define get_mux_field(val) (((val) & MUX_MASK) >> MUX_SHIFT)
+
+static const char * const mux_sdmmc_parents[] = { "pll_p", "pll_c4_out2",
+						  "pll_c4_out0", "pll_c4_out1",
+						   "clk_m" };
+static u8 mux_lj_idx[] = { [0] = 0, [1] = 1, [2] = 2, [3] = 5, [4] = 6 };
+static u8 mux_non_lj_idx[] = { [0] = 0, [1] = 3, [2] = 7, [3] = 4, [4] = 6 };
+
+static u8 clk_sdmmc_mux_get_parent(struct clk_hw *hw)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	int num_parents, i;
+	u32 src, val;
+	u8 *mux_idx;
+
+	num_parents = clk_hw_get_num_parents(hw);
+
+	val = readl_relaxed(sdmmc_mux->reg);
+	src = get_mux_field(val);
+	if (get_div_field(val))
+		mux_idx = mux_non_lj_idx;
+	else
+		mux_idx = mux_lj_idx;
+
+	for (i = 0; i < num_parents; i++) {
+		if (mux_idx[i] == src)
+			return i;
+	}
+
+	WARN(1, "Unknown parent selector %d\n", src);
+
+	return 0;
+}
+
+static int clk_sdmmc_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	u32 val;
+
+
+	val = readl_relaxed(sdmmc_mux->reg);
+	if (get_div_field(val))
+		index = mux_non_lj_idx[index];
+	else
+		index = mux_lj_idx[index];
+
+	val &= ~MUX_MASK;
+	val |= index << MUX_SHIFT;
+
+	writel(val, sdmmc_mux->reg);
+
+	return 0;
+}
+
+static unsigned long clk_sdmmc_mux_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	u32 val;
+	int div, mul;
+	u64 rate = parent_rate;
+
+	val = readl_relaxed(sdmmc_mux->reg);
+	div = get_div_field(val);
+
+	mul = 2;
+	div += mul;
+
+	rate *= mul;
+	rate += div - 1;
+	do_div(rate, div);
+
+	return rate;
+}
+
+static int clk_sdmmc_mux_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	int div, mul;
+	unsigned long output_rate = req->best_parent_rate;
+
+	req->rate = max(req->rate, req->min_rate);
+	req->rate = min(req->rate, req->max_rate);
+
+	if (!req->rate)
+		return output_rate;
+
+	div = div71_get(req->rate, output_rate, 8, 1, sdmmc_mux->div_flags);
+	if (div < 0)
+		div = 0;
+
+	mul = 2;
+	if (sdmmc_mux->div_flags & TEGRA_DIVIDER_ROUND_UP)
+		req->rate =  DIV_ROUND_UP(output_rate * mul, div + mul);
+	else
+		req->rate =  output_rate * mul / (div + mul);
+
+	return 0;
+}
+
+static int clk_sdmmc_mux_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	int div;
+	unsigned long flags = 0;
+	u32 val;
+	u8 src;
+
+	div = div71_get(rate, parent_rate, 8, 1, sdmmc_mux->div_flags);
+	if (div < 0)
+		return div;
+
+	if (sdmmc_mux->lock)
+		spin_lock_irqsave(sdmmc_mux->lock, flags);
+
+	src = clk_sdmmc_mux_get_parent(hw);
+	if (div)
+		src = mux_non_lj_idx[src];
+	else
+		src = mux_lj_idx[src];
+
+	val = src << MUX_SHIFT;
+	val |= div;
+	writel(val, sdmmc_mux->reg);
+	fence_udelay(2, sdmmc_mux->reg);
+
+	if (sdmmc_mux->lock)
+		spin_unlock_irqrestore(sdmmc_mux->lock, flags);
+
+	return 0;
+}
+
+static int clk_sdmmc_mux_is_enabled(struct clk_hw *hw)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
+	struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
+
+	__clk_hw_set_clk(gate_hw, hw);
+
+	return gate_ops->is_enabled(gate_hw);
+}
+
+static int clk_sdmmc_mux_enable(struct clk_hw *hw)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
+	struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
+
+	__clk_hw_set_clk(gate_hw, hw);
+
+	return  gate_ops->enable(gate_hw);
+}
+
+static void clk_sdmmc_mux_disable(struct clk_hw *hw)
+{
+	struct tegra_sdmmc_mux *sdmmc_mux = to_clk_sdmmc_mux(hw);
+	const struct clk_ops *gate_ops = sdmmc_mux->gate_ops;
+	struct clk_hw *gate_hw = &sdmmc_mux->gate.hw;
+
+	gate_ops->disable(gate_hw);
+}
+
+const struct clk_ops tegra_clk_sdmmc_mux_ops = {
+	.get_parent = clk_sdmmc_mux_get_parent,
+	.set_parent = clk_sdmmc_mux_set_parent,
+	.determine_rate = clk_sdmmc_mux_determine_rate,
+	.recalc_rate = clk_sdmmc_mux_recalc_rate,
+	.set_rate = clk_sdmmc_mux_set_rate,
+	.is_enabled = clk_sdmmc_mux_is_enabled,
+	.enable = clk_sdmmc_mux_enable,
+	.disable = clk_sdmmc_mux_disable,
+};
+
+struct clk *tegra_clk_register_sdmmc_mux_div(const char *name,
+	void __iomem *clk_base, u32 offset, u32 clk_num, u8 div_flags,
+	unsigned long flags, void *lock)
+{
+	struct clk *clk;
+	struct clk_init_data init;
+	const struct tegra_clk_periph_regs *bank;
+	struct tegra_sdmmc_mux *sdmmc_mux;
+
+	init.ops = &tegra_clk_sdmmc_mux_ops;
+	init.name = name;
+	init.flags = flags;
+	init.parent_names = mux_sdmmc_parents;
+	init.num_parents = ARRAY_SIZE(mux_sdmmc_parents);
+
+	bank = get_reg_bank(clk_num);
+	if (!bank)
+		return ERR_PTR(-EINVAL);
+
+	sdmmc_mux = kzalloc(sizeof(*sdmmc_mux), GFP_KERNEL);
+	if (!sdmmc_mux)
+		return ERR_PTR(-ENOMEM);
+
+	/* Data in .init is copied by clk_register(), so stack variable OK */
+	sdmmc_mux->hw.init = &init;
+	sdmmc_mux->reg = clk_base + offset;
+	sdmmc_mux->lock = lock;
+	sdmmc_mux->gate.clk_base = clk_base;
+	sdmmc_mux->gate.regs = bank;
+	sdmmc_mux->gate.enable_refcnt = periph_clk_enb_refcnt;
+	sdmmc_mux->gate.clk_num = clk_num;
+	sdmmc_mux->gate.flags = TEGRA_PERIPH_ON_APB;
+	sdmmc_mux->div_flags = div_flags;
+	sdmmc_mux->gate_ops = &tegra_clk_periph_gate_ops;
+
+	clk = clk_register(NULL, &sdmmc_mux->hw);
+	if (IS_ERR(clk))
+		return clk;
+
+	sdmmc_mux->gate.hw.clk = clk;
+
+	return clk;
+}
+
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index f14e136..4c3d0f5 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -19,6 +19,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/delay.h>
 
 /**
  * struct tegra_clk_sync_source - external clock source from codec
@@ -705,6 +706,32 @@ struct clk *tegra_clk_register_super_clk(const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
 		spinlock_t *lock);
+
+/**
+ * struct tegra_sdmmc_mux - switch divider with Low Jitter inputs for SDMMC
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @reg:	register controlling mux and divider
+ * @flags:	hardware-specific flags
+ * @lock:	optional register lock
+ * @gate:	gate clock
+ * @gate_ops:	gate clock ops
+ */
+struct tegra_sdmmc_mux {
+	struct clk_hw		hw;
+	void __iomem		*reg;
+	spinlock_t		*lock;
+	const struct clk_ops	*gate_ops;
+	struct tegra_clk_periph_gate	gate;
+	u8			div_flags;
+};
+
+#define to_clk_sdmmc_mux(_hw) container_of(_hw, struct tegra_sdmmc_mux, hw)
+
+struct clk *tegra_clk_register_sdmmc_mux_div(const char *name,
+		void __iomem *clk_base, u32 offset, u32 clk_num, u8 div_flags,
+		unsigned long flags, void *lock);
+
 /**
  * struct clk_init_table - clock initialization table
  * @clk_id:	clock id as mentioned in device tree bindings
-- 
2.7.4

