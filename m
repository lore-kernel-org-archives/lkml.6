Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED67C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A42082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 09:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3A42082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeKDSqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 13:46:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60934 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeKDSqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 13:46:10 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJEl0-0004Gt-0T; Sun, 04 Nov 2018 10:31:46 +0100
Date:   Sun, 4 Nov 2018 10:31:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT pull] timer updates for 4.20-rc1
Message-ID: <alpine.DEB.2.21.1811041030130.3160@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

A set of commits for the new C-SKY architecture timers.

Thanks,

	tglx

------------------>
Guo Ren (4):
      clocksource/drivers/c-sky: Add C-SKY SMP timer
      dt-bindings: timer: C-SKY Multi-processor timer
      clocksource/drivers/c-sky: Add gx6605s SOC system timer
      dt-bindings: timer: gx6605s SOC timer


 .../bindings/timer/csky,gx6605s-timer.txt          |  42 +++++
 .../devicetree/bindings/timer/csky,mptimer.txt     |  42 +++++
 drivers/clocksource/Kconfig                        |  18 +++
 drivers/clocksource/Makefile                       |   2 +
 drivers/clocksource/timer-gx6605s.c                | 154 ++++++++++++++++++
 drivers/clocksource/timer-mp-csky.c                | 173 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 7 files changed, 432 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 drivers/clocksource/timer-gx6605s.c
 create mode 100644 drivers/clocksource/timer-mp-csky.c

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 000000000000..6b04344f4bea
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
@@ -0,0 +1,42 @@
+=================
+gx6605s SOC Timer
+=================
+
+The timer is used in gx6605s soc as system timer and the driver
+contain clk event and clk source.
+
+==============================
+timer node bindings definition
+==============================
+
+	Description: Describes gx6605s SOC timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,gx6605s-timer"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: phandle + clock specifier cells
+		Definition: must be input clk node
+	- interrupt
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer0: timer@20a000 {
+		compatible = "csky,gx6605s-timer";
+		reg = <0x0020a000 0x400>;
+		clocks = <&dummy_apb_clk>;
+		interrupts = <10>;
+		interrupt-parent = <&intc>;
+	};
diff --git a/Documentation/devicetree/bindings/timer/csky,mptimer.txt b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
new file mode 100644
index 000000000000..15cfec08fbb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,mptimer.txt
@@ -0,0 +1,42 @@
+============================
+C-SKY Multi-processors Timer
+============================
+
+C-SKY multi-processors timer is designed for C-SKY SMP system and the
+regs is accessed by cpu co-processor 4 registers with mtcr/mfcr.
+
+ - PTIM_CTLR "cr<0, 14>" Control reg to start reset timer.
+ - PTIM_TSR  "cr<1, 14>" Interrupt cleanup status reg.
+ - PTIM_CCVR "cr<3, 14>" Current counter value reg.
+ - PTIM_LVR  "cr<6, 14>" Window value reg to triger next event.
+
+==============================
+timer node bindings definition
+==============================
+
+	Description: Describes SMP timer
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,mptimer"
+	- clocks
+		Usage: required
+		Value type: <node>
+		Definition: must be input clk node
+	- interrupts
+		Usage: required
+		Value type: <u32>
+		Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer: timer {
+		compatible = "csky,mptimer";
+		clocks = <&dummy_apb_clk>;
+		interrupts = <16>;
+		interrupt-parent = <&intc>;
+	};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba98b05..55c77e44bb2d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -620,4 +620,22 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config CSKY_MP_TIMER
+	bool "SMP Timer for the C-SKY platform" if COMPILE_TEST
+	depends on CSKY
+	select TIMER_OF
+	help
+	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
+	  system.
+	  csky,mptimer is not only used in SMP system, it also could be used
+	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
+
+config GX6605S_TIMER
+	bool "Gx6605s SOC system timer driver" if COMPILE_TEST
+	depends on CSKY
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  This option enables support for gx6605s SOC's timer.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b2427e8a..919633133271 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -79,3 +79,5 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
+obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
+obj-$(CONFIG_GX6605S_TIMER)		+= timer-gx6605s.o
diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
new file mode 100644
index 000000000000..80d0939d040b
--- /dev/null
+++ b/drivers/clocksource/timer-gx6605s.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+
+#include "timer-of.h"
+
+#define CLKSRC_OFFSET	0x40
+
+#define TIMER_STATUS	0x00
+#define TIMER_VALUE	0x04
+#define TIMER_CONTRL	0x10
+#define TIMER_CONFIG	0x20
+#define TIMER_DIV	0x24
+#define TIMER_INI	0x28
+
+#define GX6605S_STATUS_CLR	BIT(0)
+#define GX6605S_CONTRL_RST	BIT(0)
+#define GX6605S_CONTRL_START	BIT(1)
+#define GX6605S_CONFIG_EN	BIT(0)
+#define GX6605S_CONFIG_IRQ_EN	BIT(1)
+
+static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
+{
+	struct clock_event_device *ce = dev;
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	writel_relaxed(GX6605S_STATUS_CLR, base + TIMER_STATUS);
+
+	ce->event_handler(ce);
+
+	return IRQ_HANDLED;
+}
+
+static int gx6605s_timer_set_oneshot(struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	/* reset and stop counter */
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	/* enable with irq and start */
+	writel_relaxed(GX6605S_CONFIG_EN | GX6605S_CONFIG_IRQ_EN,
+		       base + TIMER_CONFIG);
+
+	return 0;
+}
+
+static int gx6605s_timer_set_next_event(unsigned long delta,
+					struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	/* use reset to pause timer */
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	/* config next timeout value */
+	writel_relaxed(ULONG_MAX - delta, base + TIMER_INI);
+	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
+
+	return 0;
+}
+
+static int gx6605s_timer_shutdown(struct clock_event_device *ce)
+{
+	void __iomem *base = timer_of_base(to_timer_of(ce));
+
+	writel_relaxed(0, base + TIMER_CONTRL);
+	writel_relaxed(0, base + TIMER_CONFIG);
+
+	return 0;
+}
+
+static struct timer_of to = {
+	.flags = TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
+	.clkevt = {
+		.rating			= 300,
+		.features		= CLOCK_EVT_FEAT_DYNIRQ |
+					  CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown	= gx6605s_timer_shutdown,
+		.set_state_oneshot	= gx6605s_timer_set_oneshot,
+		.set_next_event		= gx6605s_timer_set_next_event,
+		.cpumask		= cpu_possible_mask,
+	},
+	.of_irq = {
+		.handler		= gx6605s_timer_interrupt,
+		.flags			= IRQF_TIMER | IRQF_IRQPOLL,
+	},
+};
+
+static u64 notrace gx6605s_sched_clock_read(void)
+{
+	void __iomem *base;
+
+	base = timer_of_base(&to) + CLKSRC_OFFSET;
+
+	return (u64)readl_relaxed(base + TIMER_VALUE);
+}
+
+static void gx6605s_clkevt_init(void __iomem *base)
+{
+	writel_relaxed(0, base + TIMER_DIV);
+	writel_relaxed(0, base + TIMER_CONFIG);
+
+	clockevents_config_and_register(&to.clkevt, timer_of_rate(&to), 2,
+					ULONG_MAX);
+}
+
+static int gx6605s_clksrc_init(void __iomem *base)
+{
+	writel_relaxed(0, base + TIMER_DIV);
+	writel_relaxed(0, base + TIMER_INI);
+
+	writel_relaxed(GX6605S_CONTRL_RST, base + TIMER_CONTRL);
+
+	writel_relaxed(GX6605S_CONFIG_EN, base + TIMER_CONFIG);
+
+	writel_relaxed(GX6605S_CONTRL_START, base + TIMER_CONTRL);
+
+	sched_clock_register(gx6605s_sched_clock_read, 32, timer_of_rate(&to));
+
+	return clocksource_mmio_init(base + TIMER_VALUE, "gx6605s",
+			timer_of_rate(&to), 200, 32, clocksource_mmio_readl_up);
+}
+
+static int __init gx6605s_timer_init(struct device_node *np)
+{
+	int ret;
+
+	/*
+	 * The timer driver is for nationalchip gx6605s SOC and there are two
+	 * same timer in gx6605s. We use one for clkevt and another for clksrc.
+	 *
+	 * The timer is mmio map to access, so we need give mmio address in dts.
+	 *
+	 * It provides a 32bit countup timer and interrupt will be caused by
+	 * count-overflow.
+	 * So we need set-next-event by ULONG_MAX - delta in TIMER_INI reg.
+	 *
+	 * The counter at 0x0  offset is clock event.
+	 * The counter at 0x40 offset is clock source.
+	 * They are the same in hardware, just different used by driver.
+	 */
+	ret = timer_of_init(np, &to);
+	if (ret)
+		return ret;
+
+	gx6605s_clkevt_init(timer_of_base(&to));
+
+	return gx6605s_clksrc_init(timer_of_base(&to) + CLKSRC_OFFSET);
+}
+TIMER_OF_DECLARE(csky_gx6605s_timer, "csky,gx6605s-timer", gx6605s_timer_init);
diff --git a/drivers/clocksource/timer-mp-csky.c b/drivers/clocksource/timer-mp-csky.c
new file mode 100644
index 000000000000..a8acc431a774
--- /dev/null
+++ b/drivers/clocksource/timer-mp-csky.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+#include <linux/cpu.h>
+#include <linux/of_irq.h>
+#include <asm/reg_ops.h>
+
+#include "timer-of.h"
+
+#define PTIM_CCVR	"cr<3, 14>"
+#define PTIM_CTLR	"cr<0, 14>"
+#define PTIM_LVR	"cr<6, 14>"
+#define PTIM_TSR	"cr<1, 14>"
+
+static int csky_mptimer_irq;
+
+static int csky_mptimer_set_next_event(unsigned long delta,
+				       struct clock_event_device *ce)
+{
+	mtcr(PTIM_LVR, delta);
+
+	return 0;
+}
+
+static int csky_mptimer_shutdown(struct clock_event_device *ce)
+{
+	mtcr(PTIM_CTLR, 0);
+
+	return 0;
+}
+
+static int csky_mptimer_oneshot(struct clock_event_device *ce)
+{
+	mtcr(PTIM_CTLR, 1);
+
+	return 0;
+}
+
+static int csky_mptimer_oneshot_stopped(struct clock_event_device *ce)
+{
+	mtcr(PTIM_CTLR, 0);
+
+	return 0;
+}
+
+static DEFINE_PER_CPU(struct timer_of, csky_to) = {
+	.flags					= TIMER_OF_CLOCK,
+	.clkevt = {
+		.rating				= 300,
+		.features			= CLOCK_EVT_FEAT_PERCPU |
+						  CLOCK_EVT_FEAT_ONESHOT,
+		.set_state_shutdown		= csky_mptimer_shutdown,
+		.set_state_oneshot		= csky_mptimer_oneshot,
+		.set_state_oneshot_stopped	= csky_mptimer_oneshot_stopped,
+		.set_next_event			= csky_mptimer_set_next_event,
+	},
+};
+
+static irqreturn_t csky_timer_interrupt(int irq, void *dev)
+{
+	struct timer_of *to = this_cpu_ptr(&csky_to);
+
+	mtcr(PTIM_TSR, 0);
+
+	to->clkevt.event_handler(&to->clkevt);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * clock event for percpu
+ */
+static int csky_mptimer_starting_cpu(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&csky_to, cpu);
+
+	to->clkevt.cpumask = cpumask_of(cpu);
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					2, ULONG_MAX);
+
+	enable_percpu_irq(csky_mptimer_irq, 0);
+
+	return 0;
+}
+
+static int csky_mptimer_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(csky_mptimer_irq);
+
+	return 0;
+}
+
+/*
+ * clock source
+ */
+static u64 sched_clock_read(void)
+{
+	return (u64)mfcr(PTIM_CCVR);
+}
+
+static u64 clksrc_read(struct clocksource *c)
+{
+	return (u64)mfcr(PTIM_CCVR);
+}
+
+struct clocksource csky_clocksource = {
+	.name	= "csky",
+	.rating	= 400,
+	.mask	= CLOCKSOURCE_MASK(32),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.read	= clksrc_read,
+};
+
+static int __init csky_mptimer_init(struct device_node *np)
+{
+	int ret, cpu, cpu_rollback;
+	struct timer_of *to = NULL;
+
+	/*
+	 * Csky_mptimer is designed for C-SKY SMP multi-processors and
+	 * every core has it's own private irq and regs for clkevt and
+	 * clksrc.
+	 *
+	 * The regs is accessed by cpu instruction: mfcr/mtcr instead of
+	 * mmio map style. So we needn't mmio-address in dts, but we still
+	 * need to give clk and irq number.
+	 *
+	 * We use private irq for the mptimer and irq number is the same
+	 * for every core. So we use request_percpu_irq() in timer_of_init.
+	 */
+	csky_mptimer_irq = irq_of_parse_and_map(np, 0);
+	if (csky_mptimer_irq <= 0)
+		return -EINVAL;
+
+	ret = request_percpu_irq(csky_mptimer_irq, csky_timer_interrupt,
+				 "csky_mp_timer", &csky_to);
+	if (ret)
+		return -EINVAL;
+
+	for_each_possible_cpu(cpu) {
+		to = per_cpu_ptr(&csky_to, cpu);
+		ret = timer_of_init(np, to);
+		if (ret)
+			goto rollback;
+	}
+
+	clocksource_register_hz(&csky_clocksource, timer_of_rate(to));
+	sched_clock_register(sched_clock_read, 32, timer_of_rate(to));
+
+	ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
+				"clockevents/csky/timer:starting",
+				csky_mptimer_starting_cpu,
+				csky_mptimer_dying_cpu);
+	if (ret)
+		return -EINVAL;
+
+	return 0;
+
+rollback:
+	for_each_possible_cpu(cpu_rollback) {
+		if (cpu_rollback == cpu)
+			break;
+
+		to = per_cpu_ptr(&csky_to, cpu_rollback);
+		timer_of_cleanup(to);
+	}
+	return -EINVAL;
+}
+TIMER_OF_DECLARE(csky_mptimer, "csky,mptimer", csky_mptimer_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index caf40ad0bbc6..e0cd2baa8380 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -126,6 +126,7 @@ enum cpuhp_state {
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
 	CPUHP_AP_ARC_TIMER_STARTING,
 	CPUHP_AP_RISCV_TIMER_STARTING,
+	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_KVM_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
