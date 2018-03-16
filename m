Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeCPC5S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:57:18 -0400
Received: from vern.gendns.com ([206.190.152.46]:55442 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933118AbeCPCxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:53:50 -0400
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
Subject: [PATCH v8 16/42] clk: davinci: Add platform information for TI DM646x PSC
Date: Thu, 15 Mar 2018 21:52:32 -0500
Message-Id: <1521168778-27236-17-git-send-email-david@lechnology.com>
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

This adds platform-specific declarations for the PSC clocks on TI
DM646x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v8 changes:
- drop use of __init and __initconst attributes
- add parent clock mappings

v7 changes:
- add platform_device_id table
- don't wrap lines for readability
- add LPSC_ALWAYS_ENABLED flag to timer0 clock

v6 changes:
- change how clkdev lookups are declared

 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/psc-dm646x.c | 80 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/psc.c        |  1 +
 drivers/clk/davinci/psc.h        |  1 +
 4 files changed, 83 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-dm646x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index a20e379..6c388d4 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -15,4 +15,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= psc-dm365.o
 obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= psc-dm644x.o
+obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= psc-dm646x.o
 endif
diff --git a/drivers/clk/davinci/psc-dm646x.c b/drivers/clk/davinci/psc-dm646x.c
new file mode 100644
index 0000000..468ef86
--- /dev/null
+++ b/drivers/clk/davinci/psc-dm646x.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DaVinci DM646x
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "psc.h"
+
+LPSC_CLKDEV1(ide_clkdev,	NULL,		"palm_bk3710");
+LPSC_CLKDEV2(emac_clkdev,	NULL,		"davinci_emac.1",
+				"fck",		"davinci_mdio.0");
+LPSC_CLKDEV1(aemif_clkdev,	"aemif",	NULL);
+LPSC_CLKDEV1(mcasp0_clkdev,	NULL,		"davinci-mcasp.0");
+LPSC_CLKDEV1(mcasp1_clkdev,	NULL,		"davinci-mcasp.1");
+LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
+LPSC_CLKDEV1(uart1_clkdev,	NULL,		"serial8250.1");
+LPSC_CLKDEV1(uart2_clkdev,	NULL,		"serial8250.2");
+LPSC_CLKDEV1(i2c_clkdev,	NULL,		"i2c_davinci.1");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,	"gpio",		NULL);
+LPSC_CLKDEV1(timer0_clkdev,	"timer0",	 NULL);
+
+static const struct davinci_lpsc_clk_info dm646x_psc_info[] = {
+	LPSC(0,  0, arm,      pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	/* REVISIT how to disable? */
+	LPSC(1,  0, dsp,      pll1_sysclk1, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(4,  0, edma_cc,  pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(5,  0, edma_tc0, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(6,  0, edma_tc1, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(7,  0, edma_tc2, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(8,  0, edma_tc3, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(10, 0, ide,      pll1_sysclk4, ide_clkdev,    0),
+	LPSC(14, 0, emac,     pll1_sysclk3, emac_clkdev,   0),
+	LPSC(16, 0, vpif0,    ref_clk,      NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(17, 0, vpif1,    ref_clk,      NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(21, 0, aemif,    pll1_sysclk3, aemif_clkdev,  LPSC_ALWAYS_ENABLED),
+	LPSC(22, 0, mcasp0,   pll1_sysclk3, mcasp0_clkdev, 0),
+	LPSC(23, 0, mcasp1,   pll1_sysclk3, mcasp1_clkdev, 0),
+	LPSC(26, 0, uart0,    aux_clkin,    uart0_clkdev,  0),
+	LPSC(27, 0, uart1,    aux_clkin,    uart1_clkdev,  0),
+	LPSC(28, 0, uart2,    aux_clkin,    uart2_clkdev,  0),
+	/* REVIST: disabling hangs system */
+	LPSC(29, 0, pwm0,     pll1_sysclk3, NULL,          LPSC_ALWAYS_ENABLED),
+	/* REVIST: disabling hangs system */
+	LPSC(30, 0, pwm1,     pll1_sysclk3, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(31, 0, i2c,      pll1_sysclk3, i2c_clkdev,    0),
+	LPSC(33, 0, gpio,     pll1_sysclk3, gpio_clkdev,   0),
+	LPSC(34, 0, timer0,   pll1_sysclk3, timer0_clkdev, LPSC_ALWAYS_ENABLED),
+	LPSC(35, 0, timer1,   pll1_sysclk3, NULL,          0),
+	{ }
+};
+
+static int dm646x_psc_init(struct device *dev, void __iomem *base)
+{
+	return davinci_psc_register_clocks(dev, dm646x_psc_info, 46, base);
+}
+
+static struct clk_bulk_data dm646x_psc_parent_clks[] = {
+	{ .id = "ref_clk"      },
+	{ .id = "aux_clkin"    },
+	{ .id = "pll1_sysclk1" },
+	{ .id = "pll1_sysclk2" },
+	{ .id = "pll1_sysclk3" },
+	{ .id = "pll1_sysclk4" },
+	{ .id = "pll1_sysclk5" },
+};
+
+const struct davinci_psc_init_data dm646x_psc_init_data = {
+	.parent_clks		= dm646x_psc_parent_clks,
+	.num_parent_clks	= ARRAY_SIZE(dm646x_psc_parent_clks),
+	.psc_init		= &dm646x_psc_init,
+};
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 6520938..3b0e59d 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -495,6 +495,7 @@ static const struct platform_device_id davinci_psc_id_table[] = {
 	{ .name = "dm355-psc",  .driver_data = (kernel_ulong_t)&dm355_psc_init_data  },
 	{ .name = "dm365-psc",  .driver_data = (kernel_ulong_t)&dm365_psc_init_data  },
 	{ .name = "dm644x-psc", .driver_data = (kernel_ulong_t)&dm644x_psc_init_data },
+	{ .name = "dm646x-psc", .driver_data = (kernel_ulong_t)&dm646x_psc_init_data },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index d665cb0..c2a7df6 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -103,5 +103,6 @@ extern const struct davinci_psc_init_data of_da850_psc1_init_data;
 extern const struct davinci_psc_init_data dm355_psc_init_data;
 extern const struct davinci_psc_init_data dm365_psc_init_data;
 extern const struct davinci_psc_init_data dm644x_psc_init_data;
+extern const struct davinci_psc_init_data dm646x_psc_init_data;
 
 #endif /* __CLK_DAVINCI_PSC_H__ */
-- 
2.7.4
