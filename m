Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933099AbeCBFxO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:53:14 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36893 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936004AbeCBFv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:51:29 -0500
X-Google-Smtp-Source: AG47ELuiBFKGJHSiifvf8ZQtAY34Tw5tTjrV2jMdf2mEZHaXKpit8MpdyKAhpEkyMPK295Zu+Upeqg==
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
Subject: [PATCH v4 06/11] clk: actions: Add mux clock support
Date: Fri,  2 Mar 2018 11:18:55 +0530
Message-Id: <20180302054900.11275-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
References: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi mux clock together with helper
functions to be used in composite clock.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Makefile  |  1 +
 drivers/clk/actions/owl-mux.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-mux.h | 61 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/clk/actions/owl-mux.c
 create mode 100644 drivers/clk/actions/owl-mux.h

diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 1f0917872c9d..2d4aa8f35d90 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_CLK_ACTIONS)	+= clk-owl.o
 
 clk-owl-y			+= owl-common.o
 clk-owl-y			+= owl-gate.o
+clk-owl-y			+= owl-mux.o
diff --git a/drivers/clk/actions/owl-mux.c b/drivers/clk/actions/owl-mux.c
new file mode 100644
index 000000000000..f9c6cf2540e4
--- /dev/null
+++ b/drivers/clk/actions/owl-mux.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL mux clock driver
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
+#include "owl-mux.h"
+
+u8 owl_mux_helper_get_parent(const struct owl_clk_common *common,
+			     const struct owl_mux_hw *mux_hw)
+{
+	u32 reg;
+	u8 parent;
+
+	regmap_read(common->regmap, mux_hw->reg, &reg);
+	parent = reg >> mux_hw->shift;
+	parent &= BIT(mux_hw->width) - 1;
+
+	return parent;
+}
+
+static u8 owl_mux_get_parent(struct clk_hw *hw)
+{
+	struct owl_mux *mux = hw_to_owl_mux(hw);
+
+	return owl_mux_helper_get_parent(&mux->common, &mux->mux_hw);
+}
+
+int owl_mux_helper_set_parent(const struct owl_clk_common *common,
+			      struct owl_mux_hw *mux_hw, u8 index)
+{
+	u32 reg;
+
+	regmap_read(common->regmap, mux_hw->reg, &reg);
+	reg &= ~GENMASK(mux_hw->width + mux_hw->shift - 1, mux_hw->shift);
+	regmap_write(common->regmap, mux_hw->reg,
+			reg | (index << mux_hw->shift));
+
+	return 0;
+}
+
+static int owl_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct owl_mux *mux = hw_to_owl_mux(hw);
+
+	return owl_mux_helper_set_parent(&mux->common, &mux->mux_hw, index);
+}
+
+const struct clk_ops owl_mux_ops = {
+	.get_parent = owl_mux_get_parent,
+	.set_parent = owl_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
diff --git a/drivers/clk/actions/owl-mux.h b/drivers/clk/actions/owl-mux.h
new file mode 100644
index 000000000000..834284c8c3ae
--- /dev/null
+++ b/drivers/clk/actions/owl-mux.h
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL mux clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_MUX_H_
+#define _OWL_MUX_H_
+
+#include "owl-common.h"
+
+struct owl_mux_hw {
+	u32			reg;
+	u8			shift;
+	u8			width;
+};
+
+struct owl_mux {
+	struct owl_mux_hw	mux_hw;
+	struct owl_clk_common	common;
+};
+
+#define OWL_MUX_HW(_reg, _shift, _width)		\
+	{						\
+		.reg	= _reg,				\
+		.shift	= _shift,			\
+		.width	= _width,			\
+	}
+
+#define OWL_MUX(_struct, _name, _parents, _reg,				\
+		_shift, _width, _flags)					\
+	struct owl_mux _struct = {					\
+		.mux_hw	= OWL_MUX_HW(_reg, _shift, _width),		\
+		.common = {						\
+			.regmap = NULL,					\
+			.hw.init = CLK_HW_INIT_PARENTS(_name,		\
+						       _parents,	\
+						       &owl_mux_ops,	\
+						       _flags),		\
+		},							\
+	}
+
+static inline struct owl_mux *hw_to_owl_mux(const struct clk_hw *hw)
+{
+	struct owl_clk_common *common = hw_to_owl_clk_common(hw);
+
+	return container_of(common, struct owl_mux, common);
+}
+
+u8 owl_mux_helper_get_parent(const struct owl_clk_common *common,
+			     const struct owl_mux_hw *mux_hw);
+int owl_mux_helper_set_parent(const struct owl_clk_common *common,
+			      struct owl_mux_hw *mux_hw, u8 index);
+
+extern const struct clk_ops owl_mux_ops;
+
+#endif /* _OWL_MUX_H_ */
-- 
2.14.1
