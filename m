Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeDMVtn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:49:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43223 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbeDMVtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:49:36 -0400
X-IronPort-AV: E=Sophos;i="5.48,446,1517846400";
   d="scan'208";a="75828834"
From: Atish Patra <atish.patra@wdc.com>
To: palmer@sifive.com, linux-riscv@lists.infradead.org
Cc: albert@sifive.com, tglx@linutronix.de, mjc@sifive.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] RISCV: Support cpu hotplug.
Date: Fri, 13 Apr 2018 14:49:34 -0700
Message-Id: <1523656174-249811-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523656174-249811-1-git-send-email-atish.patra@wdc.com>
References: <1523656174-249811-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enable support for cpu hotplug in RISC-V.

In absensece of generic cpu stop functions, WFI is used
to put the cpu in low power state during offline. An IPI
is sent to bring it out of WFI during online operation.

Tested both on QEMU and HighFive Unleashed board with
4 cpus. Test result follows.

$ echo 0 > /sys/devices/system/cpu/cpu2/online
[   31.828562] CPU2: shutdown
$ cat /proc/cpuinfo
hart    : 1
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 3
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 4
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

$ echo 0 > /sys/devices/system/cpu/cpu4/online
[   52.968495] CPU4: shutdown
$ cat /proc/cpuinfo
hart    : 1
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 3
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

$ echo 1 > /sys/devices/system/cpu/cpu4/online
[   64.298250] CPU4: online
$ cat /proc/cpuinfo
hart    : 1
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 3
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

hart    : 4
isa     : rv64imafdc
mmu     : sv39
uarch   : sifive,rocket0

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig           | 11 ++++++-
 arch/riscv/include/asm/csr.h |  1 +
 arch/riscv/include/asm/smp.h |  9 ++++--
 arch/riscv/kernel/head.S     | 12 ++++++++
 arch/riscv/kernel/process.c  |  7 +++++
 arch/riscv/kernel/setup.c    | 17 +++++++++++
 arch/riscv/kernel/smpboot.c  | 70 ++++++++++++++++++++++++++++++++++++++++++--
 arch/riscv/kernel/traps.c    |  6 ++--
 8 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 578f966..5ae307b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,7 +14,6 @@ config RISCV
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
-	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_STRNCPY_FROM_USER
@@ -178,6 +177,16 @@ config NR_CPUS
 	depends on SMP
 	default "8"
 
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs"
+	select GENERIC_IRQ_MIGRATION
+	help
+
+	  Say Y here to experiment with turning CPUs off and on.  CPUs
+	  can be controlled through /sys/devices/system/cpu.
+
+	  Say N if you want to disable CPU hotplug.
+
 config CPU_SUPPORTS_32BIT_KERNEL
 	bool
 config CPU_SUPPORTS_64BIT_KERNEL
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 421fa35..1baf8e0 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -54,6 +54,7 @@
 /* Interrupt Enable and Interrupt Pending flags */
 #define SIE_SSIE _AC(0x00000002, UL) /* Software Interrupt Enable */
 #define SIE_STIE _AC(0x00000020, UL) /* Timer Interrupt Enable */
+#define SIE_SEIE _AC(0x000000200, UL) /* External Interrupt Enable */
 
 #define EXC_INST_MISALIGNED     0
 #define EXC_INST_ACCESS         1
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 01b8df8..e78b7f1 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -25,9 +25,6 @@
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
-void init_clockevent(void);
-
-/* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
 /* Hook for the generic smp_call_function_many() routine. */
@@ -47,6 +44,12 @@ void arch_send_call_function_single_ipi(int cpu);
 /* Interprocessor interrupt handler */
 irqreturn_t handle_ipi(void);
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
+extern void cpu_play_dead(void);
+extern void boot_sec_cpu(void);
+#endif
 #endif /* CONFIG_SMP */
 
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 226eeb1..63d478d 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -149,6 +149,18 @@ relocate:
 	j .Lsecondary_park
 END(_start)
 
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
+
 __PAGE_ALIGNED_BSS
 	/* Empty zero page */
 	.balign PAGE_SIZE
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index d74d4ad..c5e2234 100644
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
index a1d5853..4ef8a8b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -81,6 +81,7 @@ EXPORT_SYMBOL(empty_zero_page);
 
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static void __init setup_initrd(void)
@@ -248,6 +249,22 @@ void __init setup_arch(char **cmdline_p)
 	riscv_fill_hwcap();
 }
 
+static int __init topology_init(void)
+{
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct cpu *cpu = &per_cpu(cpu_devices, i);
+#ifdef CONFIG_HOTPLUG_CPU
+		cpu->hotpluggable = 1;
+#endif
+		register_cpu(cpu, i);
+	}
+
+	return 0;
+}
+subsys_initcall(topology_init);
+
 static int __init riscv_device_init(void)
 {
 	return of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f741458..b554de0 100644
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
@@ -82,9 +83,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
 	__cpu_up_task_pointer[cpu] = tidle;
 
+	arch_send_call_function_single_ipi(cpu);
 	while (!cpu_online(cpu))
 		cpu_relax();
 
+	pr_notice("CPU%u: online\n", cpu);
 	return 0;
 }
 
@@ -92,10 +95,72 @@ void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+/*
+ * __cpu_disable runs on the processor to be shutdown.
+ */
+int __cpu_disable(void)
+{
+	unsigned int cpu = smp_processor_id();
+	int ret;
+
+	set_cpu_online(cpu, false);
+	irq_migrate_all_off_this_cpu();
+
+	return 0;
+}
+/*
+ * called on the thread which is asking for a CPU to be shutdown -
+ * waits until shutdown has completed, or it is timed out.
+ */
+void __cpu_die(unsigned int cpu)
+{
+	int err = 0;
+
+	if (!cpu_wait_death(cpu, 5)) {
+		pr_err("CPU %u: didn't die\n", cpu);
+		return;
+	}
+	pr_notice("CPU%u: shutdown\n", cpu);
+}
+/*
+ * Called from the idle thread for the CPU which has been shutdown.
+ */
+void cpu_play_dead(void)
+{
+	int sipval, sieval, scauseval;
+	int cpu = smp_processor_id();
+
+	idle_task_exit();
+
+	(void)cpu_report_death();
+
+	/* Do not disable software interrupt to restart cpu after WFI */
+	csr_clear(sie, SIE_STIE | SIE_SEIE);
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
+		scauseval = csr_read(scause);
+	/* only break if wfi returns for an enabled interrupt */
+	} while ((sipval & sieval) == 0 &&
+		 scauseval != INTERRUPT_CAUSE_SOFTWARE);
+
+	boot_sec_cpu();
+}
+
+
+#endif
 /*
  * C entry point for a secondary processor.
  */
-asmlinkage void __init smp_callin(void)
+asmlinkage void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
@@ -104,9 +169,8 @@ asmlinkage void __init smp_callin(void)
 	current->active_mm = mm;
 
 	trap_init();
-	init_clockevent();
 	notify_cpu_starting(smp_processor_id());
-	set_cpu_online(smp_processor_id(), 1);
+	set_cpu_online(smp_processor_id(), true);
 	local_flush_tlb_all();
 	local_irq_enable();
 	preempt_disable();
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 93132cb..b99adf1 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -166,7 +166,7 @@ int is_valid_bugaddr(unsigned long pc)
 }
 #endif /* CONFIG_GENERIC_BUG */
 
-void __init trap_init(void)
+void trap_init(void)
 {
 	/*
 	 * Set sup0 scratch register to 0, indicating to exception vector
@@ -175,6 +175,6 @@ void __init trap_init(void)
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
