Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeCBFwL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:52:11 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35999 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeCBFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:52:07 -0500
X-Google-Smtp-Source: AG47ELtN69PHLCHgtTk0rnRJtiPlUYc9+JWIyh4c08uu689h4gt5JgnT0Zay+pMF634PihuphJKT1w==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 10/11] clk: actions: Add pll clock support
Date: Fri,  2 Mar 2018 11:18:59 +0530
Message-Id: <20180302054900.11275-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
References: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi PLL clock

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Makefile  |   1 +
 drivers/clk/actions/owl-pll.c | 194 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-pll.h |  92 ++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/clk/actions/owl-pll.c
 create mode 100644 drivers/clk/actions/owl-pll.h

diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 53431aef6e9c..31b68eab9309 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -6,3 +6,4 @@ clk-owl-y			+= owl-mux.o
 clk-owl-y			+= owl-divider.o
 clk-owl-y			+= owl-factor.o
 clk-owl-y			+= owl-composite.o
+clk-owl-y			+= owl-pll.o
diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
new file mode 100644
index 000000000000..3560c7324f9c
--- /dev/null
+++ b/drivers/clk/actions/owl-pll.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL pll clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+
+#include "owl-pll.h"
+
+static u32 owl_pll_calculate_mul(struct owl_pll_hw *pll_hw, unsigned long rate)
+{
+	u32 mul;
+
+	mul = DIV_ROUND_CLOSEST(rate, pll_hw->bfreq);
+	if (mul < pll_hw->min_mul)
+		mul = pll_hw->min_mul;
+	else if (mul > pll_hw->max_mul)
+		mul = pll_hw->max_mul;
+
+	return mul &= mul_mask(pll_hw);
+}
+
+static unsigned int _get_table_rate(const struct clk_pll_table *table,
+		unsigned int val)
+{
+	const struct clk_pll_table *clkt;
+
+	for (clkt = table; clkt->rate; clkt++)
+		if (clkt->val == val)
+			return clkt->rate;
+
+	return 0;
+}
+
+static const struct clk_pll_table *_get_pll_table(
+		const struct clk_pll_table *table, unsigned long rate)
+{
+	const struct clk_pll_table *clkt;
+
+	for (clkt = table; clkt->rate; clkt++) {
+		if (clkt->rate == rate) {
+			table = clkt;
+			break;
+		} else if (clkt->rate < rate)
+			table = clkt;
+	}
+
+	return table;
+}
+
+static long owl_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *parent_rate)
+{
+	struct owl_pll *pll = hw_to_owl_pll(hw);
+	struct owl_pll_hw *pll_hw = &pll->pll_hw;
+	const struct clk_pll_table *clkt;
+	u32 mul;
+
+	if (pll_hw->table) {
+		clkt = _get_pll_table(pll_hw->table, rate);
+		return clkt->rate;
+	}
+
+	/* fixed frequency */
+	if (pll_hw->width == 0)
+		return pll_hw->bfreq;
+
+	mul = owl_pll_calculate_mul(pll_hw, rate);
+
+	return pll_hw->bfreq * mul;
+}
+
+static unsigned long owl_pll_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct owl_pll *pll = hw_to_owl_pll(hw);
+	struct owl_pll_hw *pll_hw = &pll->pll_hw;
+	const struct owl_clk_common *common = &pll->common;
+	u32 val;
+
+	if (pll_hw->table) {
+		regmap_read(common->regmap, pll_hw->reg, &val);
+
+		val = val >> pll_hw->shift;
+		val &= mul_mask(pll_hw);
+
+		return _get_table_rate(pll_hw->table, val);
+	}
+
+	/* fixed frequency */
+	if (pll_hw->width == 0)
+		return pll_hw->bfreq;
+
+	regmap_read(common->regmap, pll_hw->reg, &val);
+
+	val = val >> pll_hw->shift;
+	val &= mul_mask(pll_hw);
+
+	return pll_hw->bfreq * val;
+}
+
+static int owl_pll_is_enabled(struct clk_hw *hw)
+{
+	struct owl_pll *pll = hw_to_owl_pll(hw);
+	struct owl_pll_hw *pll_hw = &pll->pll_hw;
+	const struct owl_clk_common *common = &pll->common;
+	u32 reg;
+
+	regmap_read(common->regmap, pll_hw->reg, &reg);
+
+	return !!(reg & BIT(pll_hw->bit_idx));
+}
+
+static void owl_pll_set(const struct owl_clk_common *common,
+		       const struct owl_pll_hw *pll_hw, bool enable)
+{
+	u32 reg;
+
+	regmap_read(common->regmap, pll_hw->reg, &reg);
+
+	if (enable)
+		reg |= BIT(pll_hw->bit_idx);
+	else
+		reg &= ~BIT(pll_hw->bit_idx);
+
+	regmap_write(common->regmap, pll_hw->reg, reg);
+}
+
+static int owl_pll_enable(struct clk_hw *hw)
+{
+	struct owl_pll *pll = hw_to_owl_pll(hw);
+	const struct owl_clk_common *common = &pll->common;
+
+	owl_pll_set(common, &pll->pll_hw, true);
+
+	return 0;
+}
+
+static void owl_pll_disable(struct clk_hw *hw)
+{
+	struct owl_pll *pll = hw_to_owl_pll(hw);
+	const struct owl_clk_common *common = &pll->common;
+
+	owl_pll_set(common, &pll->pll_hw, false);
+}
+
+static int owl_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct owl_pll *pll = hw_to_owl_pll(hw);
+	struct owl_pll_hw *pll_hw = &pll->pll_hw;
+	const struct owl_clk_common *common = &pll->common;
+	const struct clk_pll_table *clkt;
+	u32 val, reg;
+
+	/* fixed frequency */
+	if (pll_hw->width == 0)
+		return 0;
+
+	if (pll_hw->table) {
+		clkt = _get_pll_table(pll_hw->table, rate);
+		val = clkt->val;
+	} else {
+		val = owl_pll_calculate_mul(pll_hw, rate);
+	}
+
+	regmap_read(common->regmap, pll_hw->reg, &reg);
+
+	reg &= ~mul_mask(pll_hw);
+	reg |= val << pll_hw->shift;
+
+	regmap_write(common->regmap, pll_hw->reg, reg);
+
+	udelay(PLL_STABILITY_WAIT_US);
+
+	return 0;
+}
+
+const struct clk_ops owl_pll_ops = {
+	.enable = owl_pll_enable,
+	.disable = owl_pll_disable,
+	.is_enabled = owl_pll_is_enabled,
+	.round_rate = owl_pll_round_rate,
+	.recalc_rate = owl_pll_recalc_rate,
+	.set_rate = owl_pll_set_rate,
+};
diff --git a/drivers/clk/actions/owl-pll.h b/drivers/clk/actions/owl-pll.h
new file mode 100644
index 000000000000..0aae30abd5dc
--- /dev/null
+++ b/drivers/clk/actions/owl-pll.h
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL pll clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_PLL_H_
+#define _OWL_PLL_H_
+
+#include "owl-common.h"
+
+/* last entry should have rate = 0 */
+struct clk_pll_table {
+	unsigned int		val;
+	unsigned long		rate;
+};
+
+struct owl_pll_hw {
+	u32			reg;
+	u32			bfreq;
+	u8			bit_idx;
+	u8			shift;
+	u8			width;
+	u8			min_mul;
+	u8			max_mul;
+	const struct clk_pll_table *table;
+};
+
+struct owl_pll {
+	struct owl_pll_hw	pll_hw;
+	struct owl_clk_common	common;
+};
+
+#define OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,			\
+		   _width, _min_mul, _max_mul, _table)			\
+	{								\
+		.reg		= _reg,					\
+		.bfreq		= _bfreq,				\
+		.bit_idx	= _bit_idx,				\
+		.shift		= _shift,				\
+		.width		= _width,				\
+		.min_mul	= _min_mul,				\
+		.max_mul	= _max_mul,				\
+		.table		= _table,				\
+	}
+
+#define OWL_PLL(_struct, _name, _parent, _reg, _bfreq, _bit_idx,	\
+		_shift, _width, _min_mul, _max_mul, _table, _flags)	\
+	struct owl_pll _struct = {					\
+		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
+				     _width, _min_mul,			\
+				     _max_mul, _table),			\
+		.common = {						\
+			.regmap = NULL,					\
+			.hw.init = CLK_HW_INIT(_name,			\
+					       _parent,			\
+					       &owl_pll_ops,		\
+					       _flags),			\
+		},							\
+	}
+
+#define OWL_PLL_NO_PARENT(_struct, _name, _reg, _bfreq, _bit_idx,	\
+		_shift, _width, _min_mul, _max_mul, _table, _flags)	\
+	struct owl_pll _struct = {					\
+		.pll_hw	= OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,	\
+				     _width, _min_mul,			\
+				     _max_mul, _table),			\
+		.common = {						\
+			.regmap = NULL,					\
+			.hw.init = CLK_HW_INIT_NO_PARENT(_name,		\
+					       &owl_pll_ops,		\
+					       _flags),			\
+		},							\
+	}
+
+#define mul_mask(m)		((1 << ((m)->width)) - 1)
+#define PLL_STABILITY_WAIT_US	(50)
+
+static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
+{
+	struct owl_clk_common *common = hw_to_owl_clk_common(hw);
+
+	return container_of(common, struct owl_pll, common);
+}
+
+extern const struct clk_ops owl_pll_ops;
+
+#endif /* _OWL_PLL_H_ */
-- 
2.14.1
