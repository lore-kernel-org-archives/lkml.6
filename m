Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965143AbeEIRbc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:31:32 -0400
Received: from vern.gendns.com ([206.190.152.46]:52026 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965809AbeEIR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:05 -0400
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
Subject: [PATCH v10 17/27] ARM: davinci: da850: Remove legacy clock init
Date: Wed,  9 May 2018 12:25:56 -0500
Message-Id: <20180509172606.29387-18-david@lechnology.com>
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

This removes the unused legacy clock init code from
arch/arm/mach-davinci/da850.c.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v10 changes:
- none

v9 changes:
- rebased

v8 changes:
- none

v7 changes:
- rebased
- add davinci prefix to commit message

v6 changes:
- rebased


 arch/arm/mach-davinci/board-omapl138-hawk.c |  12 +-
 arch/arm/mach-davinci/da850.c               | 653 +-------------------
 arch/arm/mach-davinci/da8xx-dt.c            |  12 +-
 3 files changed, 3 insertions(+), 674 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 949ca567e965..466e87b24e9a 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -235,22 +235,12 @@ static __init void omapl138_hawk_usb_init(void)
 		pr_warn("%s: USB 1.1 PinMux setup failed: %d\n", __func__, ret);
 		return;
 	}
-#ifdef CONFIG_COMMON_CLK
+
 	ret = da8xx_register_usb_phy_clocks();
 	if (ret)
 		pr_warn("%s: USB PHY CLK registration failed: %d\n",
 			__func__, ret);
-#else
-	ret = da8xx_register_usb20_phy_clk(false);
-	if (ret)
-		pr_warn("%s: USB 2.0 PHY CLK registration failed: %d\n",
-			__func__, ret);
 
-	ret = da8xx_register_usb11_phy_clk(false);
-	if (ret)
-		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
-			__func__, ret);
-#endif
 	ret = da8xx_register_usb_phy();
 	if (ret)
 		pr_warn("%s: USB PHY registration failed: %d\n",
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 9e00beb943c9..4528bbf0c861 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -38,559 +38,12 @@
 
 #include "mux.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include "clock.h"
-#include "psc.h"
-#endif
-
 #define DA850_PLL1_BASE		0x01e1a000
 #define DA850_TIMER64P2_BASE	0x01f0c000
 #define DA850_TIMER64P3_BASE	0x01f0d000
 
 #define DA850_REF_FREQ		24000000
 
-#ifndef CONFIG_COMMON_CLK
-static int da850_set_armrate(struct clk *clk, unsigned long rate);
-static int da850_round_armrate(struct clk *clk, unsigned long rate);
-static int da850_set_pll0rate(struct clk *clk, unsigned long armrate);
-
-static struct pll_data pll0_data = {
-	.num		= 1,
-	.phys_base	= DA8XX_PLL0_BASE,
-	.flags		= PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
-};
-
-static struct clk ref_clk = {
-	.name		= "ref_clk",
-	.rate		= DA850_REF_FREQ,
-	.set_rate	= davinci_simple_set_rate,
-};
-
-static struct clk pll0_clk = {
-	.name		= "pll0",
-	.parent		= &ref_clk,
-	.pll_data	= &pll0_data,
-	.flags		= CLK_PLL,
-	.set_rate	= da850_set_pll0rate,
-};
-
-static struct clk pll0_aux_clk = {
-	.name		= "pll0_aux_clk",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll0_sysclk1 = {
-	.name		= "pll0_sysclk1",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV1,
-};
-
-static struct clk pll0_sysclk2 = {
-	.name		= "pll0_sysclk2",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV2,
-};
-
-static struct clk pll0_sysclk3 = {
-	.name		= "pll0_sysclk3",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV3,
-	.set_rate	= davinci_set_sysclk_rate,
-	.maxrate	= 100000000,
-};
-
-static struct clk pll0_sysclk4 = {
-	.name		= "pll0_sysclk4",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV4,
-};
-
-static struct clk pll0_sysclk5 = {
-	.name		= "pll0_sysclk5",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV5,
-};
-
-static struct clk pll0_sysclk6 = {
-	.name		= "pll0_sysclk6",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV6,
-};
-
-static struct clk pll0_sysclk7 = {
-	.name		= "pll0_sysclk7",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV7,
-};
-
-static struct pll_data pll1_data = {
-	.num		= 2,
-	.phys_base	= DA850_PLL1_BASE,
-	.flags		= PLL_HAS_POSTDIV,
-};
-
-static struct clk pll1_clk = {
-	.name		= "pll1",
-	.parent		= &ref_clk,
-	.pll_data	= &pll1_data,
-	.flags		= CLK_PLL,
-};
-
-static struct clk pll1_aux_clk = {
-	.name		= "pll1_aux_clk",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll1_sysclk2 = {
-	.name		= "pll1_sysclk2",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV2,
-};
-
-static struct clk pll1_sysclk3 = {
-	.name		= "pll1_sysclk3",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV3,
-};
-
-static int da850_async3_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
-
-	if (parent == &pll0_sysclk2) {
-		val &= ~CFGCHIP3_ASYNC3_CLKSRC;
-	} else if (parent == &pll1_sysclk2) {
-		val |= CFGCHIP3_ASYNC3_CLKSRC;
-	} else {
-		pr_err("Bad parent on async3 clock mux\n");
-		return -EINVAL;
-	}
-
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
-
-	return 0;
-}
-
-static struct clk async3_clk = {
-	.name		= "async3",
-	.parent		= &pll1_sysclk2,
-	.set_parent	= da850_async3_set_parent,
-};
-
-static struct clk i2c0_clk = {
-	.name		= "i2c0",
-	.parent		= &pll0_aux_clk,
-};
-
-static struct clk timerp64_0_clk = {
-	.name		= "timer0",
-	.parent		= &pll0_aux_clk,
-};
-
-static struct clk timerp64_1_clk = {
-	.name		= "timer1",
-	.parent		= &pll0_aux_clk,
-};
-
-static struct clk arm_rom_clk = {
-	.name		= "arm_rom",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_ARM_RAM_ROM,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk tpcc0_clk = {
-	.name		= "tpcc0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_TPCC,
-	.flags		= ALWAYS_ENABLED | CLK_PSC,
-};
-
-static struct clk tptc0_clk = {
-	.name		= "tptc0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_TPTC0,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk tptc1_clk = {
-	.name		= "tptc1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_TPTC1,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk tpcc1_clk = {
-	.name		= "tpcc1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA850_LPSC1_TPCC1,
-	.gpsc		= 1,
-	.flags		= CLK_PSC | ALWAYS_ENABLED,
-};
-
-static struct clk tptc2_clk = {
-	.name		= "tptc2",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA850_LPSC1_TPTC2,
-	.gpsc		= 1,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk pruss_clk = {
-	.name		= "pruss",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_PRUSS,
-};
-
-static struct clk uart0_clk = {
-	.name		= "uart0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_UART0,
-};
-
-static struct clk uart1_clk = {
-	.name		= "uart1",
-	.parent		= &async3_clk,
-	.lpsc		= DA8XX_LPSC1_UART1,
-	.gpsc		= 1,
-};
-
-static struct clk uart2_clk = {
-	.name		= "uart2",
-	.parent		= &async3_clk,
-	.lpsc		= DA8XX_LPSC1_UART2,
-	.gpsc		= 1,
-};
-
-static struct clk aintc_clk = {
-	.name		= "aintc",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC0_AINTC,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk gpio_clk = {
-	.name		= "gpio",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC1_GPIO,
-	.gpsc		= 1,
-};
-
-static struct clk i2c1_clk = {
-	.name		= "i2c1",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC1_I2C,
-	.gpsc		= 1,
-};
-
-static struct clk emif3_clk = {
-	.name		= "emif3",
-	.parent		= &pll0_sysclk5,
-	.lpsc		= DA8XX_LPSC1_EMIF3C,
-	.gpsc		= 1,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk arm_clk = {
-	.name		= "arm",
-	.parent		= &pll0_sysclk6,
-	.lpsc		= DA8XX_LPSC0_ARM,
-	.flags		= ALWAYS_ENABLED,
-	.set_rate	= da850_set_armrate,
-	.round_rate	= da850_round_armrate,
-};
-
-static struct clk rmii_clk = {
-	.name		= "rmii",
-	.parent		= &pll0_sysclk7,
-};
-
-static struct clk emac_clk = {
-	.name		= "emac",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC1_CPGMAC,
-	.gpsc		= 1,
-};
-
-/*
- * In order to avoid adding the emac_clk to the clock lookup table twice (and
- * screwing up the linked list in the process) create a separate clock for
- * mdio inheriting the rate from emac_clk.
- */
-static struct clk mdio_clk = {
-	.name		= "mdio",
-	.parent		= &emac_clk,
-};
-
-static struct clk mcasp_clk = {
-	.name		= "mcasp",
-	.parent		= &async3_clk,
-	.lpsc		= DA8XX_LPSC1_McASP0,
-	.gpsc		= 1,
-};
-
-static struct clk mcbsp0_clk = {
-	.name		= "mcbsp0",
-	.parent		= &async3_clk,
-	.lpsc		= DA850_LPSC1_McBSP0,
-	.gpsc		= 1,
-};
-
-static struct clk mcbsp1_clk = {
-	.name		= "mcbsp1",
-	.parent		= &async3_clk,
-	.lpsc		= DA850_LPSC1_McBSP1,
-	.gpsc		= 1,
-};
-
-static struct clk lcdc_clk = {
-	.name		= "lcdc",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_LCDC,
-	.gpsc		= 1,
-};
-
-static struct clk mmcsd0_clk = {
-	.name		= "mmcsd0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_MMC_SD,
-};
-
-static struct clk mmcsd1_clk = {
-	.name		= "mmcsd1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA850_LPSC1_MMC_SD1,
-	.gpsc		= 1,
-};
-
-static struct clk aemif_clk = {
-	.name		= "aemif",
-	.parent		= &pll0_sysclk3,
-	.lpsc		= DA8XX_LPSC0_EMIF25,
-	.flags		= ALWAYS_ENABLED,
-};
-
-/*
- * In order to avoid adding the aemif_clk to the clock lookup table twice (and
- * screwing up the linked list in the process) create a separate clock for
- * nand inheriting the rate from aemif_clk.
- */
-static struct clk aemif_nand_clk = {
-	.name		= "nand",
-	.parent		= &aemif_clk,
-};
-
-static struct clk usb11_clk = {
-	.name		= "usb11",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC1_USB11,
-	.gpsc		= 1,
-};
-
-static struct clk usb20_clk = {
-	.name		= "usb20",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_USB20,
-	.gpsc		= 1,
-};
-
-static struct clk cppi41_clk = {
-	.name		= "cppi41",
-	.parent		= &usb20_clk,
-};
-
-static struct clk spi0_clk = {
-	.name		= "spi0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_SPI0,
-};
-
-static struct clk spi1_clk = {
-	.name		= "spi1",
-	.parent		= &async3_clk,
-	.lpsc		= DA8XX_LPSC1_SPI1,
-	.gpsc		= 1,
-};
-
-static struct clk vpif_clk = {
-	.name		= "vpif",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA850_LPSC1_VPIF,
-	.gpsc		= 1,
-};
-
-static struct clk sata_clk = {
-	.name		= "sata",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA850_LPSC1_SATA,
-	.gpsc		= 1,
-	.flags		= PSC_FORCE,
-};
-
-static struct clk dsp_clk = {
-	.name		= "dsp",
-	.parent		= &pll0_sysclk1,
-	.domain		= DAVINCI_GPSC_DSPDOMAIN,
-	.lpsc		= DA8XX_LPSC0_GEM,
-	.flags		= PSC_LRST | PSC_FORCE,
-};
-
-static struct clk ehrpwm_clk = {
-	.name		= "ehrpwm",
-	.parent		= &async3_clk,
-	.lpsc		= DA8XX_LPSC1_PWM,
-	.gpsc		= 1,
-};
-
-static struct clk ehrpwm0_clk = {
-	.name		= "ehrpwm0",
-	.parent		= &ehrpwm_clk,
-};
-
-static struct clk ehrpwm1_clk = {
-	.name		= "ehrpwm1",
-	.parent		= &ehrpwm_clk,
-};
-
-#define DA8XX_EHRPWM_TBCLKSYNC	BIT(12)
-
-static void ehrpwm_tblck_enable(struct clk *clk)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG));
-	val |= DA8XX_EHRPWM_TBCLKSYNC;
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG));
-}
-
-static void ehrpwm_tblck_disable(struct clk *clk)
-{
-	u32 val;
-
-	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG));
-	val &= ~DA8XX_EHRPWM_TBCLKSYNC;
-	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP1_REG));
-}
-
-static struct clk ehrpwm_tbclk = {
-	.name		= "ehrpwm_tbclk",
-	.parent		= &ehrpwm_clk,
-	.clk_enable	= ehrpwm_tblck_enable,
-	.clk_disable	= ehrpwm_tblck_disable,
-};
-
-static struct clk ehrpwm0_tbclk = {
-	.name		= "ehrpwm0_tbclk",
-	.parent		= &ehrpwm_tbclk,
-};
-
-static struct clk ehrpwm1_tbclk = {
-	.name		= "ehrpwm1_tbclk",
-	.parent		= &ehrpwm_tbclk,
-};
-
-static struct clk ecap_clk = {
-	.name		= "ecap",
-	.parent		= &async3_clk,
-	.lpsc		= DA8XX_LPSC1_ECAP,
-	.gpsc		= 1,
-};
-
-static struct clk ecap0_clk = {
-	.name		= "ecap0_clk",
-	.parent		= &ecap_clk,
-};
-
-static struct clk ecap1_clk = {
-	.name		= "ecap1_clk",
-	.parent		= &ecap_clk,
-};
-
-static struct clk ecap2_clk = {
-	.name		= "ecap2_clk",
-	.parent		= &ecap_clk,
-};
-
-static struct clk_lookup da850_clks[] = {
-	CLK(NULL,		"ref",		&ref_clk),
-	CLK(NULL,		"pll0",		&pll0_clk),
-	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
-	CLK(NULL,		"pll0_sysclk1",	&pll0_sysclk1),
-	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
-	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
-	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
-	CLK(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
-	CLK(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
-	CLK(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
-	CLK(NULL,		"pll1",		&pll1_clk),
-	CLK(NULL,		"pll1_aux",	&pll1_aux_clk),
-	CLK(NULL,		"pll1_sysclk2",	&pll1_sysclk2),
-	CLK(NULL,		"pll1_sysclk3",	&pll1_sysclk3),
-	CLK(NULL,		"async3",	&async3_clk),
-	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
-	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("davinci-wdt",	NULL,		&timerp64_1_clk),
-	CLK(NULL,		"arm_rom",	&arm_rom_clk),
-	CLK(NULL,		"tpcc0",	&tpcc0_clk),
-	CLK(NULL,		"tptc0",	&tptc0_clk),
-	CLK(NULL,		"tptc1",	&tptc1_clk),
-	CLK(NULL,		"tpcc1",	&tpcc1_clk),
-	CLK(NULL,		"tptc2",	&tptc2_clk),
-	CLK("pruss_uio",	"pruss",	&pruss_clk),
-	CLK("serial8250.0",	NULL,		&uart0_clk),
-	CLK("serial8250.1",	NULL,		&uart1_clk),
-	CLK("serial8250.2",	NULL,		&uart2_clk),
-	CLK(NULL,		"aintc",	&aintc_clk),
-	CLK(NULL,		"gpio",		&gpio_clk),
-	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK(NULL,		"emif3",	&emif3_clk),
-	CLK(NULL,		"arm",		&arm_clk),
-	CLK(NULL,		"rmii",		&rmii_clk),
-	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK("davinci_mdio.0",	"fck",		&mdio_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
-	CLK("davinci-mcbsp.0",	NULL,		&mcbsp0_clk),
-	CLK("davinci-mcbsp.1",	NULL,		&mcbsp1_clk),
-	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
-	CLK("da830-mmc.0",	NULL,		&mmcsd0_clk),
-	CLK("da830-mmc.1",	NULL,		&mmcsd1_clk),
-	CLK("ti-aemif",		NULL,		&aemif_clk),
-	CLK("davinci-nand.0",	"aemif",	&aemif_nand_clk),
-	CLK("ohci-da8xx",	NULL,		&usb11_clk),
-	CLK("musb-da8xx",	NULL,		&usb20_clk),
-	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
-	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-	CLK("spi_davinci.1",	NULL,		&spi1_clk),
-	CLK("vpif",		NULL,		&vpif_clk),
-	CLK("ahci_da850",	"fck",		&sata_clk),
-	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
-	CLK(NULL,		NULL,		&ehrpwm_clk),
-	CLK("ehrpwm.0",		"fck",		&ehrpwm0_clk),
-	CLK("ehrpwm.1",		"fck",		&ehrpwm1_clk),
-	CLK(NULL,		NULL,		&ehrpwm_tbclk),
-	CLK("ehrpwm.0",		"tbclk",	&ehrpwm0_tbclk),
-	CLK("ehrpwm.1",		"tbclk",	&ehrpwm1_tbclk),
-	CLK(NULL,		NULL,		&ecap_clk),
-	CLK("ecap.0",		"fck",		&ecap0_clk),
-	CLK("ecap.1",		"fck",		&ecap1_clk),
-	CLK("ecap.2",		"fck",		&ecap2_clk),
-	CLK(NULL,		NULL,		NULL),
-};
-#endif
-
 /*
  * Device specific mux setup
  *
@@ -965,8 +418,6 @@ static struct map_desc da850_io_desc[] = {
 	},
 };
 
-static u32 da850_psc_bases[] = { DA8XX_PSC0_BASE, DA8XX_PSC1_BASE };
-
 /* Contents of JTAG ID register used to identify exact cpu type */
 static struct davinci_id da850_ids[] = {
 	{
@@ -1176,93 +627,11 @@ int da850_register_cpufreq(char *async_clk)
 
 	return platform_device_register(&da850_cpufreq_device);
 }
-
-#ifndef CONFIG_COMMON_CLK
-static int da850_round_armrate(struct clk *clk, unsigned long rate)
-{
-	int ret = 0, diff;
-	unsigned int best = (unsigned int) -1;
-	struct cpufreq_frequency_table *table = cpufreq_info.freq_table;
-	struct cpufreq_frequency_table *pos;
-
-	rate /= 1000; /* convert to kHz */
-
-	cpufreq_for_each_entry(pos, table) {
-		diff = pos->frequency - rate;
-		if (diff < 0)
-			diff = -diff;
-
-		if (diff < best) {
-			best = diff;
-			ret = pos->frequency;
-		}
-	}
-
-	return ret * 1000;
-}
-
-static int da850_set_armrate(struct clk *clk, unsigned long index)
-{
-	struct clk *pllclk = &pll0_clk;
-
-	return clk_set_rate(pllclk, index);
-}
-
-static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
-{
-	struct pll_data *pll = clk->pll_data;
-	struct cpufreq_frequency_table *freq;
-	unsigned int prediv, mult, postdiv;
-	struct da850_opp *opp = NULL;
-	int ret;
-
-	rate /= 1000;
-
-	for (freq = da850_freq_table;
-	     freq->frequency != CPUFREQ_TABLE_END; freq++) {
-		/* rate is in Hz, freq->frequency is in KHz */
-		if (freq->frequency == rate) {
-			opp = (struct da850_opp *)freq->driver_data;
-			break;
-		}
-	}
-
-	if (!opp)
-		return -EINVAL;
-
-	prediv = opp->prediv;
-	mult = opp->mult;
-	postdiv = opp->postdiv;
-
-	ret = davinci_set_pllrate(pll, prediv, mult, postdiv);
-	if (WARN_ON(ret))
-		return ret;
-
-	return 0;
-}
-#endif /* CONFIG_COMMON_CLK */
 #else
 int __init da850_register_cpufreq(char *async_clk)
 {
 	return 0;
 }
-
-#ifndef CONFIG_COMMON_CLK
-static int da850_set_armrate(struct clk *clk, unsigned long rate)
-{
-	return -EINVAL;
-}
-
-static int da850_set_pll0rate(struct clk *clk, unsigned long armrate)
-{
-	return -EINVAL;
-}
-
-static int da850_round_armrate(struct clk *clk, unsigned long rate)
-{
-	return clk->rate;
-}
-#endif /* CONFIG_COMMON_CLK */
 #endif
 
 /* VPIF resource, platform data */
@@ -1364,8 +733,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
 	.ids			= da850_ids,
 	.ids_num		= ARRAY_SIZE(da850_ids),
-	.psc_bases		= da850_psc_bases,
-	.psc_bases_num		= ARRAY_SIZE(da850_psc_bases),
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
@@ -1381,8 +748,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 
 void __init da850_init(void)
 {
-	unsigned int v;
-
 	davinci_common_init(&davinci_soc_info_da850);
 
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
@@ -1390,23 +755,11 @@ void __init da850_init(void)
 		return;
 
 	da8xx_syscfg1_base = ioremap(DA8XX_SYSCFG1_BASE, SZ_4K);
-	if (WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module"))
-		return;
-
-	/* Unlock writing to PLL0 registers */
-	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
-	v &= ~CFGCHIP0_PLL_MASTER_LOCK;
-	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
-
-	/* Unlock writing to PLL1 registers */
-	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
-	v &= ~CFGCHIP3_PLL1_MASTER_LOCK;
-	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
+	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
 void __init da850_init_time(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	void __iomem *pll0;
 	struct regmap *cfgchip;
 	struct clk *clk;
@@ -1421,10 +774,6 @@ void __init da850_init_time(void)
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
-#else
-	davinci_clk_init(da850_clks);
-	davinci_timer_init(&timerp64_0_clk);
-#endif
 }
 
 static struct resource da850_pll1_resources[] = {
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index c4edf051ef9b..088bc5c0318b 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -69,21 +69,11 @@ static void __init da850_init_machine(void)
 
 	da850_register_clocks();
 
-#ifdef CONFIG_COMMON_CLK
 	ret = da8xx_register_usb_phy_clocks();
 	if (ret)
 		pr_warn("%s: USB PHY CLK registration failed: %d\n",
 			__func__, ret);
-#else
-	ret = da8xx_register_usb20_phy_clk(false);
-	if (ret)
-		pr_warn("%s: registering USB 2.0 PHY clock failed: %d",
-			__func__, ret);
-	ret = da8xx_register_usb11_phy_clk(false);
-	if (ret)
-		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
-			__func__, ret);
-#endif
+
 	ret = da850_register_sata_refclk(sata_refclkpn);
 	if (ret)
 		pr_warn("%s: registering SATA REFCLK failed: %d",
-- 
2.17.0
