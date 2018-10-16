Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58645C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E98B2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E98B2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbeJPMzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:55:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33342 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbeJPMzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:55:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Z3FV5KJxz9ttC1;
        Tue, 16 Oct 2018 07:06:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lPr05X3G_03M; Tue, 16 Oct 2018 07:06:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Z3FV4jr8z9ttBh;
        Tue, 16 Oct 2018 07:06:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C2E98B755;
        Tue, 16 Oct 2018 07:07:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5ginKk-FyaBO; Tue, 16 Oct 2018 07:07:04 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF1288B790;
        Tue, 16 Oct 2018 07:07:04 +0200 (CEST)
Received: by pc13168vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 849956F4C9; Tue, 16 Oct 2018 05:07:04 +0000 (UTC)
Message-Id: <280ac036afbf6bc10c3dc4fa38b31685f953853e.1539623260.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1539623258.git.christophe.leroy@c-s.fr>
References: <cover.1539623258.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 8/9] powerpc/64: Remove CURRENT_THREAD_INFO
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 16 Oct 2018 05:07:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that current_thread_info is located at the beginning of 'current'
task struct, CURRENT_THREAD_INFO macro is not really needed any more.

This patch replaces it by loads of the value at PACACURRENT(r13).

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/exception-64s.h       |  4 ++--
 arch/powerpc/include/asm/thread_info.h         |  4 ----
 arch/powerpc/kernel/entry_64.S                 | 10 +++++-----
 arch/powerpc/kernel/exceptions-64e.S           |  2 +-
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +++---
 8 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3b4767ed3ec5..dd6a5ae7a769 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -671,7 +671,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define RUNLATCH_ON				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r3, r1);		\
+	ld	r3, PACACURRENT(r13);		\
 	ld	r4,TI_LOCAL_FLAGS(r3);		\
 	andi.	r0,r4,_TLF_RUNLATCH;		\
 	beql	ppc64_runlatch_on_trampoline;	\
@@ -721,7 +721,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 #ifdef CONFIG_PPC_970_NAP
 #define FINISH_NAP				\
 BEGIN_FTR_SECTION				\
-	CURRENT_THREAD_INFO(r11, r1);		\
+	ld	r11, PACACURRENT(r13);		\
 	ld	r9,TI_LOCAL_FLAGS(r11);		\
 	andi.	r10,r9,_TLF_NAPPING;		\
 	bnel	power4_fixup_nap;		\
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index c959b8d66cac..8e1d0195ac36 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -17,10 +17,6 @@
 
 #define THREAD_SIZE		(1 << THREAD_SHIFT)
 
-#ifdef CONFIG_PPC64
-#define CURRENT_THREAD_INFO(dest, sp)	stringify_in_c(ld dest, PACACURRENT(r13))
-#endif
-
 #ifndef __ASSEMBLY__
 #include <linux/cache.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 03cbf409c3f8..b017bd3da1ed 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -158,7 +158,7 @@ system_call:			/* label this so stack traces look sane */
 	li	r10,IRQS_ENABLED
 	std	r10,SOFTE(r1)
 
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	ld	r10,TI_FLAGS(r11)
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
@@ -205,7 +205,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r3,RESULT(r1)
 #endif
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 
 	ld	r8,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3S
@@ -336,7 +336,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	/* Repopulate r9 and r10 for the syscall path */
 	addi	r9,r1,STACK_FRAME_OVERHEAD
-	CURRENT_THREAD_INFO(r10, r1)
+	ld	r10, PACACURRENT(r13)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
@@ -734,7 +734,7 @@ _GLOBAL(ret_from_except_lite)
 	mtmsrd	r10,1		  /* Update machine state */
 #endif /* CONFIG_PPC_BOOK3E */
 
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACACURRENT(r13)
 	ld	r3,_MSR(r1)
 #ifdef CONFIG_PPC_BOOK3E
 	ld	r10,PACACURRENT(r13)
@@ -848,7 +848,7 @@ resume_kernel:
 1:	bl	preempt_schedule_irq
 
 	/* Re-test flags and eventually loop */
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACACURRENT(r13)
 	ld	r4,TI_FLAGS(r9)
 	andi.	r0,r4,_TIF_NEED_RESCHED
 	bne	1b
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 231d066b4a3d..dfafcd0af009 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -469,7 +469,7 @@ exc_##n##_bad_stack:							    \
  * interrupts happen before the wait instruction.
  */
 #define CHECK_NAPPING()							\
-	CURRENT_THREAD_INFO(r11, r1);					\
+	ld	r11, PACACURRENT(r13);					\
 	ld	r10,TI_LOCAL_FLAGS(r11);				\
 	andi.	r9,r10,_TLF_NAPPING;					\
 	beq+	1f;							\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 89d32bb79d5e..1cbe1a78df57 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1620,7 +1620,7 @@ do_hash_page:
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
 	and.	r0,r4,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
 	bne	77f			/* then don't call hash_page now */
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index 4e0d94d02030..31e732c378ad 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -63,7 +63,7 @@ _GLOBAL(\name)
 1:	/* Let's set the _TLF_NAPPING flag so interrupts make us return
 	 * to the right spot
 	*/
-	CURRENT_THREAD_INFO(r11, r1)
+	ld	r11, PACACURRENT(r13)
 	ld	r10,TI_LOCAL_FLAGS(r11)
 	ori	r10,r10,_TLF_NAPPING
 	std	r10,TI_LOCAL_FLAGS(r11)
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index a09b3c7ca176..61ac89fd0a05 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -68,7 +68,7 @@ BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	CURRENT_THREAD_INFO(r9, r1)
+	ld	r9, PACACURRENT(r13)
 	ld	r8,TI_LOCAL_FLAGS(r9)	/* set napping bit */
 	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception */
 	std	r8,TI_LOCAL_FLAGS(r9)	/* it will return to our caller */
diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
index 32476a6e4e9c..202bec086e3b 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
@@ -229,7 +229,7 @@ ftrace_call:
 	 *  - r0, r11 & r12 are free
 	 */
 livepatch_handler:
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 
 	/* Allocate 3 x 8 bytes */
 	ld	r11, TI_livepatch_sp(r12)
@@ -256,7 +256,7 @@ livepatch_handler:
 	 * restore it.
 	 */
 
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 
 	ld	r11, TI_livepatch_sp(r12)
 
@@ -273,7 +273,7 @@ livepatch_handler:
 	ld	r2,  -24(r11)
 
 	/* Pop livepatch stack frame */
-	CURRENT_THREAD_INFO(r12, r1)
+	ld	r12, PACACURRENT(r13)
 	subi	r11, r11, 24
 	std	r11, TI_livepatch_sp(r12)
 
-- 
2.13.3

