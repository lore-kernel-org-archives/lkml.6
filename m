Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeCBFwB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:52:01 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41189 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936042AbeCBFv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:51:57 -0500
X-Google-Smtp-Source: AG47ELusGICRy0B3QYPo7jndryxFNaS/pRuHqQhEWZvY5Wc148JihWcMKQf6kZuOWQyFbcgmVQlJAA==
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
Subject: [PATCH v4 09/11] clk: actions: Add composite clock support
Date: Fri,  2 Mar 2018 11:18:58 +0530
Message-Id: <20180302054900.11275-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
References: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi composite clock. This clock
consists of gate, mux, divider and factor clocks.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Makefile        |   1 +
 drivers/clk/actions/owl-composite.c | 155 ++++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-composite.h | 101 +++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 drivers/clk/actions/owl-composite.c
 create mode 100644 drivers/clk/actions/owl-composite.h

diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 994357fa560b..53431aef6e9c 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -5,3 +5,4 @@ clk-owl-y			+= owl-gate.o
 clk-owl-y			+= owl-mux.o
 clk-owl-y			+= owl-divider.o
 clk-owl-y			+= owl-factor.o
+clk-owl-y			+= owl-composite.o
diff --git a/drivers/clk/actions/owl-composite.c b/drivers/clk/actions/owl-composite.c
new file mode 100644
index 000000000000..04fe1645a60d
--- /dev/null
+++ b/drivers/clk/actions/owl-composite.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL composite clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "owl-composite.h"
+
+static u8 owl_comp_get_parent(struct clk_hw *hw)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_mux_helper_get_parent(&comp->common, &comp->mux_hw);
+}
+
+static int owl_comp_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_mux_helper_set_parent(&comp->common, &comp->mux_hw, index);
+}
+
+static void owl_comp_disable(struct clk_hw *hw)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+	struct owl_clk_common *common = &comp->common;
+
+	clk_gate_set(common, &comp->gate_hw, false);
+}
+
+static int owl_comp_enable(struct clk_hw *hw)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+	struct owl_clk_common *common = &comp->common;
+
+	clk_gate_set(common, &comp->gate_hw, true);
+
+	return 0;
+}
+
+static int owl_comp_is_enabled(struct clk_hw *hw)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+	struct owl_clk_common *common = &comp->common;
+
+	return clk_is_enabled(common, &comp->gate_hw);
+}
+
+static long owl_comp_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_divider_helper_round_rate(&comp->common, &comp->rate.div_hw,
+					rate, parent_rate);
+}
+
+static unsigned long owl_comp_div_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_divider_helper_recalc_rate(&comp->common, &comp->rate.div_hw,
+					parent_rate);
+}
+
+static int owl_comp_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_divider_helper_set_rate(&comp->common, &comp->rate.div_hw,
+					rate, parent_rate);
+}
+
+static long owl_comp_fact_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *parent_rate)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_factor_helper_round_rate(&comp->common,
+					&comp->rate.factor_hw,
+					rate, parent_rate);
+}
+
+static unsigned long owl_comp_fact_recalc_rate(struct clk_hw *hw,
+			unsigned long parent_rate)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_factor_helper_recalc_rate(&comp->common,
+					&comp->rate.factor_hw,
+					parent_rate);
+}
+
+static int owl_comp_fact_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct owl_composite *comp = hw_to_owl_comp(hw);
+
+	return owl_factor_helper_set_rate(&comp->common,
+					&comp->rate.factor_hw,
+					rate, parent_rate);
+}
+
+const struct clk_ops owl_comp_div_ops = {
+	/* mux_ops */
+	.get_parent	= owl_comp_get_parent,
+	.set_parent	= owl_comp_set_parent,
+
+	/* gate_ops */
+	.disable	= owl_comp_disable,
+	.enable		= owl_comp_enable,
+	.is_enabled	= owl_comp_is_enabled,
+
+	/* div_ops */
+	.round_rate	= owl_comp_div_round_rate,
+	.recalc_rate	= owl_comp_div_recalc_rate,
+	.set_rate	= owl_comp_div_set_rate,
+};
+
+
+const struct clk_ops owl_comp_fact_ops = {
+	/* mux_ops */
+	.get_parent	= owl_comp_get_parent,
+	.set_parent	= owl_comp_set_parent,
+
+	/* gate_ops */
+	.disable	= owl_comp_disable,
+	.enable		= owl_comp_enable,
+	.is_enabled	= owl_comp_is_enabled,
+
+	/* fact_ops */
+	.round_rate	= owl_comp_fact_round_rate,
+	.recalc_rate	= owl_comp_fact_recalc_rate,
+	.set_rate	= owl_comp_fact_set_rate,
+};
+
+const struct clk_ops owl_comp_pass_ops = {
+	/* mux_ops */
+	.get_parent	= owl_comp_get_parent,
+	.set_parent	= owl_comp_set_parent,
+
+	/* gate_ops */
+	.disable	= owl_comp_disable,
+	.enable		= owl_comp_enable,
+	.is_enabled	= owl_comp_is_enabled,
+};
diff --git a/drivers/clk/actions/owl-composite.h b/drivers/clk/actions/owl-composite.h
new file mode 100644
index 000000000000..386a93ac951e
--- /dev/null
+++ b/drivers/clk/actions/owl-composite.h
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL composite clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_COMPOSITE_H_
+#define _OWL_COMPOSITE_H_
+
+#include "owl-common.h"
+#include "owl-mux.h"
+#include "owl-gate.h"
+#include "owl-factor.h"
+#include "owl-divider.h"
+
+union owl_rate {
+	struct owl_divider_hw	div_hw;
+	struct owl_factor_hw	factor_hw;
+};
+
+struct owl_composite {
+	struct owl_mux_hw	mux_hw;
+	struct owl_gate_hw	gate_hw;
+	union owl_rate		rate;
+	struct owl_clk_common	common;
+};
+
+#define OWL_COMP_DIV(_struct, _name, _parent,				\
+		     _mux, _gate, _div, _flags)				\
+	struct owl_composite _struct = {				\
+		.mux_hw		= _mux,					\
+		.gate_hw	= _gate,				\
+		.rate.div_hw	= _div,					\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+						     _parent,		\
+						      &owl_comp_div_ops,\
+						     _flags),		\
+		},							\
+	}
+
+#define OWL_COMP_DIV_FIXED(_struct, _name, _parent,			\
+		     _gate, _div, _flags)				\
+	struct owl_composite _struct = {				\
+		.gate_hw	= _gate,				\
+		.rate.div_hw	= _div,					\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						     _parent,		\
+						      &owl_comp_div_ops,\
+						     _flags),		\
+		},							\
+	}
+
+#define OWL_COMP_FACTOR(_struct, _name, _parent,			\
+			_mux, _gate, _factor, _flags)			\
+	struct owl_composite _struct = {				\
+		.mux_hw		= _mux,					\
+		.gate_hw	= _gate,				\
+		.rate.factor_hw	= _factor,				\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+						     _parent,		\
+						     &owl_comp_fact_ops,\
+						     _flags),		\
+		},							\
+	}
+
+#define OWL_COMP_PASS(_struct, _name, _parent,				\
+		      _mux, _gate, _flags)				\
+	struct owl_composite _struct = {				\
+		.mux_hw		= _mux,					\
+		.gate_hw	= _gate,				\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+						     _parent,		\
+						     &owl_comp_pass_ops,\
+						     _flags),		\
+		},							\
+	}
+
+static inline struct owl_composite *hw_to_owl_comp(const struct clk_hw *hw)
+{
+	struct owl_clk_common *common = hw_to_owl_clk_common(hw);
+
+	return container_of(common, struct owl_composite, common);
+}
+
+extern const struct clk_ops owl_comp_div_ops;
+extern const struct clk_ops owl_comp_fact_ops;
+extern const struct clk_ops owl_comp_pass_ops;
+
+#endif /* _OWL_COMPOSITE_H_ */
-- 
2.14.1
