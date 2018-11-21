Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2008C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5FB21582
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkMcF9y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5FB21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbeKVFqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbeKVFqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6219C2151B;
        Wed, 21 Nov 2018 19:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827474;
        bh=4Bn76IQSohnIXPF9qIVzZ3+1MClmtkoHYEJEjFlUC0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkMcF9y8rfM8SK+kHB9VPiYTc1j25fuEElmzFxHfuJ/ljqzgDtV70ja+ua9b86PLK
         1oh5I7xL2fp2a6ASmOI0He5fBsoTtP1vjjrmfHVaaylqihiNA5YuoP1k9wtQeW1Mfi
         wuiEsXagTgOJNrqVcFN8s+1h5PSXJ5Kir/qPDIr4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.9 46/59] ARM: KVM: invalidate BTB on guest exit for Cortex-A12/A17
Date:   Wed, 21 Nov 2018 20:07:01 +0100
Message-Id: <20181121183510.081806172@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

Commit 3f7e8e2e1ebda787f156ce46e3f0a9ce2833fa4f upstream.

In order to avoid aliasing attacks against the branch predictor,
let's invalidate the BTB on guest exit. This is made complicated
by the fact that we cannot take a branch before invalidating the
BTB.

We only apply this to A12 and A17, which are the only two ARM
cores on which this useful.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_asm.h |    2 -
 arch/arm/include/asm/kvm_mmu.h |   17 +++++++++
 arch/arm/kvm/hyp/hyp-entry.S   |   71 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 85 insertions(+), 5 deletions(-)

--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -61,8 +61,6 @@ struct kvm_vcpu;
 extern char __kvm_hyp_init[];
 extern char __kvm_hyp_init_end[];
 
-extern char __kvm_hyp_vector[];
-
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
 extern void __kvm_tlb_flush_vmid(struct kvm *kvm);
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -248,7 +248,22 @@ static inline int kvm_read_guest_lock(st
 
 static inline void *kvm_get_hyp_vector(void)
 {
-	return kvm_ksym_ref(__kvm_hyp_vector);
+	switch(read_cpuid_part()) {
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	case ARM_CPU_PART_CORTEX_A12:
+	case ARM_CPU_PART_CORTEX_A17:
+	{
+		extern char __kvm_hyp_vector_bp_inv[];
+		return kvm_ksym_ref(__kvm_hyp_vector_bp_inv);
+	}
+
+#endif
+	default:
+	{
+		extern char __kvm_hyp_vector[];
+		return kvm_ksym_ref(__kvm_hyp_vector);
+	}
+	}
 }
 
 static inline int kvm_map_vectors(void)
--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -71,6 +71,66 @@ __kvm_hyp_vector:
 	W(b)	hyp_irq
 	W(b)	hyp_fiq
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	.align 5
+__kvm_hyp_vector_bp_inv:
+	.global __kvm_hyp_vector_bp_inv
+
+	/*
+	 * We encode the exception entry in the bottom 3 bits of
+	 * SP, and we have to guarantee to be 8 bytes aligned.
+	 */
+	W(add)	sp, sp, #1	/* Reset 	  7 */
+	W(add)	sp, sp, #1	/* Undef	  6 */
+	W(add)	sp, sp, #1	/* Syscall	  5 */
+	W(add)	sp, sp, #1	/* Prefetch abort 4 */
+	W(add)	sp, sp, #1	/* Data abort	  3 */
+	W(add)	sp, sp, #1	/* HVC		  2 */
+	W(add)	sp, sp, #1	/* IRQ		  1 */
+	W(nop)			/* FIQ		  0 */
+
+	mcr	p15, 0, r0, c7, c5, 6	/* BPIALL */
+	isb
+
+#ifdef CONFIG_THUMB2_KERNEL
+	/*
+	 * Yet another silly hack: Use VPIDR as a temp register.
+	 * Thumb2 is really a pain, as SP cannot be used with most
+	 * of the bitwise instructions. The vect_br macro ensures
+	 * things gets cleaned-up.
+	 */
+	mcr	p15, 4, r0, c0, c0, 0	/* VPIDR */
+	mov	r0, sp
+	and	r0, r0, #7
+	sub	sp, sp, r0
+	push	{r1, r2}
+	mov	r1, r0
+	mrc	p15, 4, r0, c0, c0, 0	/* VPIDR */
+	mrc	p15, 0, r2, c0, c0, 0	/* MIDR  */
+	mcr	p15, 4, r2, c0, c0, 0	/* VPIDR */
+#endif
+
+.macro vect_br val, targ
+ARM(	eor	sp, sp, #\val	)
+ARM(	tst	sp, #7		)
+ARM(	eorne	sp, sp, #\val	)
+
+THUMB(	cmp	r1, #\val	)
+THUMB(	popeq	{r1, r2}	)
+
+	beq	\targ
+.endm
+
+	vect_br	0, hyp_fiq
+	vect_br	1, hyp_irq
+	vect_br	2, hyp_hvc
+	vect_br	3, hyp_dabt
+	vect_br	4, hyp_pabt
+	vect_br	5, hyp_svc
+	vect_br	6, hyp_undef
+	vect_br	7, hyp_reset
+#endif
+
 .macro invalid_vector label, cause
 	.align
 \label:	mov	r0, #\cause
@@ -131,7 +191,14 @@ hyp_hvc:
 	mrceq	p15, 4, r0, c12, c0, 0	@ get HVBAR
 	beq	1f
 
-	push	{lr}
+	/*
+	 * Pushing r2 here is just a way of keeping the stack aligned to
+	 * 8 bytes on any path that can trigger a HYP exception. Here,
+	 * we may well be about to jump into the guest, and the guest
+	 * exit would otherwise be badly decoded by our fancy
+	 * "decode-exception-without-a-branch" code...
+	 */
+	push	{r2, lr}
 
 	mov	lr, r0
 	mov	r0, r1
@@ -141,7 +208,7 @@ hyp_hvc:
 THUMB(	orr	lr, #1)
 	blx	lr			@ Call the HYP function
 
-	pop	{lr}
+	pop	{r2, lr}
 1:	eret
 
 guest_trap:


