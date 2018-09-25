Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9404C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461CE21480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461CE21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeIYURt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:17:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:60295 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbeIYURt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:17:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KNHx4Jvmz9ttSF;
        Tue, 25 Sep 2018 16:10:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ExvdpCBl377d; Tue, 25 Sep 2018 16:10:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KNHx3XkLz9ttCN;
        Tue, 25 Sep 2018 16:10:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D01F8B7DF;
        Tue, 25 Sep 2018 16:10:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0OWO1Ukp0TUv; Tue, 25 Sep 2018 16:10:05 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33AB68B7C8;
        Tue, 25 Sep 2018 16:10:05 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0699670AB8; Tue, 25 Sep 2018 14:10:04 +0000 (UTC)
Message-Id: <86e85efc4b5a90523de6e964c5cef8858eb1177d.1537884465.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/traps: merge unrecoverable_exception() and
 nonrecoverable_exception()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Sep 2018 14:10:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC32 uses nonrecoverable_exception() while PPC64 uses
unrecoverable_exception().

Both functions are doing almost the same thing.

This patch removes nonrecoverable_exception()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Removed call to debugger() as die() already calls debugger()

 arch/powerpc/include/asm/asm-prototypes.h |  1 -
 arch/powerpc/kernel/entry_32.S            |  4 ++--
 arch/powerpc/kernel/traps.c               | 12 ++----------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 78ed3c3f879a..2741831482f4 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -63,7 +63,6 @@ void program_check_exception(struct pt_regs *regs);
 void alignment_exception(struct pt_regs *regs);
 void slb_miss_bad_addr(struct pt_regs *regs);
 void StackOverflow(struct pt_regs *regs);
-void nonrecoverable_exception(struct pt_regs *regs);
 void kernel_fp_unavailable_exception(struct pt_regs *regs);
 void altivec_unavailable_exception(struct pt_regs *regs);
 void vsx_unavailable_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e58c3f467db5..77decded1175 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -794,7 +794,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	lis	r10,MSR_KERNEL@h
 	ori	r10,r10,MSR_KERNEL@l
 	bl	transfer_to_handler_full
-	.long	nonrecoverable_exception
+	.long	unrecoverable_exception
 	.long	ret_from_except
 #endif
 
@@ -1297,7 +1297,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	rlwinm	r3,r3,0,0,30
 	stw	r3,_TRAP(r1)
 4:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	nonrecoverable_exception
+	bl	unrecoverable_exception
 	/* shouldn't return */
 	b	4b
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 6ab66a88db14..a29575215198 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1547,14 +1547,6 @@ void StackOverflow(struct pt_regs *regs)
 	panic("kernel stack overflow");
 }
 
-void nonrecoverable_exception(struct pt_regs *regs)
-{
-	printk(KERN_ERR "Non-recoverable exception at PC=%lx MSR=%lx\n",
-	       regs->nip, regs->msr);
-	debugger(regs);
-	die("nonrecoverable exception", regs, SIGKILL);
-}
-
 void kernel_fp_unavailable_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
@@ -2090,8 +2082,8 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
  */
 void unrecoverable_exception(struct pt_regs *regs)
 {
-	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
-	       regs->trap, regs->nip);
+	pr_emerg("Unrecoverable exception %lx at %lx (msr=%lx)\n",
+		 regs->trap, regs->nip, regs->msr);
 	die("Unrecoverable exception", regs, SIGABRT);
 }
 NOKPROBE_SYMBOL(unrecoverable_exception);
-- 
2.13.3

