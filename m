Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE85CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408852087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OXEotBKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408852087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeH1M0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:26:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54533 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbeH1M0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535445407; x=1566981407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=caqqGHrcEYtcnfQMg1sSxj6aeh16yJ/Wz4vAVcQH2fg=;
  b=OXEotBKprFPjpDtqPoxKXlPg4vpXY9dJuVdEqPobwoPegLdhjuKXs4yp
   Y4jpvhT2FoXcFxLSENFu7VpyIC48z7TWqrQJ/T7DpzmsfGBpbCVeBtfZe
   GscIkOKiyEy09S9xlnTNxsYYNNvyHXpoBcu89Ih+/btMkIe9vKO0ekGH7
   SD90cWELnYqyahNhlRXF152te0SRv2jHPHVFZo5/IOcpuBLCL/7H9N9Ss
   cb8qnuErkCQoI3q3cmVYb79gPFpZMylyU/DfDFIbXDTpaaSe4GcFRNx/W
   zGIv71DE0TuYZlCf+oWCcTFzKgdqrMH4xHhtlvZpUtJ2UE7AzESSpeXK1
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,298,1531756800"; 
   d="scan'208";a="185994294"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2018 16:36:47 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Aug 2018 01:23:08 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Aug 2018 01:36:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, damein@vger.kernel.org
Subject: [PATCH v2 2/3] RISC-V: Use Linux logical cpu number instead of hartid
Date:   Tue, 28 Aug 2018 01:36:09 -0700
Message-Id: <1535445370-19004-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
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
 arch/riscv/kernel/cpu.c           |  8 +++++---
 arch/riscv/kernel/head.S          |  4 +++-
 arch/riscv/kernel/setup.c         |  6 ++++++
 arch/riscv/kernel/smp.c           | 24 +++++++++++++++---------
 arch/riscv/kernel/smpboot.c       | 30 ++++++++++++++++++------------
 drivers/clocksource/riscv_timer.c | 12 ++++++++----
 drivers/irqchip/irq-sifive-plic.c | 11 +++++++----
 8 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 85c2d8ba..c6b51059 100644
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
+	riscv_cpuid_to_hartid_mask(cmask, &hmask);
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
index ca6c81e5..4684b915 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/smp.h>
 
 /* Return -1 if not a valid hart */
 int riscv_of_processor_hart(struct device_node *node)
@@ -78,11 +79,12 @@ static void c_stop(struct seq_file *m, void *v)
 
 static int c_show(struct seq_file *m, void *v)
 {
-	unsigned long hart_id = (unsigned long)v - 1;
-	struct device_node *node = of_get_cpu_node(hart_id, NULL);
+	unsigned long cpu_id = (unsigned long)v - 1;
+	struct device_node *node = of_get_cpu_node(cpu_logical_map(cpu_id),
+						   NULL);
 	const char *compat, *isa, *mmu;
 
-	seq_printf(m, "hart\t: %lu\n", hart_id);
+	seq_printf(m, "hart\t: %lu\n", cpu_id);
 	if (!of_property_read_string(node, "riscv,isa", &isa)
 	    && isa[0] == 'r'
 	    && isa[1] == 'v')
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index d1beecf1..19085349 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -47,6 +47,8 @@ ENTRY(_start)
 	/* Save hart ID and DTB physical address */
 	mv s0, a0
 	mv s1, a1
+	la a2, boot_cpu_hartid
+	REG_S a0, (a2)
 
 	/* Initialize page tables and relocate to virtual addresses */
 	la sp, init_thread_union + THREAD_SIZE
@@ -55,7 +57,7 @@ ENTRY(_start)
 
 	/* Restore C environment */
 	la tp, init_task
-	sw s0, TASK_TI_CPU(tp)
+	sw zero, TASK_TI_CPU(tp)
 
 	la sp, init_thread_union
 	li a0, ASM_THREAD_SIZE
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 7b52b4cd..4af7952c 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -81,9 +81,15 @@ EXPORT_SYMBOL(empty_zero_page);
 
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
+unsigned long boot_cpu_hartid;
 
 unsigned long __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HARTID };
 
+void __init smp_setup_processor_id(void)
+{
+	cpu_logical_map(0) = boot_cpu_hartid;
+}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
 {
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 9b288c9a..82da5c4c 100644
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
+		riscv_cpuid_to_hartid_mask(&others, &hmask);
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

