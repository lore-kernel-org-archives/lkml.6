Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753867AbeBSUWq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:22:46 -0500
Received: from vern.gendns.com ([206.190.152.46]:58422 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753827AbeBSUWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:43 -0500
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v7 04/42] clk: davinci: Add platform information for TI DA850 PLL
Date: Mon, 19 Feb 2018 14:21:25 -0600
Message-Id: <1519071723-31790-5-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519071723-31790-1-git-send-email-david@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds platform-specific declarations for the PLL clocks on TI DA850/
OMAP-L138/AM18XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- include clkdev lookup registration here instead of in mach-davinci
- split registration functions for each PLL
- Add platform_device_id lookup

v6 changes:
- Added da850_pll{0,1}_info with controller-specific information
- Added OBSCLK data
- Add empty lines between function calls


 drivers/clk/davinci/Makefile    |   1 +
 drivers/clk/davinci/pll-da850.c | 178 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c       |   4 +
 drivers/clk/davinci/pll.h       |   5 ++
 4 files changed, 188 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-da850.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 9061e19..13049d4 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -3,4 +3,5 @@
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-y += pll.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
+obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 endif
diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
new file mode 100644
index 0000000..1b4e011
--- /dev/null
+++ b/drivers/clk/davinci/pll-da850.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DA850/OMAP-L138/AM18XX
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/of.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+#define OCSEL_OCSRC_OSCIN		0x14
+#define OCSEL_OCSRC_PLL0_SYSCLK(n)	(0x16 + (n))
+#define OCSEL_OCSRC_PLL1_OBSCLK		0x1e
+#define OCSEL_OCSRC_PLL1_SYSCLK(n)	(0x16 + (n))
+
+static const struct davinci_pll_clk_info da850_pll0_info __initconst = {
+	.name = "pll0",
+	.unlock_reg = CFGCHIP(0),
+	.unlock_mask = CFGCHIP0_PLL_MASTER_LOCK,
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 4,
+	.pllm_max = 32,
+	.pllout_min_rate = 300000000,
+	.pllout_max_rate = 600000000,
+	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_HAS_POSTDIV |
+		 PLL_HAS_EXTCLKSRC,
+};
+
+/*
+ * NB: Technically, the clocks flagged as SYSCLK_FIXED_DIV are "fixed ratio",
+ * meaning that we could change the divider as long as we keep the correct
+ * ratio between all of the clocks, but we don't support that because there is
+ * currently not a need for it.
+ */
+
+static const struct davinci_pll_sysclk_info da850_pll0_sysclk_info[] __initconst = {
+	SYSCLK(1, pll0_sysclk1, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(2, pll0_sysclk2, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(3, pll0_sysclk3, pll0_pllen, 5, 0),
+	SYSCLK(4, pll0_sysclk4, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0),
+	SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_ARM_RATE | SYSCLK_FIXED_DIV),
+	SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0),
+	{ }
+};
+
+static const char * const da850_pll0_obsclk_parent_names[] __initconst = {
+	"oscin",
+	"pll0_sysclk1",
+	"pll0_sysclk2",
+	"pll0_sysclk3",
+	"pll0_sysclk4",
+	"pll0_sysclk5",
+	"pll0_sysclk6",
+	"pll0_sysclk7",
+	"pll1_obsclk",
+};
+
+static u32 da850_pll0_obsclk_table[] = {
+	OCSEL_OCSRC_OSCIN,
+	OCSEL_OCSRC_PLL0_SYSCLK(1),
+	OCSEL_OCSRC_PLL0_SYSCLK(2),
+	OCSEL_OCSRC_PLL0_SYSCLK(3),
+	OCSEL_OCSRC_PLL0_SYSCLK(4),
+	OCSEL_OCSRC_PLL0_SYSCLK(5),
+	OCSEL_OCSRC_PLL0_SYSCLK(6),
+	OCSEL_OCSRC_PLL0_SYSCLK(7),
+	OCSEL_OCSRC_PLL1_OBSCLK,
+};
+
+static const struct davinci_pll_obsclk_info da850_pll0_obsclk_info __initconst = {
+	.name = "pll0_obsclk",
+	.parent_names = da850_pll0_obsclk_parent_names,
+	.num_parents = ARRAY_SIZE(da850_pll0_obsclk_parent_names),
+	.table = da850_pll0_obsclk_table,
+	.ocsrc_mask = GENMASK(4, 0),
+};
+
+static const struct davinci_pll_clk_info da850_pll1_info __initconst = {
+	.name = "pll1",
+	.unlock_reg = CFGCHIP(3),
+	.unlock_mask = CFGCHIP3_PLL1_MASTER_LOCK,
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 4,
+	.pllm_max = 32,
+	.pllout_min_rate = 300000000,
+	.pllout_max_rate = 600000000,
+	.flags = PLL_HAS_POSTDIV,
+};
+
+static const struct davinci_pll_sysclk_info da850_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, 0),
+	SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, 0),
+	{ }
+};
+
+static const char * const da850_pll1_obsclk_parent_names[] __initconst = {
+	"oscin",
+	"pll1_sysclk1",
+	"pll1_sysclk2",
+	"pll1_sysclk3",
+};
+
+static u32 da850_pll1_obsclk_table[] = {
+	OCSEL_OCSRC_OSCIN,
+	OCSEL_OCSRC_PLL1_SYSCLK(1),
+	OCSEL_OCSRC_PLL1_SYSCLK(2),
+	OCSEL_OCSRC_PLL1_SYSCLK(3),
+};
+
+static const struct davinci_pll_obsclk_info da850_pll1_obsclk_info __initconst = {
+	.name = "pll1_obsclk",
+	.parent_names = da850_pll1_obsclk_parent_names,
+	.num_parents = ARRAY_SIZE(da850_pll1_obsclk_parent_names),
+	.table = da850_pll1_obsclk_table,
+	.ocsrc_mask = GENMASK(4, 0),
+};
+
+int __init da850_pll0_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+	struct clk *clk;
+
+	davinci_pll_clk_register(dev, &da850_pll0_info, "ref_clk", base);
+
+	davinci_pll_auxclk_register(dev, "pll0_auxclk", base);
+
+	clk = clk_register_fixed_factor(dev, "async2", "pll0_auxclk",
+					CLK_IS_CRITICAL, 1, 1);
+
+	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
+	clk_register_clkdev(clk, "timer0", NULL);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+
+	for (info = da850_pll0_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	davinci_pll_obsclk_register(dev, &da850_pll0_obsclk_info, base);
+
+	return 0;
+}
+
+int __init da850_pll1_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &da850_pll1_info, "oscin", base);
+
+	for (info = da850_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	davinci_pll_obsclk_register(dev, &da850_pll1_obsclk_info, base);
+
+	return 0;
+}
+
+int __init of_da850_pll0_init(struct device *dev, void __iomem *base)
+{
+	return of_davinci_pll_init(dev, &da850_pll0_info,
+				   &da850_pll0_obsclk_info,
+				   da850_pll0_sysclk_info, 7, base);
+}
+
+int __init of_da850_pll1_init(struct device *dev, void __iomem *base)
+{
+	return of_davinci_pll_init(dev, &da850_pll1_info,
+				   &da850_pll1_obsclk_info,
+				   da850_pll1_sysclk_info, 3, base);
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 9a22511..7c56397 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -747,11 +747,15 @@ int of_davinci_pll_init(struct device *dev,
 }
 
 static const struct of_device_id davinci_pll_of_match[] = {
+	{ .compatible = "ti,da850-pll0", .data = of_da850_pll0_init },
+	{ .compatible = "ti,da850-pll1", .data = of_da850_pll1_init },
 	{ }
 };
 
 static const struct platform_device_id davinci_pll_id_table[] = {
 	{ .name = "da830-pll",   .driver_data = (kernel_ulong_t)da830_pll_init   },
+	{ .name = "da850-pll0",  .driver_data = (kernel_ulong_t)da850_pll0_init  },
+	{ .name = "da850-pll1",  .driver_data = (kernel_ulong_t)da850_pll1_init  },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 5c4c5c8..545a156 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -121,4 +121,9 @@ int of_davinci_pll_init(struct device *dev,
 
 int da830_pll_init(struct device *dev, void __iomem *base);
 
+int da850_pll0_init(struct device *dev, void __iomem *base);
+int da850_pll1_init(struct device *dev, void __iomem *base);
+int of_da850_pll0_init(struct device *dev, void __iomem *base);
+int of_da850_pll1_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
