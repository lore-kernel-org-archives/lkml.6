Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B3A9DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC720891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAC720891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965493AbeFOCRW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:17:22 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:33012 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965373AbeFOCRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:17:16 -0400
Received: from zhangqing?rock-chips.com (unknown [192.168.167.205])
        by regular1.263xmail.com (Postfix) with ESMTP id 42EC386;
        Fri, 15 Jun 2018 10:17:11 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id C92D33C4;
        Fri, 15 Jun 2018 10:17:05 +0800 (CST)
X-RL-SENDER: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: zhangqing@rock-chips.com
X-UNIQUE-TAG: <5e24ef4d9db5c1488521981343f35c29>
X-ATTACHMENT-NUM: 0
X-SENDER: zhangqing@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 16162NWD6YG;
        Fri, 15 Jun 2018 10:17:09 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v3 3/4] clk: rockchip: add support for half divider
Date:   Fri, 15 Jun 2018 10:16:50 +0800
Message-Id: <1529029011-15021-4-git-send-email-zhangqing@rock-chips.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
References: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Rockchip socs have optional half divider:
The formula is shown as:
	freq_out = 2*freq_in / (2*div + 3)
Is this the same for all of new SoCs.

So we use "branch_half_divider" + "COMPOSITE_NOMUX_HALFDIV \
DIV_HALF \ COMPOSITE_HALFDIV \ CMPOSITE_NOGATE_HALFDIV"
to hook that special divider clock-type into our clock-tree.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/Makefile           |   1 +
 drivers/clk/rockchip/clk-half-divider.c | 230 ++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c              |  10 ++
 drivers/clk/rockchip/clk.h              |  85 ++++++++++++
 4 files changed, 326 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-half-divider.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 59b8d320960a..2b380fafd232 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -7,6 +7,7 @@ obj-y	+= clk-rockchip.o
 obj-y	+= clk.o
 obj-y	+= clk-pll.o
 obj-y	+= clk-cpu.o
+obj-y	+= clk-half-divider.o
 obj-y	+= clk-inverter.o
 obj-y	+= clk-mmc-phase.o
 obj-y	+= clk-muxgrf.o
diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
new file mode 100644
index 000000000000..fb7a6501e0c1
--- /dev/null
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
+ */
+
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include "clk.h"
+
+#define div_mask(width)	((1 << (width)) - 1)
+
+static bool _is_best_half_div(unsigned long rate, unsigned long now,
+			      unsigned long best, unsigned long flags)
+{
+	if (flags & CLK_DIVIDER_ROUND_CLOSEST)
+		return abs(rate - now) < abs(rate - best);
+
+	return now <= rate && now > best;
+}
+
+static unsigned long clk_half_divider_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int val;
+
+	val = clk_readl(divider->reg) >> divider->shift;
+	val &= div_mask(divider->width);
+	val = val * 2 + 3;
+
+	return DIV_ROUND_UP_ULL(((u64)parent_rate * 2), val);
+}
+
+static int clk_half_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *best_parent_rate, u8 width,
+				    unsigned long flags)
+{
+	unsigned int i, bestdiv = 0;
+	unsigned long parent_rate, best = 0, now, maxdiv;
+	unsigned long parent_rate_saved = *best_parent_rate;
+
+	if (!rate)
+		rate = 1;
+
+	maxdiv = div_mask(width);
+
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		parent_rate = *best_parent_rate;
+		bestdiv = DIV_ROUND_UP_ULL(((u64)parent_rate * 2), rate);
+		if (bestdiv < 3)
+			bestdiv = 0;
+		else
+			bestdiv = (bestdiv - 3) / 2;
+		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
+		return bestdiv;
+	}
+
+	/*
+	 * The maximum divider we can use without overflowing
+	 * unsigned long in rate * i below
+	 */
+	maxdiv = min(ULONG_MAX / rate, maxdiv);
+
+	for (i = 0; i <= maxdiv; i++) {
+		if (((u64)rate * (i * 2 + 3)) == ((u64)parent_rate_saved * 2)) {
+			/*
+			 * It's the most ideal case if the requested rate can be
+			 * divided from parent clock without needing to change
+			 * parent rate, so return the divider immediately.
+			 */
+			*best_parent_rate = parent_rate_saved;
+			return i;
+		}
+		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+						((u64)rate * (i * 2 + 3)) / 2);
+		now = DIV_ROUND_UP_ULL(((u64)parent_rate * 2),
+				       (i * 2 + 3));
+
+		if (_is_best_half_div(rate, now, best, flags)) {
+			bestdiv = i;
+			best = now;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	if (!bestdiv) {
+		bestdiv = div_mask(width);
+		*best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), 1);
+	}
+
+	return bestdiv;
+}
+
+static long clk_half_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *prate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	int div;
+
+	div = clk_half_divider_bestdiv(hw, rate, prate,
+				       divider->width,
+				       divider->flags);
+
+	return DIV_ROUND_UP_ULL(((u64)*prate * 2), div * 2 + 3);
+}
+
+static int clk_half_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned int value;
+	unsigned long flags = 0;
+	u32 val;
+
+	value = DIV_ROUND_UP_ULL(((u64)parent_rate * 2), rate);
+	value = (value - 3) / 2;
+	value =  min_t(unsigned int, value, div_mask(divider->width));
+
+	if (divider->lock)
+		spin_lock_irqsave(divider->lock, flags);
+	else
+		__acquire(divider->lock);
+
+	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
+		val = div_mask(divider->width) << (divider->shift + 16);
+	} else {
+		val = clk_readl(divider->reg);
+		val &= ~(div_mask(divider->width) << divider->shift);
+	}
+	val |= value << divider->shift;
+	clk_writel(val, divider->reg);
+
+	if (divider->lock)
+		spin_unlock_irqrestore(divider->lock, flags);
+	else
+		__release(divider->lock);
+
+	return 0;
+}
+
+const struct clk_ops clk_half_divider_ops = {
+	.recalc_rate = clk_half_divider_recalc_rate,
+	.round_rate = clk_half_divider_round_rate,
+	.set_rate = clk_half_divider_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_half_divider_ops);
+
+/**
+ * Register a clock branch.
+ * Most clock branches have a form like
+ *
+ * src1 --|--\
+ *        |M |--[GATE]-[DIV]-
+ * src2 --|--/
+ *
+ * sometimes without one of those components.
+ */
+struct clk *rockchip_clk_register_halfdiv(const char *name,
+					  const char *const *parent_names,
+					  u8 num_parents, void __iomem *base,
+					  int muxdiv_offset, u8 mux_shift,
+					  u8 mux_width, u8 mux_flags,
+					  u8 div_shift, u8 div_width,
+					  u8 div_flags, int gate_offset,
+					  u8 gate_shift, u8 gate_flags,
+					  unsigned long flags,
+					  spinlock_t *lock)
+{
+	struct clk *clk;
+	struct clk_mux *mux = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_divider *div = NULL;
+	const struct clk_ops *mux_ops = NULL, *div_ops = NULL,
+			     *gate_ops = NULL;
+
+	if (num_parents > 1) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+
+		mux->reg = base + muxdiv_offset;
+		mux->shift = mux_shift;
+		mux->mask = BIT(mux_width) - 1;
+		mux->flags = mux_flags;
+		mux->lock = lock;
+		mux_ops = (mux_flags & CLK_MUX_READ_ONLY) ? &clk_mux_ro_ops
+							: &clk_mux_ops;
+	}
+
+	if (gate_offset >= 0) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			goto err_gate;
+
+		gate->flags = gate_flags;
+		gate->reg = base + gate_offset;
+		gate->bit_idx = gate_shift;
+		gate->lock = lock;
+		gate_ops = &clk_gate_ops;
+	}
+
+	if (div_width > 0) {
+		div = kzalloc(sizeof(*div), GFP_KERNEL);
+		if (!div)
+			goto err_div;
+
+		div->flags = div_flags;
+		div->reg = base + muxdiv_offset;
+		div->shift = div_shift;
+		div->width = div_width;
+		div->lock = lock;
+		div_ops = &clk_half_divider_ops;
+	}
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+				     mux ? &mux->hw : NULL, mux_ops,
+				     div ? &div->hw : NULL, div_ops,
+				     gate ? &gate->hw : NULL, gate_ops,
+				     flags);
+
+	return clk;
+err_div:
+	kfree(gate);
+err_gate:
+	kfree(mux);
+	return ERR_PTR(-ENOMEM);
+}
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 3cd8ad59e0b7..cd1474c05c91 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -498,6 +498,16 @@ void __init rockchip_clk_register_branches(
 				list->gate_flags, flags, list->child,
 				&ctx->lock);
 			break;
+		case branch_half_divider:
+			clk = rockchip_clk_register_halfdiv(list->name,
+				list->parent_names, list->num_parents,
+				ctx->reg_base, list->muxdiv_offset,
+				list->mux_shift, list->mux_width,
+				list->mux_flags, list->div_shift,
+				list->div_width, list->div_flags,
+				list->gate_offset, list->gate_shift,
+				list->gate_flags, flags, &ctx->lock);
+			break;
 		case branch_gate:
 			flags |= CLK_SET_RATE_PARENT;
 
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index ef601dded32c..23c569a875d4 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -354,6 +354,7 @@ enum rockchip_clk_branch_type {
 	branch_inverter,
 	branch_factor,
 	branch_ddrclk,
+	branch_half_divider,
 };
 
 struct rockchip_clk_branch {
@@ -684,6 +685,79 @@ struct rockchip_clk_branch {
 		.gate_flags	= gf,				\
 	}
 
+#define COMPOSITE_HALFDIV(_id, cname, pnames, f, mo, ms, mw, mf, ds, dw,\
+			  df, go, gs, gf)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_half_divider,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
+#define COMPOSITE_NOGATE_HALFDIV(_id, cname, pnames, f, mo, ms, mw, mf,	\
+				 ds, dw, df)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_half_divider,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= -1,				\
+	}
+
+#define COMPOSITE_NOMUX_HALFDIV(_id, cname, pname, f, mo, ds, dw, df,	\
+			go, gs, gf)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_half_divider,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
+#define DIV_HALF(_id, cname, pname, f, o, s, w, df)			\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_half_divider,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= o,				\
+		.div_shift	= s,				\
+		.div_width	= w,				\
+		.div_flags	= df,				\
+		.gate_offset	= -1,				\
+	}
+
 struct rockchip_clk_provider *rockchip_clk_init(struct device_node *np,
 			void __iomem *base, unsigned long nr_clks);
 void rockchip_clk_of_add_provider(struct device_node *np,
@@ -708,6 +782,17 @@ void rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
 
 #define ROCKCHIP_SOFTRST_HIWORD_MASK	BIT(0)
 
+struct clk *rockchip_clk_register_halfdiv(const char *name,
+					  const char *const *parent_names,
+					  u8 num_parents, void __iomem *base,
+					  int muxdiv_offset, u8 mux_shift,
+					  u8 mux_width, u8 mux_flags,
+					  u8 div_shift, u8 div_width,
+					  u8 div_flags, int gate_offset,
+					  u8 gate_shift, u8 gate_flags,
+					  unsigned long flags,
+					  spinlock_t *lock);
+
 #ifdef CONFIG_RESET_CONTROLLER
 void rockchip_register_softrst(struct device_node *np,
 			       unsigned int num_regs,
-- 
1.9.1


