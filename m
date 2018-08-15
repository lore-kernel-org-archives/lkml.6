Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50106C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BF6214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JxOKyce7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BF6214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeHPCuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 22:50:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25856 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbeHPCuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 22:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534377380; x=1565913380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=f48xIdRZxHfKO2mpih5Fx3iYYpfzE5WvRBXdoZGnQ1o=;
  b=JxOKyce7U33ipPwL+b5jB4xlMi7cxG+ZMsEEPuwuJs3qkVChcDFUwlUg
   WGEWIL8btB/Flb0hBMfIBmEpmMw/5nVNr+WzhJtvbYRu760BlDaPUmfYq
   szMmnaYDtKm4+g9v2LG9jE4itv5Tl9MCcQpBgObbqddUnz30r8y5R0yxV
   +c1Q47AHpqf0a/tN1g85H1LdVT5Guw1zEqauyoosZzpDMeyjGR+cyhao0
   hBenAvzn1STPKsqsNMUbRLHJxDDOAGDzggMVxrge+3ZRx2fXJeMmmKGdX
   q/tj04JSbZDjEgCyR6J93jcF2ygTR0zCv4biLbO5FYXvJSnQKn8kaZI0b
   w==;
X-IronPort-AV: E=Sophos;i="5.53,245,1531756800"; 
   d="scan'208";a="88557066"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2018 07:56:19 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 Aug 2018 16:44:17 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2018 16:56:18 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, anup@brainfault.org, hch@infradead.org
Cc:     atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: [RFC PATCH 3/5] RISC-V: Add cpu_operatios structure
Date:   Wed, 15 Aug 2018 16:56:15 -0700
Message-Id: <1534377377-70108-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
References: <1534377377-70108-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining cpu_operations now helps adding cpu hotplug
support in proper manner. Moreover, it provides flexibility
in supporting other cpu enable/boot methods can be
supported in future. This patch has been largely inspired from
ARM64. However, a default boot method is defined for RISC-V unlike
ARM64.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/smp.h | 10 ++++++++++
 arch/riscv/kernel/smp.c      |  8 ++++++++
 arch/riscv/kernel/smpboot.c  | 34 ++++++++++++++++++++++++++++------
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 0763337b..2bb6e6c2 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -28,6 +28,15 @@
 extern u64 __cpu_logical_map[NR_CPUS];
 #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
 
+struct cpu_operations {
+	const char	*name;
+	int		(*cpu_init)(unsigned int);
+	int		(*cpu_prepare)(unsigned int);
+	int		(*cpu_boot)(unsigned int, struct task_struct *);
+};
+extern struct cpu_operations cpu_ops;
+void smp_set_cpu_ops(const struct cpu_operations *cpu_ops);
+
 #ifdef CONFIG_SMP
 
 /* SMP initialization hook for setup_arch */
@@ -57,5 +66,6 @@ static inline void cpuid_to_hartid_mask(const struct cpumask *in,
 	cpumask_set_cpu(cpu_logical_map(0), out);
 }
 
+
 #endif /* CONFIG_SMP */
 #endif /* _ASM_RISCV_SMP_H */
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 4ab70480..5de58ced 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -58,6 +58,14 @@ void cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out)
 	for_each_cpu(cpu, in)
 		cpumask_set_cpu(cpu_logical_map(cpu), out);
 }
+struct cpu_operations cpu_ops __ro_after_init;
+
+void smp_set_cpu_ops(const struct cpu_operations *ops)
+{
+	if (ops)
+		cpu_ops = *ops;
+}
+
 /* Unsupported */
 int setup_profiling_timer(unsigned int multiplier)
 {
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 6ab2bb1b..045a1a45 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
+#include <linux/smp.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -38,6 +39,7 @@
 
 void *__cpu_up_stack_pointer[NR_CPUS];
 void *__cpu_up_task_pointer[NR_CPUS];
+struct cpu_operations default_ops;
 
 void __init smp_prepare_boot_cpu(void)
 {
@@ -53,6 +55,7 @@ void __init setup_smp(void)
 	int hart, found_boot_cpu = 0;
 	int cpuid = 1;
 
+	smp_set_cpu_ops(&default_ops);
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
 		hart = riscv_of_processor_hart(dn);
 
@@ -73,10 +76,8 @@ void __init setup_smp(void)
 	BUG_ON(!found_boot_cpu);
 }
 
-int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+int default_cpu_boot(unsigned int hartid, struct task_struct *tidle)
 {
-	int hartid = cpu_logical_map(cpu);
-	tidle->thread_info.cpu = cpu;
 	/*
 	 * On RISC-V systems, all harts boot on their own accord.  Our _start
 	 * selects the first hart to boot the kernel and causes the remainder
@@ -84,13 +85,28 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	 * setup by that main hart.  Writing __cpu_up_stack_pointer signals to
 	 * the spinning harts that they can continue the boot process.
 	 */
-	smp_mb();
+
 	__cpu_up_stack_pointer[hartid] = task_stack_page(tidle) + THREAD_SIZE;
 	__cpu_up_task_pointer[hartid] = tidle;
+	return 0;
+}
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	int err = -1;
+	int hartid = cpu_logical_map(cpu);
 
-	while (!cpu_online(cpu))
-		cpu_relax();
+	tidle->thread_info.cpu = cpu;
+	smp_mb();
 
+	if (cpu_ops.cpu_boot)
+		err = cpu_ops.cpu_boot(hartid, tidle);
+	if (!err) {
+		while (!cpu_online(cpu))
+			cpu_relax();
+	} else {
+		pr_err("CPU %d [hartid %d]failed to boot\n", cpu, hartid);
+	}
 	return 0;
 }
 
@@ -117,3 +133,9 @@ asmlinkage void __init smp_callin(void)
 	preempt_disable();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
+
+
+struct cpu_operations default_ops = {
+	.name		= "default",
+	.cpu_boot	= default_cpu_boot,
+};
-- 
2.7.4

