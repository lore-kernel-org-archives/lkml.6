Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482EB21888
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482EB21888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeHMKSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:18:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbeHMKSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:18:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 750A4AD1B;
        Mon, 13 Aug 2018 07:37:44 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 03/11] x86/paravirt: remove clobbers from struct paravirt_patch_site
Date:   Mon, 13 Aug 2018 09:37:31 +0200
Message-Id: <20180813073739.26108-4-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180813073739.26108-1-jgross@suse.com>
References: <20180813073739.26108-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need any longer to store the clobbers in struct
paravirt_patch_site. Remove clobbers from the struct and from the
related macros.

While at it fix some lines longer than 80 characters.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       | 33 +++++++++++++++------------------
 arch/x86/include/asm/paravirt_types.h |  1 -
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d49bbf4bb5c8..76b4b5c056f3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -822,7 +822,7 @@ extern void default_banner(void);
 
 #else  /* __ASSEMBLY__ */
 
-#define _PVSITE(ptype, clobbers, ops, word, algn)	\
+#define _PVSITE(ptype, ops, word, algn)		\
 771:;						\
 	ops;					\
 772:;						\
@@ -831,7 +831,6 @@ extern void default_banner(void);
 	 word 771b;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
-	 .short clobbers;			\
 	.popsection
 
 
@@ -864,7 +863,7 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_RAX, rax)
 
 #define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 #else
 #define PV_SAVE_REGS(set)			\
@@ -879,26 +878,26 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_EAX, eax)
 
 #define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 4)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .long, 4)
+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .long, 4)
 #define PARA_INDIRECT(addr)	*%cs:addr
 #endif
 
 #define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret),			\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret);)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable),		\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable),		\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
@@ -916,8 +915,7 @@ extern void default_banner(void);
  * inlined, or the swapgs instruction must be trapped and emulated.
  */
 #define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  swapgs)
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), swapgs)
 
 /*
  * Note: swapgs is very special, and in practise is either going to be
@@ -926,8 +924,8 @@ extern void default_banner(void);
  * it.
  */
 #define SWAPGS								\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs),		\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs);		\
 		 )
 
@@ -937,15 +935,14 @@ extern void default_banner(void);
 
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
-		  CLBR_NONE,						\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64);)
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_save_fl), clobbers, \
+	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_save_fl),	    \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
-		  ANNOTATE_RETPOLINE_SAFE;				    \
+		  ANNOTATE_RETPOLINE_SAFE;			    \
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_save_fl);    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f6e24e78633b..b900088cd244 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -678,7 +678,6 @@ struct paravirt_patch_site {
 	u8 *instr; 		/* original instructions */
 	u8 instrtype;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
-	u16 clobbers;		/* what registers you may clobber */
 };
 
 extern struct paravirt_patch_site __parainstructions[],
-- 
2.13.7

