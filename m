Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4952C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A777B20844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfA3BAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:00:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:58796 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfA3BAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:00:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 17:00:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,538,1539673200"; 
   d="scan'208";a="129608937"
Received: from skl-d.bj.intel.com ([10.238.135.173])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2019 17:00:38 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v2] KVM: x86: Sync the pending Posted-Interrupts
Date:   Wed, 30 Jan 2019 08:59:32 +0800
Message-Id: <1548809972-32100-1-git-send-email-luwei.kang@intel.com>
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
 arch/x86/kvm/vmx/vmx.c | 2 +-
 arch/x86/kvm/x86.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6915f1..820a03b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6048,7 +6048,7 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu)
 	bool max_irr_updated;
 
 	WARN_ON(!vcpu->arch.apicv_active);
-	if (pi_test_on(&vmx->pi_desc)) {
+	if (!bitmap_empty((unsigned long *)vmx->pi_desc.pir, NR_VECTORS)) {
 		pi_clear_on(&vmx->pi_desc);
 		/*
 		 * IOMMU can write to PIR.ON, so the barrier matters even on UP.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 02c8e09..c31b608 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7793,7 +7793,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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

