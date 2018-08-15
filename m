Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E353C04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ED7214ED
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RvwUKrh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92ED7214ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeHPCu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:50:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25861 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbeHPCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534377380; x=1565913380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YT4cPhEuY4o5/dqAmcVH9C+fTWzvQvw2erY9QlY4Qxk=;
  b=RvwUKrh/DzBTA64wzqL7nHD8pd8IwWIZ9lEszxgxP1YasV+Rvnm6ZOHm
   7o3cRy37CQ1IPZksW+IR7KSIbiA+JYPkrCpY284e5kjDlgqYxmSnGCTEb
   GBBwf7TjKWQSyw0jh/YmxoTtRpM+sEbYA3EvtW20UuWRcIwRo2MxcK9L2
   0i0LoDQ+bAuoz4rmz8F4HA6riHqM58Nent4W44MGfLo5tBEmRf/Ow+WDK
   65qPk6dEAqGxSReFh9Zn4Vhvb9OWmXfoE7iAPbsRzOLSFiHHBy//K8syL
   tnSTawk5Dc77Ap98Ttkn7EMOBgpoE8Z26RKW3/L7dd3Eo/fH0c/JAa5p8
   A==;
X-IronPort-AV: E=Sophos;i="5.53,245,1531756800"; 
   d="scan'208";a="88557068"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 07:56:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 Aug 2018 16:44:17 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 16:56:19 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: [RFC PATCH 5/5] RISC-V: Support cpu hotplug.
Date:   Wed, 15 Aug 2018 16:56:17 -0700
Message-Id: <1534377377-70108-6-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
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
 arch/riscv/Kconfig           |  12 ++++-
 arch/riscv/include/asm/smp.h |  17 ++++++-
 arch/riscv/kernel/head.S     |  13 ++++++
 arch/riscv/kernel/process.c  |   7 +++
 arch/riscv/kernel/setup.c    |  15 +++++++
 arch/riscv/kernel/smpboot.c  | 105 +++++++++++++++++++++++++++++++++++++++++--
 arch/riscv/kernel/traps.c    |   6 +--
 7 files changed, 166 insertions(+), 9 deletions(-)

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
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 2bb6e6c2..3a1923ef 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -33,6 +33,10 @@ struct cpu_operations {
 	int		(*cpu_init)(unsigned int);
 	int		(*cpu_prepare)(unsigned int);
 	int		(*cpu_boot)(unsigned int, struct task_struct *);
+#ifdef CONFIG_HOTPLUG_CPU
+	int		(*cpu_disable)(unsigned int cpu);
+	void		(*cpu_die)(unsigned int cpu);
+#endif
 };
 extern struct cpu_operations cpu_ops;
 void smp_set_cpu_ops(const struct cpu_operations *cpu_ops);
@@ -58,6 +62,18 @@ void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
  */
 #define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
 
+#ifdef CONFIG_HOTPLUG_CPU
+int __cpu_disable(void);
+void __cpu_die(unsigned int cpu);
+void cpu_play_dead(void);
+void boot_sec_cpu(void);
+int can_hotplug_cpu(void);
+#else
+
+static inline int can_hotplug_cpu(void) { return 0; }
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 #else
 
 static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
@@ -66,6 +82,5 @@ static inline void cpuid_to_hartid_mask(const struct cpumask *in,
 	cpumask_set_cpu(cpu_logical_map(0), out);
 }
 
-
 #endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index d1beecf1..81258c42 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -150,6 +150,19 @@ relocate:
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
index 97b586f8..fc2cfa8e 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -81,6 +81,7 @@ EXPORT_SYMBOL(empty_zero_page);
 
 /* The lucky hart to first increment this variable will boot the other cores */
 atomic_t hart_lottery;
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 u64 __cpu_logical_map[NR_CPUS];
 
@@ -259,3 +260,17 @@ void __init setup_arch(char **cmdline_p)
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
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 045a1a45..a470ae29 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,7 +30,7 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
-#include <linux/smp.h>
+#include <linux/sched/hotplug.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -102,11 +102,17 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	if (cpu_ops.cpu_boot)
 		err = cpu_ops.cpu_boot(hartid, tidle);
 	if (!err) {
+
+#ifdef CONFIG_HOTPLUG_CPU
+		arch_send_call_function_single_ipi(cpu);
+#endif
 		while (!cpu_online(cpu))
 			cpu_relax();
+		pr_notice("CPU%u: online\n", cpu);
 	} else {
 		pr_err("CPU %d [hartid %d]failed to boot\n", cpu, hartid);
 	}
+
 	return 0;
 }
 
@@ -114,10 +120,98 @@ void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+int can_hotplug_cpu(void)
+{
+	if (cpu_ops.cpu_die)
+		return 1;
+	else
+		return 0;
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
+	if (cpu_ops.cpu_disable)
+		ret = cpu_ops.cpu_disable(cpu);
+	if (ret)
+		return ret;
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
+int default_cpu_disable(unsigned int cpu)
+{
+	if (!cpu_ops.cpu_die)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+/*
+ * Called from the idle thread for the CPU which has been shutdown.
+ *
+ */
+void cpu_play_dead(void)
+{
+	int cpu = smp_processor_id();
+
+	idle_task_exit();
+
+	(void)cpu_report_death();
+
+	/* Do not disable software interrupt to restart cpu after WFI */
+	csr_clear(sie, SIE_STIE | SIE_SEIE);
+	if (cpu_ops.cpu_die)
+		cpu_ops.cpu_die(cpu);
+}
+
+void default_cpu_die(unsigned int cpu)
+{
+	int sipval, sieval, scauseval;
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
+#endif /* CONFIG_HOTPLUG_CPU */
 /*
  * C entry point for a secondary processor.
  */
-asmlinkage void __init smp_callin(void)
+asmlinkage void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
 
@@ -127,15 +221,18 @@ asmlinkage void __init smp_callin(void)
 
 	trap_init();
 	notify_cpu_starting(smp_processor_id());
-	set_cpu_online(smp_processor_id(), 1);
+	set_cpu_online(smp_processor_id(), true);
 	local_flush_tlb_all();
 	local_irq_enable();
 	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
-
 struct cpu_operations default_ops = {
 	.name		= "default",
 	.cpu_boot	= default_cpu_boot,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable	= default_cpu_disable,
+	.cpu_die	= default_cpu_die,
+#endif
 };
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

