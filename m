Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965894AbeEIR1d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:27:33 -0400
Received: from vern.gendns.com ([206.190.152.46]:51886 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935202AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v10 07/27] ARM: davinci: dm355: add new clock init using common clock framework
Date: Wed,  9 May 2018 12:25:46 -0500
Message-Id: <20180509172606.29387-8-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/dm355.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- none (reported problems fixed in separate patch series [1])

[1]: https://lkml.org/lkml/2018/5/9/626

v9 changes:
- register PLL1 and PSC in dm355_init_time() instead of as platform device so
  that we get the correct timer0 clock for davinci_timer_init()
- Fixed size of PLL memory block

v8 changes:
- none

v7 changes:
- add clock platform device declarations
- register platform devices instead of registering clocks directly
- add davinci prefix to commit description

v6 changes:
- add blank lines between function calls


 arch/arm/mach-davinci/board-dm355-evm.c     |  2 +
 arch/arm/mach-davinci/board-dm355-leopard.c |  2 +
 arch/arm/mach-davinci/davinci.h             |  1 +
 arch/arm/mach-davinci/dm355.c               | 69 +++++++++++++++++----
 4 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index a3377f959444..f53a461a606f 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -394,6 +394,8 @@ static __init void dm355_evm_init(void)
 	struct clk *aemif;
 	int ret;
 
+	dm355_register_clocks();
+
 	ret = dm355_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index 8249a0bf69f0..0fdf1d03eb11 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -234,6 +234,8 @@ static __init void dm355_leopard_init(void)
 	struct clk *aemif;
 	int ret;
 
+	dm355_register_clocks();
+
 	ret = dm355_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 376cdd51ce9d..c2c634b6578e 100644
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
index 0da7516018ca..14014b942e8a 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -8,31 +8,37 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
-#include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/serial_8250.h>
-#include <linux/platform_device.h>
+
+#include <linux/clk-provider.h>
+#include <linux/clk/davinci.h>
+#include <linux/clkdev.h>
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
@@ -43,6 +49,7 @@
  */
 #define DM355_REF_FREQ		24000000	/* 24 or 36 MHz */
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -382,7 +389,7 @@ static struct clk_lookup dm355_clks[] = {
 	CLK(NULL, "usb", &usb_clk),
 	CLK(NULL, NULL, NULL),
 };
-
+#endif
 /*----------------------------------------------------------------------*/
 
 static u64 dm355_spi0_dma_mask = DMA_BIT_MASK(32);
@@ -1046,8 +1053,46 @@ void __init dm355_init(void)
 
 void __init dm355_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll1, *psc;
+	struct clk *clk;
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DM355_REF_FREQ);
+
+	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_1K);
+	dm355_pll1_init(NULL, pll1, NULL);
+
+	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
+	dm355_psc_init(NULL, psc);
+
+	clk = clk_get(NULL, "timer0");
+
+	davinci_timer_init(clk);
+#else
 	davinci_clk_init(dm355_clks);
 	davinci_timer_init(&timer0_clk);
+#endif
+}
+
+static struct resource dm355_pll2_resources[] = {
+	{
+		.start	= DAVINCI_PLL2_BASE,
+		.end	= DAVINCI_PLL2_BASE + SZ_1K - 1,
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
+void __init dm355_register_clocks(void)
+{
+	/* PLL1 and PSC are registered in dm355_init_time() */
+	platform_device_register(&dm355_pll2_device);
 }
 
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
-- 
2.17.0
