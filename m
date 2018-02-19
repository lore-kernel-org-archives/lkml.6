Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeBSUXY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:23:24 -0500
Received: from vern.gendns.com ([206.190.152.46]:58604 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932215AbeBSUXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:23:13 -0500
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
Subject: [PATCH v7 23/42] ARM: davinci: dm355: add new clock init using common clock framework
Date: Mon, 19 Feb 2018 14:21:44 -0600
Message-Id: <1519071723-31790-24-git-send-email-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/dm355.c
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

 arch/arm/mach-davinci/board-dm355-evm.c     |  2 +
 arch/arm/mach-davinci/board-dm355-leopard.c |  2 +
 arch/arm/mach-davinci/davinci.h             |  1 +
 arch/arm/mach-davinci/dm355.c               | 88 +++++++++++++++++++++++++----
 4 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 9ef24513..711f723 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -384,6 +384,8 @@ static __init void dm355_evm_init(void)
 	struct clk *aemif;
 	int ret;
 
+	dm355_register_clocks();
+
 	ret = dm355_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 3ebc89d..f46b185 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -233,6 +233,8 @@ static __init void dm355_leopard_init(void)
 	struct clk *aemif;
 	int ret;
 
+	dm355_register_clocks();
+
 	ret = dm355_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 270cef8..6b6abf0a 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -84,6 +84,7 @@ int davinci_init_wdt(void);
 /* DM355 function declarations */
 void dm355_init(void);
 void dm355_init_time(void);
+void dm355_register_clocks(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		const struct spi_board_info *info, unsigned len);
 void dm355_init_asp1(u32 evt_enable);
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 0da7516..f53e07a 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -8,31 +8,34 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
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
 
 #define DM355_UART2_BASE	(IO_PHYS + 0x206000)
 #define DM355_OSD_BASE		(IO_PHYS + 0x70200)
@@ -43,6 +46,7 @@
  */
 #define DM355_REF_FREQ		24000000	/* 24 or 36 MHz */
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -382,7 +386,7 @@ static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "usb", &usb_clk),
 	CLK(NULL, NULL, NULL),
 };
-
+#endif
 /*----------------------------------------------------------------------*/
 
 static u64 dm355_spi0_dma_mask = DMA_BIT_MASK(32);
@@ -1046,8 +1050,68 @@ void __init dm355_init(void)
 
 void __init dm355_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
+
+	davinci_timer_init(clk);
+#else
 	davinci_clk_init(dm355_clks);
 	davinci_timer_init(&timer0_clk);
+#endif
+}
+
+static struct resource dm355_pll1_resources[] = {
+	{
+		.start	= DAVINCI_PLL1_BASE,
+		.end	= DAVINCI_PLL1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm355_pll1_device = {
+	.name		= "dm355-pll1",
+	.id		= -1,
+	.resource	= dm355_pll1_resources,
+	.num_resources	= ARRAY_SIZE(dm355_pll1_resources),
+};
+
+static struct resource dm355_pll2_resources[] = {
+	{
+		.start	= DAVINCI_PLL2_BASE,
+		.end	= DAVINCI_PLL2_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm355_pll2_device = {
+	.name		= "dm355-pll2",
+	.id		= -1,
+	.resource	= dm355_pll2_resources,
+	.num_resources	= ARRAY_SIZE(dm355_pll2_resources),
+};
+
+static struct resource dm355_psc_resources[] = {
+	{
+		.start	= DAVINCI_PWR_SLEEP_CNTRL_BASE,
+		.end	= DAVINCI_PWR_SLEEP_CNTRL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm355_psc_device = {
+	.name		= "dm355-psc",
+	.id		= -1,
+	.resource	= dm355_psc_resources,
+	.num_resources	= ARRAY_SIZE(dm355_psc_resources),
+};
+
+void __init dm355_register_clocks(void)
+{
+	platform_device_register(&dm355_pll1_device);
+	platform_device_register(&dm355_pll2_device);
+	platform_device_register(&dm355_psc_device);
 }
 
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
-- 
2.7.4
