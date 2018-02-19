Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeBSUXJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:23:09 -0500
Received: from vern.gendns.com ([206.190.152.46]:58525 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932116AbeBSUXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:23:01 -0500
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
Subject: [PATCH v7 15/42] clk: davinci: Add platform information for TI DM644x PSC
Date: Mon, 19 Feb 2018 14:21:36 -0600
Message-Id: <1519071723-31790-16-git-send-email-david@lechnology.com>
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

This adds platform-specific declarations for the PSC clocks on TI
DM644x based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- add platform_device_id table
- don't wrap lines for readability
- add LPSC_ALWAYS_ENABLED flag to timer0 clock

v6 changes:
- change how clkdev lookups are declared


 drivers/clk/davinci/Makefile     |  1 +
 drivers/clk/davinci/psc-dm644x.c | 67 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/psc.c        |  1 +
 drivers/clk/davinci/psc.h        |  1 +
 4 files changed, 70 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-dm644x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 78dc1eb..a20e379 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= psc-dm365.o
+obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= psc-dm644x.o
 endif
diff --git a/drivers/clk/davinci/psc-dm644x.c b/drivers/clk/davinci/psc-dm644x.c
new file mode 100644
index 0000000..68bf48d
--- /dev/null
+++ b/drivers/clk/davinci/psc-dm644x.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DaVinci DM644x
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/types.h>
+
+#include "psc.h"
+
+LPSC_CLKDEV1(vpss_master_clkdev,	"master",	"vpss");
+LPSC_CLKDEV1(vpss_slave_clkdev,		"slave",	"vpss");
+LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
+					"fck",		"davinci_mdio.0");
+LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
+LPSC_CLKDEV1(ide_clkdev,		NULL,		"palm_bk3710");
+LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV1(mmcsd_clkdev,		NULL,		"dm6441-mmc.0");
+LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
+LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
+LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
+LPSC_CLKDEV1(uart1_clkdev,		NULL,		"serial8250.1");
+LPSC_CLKDEV1(uart2_clkdev,		NULL,		"serial8250.2");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,		"gpio",		NULL);
+LPSC_CLKDEV1(timer0_clkdev,		"timer0",	NULL);
+LPSC_CLKDEV1(timer2_clkdev,		NULL,		"davinci-wdt");
+
+static const struct davinci_lpsc_clk_info dm644x_psc_info[] __initconst = {
+	LPSC(0,  0, vpss_master, pll1_sysclk3, vpss_master_clkdev, 0),
+	LPSC(1,  0, vpss_slave,  pll1_sysclk3, vpss_slave_clkdev,  0),
+	LPSC(6,  0, emac,        pll1_sysclk5, emac_clkdev,        0),
+	LPSC(9,  0, usb,         pll1_sysclk5, usb_clkdev,         0),
+	LPSC(10, 0, ide,         pll1_sysclk5, ide_clkdev,         0),
+	LPSC(11, 0, vlynq,       pll1_sysclk5, NULL,               0),
+	LPSC(14, 0, aemif,       pll1_sysclk5, aemif_clkdev,       0),
+	LPSC(15, 0, mmcsd,       pll1_sysclk5, mmcsd_clkdev,       0),
+	LPSC(17, 0, asp0,        pll1_sysclk5, asp0_clkdev,        0),
+	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
+	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
+	LPSC(20, 0, uart1,       pll1_auxclk,  uart1_clkdev,       0),
+	LPSC(21, 0, uart2,       pll1_auxclk,  uart2_clkdev,       0),
+	LPSC(22, 0, spi,         pll1_sysclk5, NULL,               0),
+	LPSC(23, 0, pwm0,        pll1_auxclk,  NULL,               0),
+	LPSC(24, 0, pwm1,        pll1_auxclk,  NULL,               0),
+	LPSC(25, 0, pwm2,        pll1_auxclk,  NULL,               0),
+	LPSC(26, 0, gpio,        pll1_sysclk5, gpio_clkdev,        0),
+	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      LPSC_ALWAYS_ENABLED),
+	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
+	/* REVISIT: why can't this be disabled? */
+	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,      LPSC_ALWAYS_ENABLED),
+	LPSC(31, 0, arm,         pll1_sysclk2, NULL,               LPSC_ALWAYS_ENABLED),
+	/* REVISIT how to disable? */
+	LPSC(39, 1, dsp,         pll1_sysclk1, NULL,               LPSC_ALWAYS_ENABLED),
+	/* REVISIT how to disable? */
+	LPSC(40, 1, vicp,        pll1_sysclk2, NULL,               LPSC_ALWAYS_ENABLED),
+	{ }
+};
+
+int __init dm644x_psc_init(struct device *dev, void __iomem *base)
+{
+	return davinci_psc_register_clocks(dev, dm644x_psc_info, 41, base);
+}
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 5f5fc10..29422d6 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -451,6 +451,7 @@ static const struct platform_device_id davinci_psc_id_table[] = {
 	{ .name = "da850-psc1", .driver_data = (kernel_ulong_t)da850_psc1_init },
 	{ .name = "dm355-psc",  .driver_data = (kernel_ulong_t)dm355_psc_init  },
 	{ .name = "dm365-psc",  .driver_data = (kernel_ulong_t)dm365_psc_init  },
+	{ .name = "dm644x-psc", .driver_data = (kernel_ulong_t)dm644x_psc_init },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index 14caccf..41266af5b 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -95,5 +95,6 @@ int of_da850_psc0_init(struct device *dev, void __iomem *base);
 int of_da850_psc1_init(struct device *dev, void __iomem *base);
 int dm355_psc_init(struct device *dev, void __iomem *base);
 int dm365_psc_init(struct device *dev, void __iomem *base);
+int dm644x_psc_init(struct device *dev, void __iomem *base);
 
 #endif /* __CLK_DAVINCI_PSC_H__ */
-- 
2.7.4
