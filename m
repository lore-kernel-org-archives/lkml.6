Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeBZOhN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 09:37:13 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:57342 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753277AbeBZOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 09:37:06 -0500
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org, mark.rutland@arm.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, avifishman70@gmail.com, brendanhiggins@google.com,
        joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 2/2] clocksource: npcm: add NPCM7xx timer driver
Date: Mon, 26 Feb 2018 16:36:09 +0200
Message-Id: <1519655769-25836-3-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
References: <1519655769-25836-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Nuvoton BMC NPCM7xx timer driver.

the clocksource Enable 24-bit TIMER0 and TIMER1 counters,
while TIMER0 serve as clockevent and TIMER1 serve as clocksource.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Brendan Higgins <brendanhiggins@xxxxxxxxxx>
---
 drivers/clocksource/Kconfig         |   8 ++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/npcm7xx-timer.c | 237 ++++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 drivers/clocksource/npcm7xx-timer.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b3b4ed9b6874..bfc80653d89f 100644
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
+	  Enable 24-bit TIMER0 and TIMER1 counters in the NPCM7xx arcithcture,
+	  While TIMER0 serves as clockevent and TIMER1 serves as clocksource.
+
 config CADENCE_TTC_TIMER
 	bool "Cadence TTC timer driver" if COMPILE_TEST
 	depends on COMMON_CLK
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index d6dec4489d66..b16c1a2b9e0d 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_CLKSRC_NPS)	+= timer-nps.o
 obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= owl-timer.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
+obj-$(CONFIG_NPCM7XX_TIMER)	+= npcm7xx-timer.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
diff --git a/drivers/clocksource/npcm7xx-timer.c b/drivers/clocksource/npcm7xx-timer.c
new file mode 100644
index 000000000000..ab27fc82d8ef
--- /dev/null
+++ b/drivers/clocksource/npcm7xx-timer.c
@@ -0,0 +1,237 @@
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
+	writel((timer_of_rate(to) / HZ),
+		timer_of_base(to) + NPCM7XX_REG_TICR0);
+	val |= NPCM7XX_START_PERIODIC_Tx;
+
+	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
+
+	return 0;
+}
+
+static int npcm7xx_clockevent_setnextevent(unsigned long evt,
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
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE,
+
+	.clkevt = {
+		.name		    = "npcm7xx-timer0",
+		.features	    = CLOCK_EVT_FEAT_PERIODIC |
+				      CLOCK_EVT_FEAT_ONESHOT,
+		.set_next_event	    = npcm7xx_clockevent_setnextevent,
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
+static void __init npcm7xx_clockevents_init(u32 rate)
+{
+	writel(NPCM7XX_DEFAULT_CSR,
+		timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TCSR0);
+
+	writel(NPCM7XX_Tx_RESETINT,
+		timer_of_base(&npcm7xx_to) + NPCM7XX_REG_TISR);
+
+	npcm7xx_to.clkevt.cpumask = cpumask_of(0);
+	clockevents_config_and_register(&npcm7xx_to.clkevt, rate,
+					0x1, NPCM7XX_Tx_MAX_CNT);
+}
+
+static void __init npcm7xx_clocksource_init(u32 rate)
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
+				"npcm7xx-timer1", rate,
+				200, (unsigned int)NPCM7XX_Tx_TDR_MASK_BITS,
+				clocksource_mmio_readl_down);
+}
+
+static int __init npcm7xx_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+	int ret;
+	u32 rate;
+
+	clk = of_clk_get(np, 0);
+
+	if (IS_ERR(clk)) {
+		ret = of_property_read_u32(np, "clock-frequency", &rate);
+		if (ret)
+			return ret;
+	} else {
+		clk_prepare_enable(clk);
+		rate = clk_get_rate(clk);
+		npcm7xx_to.of_clk.clk = clk;
+	}
+
+	ret = timer_of_init(np, &npcm7xx_to);
+	if (ret)
+		goto err_timer_of_init;
+
+	/* Clock input is divided by PRESCALE + 1 before it is fed */
+	/* to the counter */
+	rate = rate / (NPCM7XX_Tx_MIN_PRESCALE + 1);
+	npcm7xx_to.of_clk.rate = rate;
+
+	npcm7xx_clocksource_init(rate);
+	npcm7xx_clockevents_init(rate);
+
+	pr_info("Enabling NPCM7xx clocksource timer base: %p, IRQ: %d\n",
+		 timer_of_base(&npcm7xx_to), timer_of_irq(&npcm7xx_to));
+
+	return 0;
+
+err_timer_of_init:
+	if (!IS_ERR(clk)) {
+		clk_disable_unprepare(clk);
+		clk_put(clk);
+	}
+
+	return ret;
+}
+
+TIMER_OF_DECLARE(npcm7xx, "nuvoton,npcm750-timer", npcm7xx_timer_init);
+
-- 
2.14.1
