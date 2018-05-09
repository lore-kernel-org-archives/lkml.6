Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935177AbeEIRde (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:33:34 -0400
Received: from vern.gendns.com ([206.190.152.46]:51966 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935561AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v10 11/27] ARM: davinci: da8xx: add new USB PHY clock init using common clock framework
Date: Wed,  9 May 2018 12:25:50 -0500
Message-Id: <20180509172606.29387-12-david@lechnology.com>
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

This adds the new USB PHY clock init in mach-davinci/usb-da8xx.c using
the new common clock framework drivers.

The #ifdefs are needed to prevent compile errors until the entire
ARCH_DAVINCI is converted.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- none

v9 changes:
- none

v8 changes:
- rebased on "ARM: davinci: DA8XX: fix oops in USB PHY driver due to stack
  allocated platform platform_data"

v7 changes:
- register platform device instead of registering clocks directly
- USB PHY clocks now treated as single device instead of registering them
  separately

v6 changes:
- rename stuff to match changes in "clk: davinci: New driver for TI DA8XX USB
  PHY clocks"
- take advantage of syscon lookup changes in "mfd: syscon: Add syscon_register()
  function"


 arch/arm/mach-davinci/board-da830-evm.c     |  8 ++++++-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  9 +++++--
 arch/arm/mach-davinci/da8xx-dt.c            |  8 ++++++-
 arch/arm/mach-davinci/include/mach/da8xx.h  |  1 +
 arch/arm/mach-davinci/usb-da8xx.c           | 26 +++++++++++++++++++--
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 74df37821abe..ccddbae951d6 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -110,6 +110,12 @@ static __init void da830_evm_usb_init(void)
 {
 	int ret;
 
+#ifdef CONFIG_COMMON_CLK
+	ret = da8xx_register_usb_phy_clocks();
+	if (ret)
+		pr_warn("%s: USB PHY CLK registration failed: %d\n",
+			__func__, ret);
+#else
 	/* USB_REFCLKIN is not used. */
 	ret = da8xx_register_usb20_phy_clk(false);
 	if (ret)
@@ -120,7 +126,7 @@ static __init void da830_evm_usb_init(void)
 	if (ret)
 		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
 			__func__, ret);
-
+#endif
 	ret = da8xx_register_usb_phy();
 	if (ret)
 		pr_warn("%s: USB PHY registration failed: %d\n",
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 7653e9425d44..949ca567e965 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -235,7 +235,12 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB 1.1 PinMux setup failed: %d\n", __func__, ret);
 		return;
 	}
-
+#ifdef CONFIG_COMMON_CLK
+	ret = da8xx_register_usb_phy_clocks();
+	if (ret)
+		pr_warn("%s: USB PHY CLK registration failed: %d\n",
+			__func__, ret);
+#else
 	ret = da8xx_register_usb20_phy_clk(false);
 	if (ret)
 		pr_warn("%s: USB 2.0 PHY CLK registration failed: %d\n",
@@ -245,7 +250,7 @@ static __init void omapl138_hawk_usb_init(void)
 	if (ret)
 		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
 			__func__, ret);
-
+#endif
 	ret = da8xx_register_usb_phy();
 	if (ret)
 		pr_warn("%s: USB PHY registration failed: %d\n",
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index 91dd9cb6d113..c4edf051ef9b 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -69,6 +69,12 @@ static void __init da850_init_machine(void)
 
 	da850_register_clocks();
 
+#ifdef CONFIG_COMMON_CLK
+	ret = da8xx_register_usb_phy_clocks();
+	if (ret)
+		pr_warn("%s: USB PHY CLK registration failed: %d\n",
+			__func__, ret);
+#else
 	ret = da8xx_register_usb20_phy_clk(false);
 	if (ret)
 		pr_warn("%s: registering USB 2.0 PHY clock failed: %d",
@@ -77,7 +83,7 @@ static void __init da850_init_machine(void)
 	if (ret)
 		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
 			__func__, ret);
-
+#endif
 	ret = da850_register_sata_refclk(sata_refclkpn);
 	if (ret)
 		pr_warn("%s: registering SATA REFCLK failed: %d",
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 612e45437cec..5d7b1de9aa7e 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -106,6 +106,7 @@ int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_usb_refclkin(int rate);
 int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
+int da8xx_register_usb_phy_clocks(void);
 int da850_register_sata_refclk(int rate);
 int da8xx_register_emac(void);
 int da8xx_register_uio_pruss(void);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 50445f0e98de..c8d2f3075e69 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -2,29 +2,35 @@
 /*
  * DA8xx USB
  */
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/mfd/da8xx-cfgchip.h>
+#include <linux/mfd/syscon.h>
 #include <linux/phy/phy.h>
+#include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_data/phy-da8xx-usb.h>
 #include <linux/platform_data/usb-davinci.h>
 #include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 
-#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/cputype.h>
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 
+#ifndef CONFIG_COMMON_CLK
+#include <mach/clock.h>
 #include "clock.h"
+#endif
 
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
+#ifndef CONFIG_COMMON_CLK
 static struct clk *usb20_clk;
+#endif
 
 static struct da8xx_usb_phy_platform_data da8xx_usb_phy_pdata;
 
@@ -134,6 +140,7 @@ int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
 	return platform_device_register(&da8xx_usb11_device);
 }
 
+#ifndef CONFIG_COMMON_CLK
 static struct clk usb_refclkin = {
 	.name		= "usb_refclkin",
 	.set_rate	= davinci_simple_set_rate,
@@ -360,3 +367,18 @@ int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
 
 	return ret;
 }
+#endif
+static struct platform_device da8xx_usb_phy_clks_device = {
+	.name		= "da830-usb-phy-clks",
+	.id		= -1,
+};
+
+int __init da8xx_register_usb_phy_clocks(void)
+{
+	struct da8xx_cfgchip_clk_platform_data pdata;
+
+	pdata.cfgchip = da8xx_get_cfgchip();
+	da8xx_usb_phy_clks_device.dev.platform_data = &pdata;
+
+	return platform_device_register(&da8xx_usb_phy_clks_device);
+}
-- 
2.17.0
