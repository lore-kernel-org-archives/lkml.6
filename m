Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeBSUa4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:30:56 -0500
Received: from vern.gendns.com ([206.190.152.46]:58431 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753648AbeBSUWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:44 -0500
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
Subject: [PATCH v7 05/42] clk: davinci: Add platform information for TI DM355 PLL
Date: Mon, 19 Feb 2018 14:21:26 -0600
Message-Id: <1519071723-31790-6-git-send-email-david@lechnology.com>
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
DM355 based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- split registration functions for each PLL
- Add platform_device_id lookup

v6 changes:
- Added dm355_pll{1,2}_info with controller-specific information
- Add empty lines between function calls


 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/pll-dm355.c | 75 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c       |  2 ++
 drivers/clk/davinci/pll.h       |  3 ++
 4 files changed, 81 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-dm355.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 13049d4..6720bd0 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -4,4 +4,5 @@ ifeq ($(CONFIG_COMMON_CLK), y)
 obj-y += pll.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
+obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 endif
diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
new file mode 100644
index 0000000..88bf310
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM355
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
+static const struct davinci_pll_clk_info dm355_pll1_info __initconst = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(7, 0),
+	.pllm_min = 92,
+	.pllm_max = 184,
+	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED |
+		 PLL_PREDIV_FIXED8 | PLL_HAS_POSTDIV |
+		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
+};
+
+static const struct davinci_pll_sysclk_info dm355_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED),
+	{ }
+};
+
+static const struct davinci_pll_clk_info dm355_pll2_info __initconst = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(7, 0),
+	.pllm_min = 92,
+	.pllm_max = 184,
+	.flags = PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED | PLL_HAS_POSTDIV |
+		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
+};
+
+static const struct davinci_pll_sysclk_info dm355_pll2_sysclk_info[] __initconst = {
+	SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED),
+	{ }
+};
+
+int __init dm355_pll1_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &dm355_pll1_info, "ref_clk", base);
+
+	for (info = dm355_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
+
+	return 0;
+}
+
+int __init dm355_pll2_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &dm355_pll2_info, "oscin", base);
+
+	for (info = dm355_pll2_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll2_sysclkbp", base);
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 7c56397..f72ea30 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -756,6 +756,8 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 	{ .name = "da830-pll",   .driver_data = (kernel_ulong_t)da830_pll_init   },
 	{ .name = "da850-pll0",  .driver_data = (kernel_ulong_t)da850_pll0_init  },
 	{ .name = "da850-pll1",  .driver_data = (kernel_ulong_t)da850_pll1_init  },
+	{ .name = "dm355-pll1",  .driver_data = (kernel_ulong_t)dm355_pll1_init  },
+	{ .name = "dm355-pll2",  .driver_data = (kernel_ulong_t)dm355_pll2_init  },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 545a156..6bd73d7 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -126,4 +126,7 @@ int da850_pll1_init(struct device *dev, void __iomem *base);
 int of_da850_pll0_init(struct device *dev, void __iomem *base);
 int of_da850_pll1_init(struct device *dev, void __iomem *base);
 
+int dm355_pll1_init(struct device *dev, void __iomem *base);
+int dm355_pll2_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
