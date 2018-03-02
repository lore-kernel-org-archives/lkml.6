Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032821AbeCBFvx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:51:53 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46255 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936042AbeCBFvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:51:48 -0500
X-Google-Smtp-Source: AG47ELsMaigeHicFlRGgddtb3V1XF67JkJUd5eTCRR961ueFm01klbASgFHIfw4ZWM78IPNxVAoQIQ==
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
Subject: [PATCH v4 08/11] clk: actions: Add factor clock support
Date: Fri,  2 Mar 2018 11:18:57 +0530
Message-Id: <20180302054900.11275-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
References: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi factor clock together with
helper functions to be used in composite clock.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Makefile     |   1 +
 drivers/clk/actions/owl-factor.c | 222 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-factor.h |  83 +++++++++++++++
 3 files changed, 306 insertions(+)
 create mode 100644 drivers/clk/actions/owl-factor.c
 create mode 100644 drivers/clk/actions/owl-factor.h

diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 5ce75df57e1a..994357fa560b 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -4,3 +4,4 @@ clk-owl-y			+= owl-common.o
 clk-owl-y			+= owl-gate.o
 clk-owl-y			+= owl-mux.o
 clk-owl-y			+= owl-divider.o
+clk-owl-y			+= owl-factor.o
diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
new file mode 100644
index 000000000000..c48a2c8b479e
--- /dev/null
+++ b/drivers/clk/actions/owl-factor.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL factor clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "owl-factor.h"
+
+static unsigned int _get_table_maxval(const struct clk_factor_table *table)
+{
+	unsigned int maxval = 0;
+	const struct clk_factor_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val > maxval)
+			maxval = clkt->val;
+	return maxval;
+}
+
+static int _get_table_div_mul(const struct clk_factor_table *table,
+			unsigned int val, unsigned int *mul, unsigned int *div)
+{
+	const struct clk_factor_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++) {
+		if (clkt->val == val) {
+			*mul = clkt->mul;
+			*div = clkt->div;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static unsigned int _get_table_val(const struct clk_factor_table *table,
+			unsigned long rate, unsigned long parent_rate)
+{
+	const struct clk_factor_table *clkt;
+	int val = -1;
+	u64 calc_rate;
+
+	for (clkt = table; clkt->div; clkt++) {
+		calc_rate = parent_rate * clkt->mul;
+		do_div(calc_rate, clkt->div);
+
+		if ((unsigned long)calc_rate <= rate) {
+			val = clkt->val;
+			break;
+		}
+	}
+
+	if (val == -1)
+		val = _get_table_maxval(table);
+
+	return val;
+}
+
+static int clk_val_best(struct clk_hw *hw, unsigned long rate,
+			unsigned long *best_parent_rate)
+{
+	struct owl_factor *factor = hw_to_owl_factor(hw);
+	struct owl_factor_hw *factor_hw = &factor->factor_hw;
+	const struct clk_factor_table *clkt = factor_hw->table;
+	unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
+	unsigned long parent_rate_saved = *best_parent_rate;
+	int bestval = 0;
+
+	if (!rate)
+		rate = 1;
+
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		parent_rate = *best_parent_rate;
+		bestval = _get_table_val(clkt, rate, parent_rate);
+		return bestval;
+	}
+
+	for (clkt = factor_hw->table; clkt->div; clkt++) {
+		try_parent_rate = rate * clkt->div / clkt->mul;
+
+		if (try_parent_rate == parent_rate_saved) {
+			pr_debug("%s: [%d %d %d] found try_parent_rate %ld\n",
+				__func__, clkt->val, clkt->mul, clkt->div,
+				try_parent_rate);
+			/*
+			 * It's the most ideal case if the requested rate can be
+			 * divided from parent clock without any need to change
+			 * parent rate, so return the divider immediately.
+			 */
+			*best_parent_rate = parent_rate_saved;
+			return clkt->val;
+		}
+
+		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+				try_parent_rate);
+		cur_rate = DIV_ROUND_UP(parent_rate, clkt->div) * clkt->mul;
+		if (cur_rate <= rate && cur_rate > best) {
+			bestval = clkt->val;
+			best = cur_rate;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	if (!bestval) {
+		bestval = _get_table_maxval(clkt);
+		*best_parent_rate = clk_hw_round_rate(
+				clk_hw_get_parent(hw), 1);
+	}
+
+	return bestval;
+}
+
+long owl_factor_helper_round_rate(struct owl_clk_common *common,
+				const struct owl_factor_hw *factor_hw,
+				unsigned long rate,
+				unsigned long *parent_rate)
+{
+	const struct clk_factor_table *clkt = factor_hw->table;
+	unsigned int val, mul = 0, div = 1;
+
+	val = clk_val_best(&common->hw, rate, parent_rate);
+	_get_table_div_mul(clkt, val, &mul, &div);
+
+	return *parent_rate * mul / div;
+}
+
+static long owl_factor_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *parent_rate)
+{
+	struct owl_factor *factor = hw_to_owl_factor(hw);
+	struct owl_factor_hw *factor_hw = &factor->factor_hw;
+
+	return owl_factor_helper_round_rate(&factor->common, factor_hw,
+					rate, parent_rate);
+}
+
+unsigned long owl_factor_helper_recalc_rate(struct owl_clk_common *common,
+					 const struct owl_factor_hw *factor_hw,
+					 unsigned long parent_rate)
+{
+	const struct clk_factor_table *clkt = factor_hw->table;
+	unsigned long rate;
+	u32 reg, val, mul, div;
+
+	div = 0;
+	mul = 0;
+
+	regmap_read(common->regmap, factor_hw->reg, &reg);
+
+	val = reg >> factor_hw->shift;
+	val &= div_mask(factor_hw);
+
+	_get_table_div_mul(clkt, val, &mul, &div);
+	if (!div) {
+		WARN(!(factor_hw->fct_flags & CLK_DIVIDER_ALLOW_ZERO),
+			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
+			__clk_get_name(common->hw.clk));
+		return parent_rate;
+	}
+
+	rate = parent_rate * mul;
+	do_div(rate, div);
+
+	return rate;
+}
+
+static unsigned long owl_factor_recalc_rate(struct clk_hw *hw,
+			unsigned long parent_rate)
+{
+	struct owl_factor *factor = hw_to_owl_factor(hw);
+	struct owl_factor_hw *factor_hw = &factor->factor_hw;
+	struct owl_clk_common *common = &factor->common;
+
+	return owl_factor_helper_recalc_rate(common, factor_hw, parent_rate);
+}
+
+int owl_factor_helper_set_rate(const struct owl_clk_common *common,
+				const struct owl_factor_hw *factor_hw,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	u32 val, reg;
+
+	val = _get_table_val(factor_hw->table, rate, parent_rate);
+
+	if (val > div_mask(factor_hw))
+		val = div_mask(factor_hw);
+
+	regmap_read(common->regmap, factor_hw->reg, &reg);
+
+	reg &= ~(div_mask(factor_hw) << factor_hw->shift);
+	reg |= val << factor_hw->shift;
+
+	regmap_write(common->regmap, factor_hw->reg, reg);
+
+	return 0;
+}
+
+static int owl_factor_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct owl_factor *factor = hw_to_owl_factor(hw);
+	struct owl_factor_hw *factor_hw = &factor->factor_hw;
+	struct owl_clk_common *common = &factor->common;
+
+	return owl_factor_helper_set_rate(common, factor_hw,
+					rate, parent_rate);
+}
+
+const struct clk_ops owl_factor_ops = {
+	.round_rate	= owl_factor_round_rate,
+	.recalc_rate	= owl_factor_recalc_rate,
+	.set_rate	= owl_factor_set_rate,
+};
diff --git a/drivers/clk/actions/owl-factor.h b/drivers/clk/actions/owl-factor.h
new file mode 100644
index 000000000000..f1a7ffe896e1
--- /dev/null
+++ b/drivers/clk/actions/owl-factor.h
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL factor clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_FACTOR_H_
+#define _OWL_FACTOR_H_
+
+#include "owl-common.h"
+
+struct clk_factor_table {
+	unsigned int		val;
+	unsigned int		mul;
+	unsigned int		div;
+};
+
+struct owl_factor_hw {
+	u32			reg;
+	u8			shift;
+	u8			width;
+	u8			fct_flags;
+	struct clk_factor_table	*table;
+};
+
+struct owl_factor {
+	struct owl_factor_hw	factor_hw;
+	struct owl_clk_common	common;
+};
+
+#define OWL_FACTOR_HW(_reg, _shift, _width, _fct_flags, _table)		\
+	{								\
+		.reg		= _reg,					\
+		.shift		= _shift,				\
+		.width		= _width,				\
+		.fct_flags	= _fct_flags,				\
+		.table		= _table,				\
+	}
+
+#define OWL_FACTOR(_struct, _name, _parent, _reg,			\
+		   _shift, _width, _table, _fct_flags, _flags)		\
+	struct owl_factor _struct = {					\
+		.factor_hw = OWL_FACTOR_HW(_reg, _shift,		\
+					   _width, _fct_flags, _table),	\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &owl_factor_ops,	\
+						      _flags),		\
+		},							\
+	}
+
+#define div_mask(d) ((1 << ((d)->width)) - 1)
+
+static inline struct owl_factor *hw_to_owl_factor(const struct clk_hw *hw)
+{
+	struct owl_clk_common *common = hw_to_owl_clk_common(hw);
+
+	return container_of(common, struct owl_factor, common);
+}
+
+long owl_factor_helper_round_rate(struct owl_clk_common *common,
+				const struct owl_factor_hw *factor_hw,
+				unsigned long rate,
+				unsigned long *parent_rate);
+
+unsigned long owl_factor_helper_recalc_rate(struct owl_clk_common *common,
+					 const struct owl_factor_hw *factor_hw,
+					 unsigned long parent_rate);
+
+int owl_factor_helper_set_rate(const struct owl_clk_common *common,
+				const struct owl_factor_hw *factor_hw,
+				unsigned long rate,
+				unsigned long parent_rate);
+
+extern const struct clk_ops owl_factor_ops;
+
+#endif /* _OWL_FACTOR_H_ */
-- 
2.14.1
