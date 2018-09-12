Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B379C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427D720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427D720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbeILT6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:58:34 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52028 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbeILT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:58:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07438443|-1;CH=blue;FP=12543954563359245754|1|1|11|0|-1|-1|-1;HT=e01l07447;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.Cpx4Tpa_1536764009;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.Cpx4Tpa_1536764009)
          by smtp.aliyun-inc.com(10.147.40.233);
          Wed, 12 Sep 2018 22:53:29 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org,
        andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc:     c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com,
        green.hu@gmail.com
Subject: [PATCH V4 24/27] clocksource: add C-SKY SMP timer
Date:   Wed, 12 Sep 2018 22:52:06 +0800
Message-Id: <f7ebc52b77fc5706f69c44aac467e26d166942b8.1536758961.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This timer is used by SMP system and use mfcr/mtcr instruction
to access the regs.

Changelog:
 - Support csky mp timer alpha version.
 - Just use low-counter with 32bit width as clocksource.
 - Coding convention with upstream feed-back.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 drivers/clocksource/csky_mptimer.c | 178 +++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 drivers/clocksource/csky_mptimer.c

diff --git a/drivers/clocksource/csky_mptimer.c b/drivers/clocksource/csky_mptimer.c
new file mode 100644
index 0000000..da2b239
--- /dev/null
+++ b/drivers/clocksource/csky_mptimer.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/sched_clock.h>
+#include <linux/cpu.h>
+#include <asm/reg_ops.h>
+
+#include "timer-of.h"
+
+#define PTIM_CCVR	"cr<3, 14>"
+#define PTIM_CTLR	"cr<0, 14>"
+#define PTIM_LVR	"cr<6, 14>"
+#define PTIM_TSR	"cr<1, 14>"
+
+static int csky_mptimer_set_next_event(unsigned long delta, struct clock_event_device *ce)
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
+	.of_irq = {
+		.flags				= IRQF_TIMER,
+		.percpu				= 1,
+	},
+};
+
+static irqreturn_t timer_interrupt(int irq, void *dev)
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
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to), 2, ULONG_MAX);
+
+	enable_percpu_irq(timer_of_irq(to), 0);
+
+	return 0;
+}
+
+static int csky_mptimer_dying_cpu(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&csky_to, cpu);
+
+	disable_percpu_irq(timer_of_irq(to));
+
+	return 0;
+}
+
+/*
+ * clock source
+ */
+static u64 sched_clock_read(void)
+{
+	return (u64) mfcr(PTIM_CCVR);
+}
+
+static u64 clksrc_read(struct clocksource *c)
+{
+	return (u64) mfcr(PTIM_CCVR);
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
+#define CPUHP_AP_CSKY_TIMER_STARTING CPUHP_AP_DUMMY_TIMER_STARTING
+
+static int __init csky_mptimer_init(struct device_node *np)
+{
+	int ret, cpu;
+	struct timer_of *to;
+	int rate = 0;
+	int irq	 = 0;
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
+
+	for_each_possible_cpu(cpu) {
+		to = per_cpu_ptr(&csky_to, cpu);
+
+		if (cpu == 0) {
+			to->flags	  |= TIMER_OF_IRQ;
+			to->of_irq.handler = timer_interrupt;
+
+			ret = timer_of_init(np, to);
+			if (ret)
+				return ret;
+
+			rate	= timer_of_rate(to);
+			irq	= to->of_irq.irq;
+		} else {
+			ret = timer_of_init(np, to);
+			if (ret)
+				return ret;
+
+			to->of_clk.rate	= rate;
+			to->of_irq.irq	= irq;
+		}
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_CSKY_TIMER_STARTING,
+				"clockevents/csky/timer:starting",
+				csky_mptimer_starting_cpu,
+				csky_mptimer_dying_cpu);
+	if (ret) {
+		pr_err("%s: Failed to cpuhp_setup_state.\n", __func__);
+		return ret;
+	}
+
+	clocksource_register_hz(&csky_clocksource, rate);
+	sched_clock_register(sched_clock_read, 32, rate);
+
+	return 0;
+}
+TIMER_OF_DECLARE(csky_mptimer, "csky,mptimer", csky_mptimer_init);
-- 
2.7.4

