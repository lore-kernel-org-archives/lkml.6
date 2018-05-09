Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935600AbeEIR3Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:29:25 -0400
Received: from vern.gendns.com ([206.190.152.46]:52076 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965834AbeEIR1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:13 -0400
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
Subject: [PATCH v10 22/27] ARM: davinci: da8xx: Remove legacy USB and SATA clock init
Date: Wed,  9 May 2018 12:26:01 -0500
Message-Id: <20180509172606.29387-23-david@lechnology.com>
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

This removes the unused legacy USB and SATA clock init code from
arch/arm/mach-davinci/{devices,usb}-da8xx}.c.

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
- rebased
- add davinci prefix to commit message

v6 changes:
- rebased


 arch/arm/mach-davinci/devices-da8xx.c      |  29 ---
 arch/arm/mach-davinci/include/mach/da8xx.h |   3 -
 arch/arm/mach-davinci/usb-da8xx.c          | 238 ---------------------
 3 files changed, 270 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 73de449bbc68..1fd3619f6a09 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -30,11 +30,6 @@
 #include "cpuidle.h"
 #include "sram.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include <mach/clock.h>
-#include "clock.h"
-#endif
-
 #define DA8XX_TPCC_BASE			0x01c00000
 #define DA8XX_TPTC0_BASE		0x01c08000
 #define DA8XX_TPTC1_BASE		0x01c08400
@@ -1045,29 +1040,6 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
-#ifndef CONFIG_COMMON_CLK
-static struct clk sata_refclk = {
-	.name		= "sata_refclk",
-	.set_rate	= davinci_simple_set_rate,
-};
-
-static struct clk_lookup sata_refclk_lookup =
-		CLK("ahci_da850", "refclk", &sata_refclk);
-
-int __init da850_register_sata_refclk(int rate)
-{
-	int ret;
-
-	sata_refclk.rate = rate;
-	ret = clk_register(&sata_refclk);
-	if (ret)
-		return ret;
-
-	clkdev_add(&sata_refclk_lookup);
-
-	return 0;
-}
-#else
 int __init da850_register_sata_refclk(int rate)
 {
 	struct clk *clk;
@@ -1078,7 +1050,6 @@ int __init da850_register_sata_refclk(int rate)
 
 	return clk_register_clkdev(clk, "refclk", "ahci_da850");
 }
-#endif
 
 static struct resource da850_sata_resources[] = {
 	{
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 5d7b1de9aa7e..ab4a57f433f4 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -103,9 +103,6 @@ int da8xx_register_watchdog(void);
 int da8xx_register_usb_phy(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
-int da8xx_register_usb_refclkin(int rate);
-int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
-int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb_phy_clocks(void);
 int da850_register_sata_refclk(int rate);
 int da8xx_register_emac(void);
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index c8d2f3075e69..c17ce66a3d95 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -20,11 +20,6 @@
 #include <mach/da8xx.h>
 #include <mach/irqs.h>
 
-#ifndef CONFIG_COMMON_CLK
-#include <mach/clock.h>
-#include "clock.h"
-#endif
-
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
@@ -87,11 +82,6 @@ static struct platform_device da8xx_usb20_dev = {
 	.name		= "musb-da8xx",
 	.id             = -1,
 	.dev = {
-		/*
-		 * Setting init_name so that clock lookup will work in
-		 * usb20_phy_clk_enable() even if this device is not registered.
-		 */
-		.init_name		= "musb-da8xx",
 		.platform_data		= &usb_data,
 		.dma_mask		= &usb_dmamask,
 		.coherent_dma_mask      = DMA_BIT_MASK(32),
@@ -140,234 +130,6 @@ int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
 	return platform_device_register(&da8xx_usb11_device);
 }
 
-#ifndef CONFIG_COMMON_CLK
-static struct clk usb_refclkin = {
-	.name		= "usb_refclkin",
-	.set_rate	= davinci_simple_set_rate,
-};
-
-static struct clk_lookup usb_refclkin_lookup =
-	CLK(NULL, "usb_refclkin", &usb_refclkin);
-
-/**
- * da8xx_register_usb_refclkin - register USB_REFCLKIN clock
- *
- * @rate: The clock rate in Hz
- *
- * This clock is only needed if the board provides an external USB_REFCLKIN
- * signal, in which case it will be used as the parent of usb20_phy_clk and/or
- * usb11_phy_clk.
- */
-int __init da8xx_register_usb_refclkin(int rate)
-{
-	int ret;
-
-	usb_refclkin.rate = rate;
-	ret = clk_register(&usb_refclkin);
-	if (ret)
-		return ret;
-
-	clkdev_add(&usb_refclkin_lookup);
-
-	return 0;
-}
-
-static void usb20_phy_clk_enable(struct clk *clk)
-{
-	u32 val;
-	u32 timeout = 500000; /* 500 msec */
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
-	davinci_clk_enable(usb20_clk);
-
-	/*
-	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
-	 * host may use the PLL clock without USB 2.0 OTG being used.
-	 */
-	val &= ~(CFGCHIP2_RESET | CFGCHIP2_PHYPWRDN);
-	val |= CFGCHIP2_PHY_PLLON;
-
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	while (--timeout) {
-		val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-		if (val & CFGCHIP2_PHYCLKGD)
-			goto done;
-		udelay(1);
-	}
-
-	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
-done:
-	davinci_clk_disable(usb20_clk);
-}
-
-static void usb20_phy_clk_disable(struct clk *clk)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-	val |= CFGCHIP2_PHYPWRDN;
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-}
-
-static int usb20_phy_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/* Set the mux depending on the parent clock. */
-	if (parent == &usb_refclkin) {
-		val &= ~CFGCHIP2_USB2PHYCLKMUX;
-	} else if (strcmp(parent->name, "pll0_aux_clk") == 0) {
-		val |= CFGCHIP2_USB2PHYCLKMUX;
-	} else {
-		pr_err("Bad parent on USB 2.0 PHY clock\n");
-		return -EINVAL;
-	}
-
-	/* reference frequency also comes from parent clock */
-	val &= ~CFGCHIP2_REFFREQ_MASK;
-	switch (clk_get_rate(parent)) {
-	case 12000000:
-		val |= CFGCHIP2_REFFREQ_12MHZ;
-		break;
-	case 13000000:
-		val |= CFGCHIP2_REFFREQ_13MHZ;
-		break;
-	case 19200000:
-		val |= CFGCHIP2_REFFREQ_19_2MHZ;
-		break;
-	case 20000000:
-		val |= CFGCHIP2_REFFREQ_20MHZ;
-		break;
-	case 24000000:
-		val |= CFGCHIP2_REFFREQ_24MHZ;
-		break;
-	case 26000000:
-		val |= CFGCHIP2_REFFREQ_26MHZ;
-		break;
-	case 38400000:
-		val |= CFGCHIP2_REFFREQ_38_4MHZ;
-		break;
-	case 40000000:
-		val |= CFGCHIP2_REFFREQ_40MHZ;
-		break;
-	case 48000000:
-		val |= CFGCHIP2_REFFREQ_48MHZ;
-		break;
-	default:
-		pr_err("Bad parent clock rate on USB 2.0 PHY clock\n");
-		return -EINVAL;
-	}
-
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	return 0;
-}
-
-static struct clk usb20_phy_clk = {
-	.name		= "usb0_clk48",
-	.clk_enable	= usb20_phy_clk_enable,
-	.clk_disable	= usb20_phy_clk_disable,
-	.set_parent	= usb20_phy_clk_set_parent,
-};
-
-static struct clk_lookup usb20_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb0_clk48", &usb20_phy_clk);
-
-/**
- * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
- *
- * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
- *	or "pll0_aux" if false.
- */
-int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
-{
-	struct clk *parent;
-	int ret;
-
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
-	ret = PTR_ERR_OR_ZERO(usb20_clk);
-	if (ret)
-		return ret;
-
-	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
-	ret = PTR_ERR_OR_ZERO(parent);
-	if (ret) {
-		clk_put(usb20_clk);
-		return ret;
-	}
-
-	usb20_phy_clk.parent = parent;
-	ret = clk_register(&usb20_phy_clk);
-	if (!ret)
-		clkdev_add(&usb20_phy_clk_lookup);
-
-	clk_put(parent);
-
-	return ret;
-}
-
-static int usb11_phy_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	/* Set the USB 1.1 PHY clock mux based on the parent clock. */
-	if (parent == &usb20_phy_clk) {
-		val &= ~CFGCHIP2_USB1PHYCLKMUX;
-	} else if (parent == &usb_refclkin) {
-		val |= CFGCHIP2_USB1PHYCLKMUX;
-	} else {
-		pr_err("Bad parent on USB 1.1 PHY clock\n");
-		return -EINVAL;
-	}
-
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
-
-	return 0;
-}
-
-static struct clk usb11_phy_clk = {
-	.name		= "usb1_clk48",
-	.set_parent	= usb11_phy_clk_set_parent,
-};
-
-static struct clk_lookup usb11_phy_clk_lookup =
-	CLK("da8xx-usb-phy", "usb1_clk48", &usb11_phy_clk);
-
-/**
- * da8xx_register_usb11_phy_clk - register USB1PHYCLKMUX clock
- *
- * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
- *	or "usb0_clk48" if false.
- */
-int __init da8xx_register_usb11_phy_clk(bool use_usb_refclkin)
-{
-	struct clk *parent;
-	int ret = 0;
-
-	if (use_usb_refclkin)
-		parent = clk_get(NULL, "usb_refclkin");
-	else
-		parent = clk_get(&da8xx_usb_phy.dev, "usb0_clk48");
-	if (IS_ERR(parent))
-		return PTR_ERR(parent);
-
-	usb11_phy_clk.parent = parent;
-	ret = clk_register(&usb11_phy_clk);
-	if (!ret)
-		clkdev_add(&usb11_phy_clk_lookup);
-
-	clk_put(parent);
-
-	return ret;
-}
-#endif
 static struct platform_device da8xx_usb_phy_clks_device = {
 	.name		= "da830-usb-phy-clks",
 	.id		= -1,
-- 
2.17.0
