Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228ECC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC00F20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC00F20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeIYFpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:45:19 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54545 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbeIYFpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:45:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743753|-1;CH=blue;FP=5106910831781415098|1|1|14|0|-1|-1|-1;HT=e01e01454;MF=ren_guo@c-sky.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.CvLwRig_1537832402;
Received: from localhost(mailfrom:ren_guo@c-sky.com fp:SMTPD_---.CvLwRig_1537832402)
          by smtp.aliyun-inc.com(10.147.40.200);
          Tue, 25 Sep 2018 07:40:02 +0800
From:   Guo Ren <ren_guo@c-sky.com>
To:     akpm@linux-foundation.org, arnd@arndb.de,
        daniel.lezcano@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 16/30] csky: SMP support
Date:   Tue, 25 Sep 2018 07:39:19 +0800
Message-Id: <3738782b6821ed5f2110c1b4d76c6bfde3328947.1537789737.git.ren_guo@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
References: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537789736.git.ren_guo@c-sky.com>
References: <cover.1537789736.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds boot, ipi, hotplug code for SMP.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/smp.h |  26 +++++
 arch/csky/kernel/smp.c      | 234 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 260 insertions(+)
 create mode 100644 arch/csky/include/asm/smp.h
 create mode 100644 arch/csky/kernel/smp.c

diff --git a/arch/csky/include/asm/smp.h b/arch/csky/include/asm/smp.h
new file mode 100644
index 0000000..9a53abf
--- /dev/null
+++ b/arch/csky/include/asm/smp.h
@@ -0,0 +1,26 @@
+#ifndef __ASM_CSKY_SMP_H
+#define __ASM_CSKY_SMP_H
+
+#include <linux/cpumask.h>
+#include <linux/irqreturn.h>
+#include <linux/threads.h>
+
+#ifdef CONFIG_SMP
+
+void __init setup_smp(void);
+
+void __init setup_smp_ipi(void);
+
+void __init enable_smp_ipi(void);
+
+void arch_send_call_function_ipi_mask(struct cpumask *mask);
+
+void arch_send_call_function_single_ipi(int cpu);
+
+void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long));
+
+#define raw_smp_processor_id()	(current_thread_info()->cpu)
+
+#endif /* CONFIG_SMP */
+
+#endif /* __ASM_CSKY_SMP_H */
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
new file mode 100644
index 0000000..522c73f
--- /dev/null
+++ b/arch/csky/kernel/smp.c
@@ -0,0 +1,234 @@
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/percpu.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/sched/task_stack.h>
+#include <linux/sched/mm.h>
+#include <asm/irq.h>
+#include <asm/traps.h>
+#include <asm/sections.h>
+#include <asm/mmu_context.h>
+#include <asm/pgalloc.h>
+
+#define IPI_IRQ	15
+
+static struct {
+	unsigned long bits ____cacheline_aligned;
+} ipi_data[NR_CPUS] __cacheline_aligned;
+
+enum ipi_message_type {
+	IPI_EMPTY,
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_MAX
+};
+
+static irqreturn_t handle_ipi(int irq, void *dev)
+{
+	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
+
+	while (true) {
+		unsigned long ops;
+
+		ops = xchg(pending_ipis, 0);
+		if (ops == 0)
+			return IRQ_HANDLED;
+
+		if (ops & (1 << IPI_RESCHEDULE))
+			scheduler_ipi();
+
+		if (ops & (1 << IPI_CALL_FUNC))
+			generic_smp_call_function_interrupt();
+
+		BUG_ON((ops >> IPI_MAX) != 0);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void (*send_arch_ipi)(const unsigned long *mask, unsigned long irq) = NULL;
+
+void __init set_send_ipi(void (*func)(const unsigned long *, unsigned long))
+{
+	if (send_arch_ipi)
+		return;
+
+	send_arch_ipi = func;
+}
+
+static void
+send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
+{
+	int i;
+
+	for_each_cpu(i, to_whom)
+		set_bit(operation, &ipi_data[i].bits);
+
+	smp_mb();
+	send_arch_ipi(cpumask_bits(to_whom), IPI_IRQ);
+}
+
+void arch_send_call_function_ipi_mask(struct cpumask *mask)
+{
+	send_ipi_message(mask, IPI_CALL_FUNC);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
+}
+
+static void ipi_stop(void *unused)
+{
+	while (1);
+}
+
+void smp_send_stop(void)
+{
+	on_each_cpu(ipi_stop, NULL, 1);
+}
+
+void smp_send_reschedule(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
+}
+
+void *__cpu_up_stack_pointer[NR_CPUS];
+void *__cpu_up_task_pointer[NR_CPUS];
+
+void __init smp_prepare_boot_cpu(void)
+{
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+}
+
+static int ipi_dummy_dev;
+
+void __init enable_smp_ipi(void)
+{
+	enable_percpu_irq(IPI_IRQ, 0);
+}
+
+void __init setup_smp_ipi(void)
+{
+	int rc;
+
+	irq_create_mapping(NULL, IPI_IRQ);
+
+	rc = request_percpu_irq(IPI_IRQ, handle_ipi, "IPI Interrupt", &ipi_dummy_dev);
+	if (rc)
+		panic("%s IRQ request failed\n", __func__);
+
+	enable_smp_ipi();
+}
+
+void __init setup_smp(void)
+{
+	struct device_node *node = NULL;
+	int cpu;
+
+	while ((node = of_find_node_by_type(node, "cpu"))) {
+		if (!of_device_is_available(node))
+			continue;
+
+		if (of_property_read_u32(node, "reg", &cpu))
+			continue;
+
+		if (cpu >= NR_CPUS)
+			continue;
+
+		set_cpu_possible(cpu, true);
+		set_cpu_present(cpu, true);
+	}
+}
+
+extern void _start_smp_secondary(void);
+
+volatile unsigned int secondary_hint;
+volatile unsigned int secondary_ccr;
+volatile unsigned int secondary_stack;
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	unsigned int tmp;
+
+	secondary_stack = (unsigned int)tidle->stack + THREAD_SIZE;
+
+	secondary_hint = mfcr("cr31");
+
+	secondary_ccr  = mfcr("cr18");
+
+	/* Flush dcache */
+	mtcr("cr17", 0x22);
+
+	/* Enable cpu in SMP reset ctrl reg */
+	tmp = mfcr("cr<29, 0>");
+	tmp |= 1 << cpu;
+	mtcr("cr<29, 0>", tmp);
+
+	/* Wait for the cpu online */
+	while (!cpu_online(cpu));
+
+	secondary_stack = 0;
+
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+int setup_profiling_timer(unsigned int multiplier)
+{
+	return -EINVAL;
+}
+
+void csky_start_secondary(void)
+{
+	struct mm_struct *mm = &init_mm;
+	unsigned int cpu = smp_processor_id();
+
+	mtcr("cr31", secondary_hint);
+	mtcr("cr18", secondary_ccr);
+
+	mtcr("vbr", vec_base);
+
+	flush_tlb_all();
+	write_mmu_pagemask(0);
+	TLBMISS_HANDLER_SETUP_PGD(swapper_pg_dir);
+	TLBMISS_HANDLER_SETUP_PGD_KERNEL(swapper_pg_dir);
+
+	asid_cache(smp_processor_id()) = ASID_FIRST_VERSION;
+
+#ifdef CONFIG_CPU_HAS_FPU
+	init_fpu();
+#endif
+
+	enable_smp_ipi();
+
+	mmget(mm);
+	mmgrab(mm);
+	current->active_mm = mm;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+
+	pr_info("CPU%u Online: %s...\n", cpu, __func__);
+
+	local_irq_enable();
+	preempt_disable();
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}
-- 
2.7.4

