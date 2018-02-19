Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeBSUbm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:31:42 -0500
Received: from vern.gendns.com ([206.190.152.46]:58414 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeBSUWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:42 -0500
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
Subject: [PATCH v7 03/42] clk: davinci: Add platform information for TI DA830 PLL
Date: Mon, 19 Feb 2018 14:21:24 -0600
Message-Id: <1519071723-31790-4-git-send-email-david@lechnology.com>
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

This adds platform-specific declarations for the PLL clocks on TI DA830/
OMAP-L137/AM17XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- include clkdev lookup registration here instead of in mach-davinci
- Add platform_device_id lookup

v6 changes:
- Added da830_pll_info with controller-specific information
- Add empty lines between function calls

 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/pll-da830.c | 58 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c       |  1 +
 drivers/clk/davinci/pll.h       |  4 +++
 4 files changed, 64 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-da830.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index d9673bd..9061e19 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -2,4 +2,5 @@
 
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-y += pll.o
+obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 endif
diff --git a/drivers/clk/davinci/pll-da830.c b/drivers/clk/davinci/pll-da830.c
new file mode 100644
index 0000000..240b17a
--- /dev/null
+++ b/drivers/clk/davinci/pll-da830.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DA830/OMAP-L137/AM17XX
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clkdev.h>
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+static const struct davinci_pll_clk_info da830_pll_info __initconst = {
+	.name = "pll0",
+	.pllm_mask = GENMASK(4, 0),
+	.pllm_min = 4,
+	.pllm_max = 32,
+	.pllout_min_rate = 300000000,
+	.pllout_max_rate = 600000000,
+	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
+};
+
+/*
+ * NB: Technically, the clocks flagged as SYSCLK_FIXED_DIV are "fixed ratio",
+ * meaning that we could change the divider as long as we keep the correct
+ * ratio between all of the clocks, but we don't support that because there is
+ * currently not a need for it.
+ */
+
+static const struct davinci_pll_sysclk_info da830_pll_sysclk_info[] __initconst = {
+	SYSCLK(2, pll0_sysclk2, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(3, pll0_sysclk3, pll0_pllen, 5, 0),
+	SYSCLK(4, pll0_sysclk4, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(5, pll0_sysclk5, pll0_pllen, 5, 0),
+	SYSCLK(6, pll0_sysclk6, pll0_pllen, 5, SYSCLK_FIXED_DIV),
+	SYSCLK(7, pll0_sysclk7, pll0_pllen, 5, 0),
+	{ }
+};
+
+int __init da830_pll_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+	struct clk *clk;
+
+	davinci_pll_clk_register(dev, &da830_pll_info, "ref_clk", base);
+
+	clk = davinci_pll_auxclk_register(dev, "pll0_auxclk", base);
+	clk_register_clkdev(clk, NULL, "i2c_davinci.1");
+	clk_register_clkdev(clk, "timer0", NULL);
+	clk_register_clkdev(clk, NULL, "davinci-wdt");
+
+	for (info = da830_pll_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index e4f3e5f..9a22511 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -751,6 +751,7 @@ static const struct of_device_id davinci_pll_of_match[] = {
 };
 
 static const struct platform_device_id davinci_pll_id_table[] = {
+	{ .name = "da830-pll",   .driver_data = (kernel_ulong_t)da830_pll_init   },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 50fe429..5c4c5c8 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -117,4 +117,8 @@ int of_davinci_pll_init(struct device *dev,
 			u8 max_sysclk_id,
 			void __iomem *base);
 
+/* Platform-specific callbacks */
+
+int da830_pll_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
