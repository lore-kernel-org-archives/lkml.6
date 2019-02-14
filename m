Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030A3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5AD21904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405173AbfBNCsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:48:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:39458 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732564AbfBNCsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:48:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 18:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,367,1544515200"; 
   d="scan'208";a="299599924"
Received: from skl-s2.bj.intel.com ([10.240.192.103])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2019 18:48:50 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH V4] KVM: x86: Sync the pending Posted-Interrupts
Date:   Thu, 14 Feb 2019 10:48:07 +0800
Message-Id: <1550112487-4482-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Posted-Interrupts from passthrough devices may be lost or
overwritten when the vCPU is in runnable state.

The SN (Suppress Notification) of PID (Posted Interrupt Descriptor) will
be set when the vCPU is preempted (vCPU in KVM_MP_STATE_RUNNABLE state
but not running on physical CPU). If a posted interrupt coming at this
time, the irq remmaping facility will set the bit of PIR (Posted
Interrupt Requests) without ON (Outstanding Notification).
So this interrupt can't be sync to APIC virtualization register and
will not be handled by Guest because ON is zero.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 26 +++++++++++---------------
 arch/x86/kvm/vmx/vmx.h |  6 ++++++
 arch/x86/kvm/x86.c     |  2 +-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f1..fe59199 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1192,21 +1192,6 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 	if (!pi_test_sn(pi_desc) && vcpu->cpu == cpu)
 		return;
 
-	/*
-	 * First handle the simple case where no cmpxchg is necessary; just
-	 * allow posting non-urgent interrupts.
-	 *
-	 * If the 'nv' field is POSTED_INTR_WAKEUP_VECTOR, do not change
-	 * PI.NDST: pi_post_block will do it for us and the wakeup_handler
-	 * expects the VCPU to be on the blocked_vcpu_list that matches
-	 * PI.NDST.
-	 */
-	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR ||
-	    vcpu->cpu == cpu) {
-		pi_clear_sn(pi_desc);
-		return;
-	}
-
 	/* The full case.  */
 	do {
 		old.control = new.control = pi_desc->control;
@@ -1221,6 +1206,17 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		new.sn = 0;
 	} while (cmpxchg64(&pi_desc->control, old.control,
 			   new.control) != old.control);
+
+	/*
+	 * Clear SN before reading the bitmap.  The VT-d firmware
+	 * writes the bitmap and reads SN atomically (5.2.3 in the
+	 * spec), so it doesn't really have a memory barrier that
+	 * pairs with this, but we cannot do that and we need one.
+	 */
+	smp_mb__after_atomic();
+
+	if (!bitmap_empty((unsigned long *)pi_desc->pir, NR_VECTORS))
+		pi_set_on(pi_desc);
 }
 
 /*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9932895..a4527e1 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -349,6 +349,12 @@ static inline void pi_set_sn(struct pi_desc *pi_desc)
 			(unsigned long *)&pi_desc->control);
 }
 
+static inline void pi_set_on(struct pi_desc *pi_desc)
+{
+	set_bit(POSTED_INTR_ON,
+		(unsigned long *)&pi_desc->control);
+}
+
 static inline void pi_clear_on(struct pi_desc *pi_desc)
 {
 	clear_bit(POSTED_INTR_ON,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d32b8f..ebd6737 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7795,7 +7795,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * 1) We should set ->mode before checking ->requests.  Please see
 	 * the comment in kvm_vcpu_exiting_guest_mode().
 	 *
-	 * 2) For APICv, we should set ->mode before checking PIR.ON.  This
+	 * 2) For APICv, we should set ->mode before checking PID.ON. This
 	 * pairs with the memory barrier implicit in pi_test_and_set_on
 	 * (see vmx_deliver_posted_interrupt).
 	 *
-- 
1.8.3.1

