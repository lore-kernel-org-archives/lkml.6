Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935263AbeEIRdo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:33:44 -0400
Received: from vern.gendns.com ([206.190.152.46]:51914 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935539AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v10 05/27] ARM: davinci: da830: add new clock init using common clock framework
Date: Wed,  9 May 2018 12:25:44 -0500
Message-Id: <20180509172606.29387-6-david@lechnology.com>
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

This adds the new board-specific clock init in mach-davinci/da830.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also clean up the #includes since we are adding some here.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- none

v9 changes:
- register PLL in da830_init_time() instead of as platform device so that we
  get the correct timer0 clock for davinci_timer_init()

v8 changes:
- none

v7 changes:
- add clock platform device declarations
- register platform devices instead of registering clocks directly
- clkdev lookup is moved to drivers/clk
- add davinci prefix to commit description

v6 changes:
- add blank lines between function calls
- include da8xx_register_cfgchip()


 arch/arm/mach-davinci/board-da830-evm.c    |  2 +
 arch/arm/mach-davinci/da830.c              | 70 ++++++++++++++++++++--
 arch/arm/mach-davinci/include/mach/da8xx.h |  1 +
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 14a6fc061744..74df37821abe 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -557,6 +557,8 @@ static __init void da830_evm_init(void)
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	int ret;
 
+	da830_register_clocks();
+
 	ret = da830_register_gpio();
 	if (ret)
 		pr_warn("%s: GPIO init failed: %d\n", __func__, ret);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0b17e5a22e5e..8a79e245db1f 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -8,23 +8,27 @@
  * is licensed "as is" without any warranty of any kind, whether express
  * or implied.
  */
+#include <linux/clk-provider.h>
+#include <linux/clk/davinci.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
-#include <linux/clk.h>
 #include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
 
-#include "psc.h"
-#include <mach/irqs.h>
-#include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/time.h>
+#include <mach/cputype.h>
 #include <mach/da8xx.h>
+#include <mach/irqs.h>
+#include <mach/time.h>
 
-#include "clock.h"
 #include "mux.h"
 
+#ifndef CONFIG_COMMON_CLK
+#include "clock.h"
+#include "psc.h"
+#endif
+
 /* Offsets of the 8 compare registers on the da830 */
 #define DA830_CMP12_0		0x60
 #define DA830_CMP12_1		0x64
@@ -37,6 +41,7 @@
 
 #define DA830_REF_FREQ		24000000
 
+#ifndef CONFIG_COMMON_CLK
 static struct pll_data pll0_data = {
 	.num		= 1,
 	.phys_base	= DA8XX_PLL0_BASE,
@@ -432,6 +437,7 @@ static struct clk_lookup da830_clks[] = {
 	CLK(NULL,		"rmii",		&rmii_clk),
 	CLK(NULL,		NULL,		NULL),
 };
+#endif
 
 /*
  * Device specific mux setup
@@ -1223,6 +1229,58 @@ void __init da830_init(void)
 
 void __init da830_init_time(void)
 {
+#ifdef CONFIG_COMMON_CLK
+	void __iomem *pll;
+	struct clk *clk;
+
+	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
+
+	pll = ioremap(DA8XX_PLL0_BASE, SZ_4K);
+
+	da830_pll_init(NULL, pll, NULL);
+
+	clk = clk_get(NULL, "timer0");
+
+	davinci_timer_init(clk);
+#else
 	davinci_clk_init(da830_clks);
 	davinci_timer_init(&timerp64_0_clk);
+#endif
+}
+
+static struct resource da830_psc0_resources[] = {
+	{
+		.start	= DA8XX_PSC0_BASE,
+		.end	= DA8XX_PSC0_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da830_psc0_device = {
+	.name		= "da830-psc0",
+	.id		= -1,
+	.resource	= da830_psc0_resources,
+	.num_resources	= ARRAY_SIZE(da830_psc0_resources),
+};
+
+static struct resource da830_psc1_resources[] = {
+	{
+		.start	= DA8XX_PSC1_BASE,
+		.end	= DA8XX_PSC1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device da830_psc1_device = {
+	.name		= "da830-psc1",
+	.id		= -1,
+	.resource	= da830_psc1_resources,
+	.num_resources	= ARRAY_SIZE(da830_psc1_resources),
+};
+
+void __init da830_register_clocks(void)
+{
+	/* PLL is registered in da830_init_time() */
+	platform_device_register(&da830_psc0_device);
+	platform_device_register(&da830_psc1_device);
 }
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 9fd6d0125762..64861ac6a9d4 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -89,6 +89,7 @@ extern unsigned int da850_max_speed;
 
 void da830_init(void);
 void da830_init_time(void);
+void da830_register_clocks(void);
 
 void da850_init(void);
 void da850_init_time(void);
-- 
2.17.0
