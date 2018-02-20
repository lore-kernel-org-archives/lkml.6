Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeBTKdq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:33:46 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:33679 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeBTKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:33:45 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        "Ying Huang" <ying.huang@intel.com>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>,
        "Matija Glavinic Pecotic" <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH 2/2] MIPS: SMP: Introduce CONFIG_SMP_SINGLE_IPI
Date: Tue, 20 Feb 2018 10:32:23 +0000
Message-ID: <1519122743-4847-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519122743-4847-1-git-send-email-matt.redfearn@mips.com>
References: <1519122743-4847-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1519122817-321459-23589-8117-4
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190214
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new Kconfig option which allows selection of a single IPI
per CPU rather than the usual 2 on platforms using
CONFIG_GENERIC_IRQ_IPI.

This introduces a new IPI mechanism in which a bitmask of requested IPIs
is kept per cpu. A bit is atomically set in the target CPUs mask when
requesting an IPI, before raising the necessary interrupt. The
receiving CPU atomically xchg()s the pending mask, then checks for each
IPI function bit being set in the mask and performing appropriate
actions. This is done in a loop so that any further requests that arrive
are handled immediately without returning from interrupt context.

This allows systems which have insufficient interrupts for the usual 2 /
CPU to run SMP Linux.

There is a small performance penalty to the average latency of handling
interrupts with this mechanism. Running an IPI latency test on a CI40
over a weekend, The following latencies were observed, while maxing out
CPUs with stress.

v4.15:
IPI self avg  4us
IPI other core min  5us
IPI other core avg  35us
IPI other core max  602us
IPI other thread avg  30us

v4.15 + CONFIG_SMP_SINGLE_IPI
IPI self avg  6us
IPI other core min  3us
IPI other core avg  42us
IPI other core max  272us
IPI other thread avg  38us

The average time to handle IPIs is increased for all cases of
interrupting the same CPU, the sibling CPU in the same CPU which shares
an L1 cache, and the other core where the action mask must be bounced to
the other core's L1 cache. While the average is higher, the minimum and
maximum latencies of handling IPIs on another core are both reduced.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

The logic of mips_smp_send_ipi_mask / mips_smp_send_ipi_single is
reversed here. Neither the CPU nor GIC IRQ driver implements a function
to raise an interrupt on multiple CPUs at once, so the generic IPI core
must iterate over the CPU mask raising interrupts on each target CPU
individually. Together with needing to set a bit in each CPUs
ipi_action, this would end up with 2 loops over the CPU mask, which can
be avoided by having mips_smp_send_ipi_mask call
mips_smp_send_ipi_single rather than the other way round.

---
 arch/mips/Kconfig      | 11 ++++++
 arch/mips/kernel/smp.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 8e0b3702f1c0..d53964183119 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2654,6 +2654,17 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_SINGLE_IPI
+	bool "Route all IPIs through a single vector"
+	depends on SMP && GENERIC_IRQ_IPI
+	help
+	  This option reduces the number of IPIs required for Linux to one
+	  per CPU rather than the traditional 2, at the expense of a slightly
+	  higher latency. This allows Linux to run on devices that do not have
+	  enough interrupts available for IPIs.
+
+	  If you don't know what to do here, say N.
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP && SYS_SUPPORTS_HOTPLUG_CPU
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 5b25e181cefe..f7f0ec9aa555 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -152,6 +152,71 @@ void register_smp_ops(const struct plat_smp_ops *ops)
 }
 
 #ifdef CONFIG_GENERIC_IRQ_IPI
+
+#ifdef CONFIG_SMP_SINGLE_IPI
+/* A per-cpu mask of pending IPI requests */
+static DEFINE_PER_CPU_SHARED_ALIGNED(atomic_t, ipi_action);
+static unsigned int ipi_virq;
+
+static irqreturn_t handle_IPI(int irq, void *dev_id)
+{
+	atomic_t *pending_ipis = this_cpu_ptr(&ipi_action);
+	unsigned long actions;
+
+	while ((actions = atomic_xchg(pending_ipis, 0)) != 0) {
+		if (actions & SMP_CALL_FUNCTION)
+			generic_smp_call_function_interrupt();
+
+		if (actions & SMP_RESCHEDULE_YOURSELF)
+			scheduler_ipi();
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction irq_ipi = {
+	.handler	= handle_IPI,
+	.flags		= IRQF_PERCPU,
+	.name		= "IPI"
+};
+
+void mips_smp_send_ipi_single(int cpu, unsigned int action)
+{
+	unsigned long flags;
+	unsigned int core;
+
+	local_irq_save(flags);
+
+	atomic_or(action, &per_cpu(ipi_action, cpu));
+	ipi_send_single(ipi_virq, cpu);
+
+	if (IS_ENABLED(CONFIG_CPU_PM) && mips_cpc_present() &&
+	    !cpus_are_siblings(cpu, smp_processor_id())) {
+		/*
+		 * When CPU Idle is enabled, ensure that the target CPU
+		 * is powered up and able to receive the incoming IPI
+		 */
+		while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
+			core = cpu_core(&cpu_data[cpu]);
+			mips_cm_lock_other_cpu(cpu, CM_GCR_Cx_OTHER_BLOCK_LOCAL);
+			mips_cpc_lock_other(core);
+			write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
+			mips_cpc_unlock_other();
+			mips_cm_unlock_other();
+		}
+	}
+	local_irq_restore(flags);
+}
+
+void mips_smp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mask)
+		mips_smp_send_ipi_single(cpu, action);
+}
+
+#else /* CONFIG_SMP_SINGLE_IPI */
 static unsigned int call_virq, sched_virq;
 static struct irq_desc *call_desc;
 static struct irq_desc *sched_desc;
@@ -229,6 +294,8 @@ static struct irqaction irq_call = {
 	.name		= "IPI call"
 };
 
+#endif /* CONFIG_SMP_SINGLE_IPI */
+
 static void smp_ipi_init_one(unsigned int virq,
 				    struct irqaction *action)
 {
@@ -272,6 +339,21 @@ int mips_smp_ipi_allocate(const struct cpumask *mask)
 		return 0;
 	}
 
+#ifdef CONFIG_SMP_SINGLE_IPI
+	virq = irq_reserve_ipi(ipidomain, mask);
+	BUG_ON(!virq);
+	if (!ipi_virq)
+		ipi_virq = virq;
+
+	if (irq_domain_is_ipi_per_cpu(ipidomain)) {
+		int cpu;
+
+		for_each_cpu(cpu, mask)
+			smp_ipi_init_one(ipi_virq + cpu, &irq_ipi);
+	} else {
+		smp_ipi_init_one(ipi_virq, &irq_ipi);
+	}
+#else
 	virq = irq_reserve_ipi(ipidomain, mask);
 	BUG_ON(!virq);
 	if (!call_virq)
@@ -293,6 +375,7 @@ int mips_smp_ipi_allocate(const struct cpumask *mask)
 		smp_ipi_init_one(call_virq, &irq_call);
 		smp_ipi_init_one(sched_virq, &irq_resched);
 	}
+#endif /* CONFIG_SMP_SINGLE_IPI */
 
 	return 0;
 }
@@ -315,6 +398,15 @@ int mips_smp_ipi_free(const struct cpumask *mask)
 
 	BUG_ON(!ipidomain);
 
+#ifdef CONFIG_SMP_SINGLE_IPI
+	if (irq_domain_is_ipi_per_cpu(ipidomain)) {
+		int cpu;
+
+		for_each_cpu(cpu, mask)
+			remove_irq(ipi_virq + cpu, &irq_ipi);
+	}
+	irq_destroy_ipi(ipi_virq, mask);
+#else
 	if (irq_domain_is_ipi_per_cpu(ipidomain)) {
 		int cpu;
 
@@ -325,6 +417,7 @@ int mips_smp_ipi_free(const struct cpumask *mask)
 	}
 	irq_destroy_ipi(call_virq, mask);
 	irq_destroy_ipi(sched_virq, mask);
+#endif /* CONFIG_SMP_SINGLE_IPI */
 	return 0;
 }
 
@@ -336,8 +429,10 @@ static int __init mips_smp_ipi_init(void)
 
 	mips_smp_ipi_allocate(cpu_possible_mask);
 
+#ifndef CONFIG_SMP_SINGLE_IPI
 	call_desc = irq_to_desc(call_virq);
 	sched_desc = irq_to_desc(sched_virq);
+#endif /* CONFIG_SMP_SINGLE_IPI */
 
 	return 0;
 }
-- 
2.7.4
