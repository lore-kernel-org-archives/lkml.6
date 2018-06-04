Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeFDNTZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 09:19:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37371 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbeFDNTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 09:19:22 -0400
X-Google-Smtp-Source: ADUXVKKSpexAMBva+eyq1rGxWO7ZGsEYYI5vr6dEYYfBDNZCpnLDxUPC/iMHLUDg0j/TdtcNq3RL0w==
Date: Mon, 4 Jun 2018 16:19:13 +0300
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support BD71837 gateable 32768 Hz clock.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/Kconfig       |   7 +++
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-bd71837.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/clk/clk-bd71837.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 41492e980ef4..e693496f202a 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -279,6 +279,13 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
 
+config COMMON_CLK_BD71837
+	tristate "Clock driver for ROHM BD71837 PMIC MFD"
+	depends on MFD_BD71837
+	help
+	  This driver supports ROHM BD71837 PMIC clock.
+
+
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index de6d06ac790b..8393c4af7d5a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -21,6 +21,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
+obj-$(CONFIG_COMMON_CLK_BD71837)	+= clk-bd71837.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
diff --git a/drivers/clk/clk-bd71837.c b/drivers/clk/clk-bd71837.c
new file mode 100644
index 000000000000..5ba6c05c5a98
--- /dev/null
+++ b/drivers/clk/clk-bd71837.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// bd71837.c  -- ROHM BD71837MWV clock driver
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mfd/bd71837.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+
+struct bd71837_clk {
+	struct clk_hw hw;
+	uint8_t reg;
+	uint8_t mask;
+	unsigned long rate;
+	struct platform_device *pdev;
+	struct bd71837 *mfd;
+};
+
+static int bd71837_clk_set(struct clk_hw *hw, int status)
+{
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
+
+	return bd71837_update_bits(c->mfd, c->reg, c->mask, status);
+}
+
+static void bd71837_clk_disable(struct clk_hw *hw)
+{
+	int rv;
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
+
+	rv = bd71837_clk_set(hw, 0);
+	if (rv)
+		dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d)\n", rv);
+}
+
+static int bd71837_clk_enable(struct clk_hw *hw)
+{
+	return bd71837_clk_set(hw, 1);
+}
+
+static int bd71837_clk_is_enabled(struct clk_hw *hw)
+{
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
+
+	return c->mask & bd71837_reg_read(c->mfd, c->reg);
+}
+
+static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
+
+	return c->rate;
+}
+
+static const struct clk_ops bd71837_clk_ops = {
+	.recalc_rate = &bd71837_clk_recalc_rate,
+	.prepare = &bd71837_clk_enable,
+	.unprepare = &bd71837_clk_disable,
+	.is_prepared = &bd71837_clk_is_enabled,
+};
+
+static int bd71837_clk_probe(struct platform_device *pdev)
+{
+	struct bd71837_clk *c;
+	int rval = -ENOMEM;
+	struct bd71837 *mfd = dev_get_drvdata(pdev->dev.parent);
+	struct clk_init_data init = {
+		.name = "bd71837-32k-out",
+		.ops = &bd71837_clk_ops,
+	};
+
+	c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		goto err_out;
+
+	c->reg = BD71837_REG_OUT32K;
+	c->mask = BD71837_OUT32K_EN;
+	c->rate = BD71837_CLK_RATE;
+	c->mfd = mfd;
+	c->pdev = pdev;
+
+	of_property_read_string_index(pdev->dev.parent->of_node,
+					      "clock-output-names", 0,
+					      &init.name);
+
+	c->hw.init = &init;
+
+	rval = devm_clk_hw_register(&pdev->dev, &c->hw);
+	if (rval) {
+		dev_err(&pdev->dev, "failed to register 32K clk");
+		goto err_out;
+	}
+
+	if (pdev->dev.parent->of_node) {
+		rval = of_clk_add_hw_provider(pdev->dev.parent->of_node,
+					     of_clk_hw_simple_get,
+					     &c->hw);
+		if (rval) {
+			dev_err(&pdev->dev, "adding clk provider failed\n");
+			goto err_out;
+		}
+	}
+
+	rval = clk_hw_register_clkdev(&c->hw, init.name, NULL);
+	if (rval) {
+		dev_err(&pdev->dev, "failed to register clkdev for bd71837");
+		goto err_clean_provider;
+	}
+
+	platform_set_drvdata(pdev, c);
+
+	return 0;
+
+err_clean_provider:
+	of_clk_del_provider(pdev->dev.parent->of_node);
+err_out:
+	return rval;
+}
+
+static int bd71837_clk_remove(struct platform_device *pdev)
+{
+	if (pdev->dev.parent->of_node)
+		of_clk_del_provider(pdev->dev.parent->of_node);
+	return 0;
+}
+
+static struct platform_driver bd71837_clk = {
+	.driver = {
+		.name = "bd71837-clk",
+	},
+	.probe = bd71837_clk_probe,
+	.remove = bd71837_clk_remove,
+};
+
+module_platform_driver(bd71837_clk);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3
