Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935431AbeEIRe7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:34:59 -0400
Received: from vern.gendns.com ([206.190.152.46]:51894 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935537AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v10 10/27] ARM: davinci: dm646x: add new clock init using common clock framework
Date: Wed,  9 May 2018 12:25:49 -0500
Message-Id: <20180509172606.29387-11-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/dm646x.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- none

v9 changes:
- register PLL1 and PSC in dm646x_init_time() instead of as platform device so
  that we get the correct timer0 clock for davinci_timer_init()
- Fixed size of PLL memory block

v8 changes:
- register clkdev lookup for ref_clk and aux_clkin

v7 changes:
- add clock platform device declarations
- register platform devices instead of registering clocks directly
- add davinci prefix to commit description

v6 changes:
- add blank lines between function calls


 arch/arm/mach-davinci/board-dm646x-evm.c |  2 +
 arch/arm/mach-davinci/davinci.h          |  1 +
 arch/arm/mach-davinci/dm646x.c           | 63 +++++++++++++++++++++---
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 764be73735a2..37c9e0ee4dcc 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -773,6 +773,8 @@ static __init void evm_init(void)
 	int ret;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm646x_register_clocks();
+
 	ret = dm646x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 16aca5853ab2..fa99197d36f9 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -116,6 +116,7 @@ int dm644x_gpio_register(void);
 /* DM646x function declarations */
 void dm646x_init(void);
 void dm646x_init_time(unsigned long ref_clk_rate, unsigned long aux_clkin_rate);
+void dm646x_register_clocks(void);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void dm646x_init_mcasp1(struct snd_platform_data *pdata);
 int dm646x_init_edma(struct edma_rsv_info *rsv);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index e1d6e92f434a..f5693bafc81f 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -8,29 +8,35 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+
+#include <linux/clk-provider.h>
+#include <linux/clk/davinci.h>
+#include <linux/clkdev.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
-#include <linux/clk.h>
-#include <linux/serial_8250.h>
-#include <linux/platform_device.h>
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
 
 #define DAVINCI_VPIF_BASE       (0x01C12000)
 
@@ -46,6 +52,7 @@
 #define DM646X_EMAC_CNTRL_RAM_OFFSET	0x2000
 #define DM646X_EMAC_CNTRL_RAM_SIZE	0x2000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -356,6 +363,7 @@ static struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "vpif1", &vpif1_clk),
 	CLK(NULL, NULL, NULL),
 };
+#endif
 
 static struct emac_platform_data dm646x_emac_pdata = {
 	.ctrl_reg_offset	= DM646X_EMAC_CNTRL_OFFSET,
@@ -953,10 +961,49 @@ void __init dm646x_init(void)
 void __init dm646x_init_time(unsigned long ref_clk_rate,
 			     unsigned long aux_clkin_rate)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll1, *psc;
+	struct clk *clk;
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
+	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
+
+	pll1 = ioremap(DAVINCI_PLL1_BASE, SZ_1K);
+	dm646x_pll1_init(NULL, pll1, NULL);
+
+	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
+	dm646x_psc_init(NULL, psc);
+
+	clk = clk_get(NULL, "timer0");
+
+	davinci_timer_init(clk);
+#else
 	ref_clk.rate = ref_clk_rate;
 	aux_clkin.rate = aux_clkin_rate;
 	davinci_clk_init(dm646x_clks);
 	davinci_timer_init(&timer0_clk);
+#endif
+}
+
+static struct resource dm646x_pll2_resources[] = {
+	{
+		.start	= DAVINCI_PLL2_BASE,
+		.end	= DAVINCI_PLL2_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm646x_pll2_device = {
+	.name		= "dm646x-pll2",
+	.id		= -1,
+	.resource	= dm646x_pll2_resources,
+	.num_resources	= ARRAY_SIZE(dm646x_pll2_resources),
+};
+
+void __init dm646x_register_clocks(void)
+{
+	/* PLL1 and PSC are registered in dm646x_init_time() */
+	platform_device_register(&dm646x_pll2_device);
 }
 
 static int __init dm646x_init_devices(void)
-- 
2.17.0
