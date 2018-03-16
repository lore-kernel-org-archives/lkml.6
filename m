Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeCPDAX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:00:23 -0400
Received: from vern.gendns.com ([206.190.152.46]:55372 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753033AbeCPCxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:53:37 -0400
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
Subject: [PATCH v8 08/42] clk: davinci: Add platform information for TI DM646x PLL
Date: Thu, 15 Mar 2018 21:52:24 -0500
Message-Id: <1521168778-27236-9-git-send-email-david@lechnology.com>
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
DM646x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v8 changes:
- drop __init and __initconst attributes
- add a clkdev lookup for each SYSCLK
- drop fixed-factor clock for timer2

v7 changes:
- split registration functions for each PLL
- Add platform_device_id lookup

v6 changes:
- Added dm646x_pll{1,2}_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/pll-dm646x.c | 84 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c        |  2 +
 drivers/clk/davinci/pll.h        |  3 ++
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-dm646x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 59d8ab6..d471386 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -7,4 +7,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
 obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= pll-dm644x.o
+obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
 endif
diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
new file mode 100644
index 0000000..a61cc32
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm646x.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM646X
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_clk_info dm646x_pll1_info = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 14,
+	.pllm_max = 32,
+	.flags = PLL_HAS_CLKMODE,
+};
+
+SYSCLK(1, pll1_sysclk1, pll1_pllen, 4, SYSCLK_FIXED_DIV);
+SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV);
+SYSCLK(3, pll1_sysclk3, pll1_pllen, 4, SYSCLK_FIXED_DIV);
+SYSCLK(4, pll1_sysclk4, pll1_pllen, 4, 0);
+SYSCLK(5, pll1_sysclk5, pll1_pllen, 4, 0);
+SYSCLK(6, pll1_sysclk6, pll1_pllen, 4, 0);
+SYSCLK(8, pll1_sysclk8, pll1_pllen, 4, 0);
+SYSCLK(9, pll1_sysclk9, pll1_pllen, 4, 0);
+
+int dm646x_pll1_init(struct device *dev, void __iomem *base)
+{
+	struct clk *clk;
+
+	davinci_pll_clk_register(dev, &dm646x_pll1_info, "ref_clk", base);
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
+	clk_register_clkdev(clk, "pll1_sysclk1", "dm646x-psc");
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk2, base);
+	clk_register_clkdev(clk, "pll1_sysclk2", "dm646x-psc");
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk3, base);
+	clk_register_clkdev(clk, "pll1_sysclk3", "dm646x-psc");
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk4, base);
+	clk_register_clkdev(clk, "pll1_sysclk4", "dm646x-psc");
+
+	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk5, base);
+	clk_register_clkdev(clk, "pll1_sysclk5", "dm646x-psc");
+
+	davinci_pll_sysclk_register(dev, &pll1_sysclk6, base);
+
+	davinci_pll_sysclk_register(dev, &pll1_sysclk8, base);
+
+	davinci_pll_sysclk_register(dev, &pll1_sysclk9, base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
+
+	davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
+
+	return 0;
+}
+
+static const struct davinci_pll_clk_info dm646x_pll2_info = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 14,
+	.pllm_max = 32,
+	.flags = 0,
+};
+
+SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
+
+int dm646x_pll2_init(struct device *dev, void __iomem *base)
+{
+	davinci_pll_clk_register(dev, &dm646x_pll2_info, "oscin", base);
+
+	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 0a1e68f..588a489 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -786,6 +786,8 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 	{ .name = "dm365-pll2",  .driver_data = (kernel_ulong_t)dm365_pll2_init  },
 	{ .name = "dm644x-pll1", .driver_data = (kernel_ulong_t)dm644x_pll1_init },
 	{ .name = "dm644x-pll2", .driver_data = (kernel_ulong_t)dm644x_pll2_init },
+	{ .name = "dm646x-pll1", .driver_data = (kernel_ulong_t)dm646x_pll1_init },
+	{ .name = "dm646x-pll2", .driver_data = (kernel_ulong_t)dm646x_pll2_init },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index d8af4f5..b1b6fb2 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -135,4 +135,7 @@ int dm365_pll2_init(struct device *dev, void __iomem *base);
 int dm644x_pll1_init(struct device *dev, void __iomem *base);
 int dm644x_pll2_init(struct device *dev, void __iomem *base);
 
+int dm646x_pll1_init(struct device *dev, void __iomem *base);
+int dm646x_pll2_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
