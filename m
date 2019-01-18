Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F5BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C47120855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfARGgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:36:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:27865 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfARGgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 01:36:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 22:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="109201422"
Received: from skl-d.bj.intel.com ([10.238.135.173])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2019 22:36:18 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Date:   Fri, 18 Jan 2019 14:34:00 +0800
Message-Id: <1547793240-9157-1-git-send-email-luwei.kang@intel.com>
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
Interrupt Requests) but ON (Outstanding Notification).
So this interrupt can't be sync to APIC virtualization register and
will not be handled by Guest because ON is zero.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.8.3.1

