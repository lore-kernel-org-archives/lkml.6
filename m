Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935291AbeEIRe5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:34:57 -0400
Received: from vern.gendns.com ([206.190.152.46]:51926 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935542AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
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
Subject: [PATCH v10 16/27] ARM: davinci: da830: Remove legacy clock init
Date: Wed,  9 May 2018 12:25:55 -0500
Message-Id: <20180509172606.29387-17-david@lechnology.com>
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
arch/arm/mach-davinci/da830.c.

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


 arch/arm/mach-davinci/board-da830-evm.c |  12 -
 arch/arm/mach-davinci/da830.c           | 412 ------------------------
 2 files changed, 424 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index ccddbae951d6..b2470141dba3 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -110,23 +110,11 @@ static __init void da830_evm_usb_init(void)
 {
 	int ret;
 
-#ifdef CONFIG_COMMON_CLK
 	ret = da8xx_register_usb_phy_clocks();
 	if (ret)
 		pr_warn("%s: USB PHY CLK registration failed: %d\n",
 			__func__, ret);
-#else
-	/* USB_REFCLKIN is not used. */
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
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 8a79e245db1f..0bc5bd2665df 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -24,11 +24,6 @@
 
 #include "mux.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include "clock.h"
-#include "psc.h"
-#endif
-
 /* Offsets of the 8 compare registers on the da830 */
 #define DA830_CMP12_0		0x60
 #define DA830_CMP12_1		0x64
@@ -41,404 +36,6 @@
 
 #define DA830_REF_FREQ		24000000
 
-#ifndef CONFIG_COMMON_CLK
-static struct pll_data pll0_data = {
-	.num		= 1,
-	.phys_base	= DA8XX_PLL0_BASE,
-	.flags		= PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
-};
-
-static struct clk ref_clk = {
-	.name		= "ref_clk",
-	.rate		= DA830_REF_FREQ,
-};
-
-static struct clk pll0_clk = {
-	.name		= "pll0",
-	.parent		= &ref_clk,
-	.pll_data	= &pll0_data,
-	.flags		= CLK_PLL,
-};
-
-static struct clk pll0_aux_clk = {
-	.name		= "pll0_aux_clk",
-	.parent		= &pll0_clk,
-	.flags		= CLK_PLL | PRE_PLL,
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
-static struct clk scr0_ss_clk = {
-	.name		= "scr0_ss",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_SCR0_SS,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk scr1_ss_clk = {
-	.name		= "scr1_ss",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_SCR1_SS,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk scr2_ss_clk = {
-	.name		= "scr2_ss",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_SCR2_SS,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk dmax_clk = {
-	.name		= "dmax",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_PRUSS,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk tpcc_clk = {
-	.name		= "tpcc",
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
-static struct clk mmcsd_clk = {
-	.name		= "mmcsd",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC0_MMC_SD,
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
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_UART1,
-	.gpsc		= 1,
-};
-
-static struct clk uart2_clk = {
-	.name		= "uart2",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_UART2,
-	.gpsc		= 1,
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
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_SPI1,
-	.gpsc		= 1,
-};
-
-static struct clk ecap0_clk = {
-	.name		= "ecap0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_ECAP,
-	.gpsc		= 1,
-};
-
-static struct clk ecap1_clk = {
-	.name		= "ecap1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_ECAP,
-	.gpsc		= 1,
-};
-
-static struct clk ecap2_clk = {
-	.name		= "ecap2",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_ECAP,
-	.gpsc		= 1,
-};
-
-static struct clk pwm0_clk = {
-	.name		= "pwm0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_PWM,
-	.gpsc		= 1,
-};
-
-static struct clk pwm1_clk = {
-	.name		= "pwm1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_PWM,
-	.gpsc		= 1,
-};
-
-static struct clk pwm2_clk = {
-	.name		= "pwm2",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_PWM,
-	.gpsc		= 1,
-};
-
-static struct clk eqep0_clk = {
-	.name		= "eqep0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA830_LPSC1_EQEP,
-	.gpsc		= 1,
-};
-
-static struct clk eqep1_clk = {
-	.name		= "eqep1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA830_LPSC1_EQEP,
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
-static struct clk mcasp0_clk = {
-	.name		= "mcasp0",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA8XX_LPSC1_McASP0,
-	.gpsc		= 1,
-};
-
-static struct clk mcasp1_clk = {
-	.name		= "mcasp1",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA830_LPSC1_McASP1,
-	.gpsc		= 1,
-};
-
-static struct clk mcasp2_clk = {
-	.name		= "mcasp2",
-	.parent		= &pll0_sysclk2,
-	.lpsc		= DA830_LPSC1_McASP2,
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
-static struct clk aemif_clk = {
-	.name		= "aemif",
-	.parent		= &pll0_sysclk3,
-	.lpsc		= DA8XX_LPSC0_EMIF25,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk aintc_clk = {
-	.name		= "aintc",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC0_AINTC,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk secu_mgr_clk = {
-	.name		= "secu_mgr",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC0_SECU_MGR,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk emac_clk = {
-	.name		= "emac",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC1_CPGMAC,
-	.gpsc		= 1,
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
-static struct clk usb11_clk = {
-	.name		= "usb11",
-	.parent		= &pll0_sysclk4,
-	.lpsc		= DA8XX_LPSC1_USB11,
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
-};
-
-static struct clk rmii_clk = {
-	.name		= "rmii",
-	.parent		= &pll0_sysclk7,
-};
-
-static struct clk_lookup da830_clks[] = {
-	CLK(NULL,		"ref",		&ref_clk),
-	CLK(NULL,		"pll0",		&pll0_clk),
-	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
-	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
-	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
-	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
-	CLK(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
-	CLK(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
-	CLK(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
-	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
-	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("davinci-wdt",	NULL,		&timerp64_1_clk),
-	CLK(NULL,		"arm_rom",	&arm_rom_clk),
-	CLK(NULL,		"scr0_ss",	&scr0_ss_clk),
-	CLK(NULL,		"scr1_ss",	&scr1_ss_clk),
-	CLK(NULL,		"scr2_ss",	&scr2_ss_clk),
-	CLK(NULL,		"dmax",		&dmax_clk),
-	CLK(NULL,		"tpcc",		&tpcc_clk),
-	CLK(NULL,		"tptc0",	&tptc0_clk),
-	CLK(NULL,		"tptc1",	&tptc1_clk),
-	CLK("da830-mmc.0",	NULL,		&mmcsd_clk),
-	CLK("serial8250.0",	NULL,		&uart0_clk),
-	CLK("serial8250.1",	NULL,		&uart1_clk),
-	CLK("serial8250.2",	NULL,		&uart2_clk),
-	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-	CLK("spi_davinci.1",	NULL,		&spi1_clk),
-	CLK(NULL,		"ecap0",	&ecap0_clk),
-	CLK(NULL,		"ecap1",	&ecap1_clk),
-	CLK(NULL,		"ecap2",	&ecap2_clk),
-	CLK(NULL,		"pwm0",		&pwm0_clk),
-	CLK(NULL,		"pwm1",		&pwm1_clk),
-	CLK(NULL,		"pwm2",		&pwm2_clk),
-	CLK("eqep.0",		NULL,		&eqep0_clk),
-	CLK("eqep.1",		NULL,		&eqep1_clk),
-	CLK("da8xx_lcdc.0",	"fck",		&lcdc_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
-	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
-	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK("musb-da8xx",	NULL,		&usb20_clk),
-	CLK("cppi41-dmaengine",	NULL,		&cppi41_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
-	CLK(NULL,		"aintc",	&aintc_clk),
-	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
-	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK("davinci_mdio.0",   "fck",          &emac_clk),
-	CLK(NULL,		"gpio",		&gpio_clk),
-	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK("ohci-da8xx",	NULL,	&usb11_clk),
-	CLK(NULL,		"emif3",	&emif3_clk),
-	CLK(NULL,		"arm",		&arm_clk),
-	CLK(NULL,		"rmii",		&rmii_clk),
-	CLK(NULL,		NULL,		NULL),
-};
-#endif
-
 /*
  * Device specific mux setup
  *
@@ -1136,8 +733,6 @@ static struct map_desc da830_io_desc[] = {
 	},
 };
 
-static u32 da830_psc_bases[] = { DA8XX_PSC0_BASE, DA8XX_PSC1_BASE };
-
 /* Contents of JTAG ID register used to identify exact cpu type */
 static struct davinci_id da830_ids[] = {
 	{
@@ -1206,8 +801,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.jtag_id_reg		= DA8XX_SYSCFG0_BASE + DA8XX_JTAG_ID_REG,
 	.ids			= da830_ids,
 	.ids_num		= ARRAY_SIZE(da830_ids),
-	.psc_bases		= da830_psc_bases,
-	.psc_bases_num		= ARRAY_SIZE(da830_psc_bases),
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
@@ -1229,7 +822,6 @@ void __init da830_init(void)
 
 void __init da830_init_time(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	void __iomem *pll;
 	struct clk *clk;
 
@@ -1242,10 +834,6 @@ void __init da830_init_time(void)
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
-#else
-	davinci_clk_init(da830_clks);
-	davinci_timer_init(&timerp64_0_clk);
-#endif
 }
 
 static struct resource da830_psc0_resources[] = {
-- 
2.17.0
