Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935999AbeCBFvX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:51:23 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39046 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935951AbeCBFvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:51:19 -0500
X-Google-Smtp-Source: AG47ELsCFYqDXmDoQn6AUuCPs/180abLnMzVe1XDy4xYGGfoXvn911NdQEurDHyMRr41lOOX054xDQ==
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
Subject: [PATCH v4 05/11] clk: actions: Add gate clock support
Date: Fri,  2 Mar 2018 11:18:54 +0530
Message-Id: <20180302054900.11275-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
References: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi gate clock together with helper
functions to be used in composite clock.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Makefile   |  1 +
 drivers/clk/actions/owl-gate.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-gate.h | 73 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/clk/actions/owl-gate.c
 create mode 100644 drivers/clk/actions/owl-gate.h

diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 64a50fc2d335..1f0917872c9d 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_CLK_ACTIONS)	+= clk-owl.o
 
 clk-owl-y			+= owl-common.o
+clk-owl-y			+= owl-gate.o
diff --git a/drivers/clk/actions/owl-gate.c b/drivers/clk/actions/owl-gate.c
new file mode 100644
index 000000000000..25dd94ac0f35
--- /dev/null
+++ b/drivers/clk/actions/owl-gate.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL gate clock driver
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
+#include "owl-gate.h"
+
+void clk_gate_set(const struct owl_clk_common *common,
+		 const struct owl_gate_hw *gate_hw, bool enable)
+{
+	int set = gate_hw->gate_flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	u32 reg;
+
+	set ^= enable;
+
+	regmap_read(common->regmap, gate_hw->reg, &reg);
+
+	if (set)
+		reg |= BIT(gate_hw->bit_idx);
+	else
+		reg &= ~BIT(gate_hw->bit_idx);
+
+	regmap_write(common->regmap, gate_hw->reg, reg);
+}
+
+static void owl_gate_disable(struct clk_hw *hw)
+{
+	struct owl_gate *gate = hw_to_owl_gate(hw);
+	struct owl_clk_common *common = &gate->common;
+
+	clk_gate_set(common, &gate->gate_hw, false);
+}
+
+static int owl_gate_enable(struct clk_hw *hw)
+{
+	struct owl_gate *gate = hw_to_owl_gate(hw);
+	struct owl_clk_common *common = &gate->common;
+
+	clk_gate_set(common, &gate->gate_hw, true);
+
+	return 0;
+}
+
+int clk_is_enabled(const struct owl_clk_common *common,
+		   const struct owl_gate_hw *gate_hw)
+{
+	u32 reg;
+
+	regmap_read(common->regmap, gate_hw->reg, &reg);
+
+	if (gate_hw->gate_flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= BIT(gate_hw->bit_idx);
+
+	return !!(reg & BIT(gate_hw->bit_idx));
+}
+
+static int owl_gate_is_enabled(struct clk_hw *hw)
+{
+	struct owl_gate *gate = hw_to_owl_gate(hw);
+	struct owl_clk_common *common = &gate->common;
+
+	return clk_is_enabled(common, &gate->gate_hw);
+}
+
+const struct clk_ops owl_gate_ops = {
+	.disable	= owl_gate_disable,
+	.enable		= owl_gate_enable,
+	.is_enabled	= owl_gate_is_enabled,
+};
diff --git a/drivers/clk/actions/owl-gate.h b/drivers/clk/actions/owl-gate.h
new file mode 100644
index 000000000000..4fc609647ae4
--- /dev/null
+++ b/drivers/clk/actions/owl-gate.h
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL gate clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_GATE_H_
+#define _OWL_GATE_H_
+
+#include "owl-common.h"
+
+struct owl_gate_hw {
+	u32			reg;
+	u8			bit_idx;
+	u8			gate_flags;
+};
+
+struct owl_gate {
+	struct owl_gate_hw	gate_hw;
+	struct owl_clk_common	common;
+};
+
+#define OWL_GATE_HW(_reg, _bit_idx, _gate_flags)	\
+	{						\
+		.reg		= _reg,			\
+		.bit_idx	= _bit_idx,		\
+		.gate_flags	= _gate_flags,		\
+	}
+
+#define OWL_GATE(_struct, _name, _parent, _reg,				\
+		_bit_idx, _gate_flags, _flags)				\
+	struct owl_gate _struct = {					\
+		.gate_hw = OWL_GATE_HW(_reg, _bit_idx, _gate_flags),	\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &owl_gate_ops,	\
+						      _flags),		\
+		}							\
+	}								\
+
+#define OWL_GATE_NO_PARENT(_struct, _name, _reg,			\
+		_bit_idx, _gate_flags, _flags)				\
+	struct owl_gate _struct = {					\
+		.gate_hw = OWL_GATE_HW(_reg, _bit_idx, _gate_flags),	\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT_NO_PARENT(_name,	\
+						      &owl_gate_ops,	\
+						      _flags),		\
+		},							\
+	}								\
+
+static inline struct owl_gate *hw_to_owl_gate(const struct clk_hw *hw)
+{
+	struct owl_clk_common *common = hw_to_owl_clk_common(hw);
+
+	return container_of(common, struct owl_gate, common);
+}
+
+void clk_gate_set(const struct owl_clk_common *common,
+		 const struct owl_gate_hw *gate_hw, bool enable);
+int clk_is_enabled(const struct owl_clk_common *common,
+		   const struct owl_gate_hw *gate_hw);
+
+extern const struct clk_ops owl_gate_ops;
+
+#endif /* _OWL_GATE_H_ */
-- 
2.14.1
