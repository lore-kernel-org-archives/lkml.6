Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeBSUWt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:22:49 -0500
Received: from vern.gendns.com ([206.190.152.46]:58441 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbeBSUWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:46 -0500
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
Subject: [PATCH v7 06/42] clk: davinci: Add platform information for TI DM365 PLL
Date: Mon, 19 Feb 2018 14:21:27 -0600
Message-Id: <1519071723-31790-7-git-send-email-david@lechnology.com>
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
DM365 based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- split registration functions for each PLL
- Add platform_device_id lookup

v6 changes:
- Added dm365_pll{1,2}_info with controller-specific information
- Changed OBSCLK data
- Add empty lines between function calls


 drivers/clk/davinci/Makefile    |   1 +
 drivers/clk/davinci/pll-dm365.c | 119 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/pll.c       |   2 +
 drivers/clk/davinci/pll.h       |   3 +
 4 files changed, 125 insertions(+)
 create mode 100644 drivers/clk/davinci/pll-dm365.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 6720bd0..353aa02 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -5,4 +5,5 @@ obj-y += pll.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
+obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
 endif
diff --git a/drivers/clk/davinci/pll-dm365.c b/drivers/clk/davinci/pll-dm365.c
new file mode 100644
index 0000000..8654ca7
--- /dev/null
+++ b/drivers/clk/davinci/pll-dm365.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLL clock descriptions for TI DM365
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "pll.h"
+
+#define OCSEL_OCSRC_ENABLE	0
+
+static const struct davinci_pll_clk_info dm365_pll1_info __initconst = {
+	.name = "pll1",
+	.pllm_mask = GENMASK(9, 0),
+	.pllm_min = 1,
+	.pllm_max = 1023,
+	.flags = PLL_HAS_CLKMODE | PLL_HAS_PREDIV | PLL_HAS_POSTDIV |
+		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_PLLM_2X,
+};
+
+static const struct davinci_pll_sysclk_info dm365_pll1_sysclk_info[] __initconst = {
+	SYSCLK(1, pll1_sysclk1, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(2, pll1_sysclk2, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(3, pll1_sysclk3, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(4, pll1_sysclk4, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(5, pll1_sysclk5, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(6, pll1_sysclk6, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(7, pll1_sysclk7, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(8, pll1_sysclk8, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(9, pll1_sysclk9, pll1_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	{ }
+};
+
+/*
+ * This is a bit of a hack to make OCSEL[OCSRC] on DM365 look like OCSEL[OCSRC]
+ * on DA850. On DM365, OCSEL[OCSRC] is just an enable/disable bit instead of a
+ * multiplexer. By modeling it as a single parent mux clock, the clock code will
+ * still do the right thing in this case.
+ */
+static const char * const dm365_pll_obsclk_parent_names[] __initconst = {
+	"oscin",
+};
+
+static u32 dm365_pll_obsclk_table[] = {
+	OCSEL_OCSRC_ENABLE,
+};
+
+static const struct davinci_pll_obsclk_info dm365_pll1_obsclk_info __initconst = {
+	.name = "pll1_obsclk",
+	.parent_names = dm365_pll_obsclk_parent_names,
+	.num_parents = ARRAY_SIZE(dm365_pll_obsclk_parent_names),
+	.table = dm365_pll_obsclk_table,
+	.ocsrc_mask = BIT(4),
+};
+
+static const struct davinci_pll_clk_info dm365_pll2_info __initconst = {
+	.name = "pll2",
+	.pllm_mask = GENMASK(9, 0),
+	.pllm_min = 1,
+	.pllm_max = 1023,
+	.flags = PLL_HAS_PREDIV | PLL_HAS_POSTDIV | PLL_POSTDIV_ALWAYS_ENABLED |
+		 PLL_PLLM_2X,
+};
+
+static const struct davinci_pll_sysclk_info dm365_pll2_sysclk_info[] __initconst = {
+	SYSCLK(1, pll2_sysclk1, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(2, pll2_sysclk2, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(3, pll2_sysclk3, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(4, pll2_sysclk4, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	SYSCLK(5, pll2_sysclk5, pll2_pllen, 5, SYSCLK_ALWAYS_ENABLED),
+	{ }
+};
+
+static const struct davinci_pll_obsclk_info dm365_pll2_obsclk_info __initconst = {
+	.name = "pll2_obsclk",
+	.parent_names = dm365_pll_obsclk_parent_names,
+	.num_parents = ARRAY_SIZE(dm365_pll_obsclk_parent_names),
+	.table = dm365_pll_obsclk_table,
+	.ocsrc_mask = BIT(4),
+};
+
+int __init dm365_pll1_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &dm365_pll1_info, "ref_clk", base);
+
+	davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
+
+	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
+
+	davinci_pll_obsclk_register(dev, &dm365_pll1_obsclk_info, base);
+
+	for (info = dm365_pll1_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	return 0;
+}
+
+int __init dm365_pll2_init(struct device *dev, void __iomem *base)
+{
+	const struct davinci_pll_sysclk_info *info;
+
+	davinci_pll_clk_register(dev, &dm365_pll2_info, "oscin", base);
+
+	davinci_pll_auxclk_register(dev, "pll2_auxclk", base);
+
+	davinci_pll_obsclk_register(dev, &dm365_pll2_obsclk_info, base);
+
+	for (info = dm365_pll2_sysclk_info; info->name; info++)
+		davinci_pll_sysclk_register(dev, info, base);
+
+	return 0;
+}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index f72ea30..c8dd3fa 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -758,6 +758,8 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 	{ .name = "da850-pll1",  .driver_data = (kernel_ulong_t)da850_pll1_init  },
 	{ .name = "dm355-pll1",  .driver_data = (kernel_ulong_t)dm355_pll1_init  },
 	{ .name = "dm355-pll2",  .driver_data = (kernel_ulong_t)dm355_pll2_init  },
+	{ .name = "dm365-pll1",  .driver_data = (kernel_ulong_t)dm365_pll1_init  },
+	{ .name = "dm365-pll2",  .driver_data = (kernel_ulong_t)dm365_pll2_init  },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 6bd73d7..b911c8a 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -129,4 +129,7 @@ int of_da850_pll1_init(struct device *dev, void __iomem *base);
 int dm355_pll1_init(struct device *dev, void __iomem *base);
 int dm355_pll2_init(struct device *dev, void __iomem *base);
 
+int dm365_pll1_init(struct device *dev, void __iomem *base);
+int dm365_pll2_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PLL_H___ */
-- 
2.7.4
