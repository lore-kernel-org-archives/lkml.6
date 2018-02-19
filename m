Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932347AbeBSUZX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:25:23 -0500
Received: from vern.gendns.com ([206.190.152.46]:58591 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932201AbeBSUXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:23:12 -0500
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
Subject: [PATCH v7 22/42] ARM: davinci: da850: add new clock init using common clock framework
Date: Mon, 19 Feb 2018 14:21:43 -0600
Message-Id: <1519071723-31790-23-git-send-email-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/da850.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Some CFGCHIP macros were removed because we are now including
linux/mfd/da8xx-cfgchip.h which defines the same values.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- add clock platform device declarations
- register platform devices instead of registering clocks directly
- clkdev lookup is moved to drivers/clk
- add davinci prefix to commit description

v6 changes:
- add blank lines between function calls
- include da8xx_register_cfgchip()
- add async1 and async2 clock domains


 arch/arm/mach-davinci/board-da850-evm.c     |   2 +
 arch/arm/mach-davinci/board-mityomapl138.c  |   2 +
 arch/arm/mach-davinci/board-omapl138-hawk.c |   2 +
 arch/arm/mach-davinci/da850.c               | 143 +++++++++++++++++++++++++---
 arch/arm/mach-davinci/da8xx-dt.c            |   2 +
 arch/arm/mach-davinci/include/mach/da8xx.h  |   1 +
 6 files changed, 139 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 3063478..78a670a 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1334,6 +1334,8 @@ static __init void da850_evm_init(void)
 {
 	int ret;
 
+	da850_register_clocks();
+
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index d1c8548..f442784 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -502,6 +502,8 @@ static void __init mityomapl138_init(void)
 {
 	int ret;
 
+	da850_register_clocks();
+
 	/* for now, no special EDMA channels are reserved */
 	ret = da850_register_edma(NULL);
 	if (ret)
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index e2ba9da..6a4e486 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -281,6 +281,8 @@ static __init void omapl138_hawk_init(void)
 {
 	int ret;
 
+	da850_register_clocks();
+
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 1dbf01c..9086f2b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -11,39 +11,43 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+
+#include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
-#include <linux/clk.h>
+#include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/platform_data/clk-da8xx-cfgchip.h>
+#include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
-#include <linux/cpufreq.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-#include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
 
-#include "psc.h"
-#include <mach/irqs.h>
-#include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/time.h>
-#include <mach/da8xx.h>
 #include <mach/cpufreq.h>
+#include <mach/cputype.h>
+#include <mach/da8xx.h>
+#include <mach/irqs.h>
 #include <mach/pm.h>
+#include <mach/time.h>
 
-#include "clock.h"
 #include "mux.h"
 
+#ifndef CONFIG_COMMON_CLK
+#include "clock.h"
+#include "psc.h"
+#endif
+
 #define DA850_PLL1_BASE		0x01e1a000
 #define DA850_TIMER64P2_BASE	0x01f0c000
 #define DA850_TIMER64P3_BASE	0x01f0d000
 
 #define DA850_REF_FREQ		24000000
 
-#define CFGCHIP3_ASYNC3_CLKSRC	BIT(4)
-#define CFGCHIP3_PLL1_MASTER_LOCK	BIT(5)
-#define CFGCHIP0_PLL_MASTER_LOCK	BIT(4)
-
+#ifndef CONFIG_COMMON_CLK
 static int da850_set_armrate(struct clk *clk, unsigned long rate);
 static int da850_round_armrate(struct clk *clk, unsigned long rate);
 static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
@@ -583,6 +587,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("ecap.2",		"fck",		&ecap2_clk),
 	CLK(NULL,		NULL,		NULL),
 };
+#endif
 
 /*
  * Device specific mux setup
@@ -1170,6 +1175,7 @@ int da850_register_cpufreq(char *async_clk)
 	return platform_device_register(&da850_cpufreq_device);
 }
 
+#ifndef CONFIG_COMMON_CLK
 static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	int ret = 0, diff;
@@ -1232,12 +1238,14 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
 
 	return 0;
 }
+#endif /* CONFIG_COMMON_CLK */
 #else
 int __init da850_register_cpufreq(char *async_clk)
 {
 	return 0;
 }
 
+#ifndef CONFIG_COMMON_CLK
 static int da850_set_armrate(struct clk *clk, unsigned long rate)
 {
 	return -EINVAL;
@@ -1252,6 +1260,7 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	return clk->rate;
 }
+#endif /* CONFIG_COMMON_CLK */
 #endif
 
 /* VPIF resource, platform data */
@@ -1395,6 +1404,114 @@ void __init da850_init(void)
 
 void __init da850_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
+
+	davinci_timer_init(clk);
+#else
 	davinci_clk_init(da850_clks);
 	davinci_timer_init(&timerp64_0_clk);
+#endif
+}
+
+static struct resource da850_pll0_resources[] = {
+	{
+		.start	= DA8XX_PLL0_BASE,
+		.end	= DA8XX_PLL0_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da850_pll0_device = {
+	.name		= "da850-pll0",
+	.id		= -1,
+	.resource	= da850_pll0_resources,
+	.num_resources	= ARRAY_SIZE(da850_pll0_resources),
+};
+
+static struct resource da850_pll1_resources[] = {
+	{
+		.start	= DA850_PLL1_BASE,
+		.end	= DA850_PLL1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da850_pll1_device = {
+	.name		= "da850-pll1",
+	.id		= -1,
+	.resource	= da850_pll1_resources,
+	.num_resources	= ARRAY_SIZE(da850_pll1_resources),
+};
+
+static struct resource da850_psc0_resources[] = {
+	{
+		.start	= DA8XX_PSC0_BASE,
+		.end	= DA8XX_PSC0_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da850_psc0_device = {
+	.name		= "da850-psc0",
+	.id		= -1,
+	.resource	= da850_psc0_resources,
+	.num_resources	= ARRAY_SIZE(da850_psc0_resources),
+};
+
+static struct resource da850_psc1_resources[] = {
+	{
+		.start	= DA8XX_PSC1_BASE,
+		.end	= DA8XX_PSC1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da850_psc1_device = {
+	.name		= "da850-psc1",
+	.id		= -1,
+	.resource	= da850_psc1_resources,
+	.num_resources	= ARRAY_SIZE(da850_psc1_resources),
+};
+
+static struct platform_device da850_async1_clksrc_device = {
+	.name		= "da850-async1-clksrc",
+	.id		= -1,
+};
+
+static struct platform_device da850_async3_clksrc_device = {
+	.name		= "da850-async3-clksrc",
+	.id		= -1,
+};
+
+static struct platform_device da830_tbclksync_device = {
+	.name		= "da830-tbclksync",
+	.id		= -1,
+};
+
+void __init da850_register_clocks(void)
+{
+	static struct da8xx_cfgchip_clk_platform_data async1_pdata;
+	static struct da8xx_cfgchip_clk_platform_data async3_pdata;
+	static struct da8xx_cfgchip_clk_platform_data tbclksync_pdata;
+
+	platform_device_register(&da850_pll0_device);
+	platform_device_register(&da850_pll1_device);
+
+	async1_pdata.cfgchip = da8xx_get_cfgchip();
+	da850_async1_clksrc_device.dev.platform_data = &async1_pdata;
+	platform_device_register(&da850_async1_clksrc_device);
+
+	async3_pdata.cfgchip = da8xx_get_cfgchip();
+	da850_async3_clksrc_device.dev.platform_data = &async3_pdata;
+	platform_device_register(&da850_async3_clksrc_device);
+
+	platform_device_register(&da850_psc0_device);
+	platform_device_register(&da850_psc1_device);
+
+	tbclksync_pdata.cfgchip = da8xx_get_cfgchip();
+	da830_tbclksync_device.dev.platform_data = &tbclksync_pdata;
+	platform_device_register(&da830_tbclksync_device);
 }
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index ab199f4..91dd9cb 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -67,6 +67,8 @@ static void __init da850_init_machine(void)
 
 	int ret;
 
+	da850_register_clocks();
+
 	ret = da8xx_register_usb20_phy_clk(false);
 	if (ret)
 		pr_warn("%s: registering USB 2.0 PHY clock failed: %d",
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 64861ac..612e454 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -93,6 +93,7 @@ void da830_register_clocks(void);
 
 void da850_init(void);
 void da850_init_time(void);
+void da850_register_clocks(void);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
-- 
2.7.4
