Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965101AbeEIRb3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:31:29 -0400
Received: from vern.gendns.com ([206.190.152.46]:52034 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965816AbeEIR1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:06 -0400
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
Subject: [PATCH v10 18/27] ARM: davinci: dm355: Remove legacy clock init
Date: Wed,  9 May 2018 12:25:57 -0500
Message-Id: <20180509172606.29387-19-david@lechnology.com>
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
arch/arm/mach-davinci/dm355.c.

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


 arch/arm/mach-davinci/dm355.c | 357 ----------------------------------
 1 file changed, 357 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 14014b942e8a..9f7d38d12c88 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -35,11 +35,6 @@
 #include "davinci.h"
 #include "mux.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include "clock.h"
-#include "psc.h"
-#endif
-
 #define DM355_UART2_BASE	(IO_PHYS + 0x206000)
 #define DM355_OSD_BASE		(IO_PHYS + 0x70200)
 #define DM355_VENC_BASE		(IO_PHYS + 0x70400)
@@ -49,349 +44,6 @@
  */
 #define DM355_REF_FREQ		24000000	/* 24 or 36 MHz */
 
-#ifndef CONFIG_COMMON_CLK
-static struct pll_data pll1_data = {
-	.num       = 1,
-	.phys_base = DAVINCI_PLL1_BASE,
-	.flags     = PLL_HAS_PREDIV | PLL_HAS_POSTDIV,
-};
-
-static struct pll_data pll2_data = {
-	.num       = 2,
-	.phys_base = DAVINCI_PLL2_BASE,
-	.flags     = PLL_HAS_PREDIV,
-};
-
-static struct clk ref_clk = {
-	.name = "ref_clk",
-	/* FIXME -- crystal rate is board-specific */
-	.rate = DM355_REF_FREQ,
-};
-
-static struct clk pll1_clk = {
-	.name = "pll1",
-	.parent = &ref_clk,
-	.flags = CLK_PLL,
-	.pll_data = &pll1_data,
-};
-
-static struct clk pll1_aux_clk = {
-	.name = "pll1_aux_clk",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll1_sysclk1 = {
-	.name = "pll1_sysclk1",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV1,
-};
-
-static struct clk pll1_sysclk2 = {
-	.name = "pll1_sysclk2",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV2,
-};
-
-static struct clk pll1_sysclk3 = {
-	.name = "pll1_sysclk3",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV3,
-};
-
-static struct clk pll1_sysclk4 = {
-	.name = "pll1_sysclk4",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV4,
-};
-
-static struct clk pll1_sysclkbp = {
-	.name = "pll1_sysclkbp",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
-};
-
-static struct clk vpss_dac_clk = {
-	.name = "vpss_dac",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM355_LPSC_VPSS_DAC,
-};
-
-static struct clk vpss_master_clk = {
-	.name = "vpss_master",
-	.parent = &pll1_sysclk4,
-	.lpsc = DAVINCI_LPSC_VPSSMSTR,
-	.flags = CLK_PSC,
-};
-
-static struct clk vpss_slave_clk = {
-	.name = "vpss_slave",
-	.parent = &pll1_sysclk4,
-	.lpsc = DAVINCI_LPSC_VPSSSLV,
-};
-
-static struct clk clkout1_clk = {
-	.name = "clkout1",
-	.parent = &pll1_aux_clk,
-	/* NOTE:  clkout1 can be externally gated by muxing GPIO-18 */
-};
-
-static struct clk clkout2_clk = {
-	.name = "clkout2",
-	.parent = &pll1_sysclkbp,
-};
-
-static struct clk pll2_clk = {
-	.name = "pll2",
-	.parent = &ref_clk,
-	.flags = CLK_PLL,
-	.pll_data = &pll2_data,
-};
-
-static struct clk pll2_sysclk1 = {
-	.name = "pll2_sysclk1",
-	.parent = &pll2_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV1,
-};
-
-static struct clk pll2_sysclkbp = {
-	.name = "pll2_sysclkbp",
-	.parent = &pll2_clk,
-	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV
-};
-
-static struct clk clkout3_clk = {
-	.name = "clkout3",
-	.parent = &pll2_sysclkbp,
-	/* NOTE:  clkout3 can be externally gated by muxing GPIO-16 */
-};
-
-static struct clk arm_clk = {
-	.name = "arm_clk",
-	.parent = &pll1_sysclk1,
-	.lpsc = DAVINCI_LPSC_ARM,
-	.flags = ALWAYS_ENABLED,
-};
-
-/*
- * NOT LISTED below, and not touched by Linux
- *   - in SyncReset state by default
- *	.lpsc = DAVINCI_LPSC_TPCC,
- *	.lpsc = DAVINCI_LPSC_TPTC0,
- *	.lpsc = DAVINCI_LPSC_TPTC1,
- *	.lpsc = DAVINCI_LPSC_DDR_EMIF, .parent = &sysclk2_clk,
- *	.lpsc = DAVINCI_LPSC_MEMSTICK,
- *   - in Enabled state by default
- *	.lpsc = DAVINCI_LPSC_SYSTEM_SUBSYS,
- *	.lpsc = DAVINCI_LPSC_SCR2,	// "bus"
- *	.lpsc = DAVINCI_LPSC_SCR3,	// "bus"
- *	.lpsc = DAVINCI_LPSC_SCR4,	// "bus"
- *	.lpsc = DAVINCI_LPSC_CROSSBAR,	// "emulation"
- *	.lpsc = DAVINCI_LPSC_CFG27,	// "test"
- *	.lpsc = DAVINCI_LPSC_CFG3,	// "test"
- *	.lpsc = DAVINCI_LPSC_CFG5,	// "test"
- */
-
-static struct clk mjcp_clk = {
-	.name = "mjcp",
-	.parent = &pll1_sysclk1,
-	.lpsc = DAVINCI_LPSC_IMCOP,
-};
-
-static struct clk uart0_clk = {
-	.name = "uart0",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_UART0,
-};
-
-static struct clk uart1_clk = {
-	.name = "uart1",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_UART1,
-};
-
-static struct clk uart2_clk = {
-	.name = "uart2",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_UART2,
-};
-
-static struct clk i2c_clk = {
-	.name = "i2c",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_I2C,
-};
-
-static struct clk asp0_clk = {
-	.name = "asp0",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_McBSP,
-};
-
-static struct clk asp1_clk = {
-	.name = "asp1",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM355_LPSC_McBSP1,
-};
-
-static struct clk mmcsd0_clk = {
-	.name = "mmcsd0",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_MMC_SD,
-};
-
-static struct clk mmcsd1_clk = {
-	.name = "mmcsd1",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM355_LPSC_MMC_SD1,
-};
-
-static struct clk spi0_clk = {
-	.name = "spi0",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_SPI,
-};
-
-static struct clk spi1_clk = {
-	.name = "spi1",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM355_LPSC_SPI1,
-};
-
-static struct clk spi2_clk = {
-	.name = "spi2",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM355_LPSC_SPI2,
-};
-
-static struct clk gpio_clk = {
-	.name = "gpio",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_GPIO,
-};
-
-static struct clk aemif_clk = {
-	.name = "aemif",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_AEMIF,
-};
-
-static struct clk pwm0_clk = {
-	.name = "pwm0",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_PWM0,
-};
-
-static struct clk pwm1_clk = {
-	.name = "pwm1",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_PWM1,
-};
-
-static struct clk pwm2_clk = {
-	.name = "pwm2",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_PWM2,
-};
-
-static struct clk pwm3_clk = {
-	.name = "pwm3",
-	.parent = &pll1_aux_clk,
-	.lpsc = DM355_LPSC_PWM3,
-};
-
-static struct clk timer0_clk = {
-	.name = "timer0",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_TIMER0,
-};
-
-static struct clk timer1_clk = {
-	.name = "timer1",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_TIMER1,
-};
-
-static struct clk timer2_clk = {
-	.name = "timer2",
-	.parent = &pll1_aux_clk,
-	.lpsc = DAVINCI_LPSC_TIMER2,
-	.usecount = 1,              /* REVISIT: why can't this be disabled? */
-};
-
-static struct clk timer3_clk = {
-	.name = "timer3",
-	.parent = &pll1_aux_clk,
-	.lpsc = DM355_LPSC_TIMER3,
-};
-
-static struct clk rto_clk = {
-	.name = "rto",
-	.parent = &pll1_aux_clk,
-	.lpsc = DM355_LPSC_RTO,
-};
-
-static struct clk usb_clk = {
-	.name = "usb",
-	.parent = &pll1_sysclk2,
-	.lpsc = DAVINCI_LPSC_USB,
-};
-
-static struct clk_lookup dm355_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk4", &pll1_sysclk4),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "vpss_dac", &vpss_dac_clk),
-	CLK("vpss", "master", &vpss_master_clk),
-	CLK("vpss", "slave", &vpss_slave_clk),
-	CLK(NULL, "clkout1", &clkout1_clk),
-	CLK(NULL, "clkout2", &clkout2_clk),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
-	CLK(NULL, "clkout3", &clkout3_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "mjcp", &mjcp_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("serial8250.2", NULL, &uart2_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("davinci-mcbsp.0", NULL, &asp0_clk),
-	CLK("davinci-mcbsp.1", NULL, &asp1_clk),
-	CLK("dm6441-mmc.0", NULL, &mmcsd0_clk),
-	CLK("dm6441-mmc.1", NULL, &mmcsd1_clk),
-	CLK("spi_davinci.0", NULL, &spi0_clk),
-	CLK("spi_davinci.1", NULL, &spi1_clk),
-	CLK("spi_davinci.2", NULL, &spi2_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "pwm3", &pwm3_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK(NULL, "timer3", &timer3_clk),
-	CLK(NULL, "rto", &rto_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK(NULL, NULL, NULL),
-};
-#endif
-/*----------------------------------------------------------------------*/
-
 static u64 dm355_spi0_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource dm355_spi0_resources[] = {
@@ -933,8 +585,6 @@ static struct davinci_id dm355_ids[] = {
 	},
 };
 
-static u32 dm355_psc_bases[] = { DAVINCI_PWR_SLEEP_CNTRL_BASE };
-
 /*
  * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
  * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
@@ -1019,8 +669,6 @@ static const struct davinci_soc_info davinci_soc_info_dm355 = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm355_ids,
 	.ids_num		= ARRAY_SIZE(dm355_ids),
-	.psc_bases		= dm355_psc_bases,
-	.psc_bases_num		= ARRAY_SIZE(dm355_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm355_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm355_pins),
@@ -1053,7 +701,6 @@ void __init dm355_init(void)
 
 void __init dm355_init_time(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	void __iomem *pll1, *psc;
 	struct clk *clk;
 
@@ -1068,10 +715,6 @@ void __init dm355_init_time(void)
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
-#else
-	davinci_clk_init(dm355_clks);
-	davinci_timer_init(&timer0_clk);
-#endif
 }
 
 static struct resource dm355_pll2_resources[] = {
-- 
2.17.0
