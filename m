Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeBSUYq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:24:46 -0500
Received: from vern.gendns.com ([206.190.152.46]:58627 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932223AbeBSUXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:23:17 -0500
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
Subject: [PATCH v7 26/42] ARM: davinci: dm646x: add new clock init using common clock framework
Date: Mon, 19 Feb 2018 14:21:47 -0600
Message-Id: <1519071723-31790-27-git-send-email-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/dm646x.c
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


 arch/arm/mach-davinci/board-dm646x-evm.c |  2 +
 arch/arm/mach-davinci/davinci.h          |  1 +
 arch/arm/mach-davinci/dm646x.c           | 82 ++++++++++++++++++++++++++++----
 3 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 2d37f5b..d672804 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -772,6 +772,8 @@ static __init void evm_init(void)
 	int ret;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 
+	dm646x_register_clocks();
+
 	ret = dm646x_gpio_register();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
index 2861a6f..a200977 100644
--- a/arch/arm/mach-davinci/davinci.h
+++ b/arch/arm/mach-davinci/davinci.h
@@ -115,6 +115,7 @@ int dm644x_gpio_register(void);
 /* DM646x function declarations */
 void dm646x_init(void);
 void dm646x_init_time(unsigned long ref_clk_rate, unsigned long aux_clkin_rate);
+void dm646x_register_clocks(void);
 void dm646x_init_mcasp0(struct snd_platform_data *pdata);
 void dm646x_init_mcasp1(struct snd_platform_data *pdata);
 int dm646x_init_edma(struct edma_rsv_info *rsv);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index e1d6e92..22e8dda 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -8,29 +8,32 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+#include <linux/clk-provider.h>
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
 
@@ -46,6 +49,7 @@
 #define DM646X_EMAC_CNTRL_RAM_OFFSET	0x2000
 #define DM646X_EMAC_CNTRL_RAM_SIZE	0x2000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll1_data = {
 	.num       = 1,
 	.phys_base = DAVINCI_PLL1_BASE,
@@ -356,6 +360,7 @@ static struct clk_lookup dm646x_clks[] = {
 	CLK(NULL, "vpif1", &vpif1_clk),
 	CLK(NULL, NULL, NULL),
 };
+#endif
 
 static struct emac_platform_data dm646x_emac_pdata = {
 	.ctrl_reg_offset	= DM646X_EMAC_CNTRL_OFFSET,
@@ -953,10 +958,71 @@ void __init dm646x_init(void)
 void __init dm646x_init_time(unsigned long ref_clk_rate,
 			     unsigned long aux_clkin_rate)
 {
+#ifdef CONFIG_COMMON_CLK
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, ref_clk_rate);
+	clk_register_fixed_rate(NULL, "aux_clkin", NULL, 0, aux_clkin_rate);
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
+static struct resource dm646x_pll1_resources[] = {
+	{
+		.start	= DAVINCI_PLL1_BASE,
+		.end	= DAVINCI_PLL1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm646x_pll1_device = {
+	.name		= "dm646x-pll1",
+	.id		= -1,
+	.resource	= dm646x_pll1_resources,
+	.num_resources	= ARRAY_SIZE(dm646x_pll1_resources),
+};
+
+static struct resource dm646x_pll2_resources[] = {
+	{
+		.start	= DAVINCI_PLL2_BASE,
+		.end	= DAVINCI_PLL2_BASE + SZ_4K - 1,
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
+static struct resource dm646x_psc_resources[] = {
+	{
+		.start	= DAVINCI_PWR_SLEEP_CNTRL_BASE,
+		.end	= DAVINCI_PWR_SLEEP_CNTRL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device dm646x_psc_device = {
+	.name		= "dm646x-psc",
+	.id		= -1,
+	.resource	= dm646x_psc_resources,
+	.num_resources	= ARRAY_SIZE(dm646x_psc_resources),
+};
+
+void __init dm646x_register_clocks(void)
+{
+	platform_device_register(&dm646x_pll1_device);
+	platform_device_register(&dm646x_pll2_device);
+	platform_device_register(&dm646x_psc_device);
 }
 
 static int __init dm646x_init_devices(void)
-- 
2.7.4
