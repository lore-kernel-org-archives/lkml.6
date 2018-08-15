Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D064DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71BE214ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p9Eebg89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71BE214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbeHPCvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:51:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25861 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbeHPCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534377380; x=1565913380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=noMIwGk+yiaiNP6BioUAiT1fie1UtB5ayEitPXkci7A=;
  b=p9Eebg89cxaHhmp7eceMSvB5wZRfl19NyRFfP+opWSmdvb6c1I8BqbYV
   x363RmP1dtkCaSDc3ws082fb22ACgjNPn81uqNQpgMMp8H5M4njR+pWMH
   dvkd6J2Pg9hUVZbARESYKSzKhA+8IvMDGUr84w6+GWlWUrYGyMXE4AlBG
   hoGyKWCv/IPIq4wNxpE8yvkf8EaabZ4DuhfOH++Og1n/VXDHTsvaGPgnT
   /xpnDbLY/1FlK9IQPGqDmflY4sukf1y0D5kQaqcM5FtkfA7EeoLzTLXR/
   4adf0SAnEgOqIW4sQqAyLxzo4j5jCPo/IaQABp9GgUkHnPv05SUwuyjSB
   A==;
X-IronPort-AV: E=Sophos;i="5.53,245,1531756800"; 
   d="scan'208";a="88557064"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 07:56:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 Aug 2018 16:44:16 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 16:56:18 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: [RFC PATCH 2/5] RISC-V: Use Linux logical cpu number instead of hartid
Date:   Wed, 15 Aug 2018 16:56:14 -0700
Message-Id: <1534377377-70108-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup the cpu_logical_map during boot. Moreover, every SBI call
and PLIC context are based on the physical hartid. Use the logical
cpu to hartid mapping to pass correct hartid to respective functions.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/tlbflush.h | 17 +++++++++++++----
 arch/riscv/kernel/cpu.c           |  4 +++-
 arch/riscv/kernel/setup.c         | 10 ++++++++++
 arch/riscv/kernel/smp.c           | 24 +++++++++++++++---------
 arch/riscv/kernel/smpboot.c       | 30 ++++++++++++++++++------------
 drivers/clocksource/riscv_timer.c | 12 ++++++++----
 drivers/irqchip/irq-sifive-plic.c | 11 +++++++----
 7 files changed, 74 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 85c2d8ba..ecfd9b0e 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -16,6 +16,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <asm/smp.h>
 
 /*
  * Flush entire local TLB.  'sfence.vma' implicitly fences with the instruction
@@ -49,13 +50,21 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 
 #include <asm/sbi.h>
 
-#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
+static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
+				     unsigned long size)
+{
+	struct cpumask hmask;
+
+	cpuid_to_hartid_mask(cmask, &hmask);
+	sbi_remote_sfence_vma(hmask.bits, start, size);
+}
+
+#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
 #define flush_tlb_page(vma, addr) flush_tlb_range(vma, addr, 0)
 #define flush_tlb_range(vma, start, end) \
-	sbi_remote_sfence_vma(mm_cpumask((vma)->vm_mm)->bits, \
-			      start, (end) - (start))
+	remote_sfence_vma(mm_cpumask((vma)->vm_mm), start, (end) - (start))
 #define flush_tlb_mm(mm) \
-	sbi_remote_sfence_vma(mm_cpumask(mm)->bits, 0, -1)
+	remote_sfence_vma(mm_cpumask(mm), 0, -1)
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ca6c81e5..f8a18ace 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/smp.h>
 
 /* Return -1 if not a valid hart */
 int riscv_of_processor_hart(struct device_node *node)
@@ -79,7 +80,8 @@ static void c_stop(struct seq_file *m, void *v)
 static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long hart_id = (unsigned long)v - 1;
-	struct device_node *node = of_get_cpu_node(hart_id, NULL);
+	struct device_node *node = of_get_cpu_node(cpu_logical_map(hart_id),
+						   NULL);
 	const char *compat, *isa, *mmu;
 
 	seq_printf(m, "hart\t: %lu\n", hart_id);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index e21ed481..97b586f8 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -84,6 +84,16 @@ atomic_t hart_lottery;
 
 u64 __cpu_logical_map[NR_CPUS];
 
+void __init smp_setup_processor_id(void)
+{
+	int cpu = smp_processor_id();
+
+	cpu_logical_map(0) = cpu;
+
+	/* Change the boot cpu ID in thread_info */
+	current->thread_info.cpu = 0;
+}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index d55379ee..4ab70480 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -97,14 +97,18 @@ void riscv_software_interrupt(void)
 static void
 send_ipi_message(const struct cpumask *to_whom, enum ipi_message_type operation)
 {
-	int i;
+	int cpuid, hartid;
+	struct cpumask hartid_mask;
 
+	cpumask_clear(&hartid_mask);
 	mb();
-	for_each_cpu(i, to_whom)
-		set_bit(operation, &ipi_data[i].bits);
-
+	for_each_cpu(cpuid, to_whom) {
+		set_bit(operation, &ipi_data[cpuid].bits);
+		hartid = cpu_logical_map(cpuid);
+		cpumask_set_cpu(hartid, &hartid_mask);
+	}
 	mb();
-	sbi_send_ipi(cpumask_bits(to_whom));
+	sbi_send_ipi(cpumask_bits(&hartid_mask));
 }
 
 void arch_send_call_function_ipi_mask(struct cpumask *mask)
@@ -146,7 +150,7 @@ void smp_send_reschedule(int cpu)
 void flush_icache_mm(struct mm_struct *mm, bool local)
 {
 	unsigned int cpu;
-	cpumask_t others, *mask;
+	cpumask_t others, hmask, *mask;
 
 	preempt_disable();
 
@@ -164,9 +168,11 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 	 */
 	cpumask_andnot(&others, mm_cpumask(mm), cpumask_of(cpu));
 	local |= cpumask_empty(&others);
-	if (mm != current->active_mm || !local)
-		sbi_remote_fence_i(others.bits);
-	else {
+	if (mm != current->active_mm || !local) {
+		cpumask_clear(&hmask);
+		cpuid_to_hartid_mask(&others, &hmask);
+		sbi_remote_fence_i(hmask.bits);
+	} else {
 		/*
 		 * It's assumed that at least one strongly ordered operation is
 		 * performed on this hart between setting a hart's cpumask bit
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 56abab6a..6ab2bb1b 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -50,27 +50,33 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 void __init setup_smp(void)
 {
 	struct device_node *dn = NULL;
-	int hart, im_okay_therefore_i_am = 0;
+	int hart, found_boot_cpu = 0;
+	int cpuid = 1;
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
 		hart = riscv_of_processor_hart(dn);
-		if (hart >= 0) {
-			set_cpu_possible(hart, true);
-			set_cpu_present(hart, true);
-			if (hart == smp_processor_id()) {
-				BUG_ON(im_okay_therefore_i_am);
-				im_okay_therefore_i_am = 1;
-			}
+
+		if (hart < 0)
+			continue;
+		if (hart == cpu_logical_map(0)) {
+			BUG_ON(found_boot_cpu);
+			found_boot_cpu = 1;
+			continue;
 		}
+
+		cpu_logical_map(cpuid) = hart;
+		set_cpu_possible(cpuid, true);
+		set_cpu_present(cpuid, true);
+		cpuid++;
 	}
 
-	BUG_ON(!im_okay_therefore_i_am);
+	BUG_ON(!found_boot_cpu);
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
+	int hartid = cpu_logical_map(cpu);
 	tidle->thread_info.cpu = cpu;
-
 	/*
 	 * On RISC-V systems, all harts boot on their own accord.  Our _start
 	 * selects the first hart to boot the kernel and causes the remainder
@@ -79,8 +85,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	 * the spinning harts that they can continue the boot process.
 	 */
 	smp_mb();
-	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
-	__cpu_up_task_pointer[cpu] = tidle;
+	__cpu_up_stack_pointer[hartid] = task_stack_page(tidle) + THREAD_SIZE;
+	__cpu_up_task_pointer[hartid] = tidle;
 
 	while (!cpu_online(cpu))
 		cpu_relax();
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 4e8b347e..f1f205e5 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <asm/smp.h>
 #include <asm/sbi.h>
 
 /*
@@ -84,13 +85,16 @@ void riscv_timer_interrupt(void)
 
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
-	int cpu_id = riscv_of_processor_hart(n), error;
+	int cpuid, hartid, error;
 	struct clocksource *cs;
 
-	if (cpu_id != smp_processor_id())
+	hartid = riscv_of_processor_hart(n);
+	cpuid = riscv_hartid_to_cpuid(hartid);
+
+	if (cpuid != smp_processor_id())
 		return 0;
 
-	cs = per_cpu_ptr(&riscv_clocksource, cpu_id);
+	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
 	clocksource_register_hz(cs, riscv_timebase);
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
@@ -98,7 +102,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
 	if (error)
 		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpu_id);
+		       error, cpuid);
 	return error;
 }
 
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 298685e5..2eb2e78c 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <asm/smp.h>
 
 /*
  * This driver implements a version of the RISC-V PLIC with the actual layout
@@ -93,10 +94,11 @@ static inline void plic_toggle(int ctxid, int hwirq, int enable)
 static inline void plic_irq_toggle(struct irq_data *d, int enable)
 {
 	int cpu;
+	struct plic_handler *handler;
 
 	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
-		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
+		handler = per_cpu_ptr(&plic_handlers, cpu);
 
 		if (handler->present)
 			plic_toggle(handler->ctxid, d->hwirq, enable);
@@ -217,7 +219,7 @@ static int __init plic_init(struct device_node *node,
 		struct of_phandle_args parent;
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
-		int cpu;
+		int cpu, hartid;
 
 		if (of_irq_parse_one(node, i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
@@ -228,12 +230,13 @@ static int __init plic_init(struct device_node *node,
 		if (parent.args[0] == -1)
 			continue;
 
-		cpu = plic_find_hart_id(parent.np);
-		if (cpu < 0) {
+		hartid = plic_find_hart_id(parent.np);
+		if (hartid < 0) {
 			pr_warn("failed to parse hart ID for context %d.\n", i);
 			continue;
 		}
 
+		cpu = riscv_hartid_to_cpuid(hartid);
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		handler->present = true;
 		handler->ctxid = i;
-- 
2.7.4

