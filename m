Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965152AbeEIRdh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:33:37 -0400
Received: from vern.gendns.com ([206.190.152.46]:51958 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935558AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v10 12/27] ARM: davinci: da8xx: add new sata_refclk init using common clock framework
Date: Wed,  9 May 2018 12:25:51 -0500
Message-Id: <20180509172606.29387-13-david@lechnology.com>
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

This adds the new SATA REFCLK clock init in mach-davinci/devices-da8xx.c
using the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Also, the #includes are sorted since we are adding some here.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v10 changes:
- none

v9 changes:
- none

v8 changes:
- none

v7 changes:
- none

v6 changes:
- none


 arch/arm/mach-davinci/devices-da8xx.c | 36 ++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 78390c64e6ca..73de449bbc68 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -10,25 +10,30 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  */
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/dma-contiguous.h>
-#include <linux/serial_8250.h>
 #include <linux/ahci_platform.h>
+#include <linux/clk-provider.h>
 #include <linux/clk.h>
-#include <linux/reboot.h>
+#include <linux/clkdev.h>
+#include <linux/dma-contiguous.h>
 #include <linux/dmaengine.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/serial_8250.h>
 
-#include <mach/cputype.h>
 #include <mach/common.h>
-#include <mach/time.h>
+#include <mach/cputype.h>
 #include <mach/da8xx.h>
-#include <mach/clock.h>
+#include <mach/time.h>
+
+#include "asp.h"
 #include "cpuidle.h"
 #include "sram.h"
 
+#ifndef CONFIG_COMMON_CLK
+#include <mach/clock.h>
 #include "clock.h"
-#include "asp.h"
+#endif
 
 #define DA8XX_TPCC_BASE			0x01c00000
 #define DA8XX_TPTC0_BASE		0x01c08000
@@ -1040,6 +1045,7 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
+#ifndef CONFIG_COMMON_CLK
 static struct clk sata_refclk = {
 	.name		= "sata_refclk",
 	.set_rate	= davinci_simple_set_rate,
@@ -1061,6 +1067,18 @@ int __init da850_register_sata_refclk(int rate)
 
 	return 0;
 }
+#else
+int __init da850_register_sata_refclk(int rate)
+{
+	struct clk *clk;
+
+	clk = clk_register_fixed_rate(NULL, "sata_refclk", NULL, 0, rate);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	return clk_register_clkdev(clk, "refclk", "ahci_da850");
+}
+#endif
 
 static struct resource da850_sata_resources[] = {
 	{
-- 
2.17.0
