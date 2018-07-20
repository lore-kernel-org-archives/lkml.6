Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1218ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833D920854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833D920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbeGTNSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:18:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38336 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeGTNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:18:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0E03CBB;
        Fri, 20 Jul 2018 12:29:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.9 44/66] KVM: arm64: Store vcpu on the stack during __guest_enter()
Date:   Fri, 20 Jul 2018 14:14:01 +0200
Message-Id: <20180720121409.781488694@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

Commit 32b03d1059667a39e089c45ee38ec9c16332430f upstream.

KVM uses tpidr_el2 as its private vcpu register, which makes sense for
non-vhe world switch as only KVM can access this register. This means
vhe Linux has to use tpidr_el1, which KVM has to save/restore as part
of the host context.

If the SDEI handler code runs behind KVMs back, it mustn't access any
per-cpu variables. To allow this on systems with vhe we need to make
the host use tpidr_el2, saving KVM from save/restoring it.

__guest_enter() stores the host_ctxt on the stack, do the same with
the vcpu.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/entry.S     |   10 +++++++---
 arch/arm64/kvm/hyp/hyp-entry.S |    6 +++---
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -62,8 +62,8 @@ ENTRY(__guest_enter)
 	// Store the host regs
 	save_callee_saved_regs x1
 
-	// Store the host_ctxt for use at exit time
-	str	x1, [sp, #-16]!
+	// Store host_ctxt and vcpu for use at exit time
+	stp	x1, x0, [sp, #-16]!
 
 	add	x18, x0, #VCPU_CONTEXT
 
@@ -159,6 +159,10 @@ abort_guest_exit_end:
 ENDPROC(__guest_exit)
 
 ENTRY(__fpsimd_guest_restore)
+	// x0: esr
+	// x1: vcpu
+	// x2-x29,lr: vcpu regs
+	// vcpu x0-x1 on the stack
 	stp	x2, x3, [sp, #-16]!
 	stp	x4, lr, [sp, #-16]!
 
@@ -173,7 +177,7 @@ alternative_else
 alternative_endif
 	isb
 
-	mrs	x3, tpidr_el2
+	mov	x3, x1
 
 	ldr	x0, [x3, #VCPU_HOST_CONTEXT]
 	kern_hyp_va x0
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -121,24 +121,24 @@ el1_trap:
 	/*
 	 * x0: ESR_EC
 	 */
+	ldr	x1, [sp, #16 + 8]	// vcpu stored by __guest_enter
 
 	/* Guest accessed VFP/SIMD registers, save host, restore Guest */
 	cmp	x0, #ESR_ELx_EC_FP_ASIMD
 	b.eq	__fpsimd_guest_restore
 
-	mrs	x1, tpidr_el2
 	mov	x0, #ARM_EXCEPTION_TRAP
 	b	__guest_exit
 
 el1_irq:
 	stp     x0, x1, [sp, #-16]!
-	mrs	x1, tpidr_el2
+	ldr	x1, [sp, #16 + 8]
 	mov	x0, #ARM_EXCEPTION_IRQ
 	b	__guest_exit
 
 el1_error:
 	stp     x0, x1, [sp, #-16]!
-	mrs	x1, tpidr_el2
+	ldr	x1, [sp, #16 + 8]
 	mov	x0, #ARM_EXCEPTION_EL1_SERROR
 	b	__guest_exit
 


