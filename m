Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbeBSUXV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:23:21 -0500
Received: from vern.gendns.com ([206.190.152.46]:58618 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932222AbeBSUXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:23:16 -0500
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
Subject: [PATCH v7 25/42] ARM: davinci: dm644x: add new clock init using common clock framework
Date: Mon, 19 Feb 2018 14:21:46 -0600
Message-Id: <1519071723-31790-26-git-send-email-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/dm644x.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- add clock platform device declarations
- register platform devices instead of registering clocks directly
- add davinci prefix to commit description

v6 changes:
- add blank lines between function calls


 arch/arm/mach-davinci/board-dm644x-evm.c  |  2 +
 arch/arm/mach-davinci/board-neuros-osd2.c |  2 +
 arch/arm/mach-davinci/board-sffsdr.c      |  2 +
 arch/arm/mach-davinci/davinci.h           |  1 +
 arch/arm/mach-davinci/dm644x.c            | 83 +++++++++++++++++++++++++++----
 5 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 95b55aa..91c7525 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -768,6 +768,8 @@ static __init void davinci_evm_init(void)
 	struct clk *aemif_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm644x_register_clocks();
+
 	ret = dm644x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index f287577..ae17d3e 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -174,6 +174,8 @@ static __init void davinci_ntosd2_init(void)
 	struct clk *aemif_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm644x_register_clocks();
+
 	ret = dm644x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-sffsdr.c b/arch/arm/mach-davinci/board-sffsdr.c
index 2922da9..933cc08 100644
--- a/arch/arm/mach-davinci/board-sffsdr.c
+++ b/arch/arm/mach-davinci/board-sffsdr.c
@@ -134,6 +134,8 @@ static __init void davinci_sffsdr_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm644x_register_clocks();
+
 	platform_add_devices(davinci_sffsdr_devices,
 			     ARRAY_SIZE(davinci_sffsdr_devices));
 	sffsdr_init_i2c();
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index c865226..2861a6f 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -107,6 +107,7 @@ int dm365_gpio_register(void);
 /* DM644x function declarations */
 void dm644x_init(void);
 void dm644x_init_time(void);
+void dm644x_register_clocks(void);
 void dm644x_init_asp(void);
 int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
 int dm644x_gpio_register(void);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 71a16fc..64f5193 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -8,28 +8,31 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/serial_8250.h>
+#include <linux/clk-provider.h>
 #include <linux/dmaengine.h>
-#include <linux/platform_device.h>
+#include <linux/init.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
 
 #include <asm/mach/map.h>
 
+#include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include "psc.h"
 #include <mach/mux.h>
-#include <mach/time.h>
 #include <mach/serial.h>
-#include <mach/common.h>
+#include <mach/time.h>
 
+#include "asp.h"
 #include "davinci.h"
-#include "clock.h"
 #include "mux.h"
-#include "asp.h"
+
+#ifndef CONFIG_COMMON_CLK
+#include "clock.h"
+#include "psc.h"
+#endif
 
 /*
  * Device specific clocks
@@ -43,6 +46,7 @@
 #define DM644X_EMAC_CNTRL_RAM_OFFSET	0x2000
 #define DM644X_EMAC_CNTRL_RAM_SIZE	0x2000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -326,6 +330,7 @@ static struct clk_lookup dm644x_clks[] = {
 	CLK("davinci-wdt", NULL, &timer2_clk),
 	CLK(NULL, NULL, NULL),
 };
+#endif
 
 static struct emac_platform_data dm644x_emac_pdata = {
 	.ctrl_reg_offset	= DM644X_EMAC_CNTRL_OFFSET,
@@ -934,8 +939,68 @@ void __init dm644x_init(void)
 
 void __init dm644x_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM644X_REF_FREQ);
+
+	davinci_timer_init(clk);
+#else
 	davinci_clk_init(dm644x_clks);
 	davinci_timer_init(&timer0_clk);
+#endif
+}
+
+static struct resource dm644x_pll1_resources[] = {
+	{
+		.start	= DAVINCI_PLL1_BASE,
+		.end	= DAVINCI_PLL1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm644x_pll1_device = {
+	.name		= "dm644x-pll1",
+	.id		= -1,
+	.resource	= dm644x_pll1_resources,
+	.num_resources	= ARRAY_SIZE(dm644x_pll1_resources),
+};
+
+static struct resource dm644x_pll2_resources[] = {
+	{
+		.start	= DAVINCI_PLL2_BASE,
+		.end	= DAVINCI_PLL2_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm644x_pll2_device = {
+	.name		= "dm644x-pll2",
+	.id		= -1,
+	.resource	= dm644x_pll2_resources,
+	.num_resources	= ARRAY_SIZE(dm644x_pll2_resources),
+};
+
+static struct resource dm644x_psc_resources[] = {
+	{
+		.start	= DAVINCI_PWR_SLEEP_CNTRL_BASE,
+		.end	= DAVINCI_PWR_SLEEP_CNTRL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm644x_psc_device = {
+	.name		= "dm644x-psc",
+	.id		= -1,
+	.resource	= dm644x_psc_resources,
+	.num_resources	= ARRAY_SIZE(dm644x_psc_resources),
+};
+
+void __init dm644x_register_clocks(void)
+{
+	platform_device_register(&dm644x_pll1_device);
+	platform_device_register(&dm644x_pll2_device);
+	platform_device_register(&dm644x_psc_device);
 }
 
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
-- 
2.7.4
