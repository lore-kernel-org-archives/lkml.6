Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51084C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06648223F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06648223F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeHJOWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:22:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727493AbeHJOWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:22:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EE74AE8A;
        Fri, 10 Aug 2018 11:52:58 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 05/10] x86/paravirt: remove unused paravirt bits
Date:   Fri, 10 Aug 2018 13:52:47 +0200
Message-Id: <20180810115252.18213-6-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180810115252.18213-1-jgross@suse.com>
References: <20180810115252.18213-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros ENABLE_INTERRUPTS_SYSEXIT, GET_CR0_INTO_EAX and
PARAVIRT_ADJUST_EXCEPTION_FRAME are used nowhere. Remove their
definitions.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/irqflags.h | 4 ----
 arch/x86/include/asm/paravirt.h | 9 +--------
 arch/x86/kernel/asm-offsets.c   | 1 -
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c4fc17220df9..b7a790d03229 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -132,8 +132,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
  */
 #define SWAPGS_UNSAFE_STACK	swapgs
 
-#define PARAVIRT_ADJUST_EXCEPTION_FRAME	/*  */
-
 #define INTERRUPT_RETURN	jmp native_iret
 #define USERGS_SYSRET64				\
 	swapgs;					\
@@ -147,8 +145,6 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #endif
 #else
 #define INTERRUPT_RETURN		iret
-#define ENABLE_INTERRUPTS_SYSEXIT	sti; sysexit
-#define GET_CR0_INTO_EAX		movl %cr0, %eax
 #endif
 
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 1b86bb319393..436d270e622b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -904,14 +904,7 @@ extern void default_banner(void);
 		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_enable);		\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
-#ifdef CONFIG_X86_32
-#define GET_CR0_INTO_EAX				\
-	push %ecx; push %edx;				\
-	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_ops+PV_CPU_read_cr0);	\
-	pop %edx; pop %ecx
-#else	/* !CONFIG_X86_32 */
-
+#ifdef CONFIG_X86_64
 /*
  * If swapgs is used while the userspace stack is still current,
  * there's no way to call a pvop.  The PV replacement *must* be
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index bec9fc3498f8..d0f0348209cb 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -71,7 +71,6 @@ void common(void) {
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template,
 	       pv_irq_ops.irq_enable);
 	OFFSET(PV_CPU_iret, paravirt_patch_template, pv_cpu_ops.iret);
-	OFFSET(PV_CPU_read_cr0, paravirt_patch_template, pv_cpu_ops.read_cr0);
 	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, pv_mmu_ops.read_cr2);
 #endif
 
-- 
2.13.7

