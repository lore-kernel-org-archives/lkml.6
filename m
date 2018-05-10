Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934923AbeEJIge (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:36:34 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:41801 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934366AbeEJIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:36:32 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hoeun.ryu@lge.com.com
X-Original-SENDERIP: 10.177.226.38
X-Original-MAILFROM: hoeun.ryu@lge.com.com
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Hoeun Ryu <hoeun.ryu@lge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] armpmu: broadcast overflow irq on multi-core system having one muxed SPI for PMU.
Date: Thu, 10 May 2018 17:36:17 +0900
Message-Id: <1525941385-12766-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoeun Ryu <hoeun.ryu@lge.com>

 On some SoCs like i.MX6DL/QL have only one muxed SPI for multi-core system.
On the systems, a CPU can be interrupted by overflow irq but it is possible that
the overflow actually occurs on another CPU.
 This patch broadcasts the irq using smp_call_function() so that other CPUs can
check and handle their overflows by themselves when a overflow doesn't actually
occur on the interrupted CPU.

 Local irq is enabled and preemption is disabled temporarily to call
smp_call_function_many() in armpmu_dispatch_irq() as the smp_call_function_many()
doesn't allow to be called with irq-disabled.

 The callback for smp_call_function_many() is __armpmu_handle_irq() and the
function calls armpmu->handle_irq() with an invalid irq_num because
smp_call_func_t has only one parameter and armpmu pointer is handed over by the
pointer. It can be a problem if irq_num parameter is used by handlers but no
handler uses the irq parameter for now. We could have another approach removing
irq_num argument itself in handle_irq() function.

Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
---
 drivers/perf/arm_pmu.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 1a0d340..3d65e44 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -322,6 +322,29 @@ validate_group(struct perf_event *event)
 	return 0;
 }
 
+static void __armpmu_handle_irq(void *dev)
+{
+	struct arm_pmu *armpmu;
+	u64 start_clock, finish_clock;
+	irqreturn_t ret;
+
+	armpmu = *(void **)dev;
+	start_clock = sched_clock();
+	/*
+	 * irq_num should not be used by the handler, we don't have irq_num for
+	 * the first place. There is no handler using the irq_num argument for now.
+	 * smp_call_func_t has one function argument and irq number cannot be handed
+	 * over to this callback because we need dev pointer here.
+	 * If you need valid irq_num, you need to declare a wrapper struct having
+	 * irq_num and dev pointer.
+	 */
+	ret = armpmu->handle_irq(-1, armpmu);
+	if (ret == IRQ_HANDLED) {
+		finish_clock = sched_clock();
+		perf_sample_event_took(finish_clock - start_clock);
+	}
+}
+
 static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 {
 	struct arm_pmu *armpmu;
@@ -340,9 +363,31 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 
 	start_clock = sched_clock();
 	ret = armpmu->handle_irq(irq, armpmu);
-	finish_clock = sched_clock();
-
-	perf_sample_event_took(finish_clock - start_clock);
+	/*
+	 * The handler just returns with IRQ_NONE when it checks the overflow
+	 * and the overflow doesn't occur on the CPU.
+	 *
+	 * Some SoCs like i.MX6 have one muxed SPI on multi-core system.
+	 * On the systems , the irq should be broadcasted to other CPUs so that the
+	 * CPUs can check their own PMU overflow.
+	 */
+	if (ret == IRQ_HANDLED) {
+		finish_clock = sched_clock();
+		perf_sample_event_took(finish_clock - start_clock);
+	} else if (ret == IRQ_NONE) {
+		struct cpumask mask;
+
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+		if (!cpumask_empty(&mask)) {
+			/* smp_call_function cannot be called with irq disabled */
+			local_irq_enable();
+			preempt_disable();
+			smp_call_function_many(&mask, __armpmu_handle_irq, dev, 0);
+			preempt_enable();
+			local_irq_disable();
+		}
+	}
 	return ret;
 }
 
-- 
2.1.4
