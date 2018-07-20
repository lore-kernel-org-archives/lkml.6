Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8DAECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9445220652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9445220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbeGTNbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389524AbeGTNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:17 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3098ECFB;
        Fri, 20 Jul 2018 12:40:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.17 097/101] arm64: KVM: Handle guests ARCH_WORKAROUND_2 requests
Date:   Fri, 20 Jul 2018 14:14:43 +0200
Message-Id: <20180720121427.333390287@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit b4f18c063a13dfb33e3a63fe1844823e19c2265e upstream.

In order to forward the guest's ARCH_WORKAROUND_2 calls to EL3,
add a small(-ish) sequence to handle it at EL2. Special care must
be taken to track the state of the guest itself by updating the
workaround flags. We also rely on patching to enable calls into
the firmware.

Note that since we need to execute branches, this always executes
after the Spectre-v2 mitigation has been applied.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/asm-offsets.c |    1 +
 arch/arm64/kvm/hyp/hyp-entry.S  |   38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -136,6 +136,7 @@ int main(void)
 #ifdef CONFIG_KVM_ARM_HOST
   DEFINE(VCPU_CONTEXT,		offsetof(struct kvm_vcpu, arch.ctxt));
   DEFINE(VCPU_FAULT_DISR,	offsetof(struct kvm_vcpu, arch.fault.disr_el1));
+  DEFINE(VCPU_WORKAROUND_FLAGS,	offsetof(struct kvm_vcpu, arch.workaround_flags));
   DEFINE(CPU_GP_REGS,		offsetof(struct kvm_cpu_context, gp_regs));
   DEFINE(CPU_USER_PT_REGS,	offsetof(struct kvm_regs, regs));
   DEFINE(CPU_FP_REGS,		offsetof(struct kvm_regs, fp_regs));
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -106,8 +106,44 @@ el1_hvc_guest:
 	 */
 	ldr	x1, [sp]				// Guest's x0
 	eor	w1, w1, #ARM_SMCCC_ARCH_WORKAROUND_1
+	cbz	w1, wa_epilogue
+
+	/* ARM_SMCCC_ARCH_WORKAROUND_2 handling */
+	eor	w1, w1, #(ARM_SMCCC_ARCH_WORKAROUND_1 ^ \
+			  ARM_SMCCC_ARCH_WORKAROUND_2)
 	cbnz	w1, el1_trap
-	mov	x0, x1
+
+#ifdef CONFIG_ARM64_SSBD
+alternative_cb	arm64_enable_wa2_handling
+	b	wa2_end
+alternative_cb_end
+	get_vcpu_ptr	x2, x0
+	ldr	x0, [x2, #VCPU_WORKAROUND_FLAGS]
+
+	// Sanitize the argument and update the guest flags
+	ldr	x1, [sp, #8]			// Guest's x1
+	clz	w1, w1				// Murphy's device:
+	lsr	w1, w1, #5			// w1 = !!w1 without using
+	eor	w1, w1, #1			// the flags...
+	bfi	x0, x1, #VCPU_WORKAROUND_2_FLAG_SHIFT, #1
+	str	x0, [x2, #VCPU_WORKAROUND_FLAGS]
+
+	/* Check that we actually need to perform the call */
+	hyp_ldr_this_cpu x0, arm64_ssbd_callback_required, x2
+	cbz	x0, wa2_end
+
+	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
+	smc	#0
+
+	/* Don't leak data from the SMC call */
+	mov	x3, xzr
+wa2_end:
+	mov	x2, xzr
+	mov	x1, xzr
+#endif
+
+wa_epilogue:
+	mov	x0, xzr
 	add	sp, sp, #16
 	eret
 


