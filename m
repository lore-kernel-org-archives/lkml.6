Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeENC0w (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 22:26:52 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:52567 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeENC0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 22:26:51 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: hoeun.ryu@lge.com.com
X-Original-SENDERIP: 10.177.226.38
X-Original-MAILFROM: hoeun.ryu@lge.com.com
From: Hoeun Ryu <hoeun.ryu@lge.com.com>
To: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Hoeun Ryu <hoeun.ryu@lge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] armpmu: broadcast overflow irq on multi-core system having one muxed SPI for PMU.
Date: Mon, 14 May 2018 11:23:17 +0900
Message-Id: <1526264797-24211-1-git-send-email-hoeun.ryu@lge.com.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hoeun Ryu <hoeun.ryu@lge.com>

 On some SoCs like i.MX6DL/QL have only one muxed SPI for multi-core system.
On the systems, a CPU can be interrupted by overflow irq but it is possible that
the overflow actually occurs on another CPU.
 This patch broadcasts the irq using smp_call_function_single_async() so that other
CPUs can check and handle their overflows by themselves when a overflow doesn't
actually occur on the interrupted CPU. Per-cpu call_single_data are allocated in
arm_pmu structure for this purpose during initialization

 The callback for smp_call_function_single_async() is __armpmu_handle_irq() and
the function calls armpmu->handle_irq() with an invalid irq_num because
smp_call_func_t has only one parameter and armpmu pointer is handed over by the
pointer. It can be a problem if irq_num parameter is used by handlers but no
handler uses the irq parameter for now. We could have another approach removing
irq_num argument itself in handle_irq() function.

Signed-off-by: Hoeun Ryu <hoeun.ryu@lge.com>
---
 drivers/perf/arm_pmu.c       | 62 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/perf/arm_pmu.h |  3 +++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 1a0d340..df024a0 100644
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
@@ -340,9 +363,34 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 
 	start_clock = sched_clock();
 	ret = armpmu->handle_irq(irq, armpmu);
-	finish_clock = sched_clock();
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
+		int cpu;
+		struct cpumask mask;
+
+		cpumask_copy(&mask, cpu_online_mask);
+		cpumask_clear_cpu(raw_smp_processor_id(), &mask);
+		for_each_cpu(cpu, &mask) {
+			call_single_data_t *csd =
+				per_cpu_ptr(armpmu->ov_brdcast_csd, cpu);
+
+			csd->func = __armpmu_handle_irq;
+			csd->info = dev;
+
+			smp_call_function_single_async(cpu, csd);
+		}
+	}
 
-	perf_sample_event_took(finish_clock - start_clock);
 	return ret;
 }
 
@@ -790,6 +838,13 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 		goto out_free_pmu;
 	}
 
+	pmu->ov_brdcast_csd = alloc_percpu_gfp(call_single_data_t, flags);
+	if (!pmu->ov_brdcast_csd) {
+		pr_info("failed to allocate per-cpu "
+			"overflow broadcasting call single data.\n");
+		goto out_free_hw_events;
+	}
+
 	pmu->pmu = (struct pmu) {
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
@@ -824,6 +879,8 @@ static struct arm_pmu *__armpmu_alloc(gfp_t flags)
 
 	return pmu;
 
+out_free_hw_events:
+	free_percpu(pmu->hw_events);
 out_free_pmu:
 	kfree(pmu);
 out:
@@ -844,6 +901,7 @@ struct arm_pmu *armpmu_alloc_atomic(void)
 void armpmu_free(struct arm_pmu *pmu)
 {
 	free_percpu(pmu->hw_events);
+	free_percpu(pmu->ov_brdcast_csd);
 	kfree(pmu);
 }
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 40036a5..a63da63 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -107,6 +107,9 @@ struct arm_pmu {
 
 	/* Only to be used by ACPI probing code */
 	unsigned long acpi_cpuid;
+
+	/* per-cpu call single data for overflow broadcasting */
+	call_single_data_t __percpu *ov_brdcast_csd;
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
-- 
2.1.4
