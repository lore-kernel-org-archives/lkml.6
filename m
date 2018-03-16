Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeCPCxu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:53:50 -0400
Received: from vern.gendns.com ([206.190.152.46]:55416 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933064AbeCPCxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:53:44 -0400
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
Subject: [PATCH v8 13/42] clk: davinci: Add platform information for TI DM355 PSC
Date: Thu, 15 Mar 2018 21:52:29 -0500
Message-Id: <1521168778-27236-14-git-send-email-david@lechnology.com>
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
DM355 based systems.

Signed-off-by: David Lechner <david@lechnology.com>
---

v8 changes:
- drop use of __init and __initconst attributes
- add parent clock mappings

v7 changes:
- split registration function into two, one for each PSC
- add platform_device_id table
- don't wrap lines for readability
- add LPSC_ALWAYS_ENABLED flag to timer0 clock

v6 changes:
- change how clkdev lookups are declared

 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/psc-dm355.c | 88 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/psc.c       |  1 +
 drivers/clk/davinci/psc.h       |  1 +
 4 files changed, 91 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-dm355.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index aef0390..e0da5c3 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -12,4 +12,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
 obj-y += psc.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
+obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
 endif
diff --git a/drivers/clk/davinci/psc-dm355.c b/drivers/clk/davinci/psc-dm355.c
new file mode 100644
index 0000000..249a053
--- /dev/null
+++ b/drivers/clk/davinci/psc-dm355.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DaVinci DM355
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
+LPSC_CLKDEV1(vpss_master_clkdev,	"master",	"vpss");
+LPSC_CLKDEV1(vpss_slave_clkdev,		"slave",	"vpss");
+LPSC_CLKDEV1(spi1_clkdev,		NULL,		"spi_davinci.1");
+LPSC_CLKDEV1(mmcsd1_clkdev,		NULL,		"dm6441-mmc.1");
+LPSC_CLKDEV1(mcbsp1_clkdev,		NULL,		"davinci-mcbsp.1");
+LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
+LPSC_CLKDEV1(spi2_clkdev,		NULL,		"spi_davinci.2");
+LPSC_CLKDEV1(aemif_clkdev,		"aemif",	NULL);
+LPSC_CLKDEV1(mmcsd0_clkdev,		NULL,		"dm6441-mmc.0");
+LPSC_CLKDEV1(mcbsp0_clkdev,		NULL,		"davinci-mcbsp.0");
+LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
+LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
+LPSC_CLKDEV1(uart1_clkdev,		NULL,		"serial8250.1");
+LPSC_CLKDEV1(uart2_clkdev,		NULL,		"serial8250.2");
+LPSC_CLKDEV1(spi0_clkdev,		NULL,		"spi_davinci.0");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,		"gpio",		NULL);
+LPSC_CLKDEV1(timer0_clkdev,		"timer0",	NULL);
+LPSC_CLKDEV1(timer2_clkdev,		NULL,		"davinci-wdt");
+LPSC_CLKDEV1(vpss_dac_clkdev,		"vpss_dac",	NULL);
+
+static const struct davinci_lpsc_clk_info dm355_psc_info[] = {
+	LPSC(0,  0, vpss_master, pll1_sysclk4, vpss_master_clkdev, 0),
+	LPSC(1,  0, vpss_slave,  pll1_sysclk4, vpss_slave_clkdev,  0),
+	LPSC(5,  0, timer3,      pll1_auxclk,  NULL,               0),
+	LPSC(6,  0, spi1,        pll1_sysclk2, spi1_clkdev,        0),
+	LPSC(7,  0, mmcsd1,      pll1_sysclk2, mmcsd1_clkdev,      0),
+	LPSC(8,  0, asp1,        pll1_sysclk2, NULL,               0),
+	LPSC(9,  0, usb,         pll1_sysclk2, usb_clkdev,         0),
+	LPSC(10, 0, pwm3,        pll1_auxclk,  NULL,               0),
+	LPSC(11, 0, spi2,        pll1_sysclk2, spi2_clkdev,        0),
+	LPSC(12, 0, rto,         pll1_auxclk,  NULL,               0),
+	LPSC(14, 0, aemif,       pll1_sysclk2, aemif_clkdev,       0),
+	LPSC(15, 0, mmcsd0,      pll1_sysclk2, mmcsd0_clkdev,      0),
+	LPSC(17, 0, asp0,        pll1_sysclk2, NULL,               0),
+	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
+	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
+	LPSC(20, 0, uart1,       pll1_auxclk,  uart1_clkdev,       0),
+	LPSC(21, 0, uart2,       pll1_sysclk2, uart2_clkdev,       0),
+	LPSC(22, 0, spi0,        pll1_sysclk2, spi0_clkdev,        0),
+	LPSC(23, 0, pwm0,        pll1_auxclk,  NULL,               0),
+	LPSC(24, 0, pwm1,        pll1_auxclk,  NULL,               0),
+	LPSC(25, 0, pwm2,        pll1_auxclk,  NULL,               0),
+	LPSC(26, 0, gpio,        pll1_sysclk2, gpio_clkdev,        0),
+	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      LPSC_ALWAYS_ENABLED),
+	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
+	/* REVISIT: why can't this be disabled? */
+	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,      LPSC_ALWAYS_ENABLED),
+	LPSC(31, 0, arm,         pll1_sysclk1, NULL,               LPSC_ALWAYS_ENABLED),
+	LPSC(40, 0, mjcp,        pll1_sysclk1, NULL,               0),
+	LPSC(41, 0, vpss_dac,    pll1_sysclk3, vpss_dac_clkdev,    0),
+	{ }
+};
+
+static int dm355_psc_init(struct device *dev, void __iomem *base)
+{
+	return davinci_psc_register_clocks(base, dm355_psc_info, 42, base);
+}
+
+static struct clk_bulk_data dm355_psc_parent_clks[] = {
+	{ .id = "pll1_sysclk1" },
+	{ .id = "pll1_sysclk2" },
+	{ .id = "pll1_sysclk3" },
+	{ .id = "pll1_sysclk4" },
+	{ .id = "pll1_auxclk"  },
+};
+
+const struct davinci_psc_init_data dm355_psc_init_data = {
+	.parent_clks		= dm355_psc_parent_clks,
+	.num_parent_clks	= ARRAY_SIZE(dm355_psc_parent_clks),
+	.psc_init		= &dm355_psc_init,
+};
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index fa39536..0825b62 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -492,6 +492,7 @@ static const struct platform_device_id davinci_psc_id_table[] = {
 	{ .name = "da830-psc1", .driver_data = (kernel_ulong_t)&da830_psc1_init_data },
 	{ .name = "da850-psc0", .driver_data = (kernel_ulong_t)&da850_psc0_init_data },
 	{ .name = "da850-psc1", .driver_data = (kernel_ulong_t)&da850_psc1_init_data },
+	{ .name = "dm355-psc",  .driver_data = (kernel_ulong_t)&dm355_psc_init_data  },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index 476bd74..d672e72 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -100,5 +100,6 @@ extern const struct davinci_psc_init_data da850_psc0_init_data;
 extern const struct davinci_psc_init_data da850_psc1_init_data;
 extern const struct davinci_psc_init_data of_da850_psc0_init_data;
 extern const struct davinci_psc_init_data of_da850_psc1_init_data;
+extern const struct davinci_psc_init_data dm355_psc_init_data;
 
 #endif /* __CLK_DAVINCI_PSC_H__ */
-- 
2.7.4
