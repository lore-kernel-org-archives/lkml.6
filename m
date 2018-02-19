Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeBSUs4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:48:56 -0500
Received: from vern.gendns.com ([206.190.152.46]:59520 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbeBSUsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:48:53 -0500
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
Subject: [PATCH v7 41/42] ARM: davinci: da8xx-dt: switch to device tree clocks
Date: Mon, 19 Feb 2018 14:22:02 -0600
Message-Id: <1519071723-31790-42-git-send-email-david@lechnology.com>
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

This removes all of the clock init code from da8xx-dt.c. This includes
all of the OF_DEV_AUXDATA that was just used for looking up clocks.

Signed-off-by: David Lechner <david@lechnology.com>
---

v7 changes:
- rebased
- drop of_platform_default_populate(NULL, NULL, NULL)
- add change in pm_domain.c

Note: I didn't see this until it was too late, but Bartosz has an interesting
alternative for the legacy PM domain stuff at
https://github.com/brgl/linux/commit/0197b11512e44206708f4bd320c369a2a163e82d

v6 changes:
- removed misleading statement from commit message

 arch/arm/mach-davinci/da8xx-dt.c  | 58 ---------------------------------------
 arch/arm/mach-davinci/pm_domain.c |  5 ++++
 2 files changed, 5 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 088bc5c..23ac410 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -19,67 +19,10 @@
 #include "cp_intc.h"
 #include <mach/da8xx.h>
 
-static struct of_dev_auxdata da850_aemif_auxdata_lookup[] = {
-	OF_DEV_AUXDATA("ti,davinci-nand", 0x62000000, "davinci-nand.0", NULL),
-	{}
-};
-
-static struct aemif_platform_data aemif_data = {
-	.dev_lookup = da850_aemif_auxdata_lookup,
-};
-
-static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01c22000, "i2c_davinci.1", NULL),
-	OF_DEV_AUXDATA("ti,davinci-i2c", 0x01e28000, "i2c_davinci.2", NULL),
-	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "davinci-wdt", NULL),
-	OF_DEV_AUXDATA("ti,da830-mmc", 0x01c40000, "da830-mmc.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f00000, "ehrpwm.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-ehrpwm", 0x01f02000, "ehrpwm.1", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f06000, "ecap.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f07000, "ecap.1", NULL),
-	OF_DEV_AUXDATA("ti,da850-ecap", 0x01f08000, "ecap.2", NULL),
-	OF_DEV_AUXDATA("ti,da830-spi", 0x01c41000, "spi_davinci.0", NULL),
-	OF_DEV_AUXDATA("ti,da830-spi", 0x01f0e000, "spi_davinci.1", NULL),
-	OF_DEV_AUXDATA("ns16550a", 0x01c42000, "serial8250.0", NULL),
-	OF_DEV_AUXDATA("ns16550a", 0x01d0c000, "serial8250.1", NULL),
-	OF_DEV_AUXDATA("ns16550a", 0x01d0d000, "serial8250.2", NULL),
-	OF_DEV_AUXDATA("ti,davinci_mdio", 0x01e24000, "davinci_mdio.0", NULL),
-	OF_DEV_AUXDATA("ti,davinci-dm6467-emac", 0x01e20000, "davinci_emac.1",
-		       NULL),
-	OF_DEV_AUXDATA("ti,da830-mcasp-audio", 0x01d00000, "davinci-mcasp.0", NULL),
-	OF_DEV_AUXDATA("ti,da850-aemif", 0x68000000, "ti-aemif", &aemif_data),
-	OF_DEV_AUXDATA("ti,da850-tilcdc", 0x01e13000, "da8xx_lcdc.0", NULL),
-	OF_DEV_AUXDATA("ti,da830-ohci", 0x01e25000, "ohci-da8xx", NULL),
-	OF_DEV_AUXDATA("ti,da830-musb", 0x01e00000, "musb-da8xx", NULL),
-	OF_DEV_AUXDATA("ti,da830-usb-phy", 0x01c1417c, "da8xx-usb-phy", NULL),
-	OF_DEV_AUXDATA("ti,da850-ahci", 0x01e18000, "ahci_da850", NULL),
-	OF_DEV_AUXDATA("ti,da850-vpif", 0x01e17000, "vpif", NULL),
-	OF_DEV_AUXDATA("ti,da850-dsp", 0x11800000, "davinci-rproc.0", NULL),
-	{}
-};
-
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 
 static void __init da850_init_machine(void)
 {
-	/* All existing boards use 100MHz SATA refclkpn */
-	static const unsigned long sata_refclkpn = 100 * 1000 * 1000;
-
-	int ret;
-
-	da850_register_clocks();
-
-	ret = da8xx_register_usb_phy_clocks();
-	if (ret)
-		pr_warn("%s: USB PHY CLK registration failed: %d\n",
-			__func__, ret);
-
-	ret = da850_register_sata_refclk(sata_refclkpn);
-	if (ret)
-		pr_warn("%s: registering SATA REFCLK failed: %d",
-			__func__, ret);
-
-	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 	davinci_pm_init();
 	pdata_quirks_init();
 }
@@ -94,7 +37,6 @@ static const char *const da850_boards_compat[] __initconst = {
 
 DT_MACHINE_START(DA850_DT, "Generic DA850/OMAP-L138/AM18x")
 	.map_io		= da850_init,
-	.init_time	= da850_init_time,
 	.init_machine	= da850_init_machine,
 	.dt_compat	= da850_boards_compat,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
index 78eac2c..e251fd5 100644
--- a/arch/arm/mach-davinci/pm_domain.c
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_clock.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 static struct dev_pm_domain davinci_pm_domain = {
 	.ops = {
@@ -28,6 +29,10 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 
 static int __init davinci_pm_runtime_init(void)
 {
+	if (of_have_populated_dt())
+		return 0;
+
+	/* Use pm_clk as fallback if we're not using genpd. */
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 
 	return 0;
-- 
2.7.4
