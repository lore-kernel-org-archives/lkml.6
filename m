Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DB3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F422C208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F422C208E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH1LbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:31:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45406 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727317AbeH1LbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:31:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B32F5B03E;
        Tue, 28 Aug 2018 07:40:38 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 07/15] x86/paravirt: remove clobbers from struct paravirt_patch_site
Date:   Tue, 28 Aug 2018 09:40:18 +0200
Message-Id: <20180828074026.820-8-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need any longer to store the clobbers in struct
paravirt_patch_site. Remove clobbers from the struct and from the
related macros.

While at it fix some lines longer than 80 characters.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/paravirt.h       | 33 +++++++++++++++------------------
 arch/x86/include/asm/paravirt_types.h |  1 -
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index e375d4266b53..e1364cb40ce5 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -827,7 +827,7 @@ extern void default_banner(void);
 
 #else  /* __ASSEMBLY__ */
 
-#define _PVSITE(ptype, clobbers, ops, word, algn)	\
+#define _PVSITE(ptype, ops, word, algn)		\
 771:;						\
 	ops;					\
 772:;						\
@@ -836,7 +836,6 @@ extern void default_banner(void);
 	 word 771b;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
-	 .short clobbers;			\
 	.popsection
 
 
@@ -869,7 +868,7 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_RAX, rax)
 
 #define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
-#define PARA_SITE(ptype, clobbers, ops) _PVSITE(ptype, clobbers, ops, .quad, 8)
+#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 #else
 #define PV_SAVE_REGS(set)			\
@@ -884,26 +883,26 @@ extern void default_banner(void);
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
 
@@ -921,8 +920,7 @@ extern void default_banner(void);
  * inlined, or the swapgs instruction must be trapped and emulated.
  */
 #define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  swapgs)
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), swapgs)
 
 /*
  * Note: swapgs is very special, and in practise is either going to be
@@ -931,8 +929,8 @@ extern void default_banner(void);
  * it.
  */
 #define SWAPGS								\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  ANNOTATE_RETPOLINE_SAFE;					\
+	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs),		\
+		  ANNOTATE_RETPOLINE_SAFE;				\
 		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs);		\
 		 )
 
@@ -942,15 +940,14 @@ extern void default_banner(void);
 
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
index 225d871373ed..b2220536a7d4 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -681,7 +681,6 @@ struct paravirt_patch_site {
 	u8 *instr; 		/* original instructions */
 	u8 instrtype;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
-	u16 clobbers;		/* what registers you may clobber */
 };
 
 extern struct paravirt_patch_site __parainstructions[],
-- 
2.16.4

