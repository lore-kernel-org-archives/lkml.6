Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeDPSri (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:47:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeDPSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:47:34 -0400
Date: Mon, 16 Apr 2018 20:47:31 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer updates for 4.17
Message-ID: <alpine.DEB.2.21.1804162044350.1833@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please consider to pull the latest timers-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

That's a branch which got forgotten during the merge window, but it
contains only fixes and hardware enablement. No fundamental changes.

 - Various fixes for the imx-tpm clocksource driver

 - A new timer driver for the NCPM7xx SoC family

Thanks,

	tglx

------------------>
Anson Huang (4):
      dt-bindings: timer: tpm: fix typo of clock name
      clocksource/drivers/imx-tpm: Fix typo of clock name
      clocksource/drivers/imx-tpm: Correct some registers operation flow
      clocksource/drivers/imx-tpm: Add different counter width support

Tomer Maimon (2):
      dt-binding: timer: document NPCM7xx timer DT bindings
      clocksource/drivers/npcm: Add NPCM7xx timer driver


 .../bindings/timer/nuvoton,npcm7xx-timer.txt       |  21 ++
 .../devicetree/bindings/timer/nxp,tpm-timer.txt    |   2 +-
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-imx-tpm.c                |  43 ++++-
 drivers/clocksource/timer-npcm7xx.c                | 215 +++++++++++++++++++++
 6 files changed, 279 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
 create mode 100644 drivers/clocksource/timer-npcm7xx.c

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
new file mode 100644
index 000000000000..ea22dfe485be
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
@@ -0,0 +1,21 @@
+Nuvoton NPCM7xx timer
+
+Nuvoton NPCM7xx have three timer modules, each timer module provides five 24-bit
+timer counters.
+
+Required properties:
+- compatible      : "nuvoton,npcm750-timer" for Poleg NPCM750.
+- reg             : Offset and length of the register set for the device.
+- interrupts      : Contain the timer interrupt with flags for
+                    falling edge.
+- clocks          : phandle of timer reference clock (usually a 25 MHz clock).
+
+Example:
+
+timer@f0008000 {
+    compatible = "nuvoton,npcm750-timer";
+    interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    reg = <0xf0008000 0x50>;
+    clocks = <&clk NPCM7XX_CLK_TIMER>;
+};
+
diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
index b4aa7ddb5b13..f82087b220f4 100644
--- a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
@@ -15,7 +15,7 @@ Required properties:
 - interrupts :	Should be the clock event device interrupt.
 - clocks :	The clocks provided by the SoC to drive the timer, must contain
 		an entry for each entry in clock-names.
-- clock-names : Must include the following entries: "igp" and "per".
+- clock-names : Must include the following entries: "ipg" and "per".
 
 Example:
 tpm5: tpm@40260000 {
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b3b4ed9b6874..76194bc20bdf 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -130,6 +130,14 @@ config VT8500_TIMER
 	help
 	  Enables support for the VT8500 driver.
 
+config NPCM7XX_TIMER
+	bool "NPCM7xx timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	help
+	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx architecture,
+	  While TIMER0 serves as clockevent and TIMER1 serves as clocksource.
+
 config CADENCE_TTC_TIMER
 	bool "Cadence TTC timer driver" if COMPILE_TEST
 	depends on COMMON_CLK
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index d6dec4489d66..74387877f7cf 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
+obj-$(CONFIG_NPCM7XX_TIMER)	+= timer-npcm7xx.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 21bffdcb2f20..05d97a6871d8 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -17,9 +17,14 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
+#define TPM_PARAM			0x4
+#define TPM_PARAM_WIDTH_SHIFT		16
+#define TPM_PARAM_WIDTH_MASK		(0xff << 16)
 #define TPM_SC				0x10
 #define TPM_SC_CMOD_INC_PER_CNT		(0x1 << 3)
 #define TPM_SC_CMOD_DIV_DEFAULT		0x3
+#define TPM_SC_CMOD_DIV_MAX		0x7
+#define TPM_SC_TOF_MASK			(0x1 << 7)
 #define TPM_CNT				0x14
 #define TPM_MOD				0x18
 #define TPM_STATUS			0x1c
@@ -29,8 +34,11 @@
 #define TPM_C0SC_MODE_SHIFT		2
 #define TPM_C0SC_MODE_MASK		0x3c
 #define TPM_C0SC_MODE_SW_COMPARE	0x4
+#define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
 
+static int counter_width;
+static int rating;
 static void __iomem *timer_base;
 static struct clock_event_device clockevent_tpm;
 
@@ -83,10 +91,11 @@ static int __init tpm_clocksource_init(unsigned long rate)
 	tpm_delay_timer.freq = rate;
 	register_current_timer_delay(&tpm_delay_timer);
 
-	sched_clock_register(tpm_read_sched_clock, 32, rate);
+	sched_clock_register(tpm_read_sched_clock, counter_width, rate);
 
 	return clocksource_mmio_init(timer_base + TPM_CNT, "imx-tpm",
-				     rate, 200, 32, clocksource_mmio_readl_up);
+				     rate, rating, counter_width,
+				     clocksource_mmio_readl_up);
 }
 
 static int tpm_set_next_event(unsigned long delta,
@@ -139,7 +148,6 @@ static struct clock_event_device clockevent_tpm = {
 	.set_state_oneshot	= tpm_set_state_oneshot,
 	.set_next_event		= tpm_set_next_event,
 	.set_state_shutdown	= tpm_set_state_shutdown,
-	.rating			= 200,
 };
 
 static int __init tpm_clockevent_init(unsigned long rate, int irq)
@@ -149,10 +157,11 @@ static int __init tpm_clockevent_init(unsigned long rate, int irq)
 	ret = request_irq(irq, tpm_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			  "i.MX7ULP TPM Timer", &clockevent_tpm);
 
+	clockevent_tpm.rating = rating;
 	clockevent_tpm.cpumask = cpumask_of(0);
 	clockevent_tpm.irq = irq;
-	clockevents_config_and_register(&clockevent_tpm,
-					rate, 300, 0xfffffffe);
+	clockevents_config_and_register(&clockevent_tpm, rate, 300,
+					GENMASK(counter_width - 1, 1));
 
 	return ret;
 }
@@ -179,7 +188,7 @@ static int __init tpm_timer_init(struct device_node *np)
 	ipg = of_clk_get_by_name(np, "ipg");
 	per = of_clk_get_by_name(np, "per");
 	if (IS_ERR(ipg) || IS_ERR(per)) {
-		pr_err("tpm: failed to get igp or per clk\n");
+		pr_err("tpm: failed to get ipg or per clk\n");
 		ret = -ENODEV;
 		goto err_clk_get;
 	}
@@ -197,6 +206,11 @@ static int __init tpm_timer_init(struct device_node *np)
 		goto err_per_clk_enable;
 	}
 
+	counter_width = (readl(timer_base + TPM_PARAM) & TPM_PARAM_WIDTH_MASK)
+		>> TPM_PARAM_WIDTH_SHIFT;
+	/* use rating 200 for 32-bit counter and 150 for 16-bit counter */
+	rating = counter_width == 0x20 ? 200 : 150;
+
 	/*
 	 * Initialize tpm module to a known state
 	 * 1) Counter disabled
@@ -205,16 +219,25 @@ static int __init tpm_timer_init(struct device_node *np)
 	 * 4) Channel0 disabled
 	 * 5) DMA transfers disabled
 	 */
+	/* make sure counter is disabled */
 	writel(0, timer_base + TPM_SC);
+	/* TOF is W1C */
+	writel(TPM_SC_TOF_MASK, timer_base + TPM_SC);
 	writel(0, timer_base + TPM_CNT);
-	writel(0, timer_base + TPM_C0SC);
+	/* CHF is W1C */
+	writel(TPM_C0SC_CHF_MASK, timer_base + TPM_C0SC);
 
-	/* increase per cnt, div 8 by default */
-	writel(TPM_SC_CMOD_INC_PER_CNT | TPM_SC_CMOD_DIV_DEFAULT,
+	/*
+	 * increase per cnt,
+	 * div 8 for 32-bit counter and div 128 for 16-bit counter
+	 */
+	writel(TPM_SC_CMOD_INC_PER_CNT |
+		(counter_width == 0x20 ?
+		TPM_SC_CMOD_DIV_DEFAULT : TPM_SC_CMOD_DIV_MAX),
 		     timer_base + TPM_SC);
 
 	/* set MOD register to maximum for free running mode */
-	writel(0xffffffff, timer_base + TPM_MOD);
+	writel(GENMASK(counter_width - 1, 0), timer_base + TPM_MOD);
 
 	rate = clk_get_rate(per) >> 3;
 	ret = tpm_clocksource_init(rate);
diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
new file mode 100644
index 000000000000..7a9bb5532d99
--- /dev/null
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2014-2018 Nuvoton Technologies tomer.maimon@nuvoton.com
+ * All rights reserved.
+ *
+ * Copyright 2017 Google, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/clockchips.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include "timer-of.h"
+
+/* Timers registers */
+#define NPCM7XX_REG_TCSR0	0x0 /* Timer 0 Control and Status Register */
+#define NPCM7XX_REG_TICR0	0x8 /* Timer 0 Initial Count Register */
+#define NPCM7XX_REG_TCSR1	0x4 /* Timer 1 Control and Status Register */
+#define NPCM7XX_REG_TICR1	0xc /* Timer 1 Initial Count Register */
+#define NPCM7XX_REG_TDR1	0x14 /* Timer 1 Data Register */
+#define NPCM7XX_REG_TISR	0x18 /* Timer Interrupt Status Register */
+
+/* Timers control */
+#define NPCM7XX_Tx_RESETINT		0x1f
+#define NPCM7XX_Tx_PERIOD		BIT(27)
+#define NPCM7XX_Tx_INTEN		BIT(29)
+#define NPCM7XX_Tx_COUNTEN		BIT(30)
+#define NPCM7XX_Tx_ONESHOT		0x0
+#define NPCM7XX_Tx_OPER			GENMASK(3, 27)
+#define NPCM7XX_Tx_MIN_PRESCALE		0x1
+#define NPCM7XX_Tx_TDR_MASK_BITS	24
+#define NPCM7XX_Tx_MAX_CNT		0xFFFFFF
+#define NPCM7XX_T0_CLR_INT		0x1
+#define NPCM7XX_Tx_CLR_CSR		0x0
+
+/* Timers operating mode */
+#define NPCM7XX_START_PERIODIC_Tx (NPCM7XX_Tx_PERIOD | NPCM7XX_Tx_COUNTEN | \
+					NPCM7XX_Tx_INTEN | \
+					NPCM7XX_Tx_MIN_PRESCALE)
+
+#define NPCM7XX_START_ONESHOT_Tx (NPCM7XX_Tx_ONESHOT | NPCM7XX_Tx_COUNTEN | \
+					NPCM7XX_Tx_INTEN | \
+					NPCM7XX_Tx_MIN_PRESCALE)
+
+#define NPCM7XX_START_Tx (NPCM7XX_Tx_COUNTEN | NPCM7XX_Tx_PERIOD | \
+				NPCM7XX_Tx_MIN_PRESCALE)
+
+#define NPCM7XX_DEFAULT_CSR (NPCM7XX_Tx_CLR_CSR | NPCM7XX_Tx_MIN_PRESCALE)
+
+static int npcm7xx_timer_resume(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+	u32 val;
+
+	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
+	val |= NPCM7XX_Tx_COUNTEN;
+	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
+
+	return 0;
+}
+
+static int npcm7xx_timer_shutdown(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+	u32 val;
+
+	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
+	val &= ~NPCM7XX_Tx_COUNTEN;
+	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
+
+	return 0;
+}
+
+static int npcm7xx_timer_oneshot(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+	u32 val;
+
+	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
+	val &= ~NPCM7XX_Tx_OPER;
+
+	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
+	val |= NPCM7XX_START_ONESHOT_Tx;
+	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
+
+	return 0;
+}
+
+static int npcm7xx_timer_periodic(struct clock_event_device *evt)
+{
+	struct timer_of *to = to_timer_of(evt);
+	u32 val;
+
+	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
+	val &= ~NPCM7XX_Tx_OPER;
+
+	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
+	val |= NPCM7XX_START_PERIODIC_Tx;
+
+	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
+
+	return 0;
+}
+
+static int npcm7xx_clockevent_set_next_event(unsigned long evt,
+		struct clock_event_device *clk)
+{
+	struct timer_of *to = to_timer_of(clk);
+	u32 val;
+
+	writel(evt, timer_of_base(to) + NPCM7XX_REG_TICR0);
+	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
+	val |= NPCM7XX_START_Tx;
+	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
+
+	return 0;
+}
+
+static irqreturn_t npcm7xx_timer0_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct timer_of *to = to_timer_of(evt);
+
+	writel(NPCM7XX_T0_CLR_INT, timer_of_base(to) + NPCM7XX_REG_TISR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct timer_of npcm7xx_to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+
+	.clkevt = {
+		.name		    = "npcm7xx-timer0",
+		.features	    = CLOCK_EVT_FEAT_PERIODIC |
+				      CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event	    = npcm7xx_clockevent_set_next_event,
+		.set_state_shutdown = npcm7xx_timer_shutdown,
+		.set_state_periodic = npcm7xx_timer_periodic,
+		.set_state_oneshot  = npcm7xx_timer_oneshot,
+		.tick_resume	    = npcm7xx_timer_resume,
+		.rating		    = 300,
+	},
+
+	.of_irq = {
+		.handler = npcm7xx_timer0_interrupt,
+		.flags = IRQF_TIMER | IRQF_IRQPOLL,
+	},
+};
+
+static void __init npcm7xx_clockevents_init(void)
+{
+	writel(NPCM7XX_DEFAULT_CSR,
+		timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TCSR0);
+
+	writel(NPCM7XX_Tx_RESETINT,
+		timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TISR);
+
+	npcm7xx_to.clkevt.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&npcm7xx_to.clkevt,
+					timer_of_rate(&npcm7xx_to),
+					0x1, NPCM7XX_Tx_MAX_CNT);
+}
+
+static void __init npcm7xx_clocksource_init(void)
+{
+	u32 val;
+
+	writel(NPCM7XX_DEFAULT_CSR,
+		timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TCSR1);
+	writel(NPCM7XX_Tx_MAX_CNT,
+		timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TICR1);
+
+	val = readl(timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TCSR1);
+	val |= NPCM7XX_START_Tx;
+	writel(val, timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TCSR1);
+
+	clocksource_mmio_init(timer_of_base(&npcm7xx_to) +
+				NPCM7XX_REG_TDR1,
+				"npcm7xx-timer1", timer_of_rate(&npcm7xx_to),
+				200, (unsigned int)NPCM7XX_Tx_TDR_MASK_BITS,
+				clocksource_mmio_readl_down);
+}
+
+static int __init npcm7xx_timer_init(struct device_node *np)
+{
+	int ret;
+
+	ret = timer_of_init(np, &npcm7xx_to);
+	if (ret)
+		return ret;
+
+	/* Clock input is divided by PRESCALE + 1 before it is fed */
+	/* to the counter */
+	npcm7xx_to.of_clk.rate = npcm7xx_to.of_clk.rate /
+		(NPCM7XX_Tx_MIN_PRESCALE + 1);
+
+	npcm7xx_clocksource_init();
+	npcm7xx_clockevents_init();
+
+	pr_info("Enabling NPCM7xx clocksource timer base: %px, IRQ: %d ",
+		timer_of_base(&npcm7xx_to), timer_of_irq(&npcm7xx_to));
+
+	return 0;
+}
+
+TIMER_OF_DECLARE(npcm7xx, "nuvoton,npcm750-timer", npcm7xx_timer_init);
+
