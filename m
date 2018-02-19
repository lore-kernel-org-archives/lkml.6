Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932297AbeBSU1u (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:27:50 -0500
Received: from vern.gendns.com ([206.190.152.46]:58492 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932075AbeBSUWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:22:53 -0500
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
Subject: [PATCH v7 11/42] clk: davinci: Add platform information for TI DA830 PSC
Date: Mon, 19 Feb 2018 14:21:32 -0600
Message-Id: <1519071723-31790-12-git-send-email-david@lechnology.com>
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

This adds platform-specific declarations for the PSC clocks on TI DA830/
OMAP-L137/AM17XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- split registration function into two, one for each PSC
- add platform_device_id table

v6 changes:
- change how clkdev lookups are declared


 drivers/clk/davinci/Makefile    |  1 +
 drivers/clk/davinci/psc-da830.c | 89 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/psc.c       |  2 +
 drivers/clk/davinci/psc.h       |  4 ++
 4 files changed, 96 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-da830.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index cd1bf2c..fb14c8c 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= pll-dm644x.o
 obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
 
 obj-y += psc.o
+obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 endif
diff --git a/drivers/clk/davinci/psc-da830.c b/drivers/clk/davinci/psc-da830.c
new file mode 100644
index 0000000..89e6e10
--- /dev/null
+++ b/drivers/clk/davinci/psc-da830.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DA830/OMAP-L137/AM17XX
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
+LPSC_CLKDEV1(spi0_clkdev,	NULL,	"spi_davinci.0");
+LPSC_CLKDEV1(mmcsd_clkdev,	NULL,	"da830-mmc.0");
+LPSC_CLKDEV1(uart0_clkdev,	NULL,	"serial8250.0");
+
+static const struct davinci_lpsc_clk_info da830_psc0_info[] __initconst = {
+	LPSC(0,  0, tpcc,     pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(1,  0, tptc0,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(2,  0, tptc1,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(3,  0, aemif,    pll0_sysclk3, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(4,  0, spi0,     pll0_sysclk2, spi0_clkdev,  0),
+	LPSC(5,  0, mmcsd,    pll0_sysclk2, mmcsd_clkdev, 0),
+	LPSC(6,  0, aintc,    pll0_sysclk4, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(7,  0, arm_rom,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(8,  0, secu_mgr, pll0_sysclk4, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(9,  0, uart0,    pll0_sysclk2, uart0_clkdev, 0),
+	LPSC(10, 0, scr0_ss,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(11, 0, scr1_ss,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(12, 0, scr2_ss,  pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(13, 0, pruss,    pll0_sysclk2, NULL,         LPSC_ALWAYS_ENABLED),
+	LPSC(14, 0, arm,      pll0_sysclk6, NULL,         LPSC_ALWAYS_ENABLED),
+	{ }
+};
+
+LPSC_CLKDEV2(usb0_clkdev,	NULL,	"musb-da8xx",
+				NULL,	"cppi41-dmaengine");
+LPSC_CLKDEV1(usb1_clkdev,	NULL,	"ohci-da8xx");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,	"gpio",	NULL);
+LPSC_CLKDEV2(emac_clkdev,	NULL,	"davinci_emac.1",
+				"fck",	"davinci_mdio.0");
+LPSC_CLKDEV1(mcasp0_clkdev,	NULL,	"davinci-mcasp.0");
+LPSC_CLKDEV1(mcasp1_clkdev,	NULL,	"davinci-mcasp.1");
+LPSC_CLKDEV1(mcasp2_clkdev,	NULL,	"davinci-mcasp.2");
+LPSC_CLKDEV1(spi1_clkdev,	NULL,	"spi_davinci.1");
+LPSC_CLKDEV1(i2c1_clkdev,	NULL,	"i2c_davinci.2");
+LPSC_CLKDEV1(uart1_clkdev,	NULL,	"serial8250.1");
+LPSC_CLKDEV1(uart2_clkdev,	NULL,	"serial8250.2");
+LPSC_CLKDEV1(lcdc_clkdev,	"fck",	"da8xx_lcdc.0");
+LPSC_CLKDEV2(pwm_clkdev,	"fck",	"ehrpwm.0",
+				"fck",	"ehrpwm.1");
+LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
+				"fck",	"ecap.1",
+				"fck",	"ecap.2");
+LPSC_CLKDEV2(eqep_clkdev,	NULL,	"eqep.0",
+				NULL,	"eqep.1");
+
+static const struct davinci_lpsc_clk_info da830_psc1_info[] __initconst = {
+	LPSC(1,  0, usb0,   pll0_sysclk2, usb0_clkdev,   0),
+	LPSC(2,  0, usb1,   pll0_sysclk4, usb1_clkdev,   0),
+	LPSC(3,  0, gpio,   pll0_sysclk4, gpio_clkdev,   0),
+	LPSC(5,  0, emac,   pll0_sysclk4, emac_clkdev,   0),
+	LPSC(6,  0, emif3,  pll0_sysclk5, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(7,  0, mcasp0, pll0_sysclk2, mcasp0_clkdev, 0),
+	LPSC(8,  0, mcasp1, pll0_sysclk2, mcasp1_clkdev, 0),
+	LPSC(9,  0, mcasp2, pll0_sysclk2, mcasp2_clkdev, 0),
+	LPSC(10, 0, spi1,   pll0_sysclk2, spi1_clkdev,   0),
+	LPSC(11, 0, i2c1,   pll0_sysclk4, i2c1_clkdev,   0),
+	LPSC(12, 0, uart1,  pll0_sysclk2, uart1_clkdev,  0),
+	LPSC(13, 0, uart2,  pll0_sysclk2, uart2_clkdev,  0),
+	LPSC(16, 0, lcdc,   pll0_sysclk2, lcdc_clkdev,   0),
+	LPSC(17, 0, pwm,    pll0_sysclk2, pwm_clkdev,    0),
+	LPSC(20, 0, ecap,   pll0_sysclk2, ecap_clkdev,   0),
+	LPSC(21, 0, eqep,   pll0_sysclk2, eqep_clkdev,   0),
+	{ }
+};
+
+int __init da830_psc0_init(struct device *dev, void __iomem *base)
+{
+	return davinci_psc_register_clocks(dev, da830_psc0_info, 16, base);
+}
+
+int __init da830_psc1_init(struct device *dev, void __iomem *base)
+{
+	return davinci_psc_register_clocks(dev, da830_psc1_info, 32, base);
+}
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 8e08ac8..c4310af 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -443,6 +443,8 @@ static const struct of_device_id davinci_psc_of_match[] = {
 };
 
 static const struct platform_device_id davinci_psc_id_table[] = {
+	{ .name = "da830-psc0", .driver_data = (kernel_ulong_t)da830_psc0_init },
+	{ .name = "da830-psc1", .driver_data = (kernel_ulong_t)da830_psc1_init },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index c342d54..c165cee 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -86,4 +86,8 @@ int of_davinci_psc_clk_init(struct device *dev,
 			    u8 num_clks,
 			    void __iomem *base);
 
+/* Device-specific callbacks */
+int da830_psc0_init(struct device *dev, void __iomem *base);
+int da830_psc1_init(struct device *dev, void __iomem *base);
+
 #endif /* __CLK_DAVINCI_PSC_H__ */
-- 
2.7.4
