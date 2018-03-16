Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933097AbeCPCxr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:53:47 -0400
Received: from vern.gendns.com ([206.190.152.46]:55408 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933060AbeCPCxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:53:43 -0400
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
Subject: [PATCH v8 12/42] clk: davinci: Add platform information for TI DA850 PSC
Date: Thu, 15 Mar 2018 21:52:28 -0500
Message-Id: <1521168778-27236-13-git-send-email-david@lechnology.com>
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

This adds platform-specific declarations for the PSC clocks on TI DA850/
OMAP-L138/AM18XX SoCs.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v8 changes:
- drop use of __init and __initconst attributes
- add parent clock mappings

v7 changes:
- split registration function into two, one for each PSC
- add platform_device_id table
- add additional clkdev lookups for clock platform devices
- add LPSC_SET_RATE_PARENT flag to LCDC clock
- fix davinci_nand device name

v6 changes:
- change how clkdev lookups are declared

 drivers/clk/davinci/Makefile    |   1 +
 drivers/clk/davinci/psc-da850.c | 149 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/davinci/psc.c       |   4 ++
 drivers/clk/davinci/psc.h       |   4 ++
 4 files changed, 158 insertions(+)
 create mode 100644 drivers/clk/davinci/psc-da850.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index fb14c8c..aef0390 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
 
 obj-y += psc.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
+obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 endif
diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
new file mode 100644
index 0000000..dca2dd2
--- /dev/null
+++ b/drivers/clk/davinci/psc-da850.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSC clock descriptions for TI DA850/OMAP-L138/AM18XX
+ *
+ * Copyright (C) 2018 David Lechner <david@lechnology.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/types.h>
+
+#include "psc.h"
+
+LPSC_CLKDEV2(emifa_clkdev,	NULL,		"ti-aemif",
+				"aemif",	"davinci_nand.0");
+LPSC_CLKDEV1(spi0_clkdev,	NULL,		"spi_davinci.0");
+LPSC_CLKDEV1(mmcsd0_clkdev,	NULL,		"da830-mmc.0");
+LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
+/* REVISIT: used dev_id instead of con_id */
+LPSC_CLKDEV1(arm_clkdev,	"arm",		NULL);
+LPSC_CLKDEV1(dsp_clkdev,	NULL,		"davinci-rproc.0");
+
+static const struct davinci_lpsc_clk_info da850_psc0_info[] = {
+	LPSC(0,  0, tpcc0,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(1,  0, tptc0,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(2,  0, tptc1,   pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(3,  0, emifa,   async1,       emifa_clkdev,  0),
+	LPSC(4,  0, spi0,    pll0_sysclk2, spi0_clkdev,   0),
+	LPSC(5,  0, mmcsd0,  pll0_sysclk2, mmcsd0_clkdev, 0),
+	LPSC(6,  0, aintc,   pll0_sysclk4, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(7,  0, arm_rom, pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(9,  0, uart0,   pll0_sysclk2, uart0_clkdev,  0),
+	LPSC(13, 0, pruss,   pll0_sysclk2, NULL,          0),
+	LPSC(14, 0, arm,     pll0_sysclk6, arm_clkdev,    LPSC_ALWAYS_ENABLED | LPSC_SET_RATE_PARENT),
+	LPSC(15, 1, dsp,     pll0_sysclk1, dsp_clkdev,    LPSC_FORCE | LPSC_LOCAL_RESET),
+	{ }
+};
+
+LPSC_CLKDEV3(usb0_clkdev,	"fck",	"da830-usb-phy-clks",
+				NULL,	"musb-da8xx",
+				NULL,	"cppi41-dmaengine");
+LPSC_CLKDEV1(usb1_clkdev,	NULL,	"ohci-da8xx");
+/* REVISIT: gpio-davinci.c should be modified to drop con_id */
+LPSC_CLKDEV1(gpio_clkdev,	"gpio",	NULL);
+LPSC_CLKDEV2(emac_clkdev,	NULL,	"davinci_emac.1",
+				"fck",	"davinci_mdio.0");
+LPSC_CLKDEV1(mcasp0_clkdev,	NULL,	"davinci-mcasp.0");
+LPSC_CLKDEV1(sata_clkdev,	"fck",	"ahci_da850");
+LPSC_CLKDEV1(vpif_clkdev,	NULL,	"vpif");
+LPSC_CLKDEV1(spi1_clkdev,	NULL,	"spi_davinci.1");
+LPSC_CLKDEV1(i2c1_clkdev,	NULL,	"i2c_davinci.2");
+LPSC_CLKDEV1(uart1_clkdev,	NULL,	"serial8250.1");
+LPSC_CLKDEV1(uart2_clkdev,	NULL,	"serial8250.2");
+LPSC_CLKDEV1(mcbsp0_clkdev,	NULL,	"davinci-mcbsp.0");
+LPSC_CLKDEV1(mcbsp1_clkdev,	NULL,	"davinci-mcbsp.1");
+LPSC_CLKDEV1(lcdc_clkdev,	"fck",	"da8xx_lcdc.0");
+LPSC_CLKDEV3(ehrpwm_clkdev,	"fck",	"ehrpwm.0",
+				"fck",	"ehrpwm.1",
+				NULL,	"da830-tbclksync");
+LPSC_CLKDEV1(mmcsd1_clkdev,	NULL,	"da830-mmc.1");
+LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
+				"fck",	"ecap.1",
+				"fck",	"ecap.2");
+
+static int da850_psc0_init(struct device *dev, void __iomem *base)
+{
+	return davinci_psc_register_clocks(dev, da850_psc0_info, 16, base);
+}
+
+static int of_da850_psc0_init(struct device *dev, void __iomem *base)
+{
+	return of_davinci_psc_clk_init(dev, da850_psc0_info, 16, base);
+}
+
+static struct clk_bulk_data da850_psc0_parent_clks[] = {
+	{ .id = "pll0_sysclk1" },
+	{ .id = "pll0_sysclk2" },
+	{ .id = "pll0_sysclk4" },
+	{ .id = "pll0_sysclk6" },
+	{ .id = "async1"       },
+};
+
+const struct davinci_psc_init_data da850_psc0_init_data = {
+	.parent_clks		= da850_psc0_parent_clks,
+	.num_parent_clks	= ARRAY_SIZE(da850_psc0_parent_clks),
+	.psc_init		= &da850_psc0_init,
+};
+
+const struct davinci_psc_init_data of_da850_psc0_init_data = {
+	.parent_clks		= da850_psc0_parent_clks,
+	.num_parent_clks	= ARRAY_SIZE(da850_psc0_parent_clks),
+	.psc_init		= &of_da850_psc0_init,
+};
+
+static const struct davinci_lpsc_clk_info da850_psc1_info[] = {
+	LPSC(0,  0, tpcc1,  pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(1,  0, usb0,   pll0_sysclk2, usb0_clkdev,   0),
+	LPSC(2,  0, usb1,   pll0_sysclk4, usb1_clkdev,   0),
+	LPSC(3,  0, gpio,   pll0_sysclk4, gpio_clkdev,   0),
+	LPSC(5,  0, emac,   pll0_sysclk4, emac_clkdev,   0),
+	LPSC(6,  0, ddr,    pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	LPSC(7,  0, mcasp0, async3,       mcasp0_clkdev, 0),
+	LPSC(8,  0, sata,   pll0_sysclk2, sata_clkdev,   LPSC_FORCE),
+	LPSC(9,  0, vpif,   pll0_sysclk2, vpif_clkdev,   0),
+	LPSC(10, 0, spi1,   async3,       spi1_clkdev,   0),
+	LPSC(11, 0, i2c1,   pll0_sysclk4, i2c1_clkdev,   0),
+	LPSC(12, 0, uart1,  async3,       uart1_clkdev,  0),
+	LPSC(13, 0, uart2,  async3,       uart2_clkdev,  0),
+	LPSC(14, 0, mcbsp0, async3,       mcbsp0_clkdev, 0),
+	LPSC(15, 0, mcbsp1, async3,       mcbsp1_clkdev, 0),
+	LPSC(16, 0, lcdc,   pll0_sysclk2, lcdc_clkdev,   0),
+	LPSC(17, 0, ehrpwm, async3,       ehrpwm_clkdev, 0),
+	LPSC(18, 0, mmcsd1, pll0_sysclk2, mmcsd1_clkdev, 0),
+	LPSC(20, 0, ecap,   async3,       ecap_clkdev,   0),
+	LPSC(21, 0, tptc2,  pll0_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
+	{ }
+};
+
+static int da850_psc1_init(struct device *dev, void __iomem *base)
+{
+	return davinci_psc_register_clocks(dev, da850_psc1_info, 32, base);
+}
+
+static int of_da850_psc1_init(struct device *dev, void __iomem *base)
+{
+	return of_davinci_psc_clk_init(dev, da850_psc1_info, 32, base);
+}
+
+static struct clk_bulk_data da850_psc1_parent_clks[] = {
+	{ .id = "pll0_sysclk2" },
+	{ .id = "pll0_sysclk4" },
+	{ .id = "async3"       },
+};
+
+const struct davinci_psc_init_data da850_psc1_init_data = {
+	.parent_clks		= da850_psc1_parent_clks,
+	.num_parent_clks	= ARRAY_SIZE(da850_psc1_parent_clks),
+	.psc_init		= &da850_psc1_init,
+};
+
+const struct davinci_psc_init_data of_da850_psc1_init_data = {
+	.parent_clks		= da850_psc1_parent_clks,
+	.num_parent_clks	= ARRAY_SIZE(da850_psc1_parent_clks),
+	.psc_init		= &of_da850_psc1_init,
+};
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index d4cff87..fa39536 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -482,12 +482,16 @@ int of_davinci_psc_clk_init(struct device *dev,
 }
 
 static const struct of_device_id davinci_psc_of_match[] = {
+	{ .compatible = "ti,da850-psc0", .data = &of_da850_psc0_init_data },
+	{ .compatible = "ti,da850-psc1", .data = &of_da850_psc1_init_data },
 	{ }
 };
 
 static const struct platform_device_id davinci_psc_id_table[] = {
 	{ .name = "da830-psc0", .driver_data = (kernel_ulong_t)&da830_psc0_init_data },
 	{ .name = "da830-psc1", .driver_data = (kernel_ulong_t)&da830_psc1_init_data },
+	{ .name = "da850-psc0", .driver_data = (kernel_ulong_t)&da850_psc0_init_data },
+	{ .name = "da850-psc1", .driver_data = (kernel_ulong_t)&da850_psc1_init_data },
 	{ }
 };
 
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index 852e9aa..476bd74 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -96,5 +96,9 @@ struct davinci_psc_init_data {
 
 extern const struct davinci_psc_init_data da830_psc0_init_data;
 extern const struct davinci_psc_init_data da830_psc1_init_data;
+extern const struct davinci_psc_init_data da850_psc0_init_data;
+extern const struct davinci_psc_init_data da850_psc1_init_data;
+extern const struct davinci_psc_init_data of_da850_psc0_init_data;
+extern const struct davinci_psc_init_data of_da850_psc1_init_data;
 
 #endif /* __CLK_DAVINCI_PSC_H__ */
-- 
2.7.4
