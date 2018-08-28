Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9774FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3519E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g3dIR0Sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3519E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbeH1M0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:26:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54531 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbeH1M0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1535445408; x=1566981408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/yYpwKQl520jpagW81OWFdhou9tdHNp5w0vw5DocxBM=;
  b=g3dIR0Sp2our4t28AO0W7AOnd9IRD5C+65rjmVTyGIGM7e2SoufvhbU8
   VgxB/qL87+hL2NJPQaJM9WKfJCQ0dPqZktm2mE+e+KQllVBasd1kK7ID0
   C1ZbPfRI4wxL0G4UVcsaWNwHqobJqlkT5C2rFVzIdvMmjo3K/cPHGFDEU
   y4Pg6PzcisGEu8j79f7k1FXDRmQym1MxLZ/ZcB3DxwRmoDA3B3LLFEDQj
   F1M+wW/G0pEr8Rq3OknrGjl/stWltcmWYjELULX6d5F1AA4Dngbcyc4un
   wzlrwbj4/mpwXCnxSgFC0VyAyHWH6/iJxL3z26/15njIibWmSibHZz7Rk
   w==;
X-IronPort-AV: E=Sophos;i="5.53,298,1531756800"; 
   d="scan'208";a="185994296"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2018 16:36:47 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 28 Aug 2018 01:23:09 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Aug 2018 01:36:12 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, damein@vger.kernel.org
Subject: [PATCH v2 3/3] RISC-V: Support cpu hotplug.
Date:   Tue, 28 Aug 2018 01:36:10 -0700
Message-Id: <1535445370-19004-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable support for cpu hotplug in RISC-V.

In absence of generic cpu stop functions, WFI is used
to put the cpu in low power state during offline. An IPI
is sent to bring it out of WFI during online operation.

Tested both on QEMU and HighFive Unleashed board with
4 cpus. Test result follows.

$ echo 0 > /sys/devices/system/cpu/cpu2/online
[   31.828562] CPU2: shutdown
$ cat /proc/cpuinfo
hart    : 0
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 1
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 3
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

$ echo 0 > /sys/devices/system/cpu/cpu3/online
[   52.968495] CPU3: shutdown
$ cat /proc/cpuinfo
hart    : 0
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 2
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

$ echo 1 > /sys/devices/system/cpu/cpu3/online
[   64.298250] CPU3: online
$ cat /proc/cpuinfo
hart    : 0
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 1
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 3
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig           | 12 ++++++++-
 arch/riscv/include/asm/irq.h |  1 +
 arch/riscv/include/asm/smp.h | 15 +++++++++++
 arch/riscv/kernel/head.S     | 13 ++++++++++
 arch/riscv/kernel/irq.c      | 27 +++++++++++++++++++-
 arch/riscv/kernel/process.c  |  7 ++++++
 arch/riscv/kernel/setup.c    | 17 ++++++++++++-
 arch/riscv/kernel/smp.c      |  8 ++++++
 arch/riscv/kernel/smpboot.c  | 59 ++++++++++++++++++++++++++++++++++++++++++--
 arch/riscv/kernel/traps.c    |  6 ++---
 10 files changed, 157 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4764fdeb..51c6ac8d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -21,7 +21,6 @@ config RISCV
 	select COMMON_CLK
 	select DMA_DIRECT_OPS
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_STRNCPY_FROM_USER
@@ -167,6 +166,17 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs"
+	depends on SMP
+	select GENERIC_IRQ_MIGRATION
+	help
+
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
+	  Say N if you want to disable CPU hotplug.
+
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
 	range 2 32
diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 996b6fbe..a873a72d 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -19,6 +19,7 @@
 
 void riscv_timer_interrupt(void);
 void riscv_software_interrupt(void);
+void wait_for_software_interrupt(void);
 
 #include <asm-generic/irq.h>
 
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a5c257b3..5e481e69 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -29,6 +29,14 @@
 extern unsigned long __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
 
+#if defined CONFIG_SMP && defined CONFIG_HOTPLUG_CPU
+void arch_send_call_wakeup_ipi(int cpu);
+bool can_hotplug_cpu(void);
+#else
+static inline bool can_hotplug_cpu(void) { return 0; }
+static inline void arch_send_call_wakeup_ipi(int cpu) { }
+#endif
+
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
@@ -50,6 +58,13 @@ void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
  */
 #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
 
+#ifdef CONFIG_HOTPLUG_CPU
+int __cpu_disable(void);
+void __cpu_die(unsigned int cpu);
+void cpu_play_dead(void);
+void boot_sec_cpu(void);
+#endif /* CONFIG_HOTPLUG_CPU */
+
 #else
 
 static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 19085349..b20edc6a 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -152,6 +152,19 @@ relocate:
 	j .Lsecondary_park
 END(_start)
 
+#ifdef CONFIG_SMP
+.section .text
+.global boot_sec_cpu
+
+boot_sec_cpu:
+	/* clear all pending flags */
+	csrw sip, zero
+	/* Mask all interrupts */
+	csrw sie, zero
+	fence
+
+	tail smp_callin
+#endif
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 0cfac48a..5f8ba901 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -23,13 +23,14 @@
  * need to mask it off.
  */
 #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
+#define get_scause(cause)	(cause & ~INTERRUPT_CAUSE_FLAG)
 
 asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	irq_enter();
-	switch (cause & ~INTERRUPT_CAUSE_FLAG) {
+	switch (get_scause(cause)) {
 	case INTERRUPT_CAUSE_TIMER:
 		riscv_timer_interrupt();
 		break;
@@ -53,6 +54,30 @@ asmlinkage void __irq_entry do_IRQ(struct pt_regs *regs, unsigned long cause)
 	set_irq_regs(old_regs);
 }
 
+/*
+ * This function doesn't return until a software interrupt is sent via IPI.
+ * Obviously, all the interrupts except software interrupt should be disabled
+ * before this function is called.
+ */
+void wait_for_software_interrupt(void)
+{
+	unsigned long sipval, sieval, scauseval;
+
+	/* clear all pending flags */
+	csr_write(sip, 0);
+	/* clear any previous scause data */
+	csr_write(scause, 0);
+
+	do {
+		wait_for_interrupt();
+		sipval = csr_read(sip);
+		sieval = csr_read(sie);
+		scauseval = get_scause(csr_read(scause));
+	/* only break if wfi returns for an enabled interrupt */
+	} while ((sipval & sieval) == 0 &&
+		 scauseval != INTERRUPT_CAUSE_SOFTWARE);
+}
+
 void __init init_IRQ(void)
 {
 	irqchip_init();
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index d7c6ca7c..cb209139 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -42,6 +42,13 @@ void arch_cpu_idle(void)
 	local_irq_enable();
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+void arch_cpu_idle_dead(void)
+{
+	cpu_play_dead();
+}
+#endif
+
 void show_regs(struct pt_regs *regs)
 {
 	show_regs_print_info(KERN_DEFAULT);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 4af7952c..f0faa890 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -30,11 +30,11 @@
 #include <linux/of_platform.h>
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
+#include <linux/smp.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/pgtable.h>
-#include <asm/smp.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/thread_info.h>
@@ -82,6 +82,7 @@ EXPORT_SYMBOL(empty_zero_page);
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
 unsigned long boot_cpu_hartid;
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 unsigned long __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HARTID };
 
@@ -255,3 +256,17 @@ void __init setup_arch(char **cmdline_p)
 	riscv_fill_hwcap();
 }
 
+static int __init topology_init(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct cpu *cpu = &per_cpu(cpu_devices, i);
+
+		cpu->hotpluggable = can_hotplug_cpu();
+		register_cpu(cpu, i);
+	}
+
+	return 0;
+}
+subsys_initcall(topology_init);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 82da5c4c..5384fe41 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -35,6 +35,7 @@ static struct {
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
+	IPI_CALL_WAKEUP,
 	IPI_MAX
 };
 
@@ -121,6 +122,13 @@ void arch_send_call_function_single_ipi(int cpu)
 	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+void arch_send_call_wakeup_ipi(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_CALL_WAKEUP);
+}
+#endif
+
 static void ipi_stop(void *unused)
 {
 	while (1)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 6ab2bb1b..74d65e19 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/hotplug.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -77,6 +78,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
 	int hartid = cpu_logical_map(cpu);
 	tidle->thread_info.cpu = cpu;
+
 	/*
 	 * On RISC-V systems, all harts boot on their own accord.  Our _start
 	 * selects the first hart to boot the kernel and causes the remainder
@@ -88,9 +90,12 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	__cpu_up_stack_pointer[hartid] = task_stack_page(tidle) + THREAD_SIZE;
 	__cpu_up_task_pointer[hartid] = tidle;
 
+	arch_send_call_wakeup_ipi(cpu);
 	while (!cpu_online(cpu))
 		cpu_relax();
 
+	pr_notice("CPU%u: online\n", cpu);
+
 	return 0;
 }
 
@@ -98,10 +103,60 @@ void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+bool can_hotplug_cpu(void)
+{
+	return true;
+}
+
+/*
+ * __cpu_disable runs on the processor to be shutdown.
+ */
+int __cpu_disable(void)
+{
+	int ret = 0;
+	unsigned int cpu = smp_processor_id();
+
+	set_cpu_online(cpu, false);
+	irq_migrate_all_off_this_cpu();
+
+	return ret;
+}
+/*
+ * called on the thread which is asking for a CPU to be shutdown -
+ * waits until shutdown has completed, or it is timed out.
+ */
+void __cpu_die(unsigned int cpu)
+{
+	if (!cpu_wait_death(cpu, 5)) {
+		pr_err("CPU %u: didn't die\n", cpu);
+		return;
+	}
+	pr_notice("CPU%u: shutdown\n", cpu);
+	/*TODO: Do we need to verify is cpu is really dead */
+}
+
+/*
+ * Called from the idle thread for the CPU which has been shutdown.
+ *
+ */
+void cpu_play_dead(void)
+{
+	idle_task_exit();
+
+	(void)cpu_report_death();
+
+	/* Do not disable software interrupt to restart cpu after WFI */
+	csr_clear(sie, SIE_STIE | SIE_SEIE);
+	wait_for_software_interrupt();
+	boot_sec_cpu();
+}
+
+#endif /* CONFIG_HOTPLUG_CPU */
 /*
  * C entry point for a secondary processor.
  */
-asmlinkage void __init smp_callin(void)
+asmlinkage void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
@@ -111,7 +166,7 @@ asmlinkage void __init smp_callin(void)
 
 	trap_init();
 	notify_cpu_starting(smp_processor_id());
-	set_cpu_online(smp_processor_id(), 1);
+	set_cpu_online(smp_processor_id(), true);
 	local_flush_tlb_all();
 	local_irq_enable();
 	preempt_disable();
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 24a9333d..8b331619 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -153,7 +153,7 @@ int is_valid_bugaddr(unsigned long pc)
 }
 #endif /* CONFIG_GENERIC_BUG */
 
-void __init trap_init(void)
+void trap_init(void)
 {
 	/*
 	 * Set sup0 scratch register to 0, indicating to exception vector
@@ -162,6 +162,6 @@ void __init trap_init(void)
 	csr_write(sscratch, 0);
 	/* Set the exception vector address */
 	csr_write(stvec, &handle_exception);
-	/* Enable all interrupts */
-	csr_write(sie, -1);
+	/* Enable all interrupts but timer interrupt*/
+	csr_set(sie, SIE_SSIE | SIE_SEIE);
 }
-- 
2.7.4

