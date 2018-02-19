Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbeBSUWw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:22:52 -0500
Received: from vern.gendns.com ([206.190.152.46]:58455 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753827AbeBSUWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:47 -0500
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
Subject: [PATCH v7 07/42] clk: davinci: Add platform information for TI DM644x PLL
Date: Mon, 19 Feb 2018 14:21:28 -0600
Message-Id: <1519071723-31790-8-git-send-email-david@lechnology.com>
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

This adds platform-specific declarations for the PLL clocks on TI
DM644x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- split registration functions for each PLL
- Add platform_device_id lookup

v6 changes:
- Added dm644x_pll{1,2}_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/pll-dm644x.c | 76 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c        |  2 ++
 drivers/clk/davinci/pll.h        |  3 ++
 4 files changed, 82 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-dm644x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 353aa02..59d8ab6 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
+obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= pll-dm644x.o
 endif
diff --git a/drivers/clk/davinci/pll-dm644x.c b/drivers/clk/davinci/pll-dm644x.c
new file mode 100644
index 0000000..cb31aa0
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm644x.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM644X
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_clk_info dm644x_pll1_info __initconst = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 1,
+	.pllm_max = 32,
+	.pllout_min_rate = 400000000,
+	.pllout_max_rate = 600000000, /* 810MHz @ 1.3V, -810 only */
+	.flags = PLL_HAS_CLKMODE | PLL_HAS_POSTDIV,
+};
+
+static const struct davinci_pll_sysclk_info dm644x_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(3, pll1_sysclk3, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	SYSCLK(5, pll1_sysclk5, pll1_pllen, 4, SYSCLK_FIXED_DIV),
+	{ }
+};
+
+static const struct davinci_pll_clk_info dm644x_pll2_info __initconst = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 1,
+	.pllm_max = 32,
+	.pllout_min_rate = 400000000,
+	.pllout_max_rate = 900000000,
+	.flags = PLL_HAS_POSTDIV | PLL_POSTDIV_FIXED_DIV,
+};
+
+static const struct davinci_pll_sysclk_info dm644x_pll2_sysclk_info[] __initconst = {
+	SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0),
+	SYSCLK(2, pll2_sysclk2, pll2_pllen, 4, 0),
+	{ }
+};
+
+int __init dm644x_pll1_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &dm644x_pll1_info, "ref_clk", base);
+
+	for (info = dm644x_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
+
+	return 0;
+}
+
+int __init dm644x_pll2_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &dm644x_pll2_info, "oscin", base);
+
+	for (info = dm644x_pll2_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll2_sysclkbp", base);
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index c8dd3fa..613ec24 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -760,6 +760,8 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 	{ .name = "dm355-pll2",  .driver_data = (kernel_ulong_t)dm355_pll2_init  },
 	{ .name = "dm365-pll1",  .driver_data = (kernel_ulong_t)dm365_pll1_init  },
 	{ .name = "dm365-pll2",  .driver_data = (kernel_ulong_t)dm365_pll2_init  },
+	{ .name = "dm644x-pll1", .driver_data = (kernel_ulong_t)dm644x_pll1_init },
+	{ .name = "dm644x-pll2", .driver_data = (kernel_ulong_t)dm644x_pll2_init },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index b911c8a..df977a6 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -132,4 +132,7 @@ int dm355_pll2_init(struct device *dev, void __iomem *base);
 int dm365_pll1_init(struct device *dev, void __iomem *base);
 int dm365_pll2_init(struct device *dev, void __iomem *base);
 
+int dm644x_pll1_init(struct device *dev, void __iomem *base);
+int dm644x_pll2_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
