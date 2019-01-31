Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B518C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87CB218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfAaIwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:52:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:2665 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfAaIwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:52:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 00:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="139449698"
Received: from sqa-gate.sh.intel.com (HELO p-demo5.tsp.org) ([10.239.48.212])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jan 2019 00:52:18 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH V3] KVM: x86: Sync the pending Posted-Interrupts
Date:   Thu, 31 Jan 2019 16:52:02 +0800
Message-Id: <1548924722-64060-1-git-send-email-luwei.kang@intel.com>
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
 arch/x86/kvm/vmx/vmx.c | 5 +++++
 arch/x86/kvm/x86.c     | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4341175..8ed9634 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1221,6 +1221,11 @@ static void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		new.sn = 0;
 	} while (cmpxchg64(&pi_desc->control, old.control,
 			   new.control) != old.control);
+
+	smp_mb__after_atomic();
+
+	if (!bitmap_empty((unsigned long *)pi_desc->pir, NR_VECTORS))
+		pi_test_and_set_on(pi_desc);
 }
 
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3d27206..5bcf2c4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7794,7 +7794,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 * 1) We should set ->mode before checking ->requests.  Please see
 	 * the comment in kvm_vcpu_exiting_guest_mode().
 	 *
-	 * 2) For APICv, we should set ->mode before checking PIR.ON.  This
+	 * 2) For APICv, we should set ->mode before checking PID.PIR. This
 	 * pairs with the memory barrier implicit in pi_test_and_set_on
 	 * (see vmx_deliver_posted_interrupt).
 	 *
-- 
1.8.3.1

