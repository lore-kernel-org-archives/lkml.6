Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D06C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535E520831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsVrQgNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535E520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKCERa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:17:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51798 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeKCERa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:17:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so2878327wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5rXuDaEHAkFW6LDykdQEBdeHgn9b95w5iCoVqi0Omg=;
        b=PsVrQgNfaLhnEDvTl5n5EKW2y3IWdusohE/I75tigkTc15taDY2nE/wcnS08gQ4mDK
         eryWgL4JvX3Ov9GDRFzpBTidlRsUaQyYLsEWhsT+rUoeEcvYQ9OipnoLmSp6DLB97w0G
         ywtxM/spcMzmwaxvD2l90A7XeRQ1wdC+ENnJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5rXuDaEHAkFW6LDykdQEBdeHgn9b95w5iCoVqi0Omg=;
        b=owKcetrwGV7Oenyeu216H+W9JPyCAtHOz0FftB4DgniwmcuTP+lfVzu/6YsqbWRdsZ
         JUobEErOtTPubKPaJCbrER69GdEoDdpqogxWQJWk8RIWS5xwQkbAk3mLUZD1kG5d43E3
         kLeNbZmSYUFIbsedS6NECaxlFGe2gpMiIxYyd99WWLY0OiBGdeSa9aFG6LuwL1b3UV8+
         7VuYqAmV24kNeZ78hMoUQXntiu71uiI67R0gKBPq28kDKl9zq3ktzY73FBLaR89UaDZm
         KGaH7Hvk3UMTMPG0zkcQjazxOSf3exliVuYlI5YgpPwE0L4J0JZw1fZA4psI6uOL+j0o
         ipOA==
X-Gm-Message-State: AGRZ1gI9wtCYLGuxNDzreweZDAHpmHSTfQS6H+JDeh/c4JOc4aQbmBqP
        sWAcMMSMFuwPluKVMc8sXpu++A==
X-Google-Smtp-Source: AJdET5ftSn0ptduplu9wTH8s9jceJCakXVD53CJiqRMRVq48I65VULQN1ztWAjpcfuyyC8IsmV2t2A==
X-Received: by 2002:a1c:a905:: with SMTP id s5-v6mr154989wme.75.1541185748291;
        Fri, 02 Nov 2018 12:09:08 -0700 (PDT)
Received: from localhost.localdomain ([80.125.186.228])
        by smtp.gmail.com with ESMTPSA id s195-v6sm3899337wmd.39.2018.11.02.12.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Nov 2018 12:09:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ren_guo@c-sky.com
Subject: [PATCH 1/4] clocksource/drivers/c-sky: Add C-SKY SMP timer
Date:   Fri,  2 Nov 2018 20:08:55 +0100
Message-Id: <1541185738-8208-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
References: <d99ed466-b11a-b931-fc7a-a555cae80a53@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The driver is for C-SKY SMP timer. It only supports oneshot event
and 32bit overflow for clocksource. Per cpu core has one timer and
all timers share one clock-counter-input from the same clocksource.

This use mfcr&mtcr instructions to access the regs.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig         |  10 +++
 drivers/clocksource/Makefile        |   1 +
 drivers/clocksource/timer-mp-csky.c | 173 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h          |   1 +
 4 files changed, 185 insertions(+)
 create mode 100644 drivers/clocksource/timer-mp-csky.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba..591c9a8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -620,4 +620,14 @@ config RISCV_TIMER
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
index 0000000..a8acc43
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

