Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB34C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E700E2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E700E2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbeJPMzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:55:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11323 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbeJPMzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:55:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Z3FQ4g1Pz9ttBk;
        Tue, 16 Oct 2018 07:06:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6dDznehU35IB; Tue, 16 Oct 2018 07:06:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Z3FQ41gmz9ttBh;
        Tue, 16 Oct 2018 07:06:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D7B9A8B78F;
        Tue, 16 Oct 2018 07:07:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NTEjo0I8LkZV; Tue, 16 Oct 2018 07:07:00 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A6F38B755;
        Tue, 16 Oct 2018 07:07:00 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 68A126F4C9; Tue, 16 Oct 2018 05:07:00 +0000 (UTC)
Message-Id: <9152931a84c856646056ff2801a1940c302131d2.1539623260.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539623258.git.christophe.leroy@c-s.fr>
References: <cover.1539623258.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 6/9] powerpc: 'current_set' is now a table of task_struct
 pointers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 16 Oct 2018 05:07:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table of pointers 'current_set' has been used for retrieving
the stack and current. They used to be thread_info pointers as
they were pointing to the stack and current was taken from the
'task' field of the thread_info.

Now, the pointers of 'current_set' table are now both pointers
to task_struct and pointers to thread_info.

As they are used to get current, and the stack pointer is
retrieved from current's stack field, this patch changes
their type to task_struct, and renames secondary_ti to
secondary_current.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/asm-prototypes.h |  4 ++--
 arch/powerpc/kernel/head_32.S             |  6 +++---
 arch/powerpc/kernel/head_44x.S            |  4 ++--
 arch/powerpc/kernel/head_fsl_booke.S      |  4 ++--
 arch/powerpc/kernel/smp.c                 | 10 ++++------
 5 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 2741831482f4..d6fdc7e79d09 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -23,8 +23,8 @@
 #include <uapi/asm/ucontext.h>
 
 /* SMP */
-extern struct thread_info *current_set[NR_CPUS];
-extern struct thread_info *secondary_ti;
+extern struct task_struct *current_set[NR_CPUS];
+extern struct task_struct *secondary_current;
 void start_secondary(void *unused);
 
 /* kexec */
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 44dfd73b2a62..ba0341bd5a00 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -842,9 +842,9 @@ __secondary_start:
 #endif /* CONFIG_6xx */
 
 	/* get current's stack and current */
-	lis	r1,secondary_ti@ha
-	tophys(r1,r1)
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	tophys(r2,r2)
+	lwz	r2,secondary_current@l(r2)
 	tophys(r1,r2)
 	lwz	r1,TASK_STACK(r1)
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 2c7e90f36358..48e4de4dfd0c 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1021,8 +1021,8 @@ _GLOBAL(start_secondary_47x)
 	/* Now we can get our task struct and real stack pointer */
 
 	/* Get current's stack and current */
-	lis	r1,secondary_ti@ha
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
 	lwz	r1,TASK_STACK(r2)
 
 	/* Current stack pointer */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index b8a2b789677e..0d27bfff52dd 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -1076,8 +1076,8 @@ __secondary_start:
 	bl	call_setup_cpu
 
 	/* get current's stack and current */
-	lis	r1,secondary_ti@ha
-	lwz	r2,secondary_ti@l(r1)
+	lis	r2,secondary_current@ha
+	lwz	r2,secondary_current@l(r2)
 	lwz	r1,TASK_STACK(r2)
 
 	/* stack */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 0f9f7f1f4e2f..2df2bc3ea17d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -75,7 +75,7 @@
 static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 #endif
 
-struct thread_info *secondary_ti;
+struct task_struct *secondary_current;
 bool has_big_cores;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
@@ -663,7 +663,7 @@ void smp_send_stop(void)
 }
 #endif /* CONFIG_NMI_IPI */
 
-struct thread_info *current_set[NR_CPUS];
+struct task_struct *current_set[NR_CPUS];
 
 static void smp_store_cpu_info(int id)
 {
@@ -928,7 +928,7 @@ void smp_prepare_boot_cpu(void)
 	paca_ptrs[boot_cpuid]->__current = current;
 #endif
 	set_numa_node(numa_cpu_lookup_table[boot_cpuid]);
-	current_set[boot_cpuid] = task_thread_info(current);
+	current_set[boot_cpuid] = current;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1013,8 +1013,6 @@ static bool secondaries_inhibited(void)
 
 static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 {
-	struct thread_info *ti = task_thread_info(idle);
-
 #ifdef CONFIG_STACKPROTECTOR
 	idle->stack_canary = get_random_canary();
 #endif
@@ -1028,7 +1026,7 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
 #endif
 #endif
 	idle->cpu = cpu;
-	secondary_ti = current_set[cpu] = ti;
+	secondary_current = current_set[cpu] = idle;
 }
 
 int __cpu_up(unsigned int cpu, struct task_struct *tidle)
-- 
2.13.3

