Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeCZRmC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:42:02 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39430 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752828AbeCZRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:41:59 -0400
X-Google-Smtp-Source: AG47ELvQPp5LXkjg4zFa5BetOdKSW1kGjAJP+lUD6RuuSswlE1mVlpz0PhUctIta82022cVYqzBtUA==
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
Subject: [PATCH v7 03/11] clk: actions: Add common clock driver support
Date: Mon, 26 Mar 2018 23:08:57 +0530
Message-Id: <20180326173905.22313-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180326173905.22313-1-manivannan.sadhasivam@linaro.org>
References: <20180326173905.22313-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi common clock driver with generic structures
and interface functions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/Kconfig              |  1 +
 drivers/clk/Makefile             |  1 +
 drivers/clk/actions/Kconfig      |  4 ++
 drivers/clk/actions/Makefile     |  3 ++
 drivers/clk/actions/owl-common.c | 89 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-common.h | 41 ++++++++++++++++++
 6 files changed, 139 insertions(+)
 create mode 100644 drivers/clk/actions/Kconfig
 create mode 100644 drivers/clk/actions/Makefile
 create mode 100644 drivers/clk/actions/owl-common.c
 create mode 100644 drivers/clk/actions/owl-common.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 98ce9fc6e6c0..6313a4f4327a 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -238,6 +238,7 @@ config COMMON_CLK_VC5
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
 
+source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 71ec41e6364f..b7909df532ed 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 
 # please keep this section sorted lexicographically by directory path name
+obj-y					+= actions/
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_ARTPEC)		+= axis/
 obj-$(CONFIG_ARC_PLAT_AXS10X)		+= axs10x/
diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
new file mode 100644
index 000000000000..13a3e5083d43
--- /dev/null
+++ b/drivers/clk/actions/Kconfig
@@ -0,0 +1,4 @@
+config CLK_ACTIONS
+	bool "Clock driver for Actions Semi SoCs"
+	depends on ARCH_ACTIONS || COMPILE_TEST
+	default ARCH_ACTIONS
diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
new file mode 100644
index 000000000000..64a50fc2d335
--- /dev/null
+++ b/drivers/clk/actions/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_CLK_ACTIONS)	+= clk-owl.o
+
+clk-owl-y			+= owl-common.o
diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
new file mode 100644
index 000000000000..61c1071b5180
--- /dev/null
+++ b/drivers/clk/actions/owl-common.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL common clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "owl-common.h"
+
+static const struct regmap_config owl_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x00cc,
+	.fast_io	= true,
+};
+
+static void owl_clk_set_regmap(const struct owl_clk_desc *desc,
+			 struct regmap *regmap)
+{
+	int i;
+	struct owl_clk_common *clks;
+
+	for (i = 0; i < desc->num_clks; i++) {
+		clks = desc->clks[i];
+		if (!clks)
+			continue;
+
+		clks->regmap = regmap;
+	}
+}
+
+int owl_clk_regmap_init(struct platform_device *pdev,
+			 const struct owl_clk_desc *desc)
+{
+	void __iomem *base;
+	struct regmap *regmap;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, &owl_regmap_config);
+	if (IS_ERR(regmap)) {
+		pr_err("failed to init regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	owl_clk_set_regmap(desc, regmap);
+
+	return 0;
+}
+
+int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks)
+{
+	int i, ret;
+	struct clk_hw *hw;
+
+	for (i = 0; i < hw_clks->num; i++) {
+
+		hw = hw_clks->hws[i];
+
+		if (IS_ERR_OR_NULL(hw))
+			continue;
+
+		ret = devm_clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "Couldn't register clock %d - %s\n",
+				i, hw->init->name);
+			return ret;
+		}
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_clks);
+	if (ret)
+		dev_err(dev, "Failed to add clock provider\n");
+
+	return ret;
+}
diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
new file mode 100644
index 000000000000..4fd726ec54a6
--- /dev/null
+++ b/drivers/clk/actions/owl-common.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL common clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_COMMON_H_
+#define _OWL_COMMON_H_
+
+#include <linux/clk-provider.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+struct device_node;
+
+struct owl_clk_common {
+	struct regmap			*regmap;
+	struct clk_hw			hw;
+};
+
+struct owl_clk_desc {
+	struct owl_clk_common		**clks;
+	unsigned long			num_clks;
+	struct clk_hw_onecell_data	*hw_clks;
+};
+
+static inline struct owl_clk_common *
+	hw_to_owl_clk_common(const struct clk_hw *hw)
+{
+	return container_of(hw, struct owl_clk_common, hw);
+}
+
+int owl_clk_regmap_init(struct platform_device *pdev,
+			 const struct owl_clk_desc *desc);
+int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks);
+
+#endif /* _OWL_COMMON_H_ */
-- 
2.14.1
