Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeBSUXZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:23:25 -0500
Received: from vern.gendns.com ([206.190.152.46]:58609 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932116AbeBSUXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:23:15 -0500
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
Subject: [PATCH v7 24/42] ARM: davinci: dm365: add new clock init using common clock framework
Date: Mon, 19 Feb 2018 14:21:45 -0600
Message-Id: <1519071723-31790-25-git-send-email-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/dm365.c
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


 arch/arm/mach-davinci/board-dm365-evm.c |  2 +
 arch/arm/mach-davinci/davinci.h         |  1 +
 arch/arm/mach-davinci/dm365.c           | 88 ++++++++++++++++++++++++++++-----
 3 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 3daeac7..67339b42 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -741,6 +741,8 @@ static __init void dm365_evm_init(void)
 {
 	int ret;
 
+	dm365_register_clocks();
+
 	ret = dm365_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 6b6abf0a..c865226 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -94,6 +94,7 @@ int dm355_gpio_register(void);
 /* DM365 function declarations */
 void dm365_init(void);
 void dm365_init_time(void);
+void dm365_register_clocks(void);
 void dm365_init_asp(void);
 void dm365_init_vc(void);
 void dm365_init_ks(struct davinci_ks_platform_data *pdata);
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 871372a..93067e1 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -12,32 +12,35 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/serial_8250.h>
-#include <linux/platform_device.h>
+#include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
-#include <linux/spi/spi.h>
+#include <linux/init.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_data/keyscan-davinci.h>
 #include <linux/platform_data/spi-davinci.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach/map.h>
 
+#include <mach/common.h>
 #include <mach/cputype.h>
-#include "psc.h"
-#include <mach/mux.h>
 #include <mach/irqs.h>
-#include <mach/time.h>
+#include <mach/mux.h>
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
 
 #define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
 #define DM365_RTC_BASE			0x01c69000
@@ -54,6 +57,7 @@
 #define DM365_EMAC_CNTRL_RAM_OFFSET	0x1000
 #define DM365_EMAC_CNTRL_RAM_SIZE	0x2000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num		= 1,
 	.phys_base	= DAVINCI_PLL1_BASE,
@@ -485,7 +489,7 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "mjcp", &mjcp_clk),
 	CLK(NULL, NULL, NULL),
 };
-
+#endif
 /*----------------------------------------------------------------------*/
 
 #define INTMUX		0x18
@@ -1171,8 +1175,68 @@ void __init dm365_init(void)
 
 void __init dm365_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM365_REF_FREQ);
+
+	davinci_timer_init(clk);
+#else
 	davinci_clk_init(dm365_clks);
 	davinci_timer_init(&timer0_clk);
+#endif
+}
+
+static struct resource dm365_pll1_resources[] = {
+	{
+		.start	= DAVINCI_PLL1_BASE,
+		.end	= DAVINCI_PLL1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm365_pll1_device = {
+	.name		= "dm365-pll1",
+	.id		= -1,
+	.resource	= dm365_pll1_resources,
+	.num_resources	= ARRAY_SIZE(dm365_pll1_resources),
+};
+
+static struct resource dm365_pll2_resources[] = {
+	{
+		.start	= DAVINCI_PLL2_BASE,
+		.end	= DAVINCI_PLL2_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm365_pll2_device = {
+	.name		= "dm365-pll2",
+	.id		= -1,
+	.resource	= dm365_pll2_resources,
+	.num_resources	= ARRAY_SIZE(dm365_pll2_resources),
+};
+
+static struct resource dm365_psc_resources[] = {
+	{
+		.start	= DAVINCI_PWR_SLEEP_CNTRL_BASE,
+		.end	= DAVINCI_PWR_SLEEP_CNTRL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm365_psc_device = {
+	.name		= "dm365-psc",
+	.id		= -1,
+	.resource	= dm365_psc_resources,
+	.num_resources	= ARRAY_SIZE(dm365_psc_resources),
+};
+
+void __init dm365_register_clocks(void)
+{
+	platform_device_register(&dm365_pll1_device);
+	platform_device_register(&dm365_pll2_device);
+	platform_device_register(&dm365_psc_device);
 }
 
 static struct resource dm365_vpss_resources[] = {
-- 
2.7.4
