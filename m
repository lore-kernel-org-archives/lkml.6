Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965072AbeEIRal (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:30:41 -0400
Received: from vern.gendns.com ([206.190.152.46]:52045 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935563AbeEIR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:07 -0400
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
Subject: [PATCH v10 19/27] ARM: davinci: dm365: Remove legacy clock init
Date: Wed,  9 May 2018 12:25:58 -0500
Message-Id: <20180509172606.29387-20-david@lechnology.com>
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
arch/arm/mach-davinci/dm365.c.

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


 arch/arm/mach-davinci/dm365.c | 449 ----------------------------------
 1 file changed, 449 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 76de426a0e41..abcf2a5ed89b 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -40,11 +40,6 @@
 #include "davinci.h"
 #include "mux.h"
 
-#ifndef CONFIG_COMMON_CLK
-#include "clock.h"
-#include "psc.h"
-#endif
-
 #define DM365_REF_FREQ		24000000	/* 24 MHz on the DM365 EVM */
 #define DM365_RTC_BASE			0x01c69000
 #define DM365_KEYSCAN_BASE		0x01c69400
@@ -60,441 +55,6 @@
 #define DM365_EMAC_CNTRL_RAM_OFFSET	0x1000
 #define DM365_EMAC_CNTRL_RAM_SIZE	0x2000
 
-#ifndef CONFIG_COMMON_CLK
-static struct pll_data pll1_data = {
-	.num		= 1,
-	.phys_base	= DAVINCI_PLL1_BASE,
-	.flags		= PLL_HAS_POSTDIV | PLL_HAS_PREDIV,
-};
-
-static struct pll_data pll2_data = {
-	.num		= 2,
-	.phys_base	= DAVINCI_PLL2_BASE,
-	.flags		= PLL_HAS_POSTDIV | PLL_HAS_PREDIV,
-};
-
-static struct clk ref_clk = {
-	.name		= "ref_clk",
-	.rate		= DM365_REF_FREQ,
-};
-
-static struct clk pll1_clk = {
-	.name		= "pll1",
-	.parent		= &ref_clk,
-	.flags		= CLK_PLL,
-	.pll_data	= &pll1_data,
-};
-
-static struct clk pll1_aux_clk = {
-	.name		= "pll1_aux_clk",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll1_sysclkbp = {
-	.name		= "pll1_sysclkbp",
-	.parent		= &pll1_clk,
-	.flags 		= CLK_PLL | PRE_PLL,
-	.div_reg	= BPDIV
-};
-
-static struct clk clkout0_clk = {
-	.name		= "clkout0",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll1_sysclk1 = {
-	.name		= "pll1_sysclk1",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV1,
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
-static struct clk pll1_sysclk4 = {
-	.name		= "pll1_sysclk4",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV4,
-};
-
-static struct clk pll1_sysclk5 = {
-	.name		= "pll1_sysclk5",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV5,
-};
-
-static struct clk pll1_sysclk6 = {
-	.name		= "pll1_sysclk6",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV6,
-};
-
-static struct clk pll1_sysclk7 = {
-	.name		= "pll1_sysclk7",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV7,
-};
-
-static struct clk pll1_sysclk8 = {
-	.name		= "pll1_sysclk8",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV8,
-};
-
-static struct clk pll1_sysclk9 = {
-	.name		= "pll1_sysclk9",
-	.parent		= &pll1_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV9,
-};
-
-static struct clk pll2_clk = {
-	.name		= "pll2",
-	.parent		= &ref_clk,
-	.flags		= CLK_PLL,
-	.pll_data	= &pll2_data,
-};
-
-static struct clk pll2_aux_clk = {
-	.name		= "pll2_aux_clk",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL | PRE_PLL,
-};
-
-static struct clk clkout1_clk = {
-	.name		= "clkout1",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL | PRE_PLL,
-};
-
-static struct clk pll2_sysclk1 = {
-	.name		= "pll2_sysclk1",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV1,
-};
-
-static struct clk pll2_sysclk2 = {
-	.name		= "pll2_sysclk2",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV2,
-};
-
-static struct clk pll2_sysclk3 = {
-	.name		= "pll2_sysclk3",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV3,
-};
-
-static struct clk pll2_sysclk4 = {
-	.name		= "pll2_sysclk4",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV4,
-};
-
-static struct clk pll2_sysclk5 = {
-	.name		= "pll2_sysclk5",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV5,
-};
-
-static struct clk pll2_sysclk6 = {
-	.name		= "pll2_sysclk6",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV6,
-};
-
-static struct clk pll2_sysclk7 = {
-	.name		= "pll2_sysclk7",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV7,
-};
-
-static struct clk pll2_sysclk8 = {
-	.name		= "pll2_sysclk8",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV8,
-};
-
-static struct clk pll2_sysclk9 = {
-	.name		= "pll2_sysclk9",
-	.parent		= &pll2_clk,
-	.flags		= CLK_PLL,
-	.div_reg	= PLLDIV9,
-};
-
-static struct clk vpss_dac_clk = {
-	.name		= "vpss_dac",
-	.parent		= &pll1_sysclk3,
-	.lpsc		= DM365_LPSC_DAC_CLK,
-};
-
-static struct clk vpss_master_clk = {
-	.name		= "vpss_master",
-	.parent		= &pll1_sysclk5,
-	.lpsc		= DM365_LPSC_VPSSMSTR,
-	.flags		= CLK_PSC,
-};
-
-static struct clk vpss_slave_clk = {
-	.name		= "vpss_slave",
-	.parent		= &pll1_sysclk5,
-	.lpsc		= DAVINCI_LPSC_VPSSSLV,
-};
-
-static struct clk arm_clk = {
-	.name		= "arm_clk",
-	.parent		= &pll2_sysclk2,
-	.lpsc		= DAVINCI_LPSC_ARM,
-	.flags		= ALWAYS_ENABLED,
-};
-
-static struct clk uart0_clk = {
-	.name		= "uart0",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_UART0,
-};
-
-static struct clk uart1_clk = {
-	.name		= "uart1",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DAVINCI_LPSC_UART1,
-};
-
-static struct clk i2c_clk = {
-	.name		= "i2c",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_I2C,
-};
-
-static struct clk mmcsd0_clk = {
-	.name		= "mmcsd0",
-	.parent		= &pll1_sysclk8,
-	.lpsc		= DAVINCI_LPSC_MMC_SD,
-};
-
-static struct clk mmcsd1_clk = {
-	.name		= "mmcsd1",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DM365_LPSC_MMC_SD1,
-};
-
-static struct clk spi0_clk = {
-	.name		= "spi0",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DAVINCI_LPSC_SPI,
-};
-
-static struct clk spi1_clk = {
-	.name		= "spi1",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DM365_LPSC_SPI1,
-};
-
-static struct clk spi2_clk = {
-	.name		= "spi2",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DM365_LPSC_SPI2,
-};
-
-static struct clk spi3_clk = {
-	.name		= "spi3",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DM365_LPSC_SPI3,
-};
-
-static struct clk spi4_clk = {
-	.name		= "spi4",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DM365_LPSC_SPI4,
-};
-
-static struct clk gpio_clk = {
-	.name		= "gpio",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DAVINCI_LPSC_GPIO,
-};
-
-static struct clk aemif_clk = {
-	.name		= "aemif",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DAVINCI_LPSC_AEMIF,
-};
-
-static struct clk pwm0_clk = {
-	.name		= "pwm0",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_PWM0,
-};
-
-static struct clk pwm1_clk = {
-	.name		= "pwm1",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_PWM1,
-};
-
-static struct clk pwm2_clk = {
-	.name		= "pwm2",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_PWM2,
-};
-
-static struct clk pwm3_clk = {
-	.name		= "pwm3",
-	.parent		= &ref_clk,
-	.lpsc		= DM365_LPSC_PWM3,
-};
-
-static struct clk timer0_clk = {
-	.name		= "timer0",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_TIMER0,
-};
-
-static struct clk timer1_clk = {
-	.name		= "timer1",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_TIMER1,
-};
-
-static struct clk timer2_clk = {
-	.name		= "timer2",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_TIMER2,
-	.usecount	= 1,
-};
-
-static struct clk timer3_clk = {
-	.name		= "timer3",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DM365_LPSC_TIMER3,
-};
-
-static struct clk usb_clk = {
-	.name		= "usb",
-	.parent		= &pll1_aux_clk,
-	.lpsc		= DAVINCI_LPSC_USB,
-};
-
-static struct clk emac_clk = {
-	.name		= "emac",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DM365_LPSC_EMAC,
-};
-
-static struct clk voicecodec_clk = {
-	.name		= "voice_codec",
-	.parent		= &pll2_sysclk4,
-	.lpsc		= DM365_LPSC_VOICE_CODEC,
-};
-
-static struct clk asp0_clk = {
-	.name		= "asp0",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DM365_LPSC_McBSP1,
-};
-
-static struct clk rto_clk = {
-	.name		= "rto",
-	.parent		= &pll1_sysclk4,
-	.lpsc		= DM365_LPSC_RTO,
-};
-
-static struct clk mjcp_clk = {
-	.name		= "mjcp",
-	.parent		= &pll1_sysclk3,
-	.lpsc		= DM365_LPSC_MJCP,
-};
-
-static struct clk_lookup dm365_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "clkout0", &clkout0_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk4", &pll1_sysclk4),
-	CLK(NULL, "pll1_sysclk5", &pll1_sysclk5),
-	CLK(NULL, "pll1_sysclk6", &pll1_sysclk6),
-	CLK(NULL, "pll1_sysclk7", &pll1_sysclk7),
-	CLK(NULL, "pll1_sysclk8", &pll1_sysclk8),
-	CLK(NULL, "pll1_sysclk9", &pll1_sysclk9),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_aux", &pll2_aux_clk),
-	CLK(NULL, "clkout1", &clkout1_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclk2", &pll2_sysclk2),
-	CLK(NULL, "pll2_sysclk3", &pll2_sysclk3),
-	CLK(NULL, "pll2_sysclk4", &pll2_sysclk4),
-	CLK(NULL, "pll2_sysclk5", &pll2_sysclk5),
-	CLK(NULL, "pll2_sysclk6", &pll2_sysclk6),
-	CLK(NULL, "pll2_sysclk7", &pll2_sysclk7),
-	CLK(NULL, "pll2_sysclk8", &pll2_sysclk8),
-	CLK(NULL, "pll2_sysclk9", &pll2_sysclk9),
-	CLK(NULL, "vpss_dac", &vpss_dac_clk),
-	CLK("vpss", "master", &vpss_master_clk),
-	CLK("vpss", "slave", &vpss_slave_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK("serial8250.0", NULL, &uart0_clk),
-	CLK("serial8250.1", NULL, &uart1_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("da830-mmc.0", NULL, &mmcsd0_clk),
-	CLK("da830-mmc.1", NULL, &mmcsd1_clk),
-	CLK("spi_davinci.0", NULL, &spi0_clk),
-	CLK("spi_davinci.1", NULL, &spi1_clk),
-	CLK("spi_davinci.2", NULL, &spi2_clk),
-	CLK("spi_davinci.3", NULL, &spi3_clk),
-	CLK("spi_davinci.4", NULL, &spi4_clk),
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
-	CLK(NULL, "usb", &usb_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("davinci_mdio.0", "fck", &emac_clk),
-	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
-	CLK("davinci-mcbsp", NULL, &asp0_clk),
-	CLK(NULL, "rto", &rto_clk),
-	CLK(NULL, "mjcp", &mjcp_clk),
-	CLK(NULL, NULL, NULL),
-};
-#endif
-/*----------------------------------------------------------------------*/
-
 #define INTMUX		0x18
 #define EVTMUX		0x1c
 
@@ -1061,8 +621,6 @@ static struct davinci_id dm365_ids[] = {
 	},
 };
 
-static u32 dm365_psc_bases[] = { DAVINCI_PWR_SLEEP_CNTRL_BASE };
-
 static struct davinci_timer_info dm365_timer_info = {
 	.timers		= davinci_timer_instance,
 	.clockevent_id	= T0_BOT,
@@ -1123,8 +681,6 @@ static const struct davinci_soc_info davinci_soc_info_dm365 = {
 	.jtag_id_reg		= 0x01c40028,
 	.ids			= dm365_ids,
 	.ids_num		= ARRAY_SIZE(dm365_ids),
-	.psc_bases		= dm365_psc_bases,
-	.psc_bases_num		= ARRAY_SIZE(dm365_psc_bases),
 	.pinmux_base		= DAVINCI_SYSTEM_MODULE_BASE,
 	.pinmux_pins		= dm365_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(dm365_pins),
@@ -1178,7 +734,6 @@ void __init dm365_init(void)
 
 void __init dm365_init_time(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	void __iomem *pll1, *pll2, *psc;
 	struct clk *clk;
 
@@ -1196,10 +751,6 @@ void __init dm365_init_time(void)
 	clk = clk_get(NULL, "timer0");
 
 	davinci_timer_init(clk);
-#else
-	davinci_clk_init(dm365_clks);
-	davinci_timer_init(&timer0_clk);
-#endif
 }
 
 void __init dm365_register_clocks(void)
-- 
2.17.0
