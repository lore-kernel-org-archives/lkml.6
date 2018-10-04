Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5968CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232DA21479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232DA21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeJEARJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:17:09 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34742 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727536AbeJEARJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:17:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437585|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03297;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.CzPtqHg_1538673763;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CzPtqHg_1538673763)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 05 Oct 2018 01:22:43 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        daniel.lezcano@linaro.org, anurup.m@huawei.com,
        Jonathan.Cameron@huawei.com, will.deacon@arm.com,
        zhangshaokun@hisilicon.com, jhogan@kernel.org,
        paul.burton@mips.com, peterz@infradead.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V10 5/8] clocksource: add C-SKY SMP timer
Date:   Fri,  5 Oct 2018 01:22:25 +0800
Message-Id: <76f127a22faf8f110f102ee3534792b2b84a7d78.1538672812.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1538672812.git.ren_guo@c-sky.com>
References: <cover.1538672812.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538672812.git.ren_guo@c-sky.com>
References: <cover.1538672812.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This timer is used by SMP system and use mfcr/mtcr instruction
to access the regs.

Changelog:
 - Add rollback for timer_of_cleanup.
 - Use request_percpu_irq separate from time_of.
 - Remove #define CPUHP_AP_CSKY_TIMER_STARTING.
 - Add CPUHP_AP_CSKY_TIMER_STARTING in cpuhotplug.h.
 - Support csky mp timer alpha version.
 - Just use low-counter with 32bit width as clocksource.
 - Coding convention with upstream feed-back.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/Kconfig         |  10 +++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-mp-csky.c | 173 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h          |   1 +
 4 files changed, 185 insertions(+)
 create mode 100644 drivers/clocksource/timer-mp-csky.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba..826a2e8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -620,4 +620,14 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
 
+config CSKY_MP_TIMER
+	bool "SMP Timer for the C-SKY platform"
+	depends on CSKY
+	select TIMER_OF
+	help
+	  Say yes here to enable C-SKY SMP timer driver used for C-SKY SMP
+	  system.
+	  csky,mptimer is not only used in SMP system, it also could be used
+	  single core system. It's not a mmio reg and it use mtcr/mfcr instruction.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b24..5ce82d3 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -79,3 +79,4 @@ obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
 obj-$(CONFIG_ATCPIT100_TIMER)		+= timer-atcpit100.o
 obj-$(CONFIG_RISCV_TIMER)		+= riscv_timer.o
+obj-$(CONFIG_CSKY_MP_TIMER)		+= timer-mp-csky.o
diff --git a/drivers/clocksource/timer-mp-csky.c b/drivers/clocksource/timer-mp-csky.c
new file mode 100644
index 0000000..3e8de73
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
+	ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
+				"clockevents/csky/timer:starting",
+				csky_mptimer_starting_cpu,
+				csky_mptimer_dying_cpu);
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
index caf40ad..e0cd2ba 100644
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
-- 
2.7.4

