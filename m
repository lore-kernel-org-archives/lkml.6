Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964883AbeEIRag (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:30:36 -0400
Received: from vern.gendns.com ([206.190.152.46]:52066 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965832AbeEIR1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:10 -0400
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
Subject: [PATCH v10 21/27] ARM: davinci: dm646x: Remove legacy clock init
Date: Wed,  9 May 2018 12:26:00 -0500
Message-Id: <20180509172606.29387-22-david@lechnology.com>
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
arch/arm/mach-davinci/dm646x.c.

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


 arch/arm/mach-davinci/dm646x.c | 329 ---------------------------------
 1 file changed, 329 deletions(-)

diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index f5693bafc81f..54a4299030de 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -33,11 +33,6 @@
 #include "davinci.h"
 #include "mux.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include "clock.h"
-#include "psc.h"
-#endif
-
 #define DAVINCI_VPIF_BASE       (0x01C12000)
 
 #define VDD3P3V_VID_MASK	(BIT_MASK(3) | BIT_MASK(2) | BIT_MASK(1) |\
@@ -52,319 +47,6 @@
 #define DM646X_EMAC_CNTRL_RAM_OFFSET	0x2000
 #define DM646X_EMAC_CNTRL_RAM_SIZE	0x2000
 
-#ifndef CONFIG_COMMON_CLK
-static struct pll_data pll1_data = {
-	.num       = 1,
-	.phys_base = DAVINCI_PLL1_BASE,
-};
-
-static struct pll_data pll2_data = {
-	.num       = 2,
-	.phys_base = DAVINCI_PLL2_BASE,
-};
-
-static struct clk ref_clk = {
-	.name = "ref_clk",
-	/* rate is initialized in dm646x_init_time() */
-};
-
-static struct clk aux_clkin = {
-	.name = "aux_clkin",
-	/* rate is initialized in dm646x_init_time() */
-};
-
-static struct clk pll1_clk = {
-	.name = "pll1",
-	.parent = &ref_clk,
-	.pll_data = &pll1_data,
-	.flags = CLK_PLL,
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
-static struct clk pll1_sysclk5 = {
-	.name = "pll1_sysclk5",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV5,
-};
-
-static struct clk pll1_sysclk6 = {
-	.name = "pll1_sysclk6",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV6,
-};
-
-static struct clk pll1_sysclk8 = {
-	.name = "pll1_sysclk8",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV8,
-};
-
-static struct clk pll1_sysclk9 = {
-	.name = "pll1_sysclk9",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV9,
-};
-
-static struct clk pll1_sysclkbp = {
-	.name = "pll1_sysclkbp",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL | PRE_PLL,
-	.div_reg = BPDIV,
-};
-
-static struct clk pll1_aux_clk = {
-	.name = "pll1_aux_clk",
-	.parent = &pll1_clk,
-	.flags = CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll2_clk = {
-	.name = "pll2_clk",
-	.parent = &ref_clk,
-	.pll_data = &pll2_data,
-	.flags = CLK_PLL,
-};
-
-static struct clk pll2_sysclk1 = {
-	.name = "pll2_sysclk1",
-	.parent = &pll2_clk,
-	.flags = CLK_PLL,
-	.div_reg = PLLDIV1,
-};
-
-static struct clk dsp_clk = {
-	.name = "dsp",
-	.parent = &pll1_sysclk1,
-	.lpsc = DM646X_LPSC_C64X_CPU,
-	.usecount = 1,			/* REVISIT how to disable? */
-};
-
-static struct clk arm_clk = {
-	.name = "arm",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM646X_LPSC_ARM,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk edma_cc_clk = {
-	.name = "edma_cc",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM646X_LPSC_TPCC,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk edma_tc0_clk = {
-	.name = "edma_tc0",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM646X_LPSC_TPTC0,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk edma_tc1_clk = {
-	.name = "edma_tc1",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM646X_LPSC_TPTC1,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk edma_tc2_clk = {
-	.name = "edma_tc2",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM646X_LPSC_TPTC2,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk edma_tc3_clk = {
-	.name = "edma_tc3",
-	.parent = &pll1_sysclk2,
-	.lpsc = DM646X_LPSC_TPTC3,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk uart0_clk = {
-	.name = "uart0",
-	.parent = &aux_clkin,
-	.lpsc = DM646X_LPSC_UART0,
-};
-
-static struct clk uart1_clk = {
-	.name = "uart1",
-	.parent = &aux_clkin,
-	.lpsc = DM646X_LPSC_UART1,
-};
-
-static struct clk uart2_clk = {
-	.name = "uart2",
-	.parent = &aux_clkin,
-	.lpsc = DM646X_LPSC_UART2,
-};
-
-static struct clk i2c_clk = {
-	.name = "I2CCLK",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_I2C,
-};
-
-static struct clk gpio_clk = {
-	.name = "gpio",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_GPIO,
-};
-
-static struct clk mcasp0_clk = {
-	.name = "mcasp0",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_McASP0,
-};
-
-static struct clk mcasp1_clk = {
-	.name = "mcasp1",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_McASP1,
-};
-
-static struct clk aemif_clk = {
-	.name = "aemif",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_AEMIF,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk emac_clk = {
-	.name = "emac",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_EMAC,
-};
-
-static struct clk pwm0_clk = {
-	.name = "pwm0",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_PWM0,
-	.usecount = 1,            /* REVIST: disabling hangs system */
-};
-
-static struct clk pwm1_clk = {
-	.name = "pwm1",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_PWM1,
-	.usecount = 1,            /* REVIST: disabling hangs system */
-};
-
-static struct clk timer0_clk = {
-	.name = "timer0",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_TIMER0,
-};
-
-static struct clk timer1_clk = {
-	.name = "timer1",
-	.parent = &pll1_sysclk3,
-	.lpsc = DM646X_LPSC_TIMER1,
-};
-
-static struct clk timer2_clk = {
-	.name = "timer2",
-	.parent = &pll1_sysclk3,
-	.flags = ALWAYS_ENABLED, /* no LPSC, always enabled; c.f. spruep9a */
-};
-
-
-static struct clk ide_clk = {
-	.name = "ide",
-	.parent = &pll1_sysclk4,
-	.lpsc = DAVINCI_LPSC_ATA,
-};
-
-static struct clk vpif0_clk = {
-	.name = "vpif0",
-	.parent = &ref_clk,
-	.lpsc = DM646X_LPSC_VPSSMSTR,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk vpif1_clk = {
-	.name = "vpif1",
-	.parent = &ref_clk,
-	.lpsc = DM646X_LPSC_VPSSSLV,
-	.flags = ALWAYS_ENABLED,
-};
-
-static struct clk_lookup dm646x_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "aux", &aux_clkin),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk4),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk5),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk6),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk8),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk9),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclkbp),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "dsp", &dsp_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "edma_cc", &edma_cc_clk),
-	CLK(NULL, "edma_tc0", &edma_tc0_clk),
-	CLK(NULL, "edma_tc1", &edma_tc1_clk),
-	CLK(NULL, "edma_tc2", &edma_tc2_clk),
-	CLK(NULL, "edma_tc3", &edma_tc3_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("serial8250.2", NULL, &uart2_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK("davinci-mcasp.0", NULL, &mcasp0_clk),
-	CLK("davinci-mcasp.1", NULL, &mcasp1_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("davinci_mdio.0", "fck", &emac_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("davinci-wdt", NULL, &timer2_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK(NULL, "vpif0", &vpif0_clk),
-	CLK(NULL, "vpif1", &vpif1_clk),
-	CLK(NULL, NULL, NULL),
-};
-#endif
-
 static struct emac_platform_data dm646x_emac_pdata = {
 	.ctrl_reg_offset	= DM646X_EMAC_CNTRL_OFFSET,
 	.ctrl_mod_reg_offset	= DM646X_EMAC_CNTRL_MOD_OFFSET,
@@ -803,8 +485,6 @@ static struct davinci_id dm646x_ids[] = {
 	},
 };
 
-static u32 dm646x_psc_bases[] = { DAVINCI_PWR_SLEEP_CNTRL_BASE };
-
 /*
  * T0_BOT: Timer 0, bottom:  clockevent source for hrtimers
  * T0_TOP: Timer 0, top   :  clocksource for generic timekeeping
@@ -889,8 +569,6 @@ static const struct davinci_soc_info davinci_soc_info_dm646x = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm646x_ids,
 	.ids_num		= ARRAY_SIZE(dm646x_ids),
-	.psc_bases		= dm646x_psc_bases,
-	.psc_bases_num		= ARRAY_SIZE(dm646x_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm646x_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm646x_pins),
@@ -961,7 +639,6 @@ void __init dm646x_init(void)
 void __init dm646x_init_time(unsigned long ref_clk_rate,
 			     unsigned long aux_clkin_rate)
 {
-#ifdef CONFIG_COMMON_CLK
 	void __iomem *pll1, *psc;
 	struct clk *clk;
 
@@ -977,12 +654,6 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
-#else
-	ref_clk.rate = ref_clk_rate;
-	aux_clkin.rate = aux_clkin_rate;
-	davinci_clk_init(dm646x_clks);
-	davinci_timer_init(&timer0_clk);
-#endif
 }
 
 static struct resource dm646x_pll2_resources[] = {
-- 
2.17.0
