Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeCPDBG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:01:06 -0400
Received: from vern.gendns.com ([206.190.152.46]:55344 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932912AbeCPCxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:53:32 -0400
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
Subject: [PATCH v8 05/42] clk: davinci: Add platform information for TI DM355 PLL
Date: Thu, 15 Mar 2018 21:52:21 -0500
Message-Id: <1521168778-27236-6-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521168778-27236-1-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
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

v8 changes:
- drop __init and __initconst attributes
- add a clkdev lookup for each SYSCLK

v7 changes:
- split registration functions for each PLL
- Add platform_device_id lookup

v6 changes:
- Added dm355_pll{1,2}_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/pll-dm355.c | 79 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c       |  2 ++
 drivers/clk/davinci/pll.h       |  3 ++
 4 files changed, 85 insertions(+)
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
index 0000000..5345f82
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM355
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_clk_info dm355_pll1_info = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(7, 0),
+	.pllm_min = 92,
+	.pllm_max = 184,
+	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED |
+		 PLL_PREDIV_FIXED8 | PLL_HAS_POSTDIV |
+		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
+};
+
+SYSCLK(1, pll1_sysclk1, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(2, pll1_sysclk2, pll1, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(3, pll1_sysclk3, pll1, 5, SYSCLK_ALWAYS_ENABLED);
+SYSCLK(4, pll1_sysclk4, pll1, 5, SYSCLK_ALWAYS_ENABLED);
+
+int dm355_pll1_init(struct device *dev, void __iomem *base)
+{
+	struct clk *clk;
+
+	davinci_pll_clk_register(dev, &dm355_pll1_info, "ref_clk", base);
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
+	clk_register_clkdev(clk, "pll1_sysclk1", "dm355-psc");
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk2, base);
+	clk_register_clkdev(clk, "pll1_sysclk2", "dm355-psc");
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk3, base);
+	clk_register_clkdev(clk, "pll1_sysclk3", "dm355-psc");
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk4, base);
+	clk_register_clkdev(clk, "pll1_sysclk4", "dm355-psc");
+
+	clk = davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
+	clk_register_clkdev(clk, "pll1_auxclk", "dm355-psc");
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
+
+	return 0;
+}
+
+static const struct davinci_pll_clk_info dm355_pll2_info = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(7, 0),
+	.pllm_min = 92,
+	.pllm_max = 184,
+	.flags = PLL_HAS_PREDIV | PLL_PREDIV_ALWAYS_ENABLED | PLL_HAS_POSTDIV |
+		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
+};
+
+SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV);
+SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+
+int dm355_pll2_init(struct device *dev, void __iomem *base)
+{
+	davinci_pll_clk_register(dev, &dm355_pll2_info, "oscin", base);
+
+	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
+
+	davinci_pll_sysclk_register(dev, &pll2_sysclk2, base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll2_sysclkbp", base);
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 535f725..305d2e9 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -780,6 +780,8 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 	{ .name = "da830-pll",   .driver_data = (kernel_ulong_t)da830_pll_init   },
 	{ .name = "da850-pll0",  .driver_data = (kernel_ulong_t)da850_pll0_init  },
 	{ .name = "da850-pll1",  .driver_data = (kernel_ulong_t)da850_pll1_init  },
+	{ .name = "dm355-pll1",  .driver_data = (kernel_ulong_t)dm355_pll1_init  },
+	{ .name = "dm355-pll2",  .driver_data = (kernel_ulong_t)dm355_pll2_init  },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 53b8d51..d90d308 100644
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
