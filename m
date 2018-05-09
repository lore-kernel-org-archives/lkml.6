Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935591AbeEIR1j (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:27:39 -0400
Received: from vern.gendns.com ([206.190.152.46]:51955 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935553AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
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
Subject: [PATCH v10 06/27] ARM: davinci: da850: add new clock init using common clock framework
Date: Wed,  9 May 2018 12:25:45 -0500
Message-Id: <20180509172606.29387-7-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
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

Reviewed-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- none

v9 changes:
- register PLL in da850_init_time() instead of as platform device so that we
  get the correct timer0 clock for davinci_timer_init()

v8 changes:
- add platform data for PLL clocks

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
 arch/arm/mach-davinci/da850.c               | 155 ++++++++++++++++++--
 arch/arm/mach-davinci/da8xx-dt.c            |   2 +
 arch/arm/mach-davinci/include/mach/da8xx.h  |   1 +
 6 files changed, 151 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index e22fb40e34bc..442c16773f09 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1340,6 +1340,8 @@ static __init void da850_evm_init(void)
 {
 	int ret;
 
+	da850_register_clocks();
+
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 37b3e48a21d1..2cce0d7d2f2a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -503,6 +503,8 @@ static void __init mityomapl138_init(void)
 {
 	int ret;
 
+	da850_register_clocks();
+
 	/* for now, no special EDMA channels are reserved */
 	ret = da850_register_edma(NULL);
 	if (ret)
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index be8b892a6ea7..7653e9425d44 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -285,6 +285,8 @@ static __init void omapl138_hawk_init(void)
 {
 	int ret;
 
+	da850_register_clocks();
+
 	ret = da850_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 1dbf01c4124b..9e00beb943c9 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -11,39 +11,45 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+
+#include <linux/clk-provider.h>
+#include <linux/clk/davinci.h>
 #include <linux/clkdev.h>
+#include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
-#include <linux/clk.h>
+#include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/platform_data/clk-da8xx-cfgchip.h>
+#include <linux/platform_data/clk-davinci-pll.h>
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
@@ -583,6 +589,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("ecap.2",		"fck",		&ecap2_clk),
 	CLK(NULL,		NULL,		NULL),
 };
+#endif
 
 /*
  * Device specific mux setup
@@ -1170,6 +1177,7 @@ int da850_register_cpufreq(char *async_clk)
 	return platform_device_register(&da850_cpufreq_device);
 }
 
+#ifndef CONFIG_COMMON_CLK
 static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	int ret = 0, diff;
@@ -1232,12 +1240,14 @@ static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
 
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
@@ -1252,6 +1262,7 @@ static int da850_round_armrate(struct clk *clk, unsigned long rate)
 {
 	return clk->rate;
 }
+#endif /* CONFIG_COMMON_CLK */
 #endif
 
 /* VPIF resource, platform data */
@@ -1395,6 +1406,124 @@ void __init da850_init(void)
 
 void __init da850_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll0;
+	struct regmap *cfgchip;
+	struct clk *clk;
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
+
+	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+	cfgchip = da8xx_get_cfgchip();
+
+	da850_pll0_init(NULL, pll0, cfgchip);
+
+	clk = clk_get(NULL, "timer0");
+
+	davinci_timer_init(clk);
+#else
 	davinci_clk_init(da850_clks);
 	davinci_timer_init(&timerp64_0_clk);
+#endif
+}
+
+static struct resource da850_pll1_resources[] = {
+	{
+		.start	= DA850_PLL1_BASE,
+		.end	= DA850_PLL1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct davinci_pll_platform_data da850_pll1_pdata;
+
+static struct platform_device da850_pll1_device = {
+	.name		= "da850-pll1",
+	.id		= -1,
+	.resource	= da850_pll1_resources,
+	.num_resources	= ARRAY_SIZE(da850_pll1_resources),
+	.dev		= {
+		.platform_data	= &da850_pll1_pdata,
+	},
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
+static struct da8xx_cfgchip_clk_platform_data da850_async1_pdata;
+
+static struct platform_device da850_async1_clksrc_device = {
+	.name		= "da850-async1-clksrc",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &da850_async1_pdata,
+	},
+};
+
+static struct da8xx_cfgchip_clk_platform_data da850_async3_pdata;
+
+static struct platform_device da850_async3_clksrc_device = {
+	.name		= "da850-async3-clksrc",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &da850_async3_pdata,
+	},
+};
+
+static struct da8xx_cfgchip_clk_platform_data da850_tbclksync_pdata;
+
+static struct platform_device da850_tbclksync_device = {
+	.name		= "da830-tbclksync",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &da850_tbclksync_pdata,
+	},
+};
+
+void __init da850_register_clocks(void)
+{
+	/* PLL0 is registered in da850_init_time() */
+
+	da850_pll1_pdata.cfgchip = da8xx_get_cfgchip();
+	platform_device_register(&da850_pll1_device);
+
+	da850_async1_pdata.cfgchip = da8xx_get_cfgchip();
+	platform_device_register(&da850_async1_clksrc_device);
+
+	da850_async3_pdata.cfgchip = da8xx_get_cfgchip();
+	platform_device_register(&da850_async3_clksrc_device);
+
+	platform_device_register(&da850_psc0_device);
+
+	platform_device_register(&da850_psc1_device);
+
+	da850_tbclksync_pdata.cfgchip = da8xx_get_cfgchip();
+	platform_device_register(&da850_tbclksync_device);
 }
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index ab199f4b9ce4..91dd9cb6d113 100644
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
index 64861ac6a9d4..612e45437cec 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -93,6 +93,7 @@ void da830_register_clocks(void);
 
 void da850_init(void);
 void da850_init_time(void);
+void da850_register_clocks(void);
 
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
-- 
2.17.0
