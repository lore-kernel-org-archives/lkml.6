Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbeCQKMS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 06:12:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34778 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeCQKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 06:12:09 -0400
X-Google-Smtp-Source: AG47ELvyv+sNMtJEBT81QKMCakn5B7aTmbaMDGgIi72YXOT9FLWCEX1iGU9fSft1aCkdaAHHwBCj6A==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 09/12] clk: actions: Add fixed factor clock support
Date: Sat, 17 Mar 2018 15:39:49 +0530
Message-Id: <20180317100952.28538-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
References: <20180317100952.28538-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi fixed factor clock together with
helper functions to be used in composite clock.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Makefile           |  1 +
 drivers/clk/actions/owl-fixed-factor.c | 81 ++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-fixed-factor.h | 62 ++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/clk/actions/owl-fixed-factor.c
 create mode 100644 drivers/clk/actions/owl-fixed-factor.h

diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 994357fa560b..b618696ba54e 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -5,3 +5,4 @@ clk-owl-y			+= owl-gate.o
 clk-owl-y			+= owl-mux.o
 clk-owl-y			+= owl-divider.o
 clk-owl-y			+= owl-factor.o
+clk-owl-y			+= owl-fixed-factor.o
diff --git a/drivers/clk/actions/owl-fixed-factor.c b/drivers/clk/actions/owl-fixed-factor.c
new file mode 100644
index 000000000000..f1281565129c
--- /dev/null
+++ b/drivers/clk/actions/owl-fixed-factor.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL fixed factor clock driver
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
+#include "owl-fixed-factor.h"
+
+long owl_fix_fact_helper_round_rate(struct owl_clk_common *common,
+				const struct owl_fix_fact_hw *fix_fact_hw,
+				unsigned long rate,
+				unsigned long *parent_rate)
+{
+	if (clk_hw_get_flags(&common->hw) & CLK_SET_RATE_PARENT) {
+		unsigned long best_parent;
+
+		best_parent = (rate / fix_fact_hw->mul) * fix_fact_hw->div;
+		*parent_rate = clk_hw_round_rate(clk_hw_get_parent(&common->hw),
+							best_parent);
+	}
+
+	return (*parent_rate / fix_fact_hw->div) * fix_fact_hw->mul;
+}
+
+static long owl_fix_fact_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *parent_rate)
+{
+	struct owl_fix_fact *fix_fact = hw_to_owl_fix_fact(hw);
+	struct owl_fix_fact_hw *fix_fact_hw = &fix_fact->fix_fact_hw;
+
+	return owl_fix_fact_helper_round_rate(&fix_fact->common, fix_fact_hw,
+							rate, parent_rate);
+}
+
+unsigned long owl_fix_fact_helper_recalc_rate(struct owl_clk_common *common,
+			const struct owl_fix_fact_hw *fix_fact_hw,
+			unsigned long parent_rate)
+{
+	unsigned long long int rate;
+
+	rate = (unsigned long long int)parent_rate * fix_fact_hw->mul;
+	do_div(rate, fix_fact_hw->div);
+
+	return (unsigned long)rate;
+}
+
+static unsigned long owl_fix_fact_recalc_rate(struct clk_hw *hw,
+			unsigned long parent_rate)
+{
+	struct owl_fix_fact *fix_fact = hw_to_owl_fix_fact(hw);
+	struct owl_fix_fact_hw *fix_fact_hw = &fix_fact->fix_fact_hw;
+
+	return owl_fix_fact_helper_recalc_rate(&fix_fact->common, fix_fact_hw,
+							parent_rate);
+}
+
+static int owl_fix_fact_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	/*
+	 * We must report success but we can do so unconditionally because
+	 * clk_fix_fact_round_rate returns values that ensure this call is a
+	 * nop.
+	 */
+
+	return 0;
+}
+
+const struct clk_ops owl_fix_fact_ops = {
+	.round_rate	= owl_fix_fact_round_rate,
+	.recalc_rate	= owl_fix_fact_recalc_rate,
+	.set_rate	= owl_fix_fact_set_rate,
+};
diff --git a/drivers/clk/actions/owl-fixed-factor.h b/drivers/clk/actions/owl-fixed-factor.h
new file mode 100644
index 000000000000..665dadef8738
--- /dev/null
+++ b/drivers/clk/actions/owl-fixed-factor.h
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL fixed factor clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_FIXED_FACTOR_H_
+#define _OWL_FIXED_FACTOR_H_
+
+#include "owl-common.h"
+
+struct owl_fix_fact_hw {
+	unsigned int		mul;
+	unsigned int		div;
+};
+
+struct owl_fix_fact {
+	struct owl_fix_fact_hw	fix_fact_hw;
+	struct owl_clk_common	common;
+};
+
+#define OWL_FIX_FACT_HW(_mul, _div)					\
+	{								\
+		.mul		= _mul,					\
+		.div		= _div,					\
+	}
+
+#define OWL_FIX_FACT(_struct, _name, _parent, _mul, _div, _flags)	\
+	struct owl_fix_fact _struct = {					\
+		.fix_fact_hw = OWL_FIX_FACT_HW(_mul, _div),		\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &owl_fix_fact_ops,\
+						      _flags),		\
+		},							\
+	}
+
+static inline struct owl_fix_fact *hw_to_owl_fix_fact(const struct clk_hw *hw)
+{
+	struct owl_clk_common *common = hw_to_owl_clk_common(hw);
+
+	return container_of(common, struct owl_fix_fact, common);
+}
+
+long owl_fix_fact_helper_round_rate(struct owl_clk_common *common,
+				const struct owl_fix_fact_hw *fix_fact_hw,
+				unsigned long rate,
+				unsigned long *parent_rate);
+
+unsigned long owl_fix_fact_helper_recalc_rate(struct owl_clk_common *common,
+				const struct owl_fix_fact_hw *fix_fact_hw,
+				unsigned long parent_rate);
+
+extern const struct clk_ops owl_fix_fact_ops;
+
+#endif /* _OWL_FIXED_FACTOR_H_ */
-- 
2.14.1
