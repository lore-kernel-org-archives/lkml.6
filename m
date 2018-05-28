Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeE1Re3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:34:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52612 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbeE1Re0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:34:26 -0400
X-Google-Smtp-Source: ADUXVKL+IxOao9+Oj0SwHH5rSQxmE5tl6qzcoba3Ja0POj7LKq6aa0SVg/mN+IB42hltcharCJz91w==
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.dider@devialet.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Colin Didier <colin.didier@devialet.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH 4/5] clocksource: add driver for i.MX EPIT timer
Date: Mon, 28 May 2018 19:34:11 +0200
Message-Id: <20180528173412.10000-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528173412.10000-1-peron.clem@gmail.com>
References: <20180528173412.10000-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

Add driver for NXP's EPIT timer used in i.MX 6 family of SoC.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
---
 drivers/clocksource/Kconfig          |  12 ++
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/timer-imx-epit.c | 254 +++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/clocksource/timer-imx-epit.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8e8a09755d10..cc1ed592fa6f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -576,6 +576,18 @@ config H8300_TPU
 	  This enables the clocksource for the H8300 platform with the
 	  H8S2678 cpu.
 
+config CLKSRC_IMX_EPIT
+	bool "Clocksource using i.MX EPIT"
+	depends on ARM && CLKDEV_LOOKUP && (ARCH_MXC || COMPILE_TEST)
+	select CLKSRC_OF if OF
+	select CLKSRC_MMIO
+	help
+	  This enables EPIT support available on some i.MX platforms.
+	  Normally you don't have a reason to do so as the EPIT has
+	  the same features and uses the same clocks as the GPT.
+	  Anyway, on some systems the GPT may be in use for other
+	  purposes.
+
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
 	depends on ARM && CLKDEV_LOOKUP
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 00caf37e52f9..d9426f69ec69 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
 obj-$(CONFIG_CLKSRC_VERSATILE)		+= versatile.o
 obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
+obj-$(CONFIG_CLKSRC_IMX_EPIT)		+= timer-imx-epit.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
diff --git a/drivers/clocksource/timer-imx-epit.c b/drivers/clocksource/timer-imx-epit.c
new file mode 100644
index 000000000000..96eb6435a9c3
--- /dev/null
+++ b/drivers/clocksource/timer-imx-epit.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * i.MX EPIT Timer
+ *
+ * Copyright (C) 2010 Sascha Hauer <s.hauer@pengutronix.de>
+ * Copyright (C) 2018 Colin Didier <colin.didier@devialet.com>
+ */
+
+#define EPITCR		0x00
+#define EPITSR		0x04
+#define EPITLR		0x08
+#define EPITCMPR	0x0c
+#define EPITCNR		0x10
+
+#define EPITCR_EN			(1 << 0)
+#define EPITCR_ENMOD			(1 << 1)
+#define EPITCR_OCIEN			(1 << 2)
+#define EPITCR_RLD			(1 << 3)
+#define EPITCR_PRESC(x)			(((x) & 0xfff) << 4)
+#define EPITCR_SWR			(1 << 16)
+#define EPITCR_IOVW			(1 << 17)
+#define EPITCR_DBGEN			(1 << 18)
+#define EPITCR_WAITEN			(1 << 19)
+#define EPITCR_RES			(1 << 20)
+#define EPITCR_STOPEN			(1 << 21)
+#define EPITCR_OM_DISCON		(0 << 22)
+#define EPITCR_OM_TOGGLE		(1 << 22)
+#define EPITCR_OM_CLEAR			(2 << 22)
+#define EPITCR_OM_SET			(3 << 22)
+#define EPITCR_CLKSRC_OFF		(0 << 24)
+#define EPITCR_CLKSRC_PERIPHERAL	(1 << 24)
+#define EPITCR_CLKSRC_REF_HIGH		(2 << 24)
+#define EPITCR_CLKSRC_REF_LOW		(3 << 24)
+
+#define EPITSR_OCIF			(1 << 0)
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/clockchips.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+
+struct epit_timer {
+	void __iomem *base;
+	int irq;
+	struct clk *clk_per;
+	struct clock_event_device ced;
+	struct irqaction act;
+};
+
+static inline struct epit_timer *to_epit_timer(struct clock_event_device *ced)
+{
+	return container_of(ced, struct epit_timer, ced);
+}
+
+static inline void epit_irq_disable(struct epit_timer *epittm)
+{
+	u32 val;
+
+	val = readl_relaxed(epittm->base + EPITCR);
+	writel_relaxed(val & ~EPITCR_OCIEN, epittm->base + EPITCR);
+}
+
+static inline void epit_irq_enable(struct epit_timer *epittm)
+{
+	u32 val;
+
+	val = readl_relaxed(epittm->base + EPITCR);
+	writel_relaxed(val | EPITCR_OCIEN, epittm->base + EPITCR);
+}
+
+static void epit_irq_acknowledge(struct epit_timer *epittm)
+{
+	writel_relaxed(EPITSR_OCIF, epittm->base + EPITSR);
+}
+
+static void __iomem *sched_clock_reg;
+
+static u64 notrace epit_read_sched_clock(void)
+{
+	return ~readl_relaxed(sched_clock_reg);
+}
+
+static int __init epit_clocksource_init(struct epit_timer *epittm)
+{
+	unsigned int c = clk_get_rate(epittm->clk_per);
+
+	sched_clock_reg = epittm->base + EPITCNR;
+	sched_clock_register(epit_read_sched_clock, 32, c);
+
+	return clocksource_mmio_init(epittm->base + EPITCNR, "epit", c, 200, 32,
+			clocksource_mmio_readl_down);
+}
+
+/* clock event */
+
+static int epit_set_next_event(unsigned long cycles,
+		struct clock_event_device *ced)
+{
+	struct epit_timer *epittm = to_epit_timer(ced);
+	unsigned long tcmp;
+
+	tcmp = readl_relaxed(epittm->base + EPITCNR) - cycles;
+
+	writel_relaxed(tcmp, epittm->base + EPITCMPR);
+
+	return 0;
+}
+
+/* Left event sources disabled, no more interrupts appear */
+static int epit_shutdown(struct clock_event_device *ced)
+{
+	struct epit_timer *epittm = to_epit_timer(ced);
+	unsigned long flags;
+
+	/*
+	 * The timer interrupt generation is disabled at least
+	 * for enough time to call epit_set_next_event()
+	 */
+	local_irq_save(flags);
+
+	/* Disable interrupt in EPIT module */
+	epit_irq_disable(epittm);
+
+	/* Clear pending interrupt */
+	epit_irq_acknowledge(epittm);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int epit_set_oneshot(struct clock_event_device *ced)
+{
+	struct epit_timer *epittm = to_epit_timer(ced);
+	unsigned long flags;
+
+	/*
+	 * The timer interrupt generation is disabled at least
+	 * for enough time to call epit_set_next_event()
+	 */
+	local_irq_save(flags);
+
+	/* Disable interrupt in EPIT module */
+	epit_irq_disable(epittm);
+
+	/* Clear pending interrupt, only while switching mode */
+	if (!clockevent_state_oneshot(ced))
+		epit_irq_acknowledge(epittm);
+
+	/*
+	 * Do not put overhead of interrupt enable/disable into
+	 * epit_set_next_event(), the core has about 4 minutes
+	 * to call epit_set_next_event() or shutdown clock after
+	 * mode switching
+	 */
+	epit_irq_enable(epittm);
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t epit_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *ced = dev_id;
+	struct epit_timer *epittm = to_epit_timer(ced);
+
+	epit_irq_acknowledge(epittm);
+
+	ced->event_handler(ced);
+
+	return IRQ_HANDLED;
+}
+
+static int __init epit_clockevent_init(struct epit_timer *epittm)
+{
+	struct clock_event_device *ced = &epittm->ced;
+	struct irqaction *act = &epittm->act;
+
+	ced->name = "epit";
+	ced->features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ;
+	ced->set_state_shutdown = epit_shutdown;
+	ced->tick_resume = epit_shutdown;
+	ced->set_state_oneshot = epit_set_oneshot;
+	ced->set_next_event = epit_set_next_event;
+	ced->rating = 200;
+	ced->cpumask = cpumask_of(0);
+	ced->irq = epittm->irq;
+	clockevents_config_and_register(ced, clk_get_rate(epittm->clk_per),
+		0xff, 0xfffffffe);
+
+	act->name = "i.MX EPIT Timer Tick",
+	act->flags = IRQF_TIMER | IRQF_IRQPOLL;
+	act->handler = epit_timer_interrupt;
+	act->dev_id = ced;
+
+	/* Make irqs happen */
+	return setup_irq(epittm->irq, act);
+}
+
+static int __init epit_timer_init(struct device_node *np)
+{
+	struct epit_timer *epittm;
+	struct clk *clk_ipg;
+
+	epittm = kzalloc(sizeof(*epittm), GFP_KERNEL);
+	if (!epittm)
+		return -ENOMEM;
+
+	epittm->base = of_iomap(np, 0);
+	if (!epittm->base)
+		return -ENXIO;
+
+	epittm->irq = irq_of_parse_and_map(np, 0);
+	if (epittm->irq <= 0)
+		return -EINVAL;
+
+	epittm->clk_per = of_clk_get_by_name(np, "per");
+
+	clk_ipg = of_clk_get_by_name(np, "ipg");
+	if (!IS_ERR(clk_ipg))
+		clk_prepare_enable(clk_ipg);
+
+	if (IS_ERR(epittm->clk_per)) {
+		pr_err("i.MX EPIT: unable to get clk\n");
+		return PTR_ERR(epittm->clk_per);
+	}
+	clk_prepare_enable(epittm->clk_per);
+
+	/*
+	 * Initialise to a known state (all timers off, and timing reset)
+	 */
+	writel_relaxed(0x0, epittm->base + EPITCR);
+
+	writel_relaxed(0xffffffff, epittm->base + EPITLR);
+	writel_relaxed(EPITCR_EN | EPITCR_CLKSRC_REF_HIGH | EPITCR_WAITEN,
+		epittm->base + EPITCR);
+
+	/* init and register the timer to the framework */
+	epit_clocksource_init(epittm);
+	epit_clockevent_init(epittm);
+
+	return 0;
+}
+CLOCKSOURCE_OF_DECLARE(mx6q_timer, "fsl,imx6q-epit", epit_timer_init);
-- 
2.17.0
