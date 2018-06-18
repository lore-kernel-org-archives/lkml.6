Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2051BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99D7208E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99D7208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934844AbeFRIRd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:17:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934068AbeFRIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:17:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A97ECC7F;
        Mon, 18 Jun 2018 08:17:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 024/279] kvm: x86: move MSR_IA32_TSC handling to x86.c
Date:   Mon, 18 Jun 2018 10:10:09 +0200
Message-Id: <20180618080609.808314649@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit dd259935e4eec844dc3e5b8a7cd951cd658b4fb6 ]

This is not specific to Intel/AMD anymore.  The TSC offset is available
in vcpu->arch.tsc_offset.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |    9 ---------
 arch/x86/kvm/vmx.c |   20 --------------------
 arch/x86/kvm/x86.c |    6 ++++++
 3 files changed, 6 insertions(+), 29 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3915,12 +3915,6 @@ static int svm_get_msr(struct kvm_vcpu *
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	switch (msr_info->index) {
-	case MSR_IA32_TSC: {
-		msr_info->data = svm->vmcb->control.tsc_offset +
-			kvm_scale_tsc(vcpu, rdtsc());
-
-		break;
-	}
 	case MSR_STAR:
 		msr_info->data = svm->vmcb->save.star;
 		break;
@@ -4080,9 +4074,6 @@ static int svm_set_msr(struct kvm_vcpu *
 		svm->vmcb->save.g_pat = data;
 		mark_dirty(svm->vmcb, VMCB_NPT);
 		break;
-	case MSR_IA32_TSC:
-		kvm_write_tsc(vcpu, msr);
-		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2650,20 +2650,6 @@ static u64 vmx_read_l1_tsc_offset(struct
 }
 
 /*
- * reads and returns guest's timestamp counter "register"
- * guest_tsc = (host_tsc * tsc multiplier) >> 48 + tsc_offset
- * -- Intel TSC Scaling for Virtualization White Paper, sec 1.3
- */
-static u64 guest_read_tsc(struct kvm_vcpu *vcpu)
-{
-	u64 host_tsc, tsc_offset;
-
-	host_tsc = rdtsc();
-	tsc_offset = vmcs_read64(TSC_OFFSET);
-	return kvm_scale_tsc(vcpu, host_tsc) + tsc_offset;
-}
-
-/*
  * writes 'offset' into guest's timestamp counter offset register
  */
 static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
@@ -3283,9 +3269,6 @@ static int vmx_get_msr(struct kvm_vcpu *
 #endif
 	case MSR_EFER:
 		return kvm_get_msr_common(vcpu, msr_info);
-	case MSR_IA32_TSC:
-		msr_info->data = guest_read_tsc(vcpu);
-		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
@@ -3403,9 +3386,6 @@ static int vmx_set_msr(struct kvm_vcpu *
 			return 1;
 		vmcs_write64(GUEST_BNDCFGS, data);
 		break;
-	case MSR_IA32_TSC:
-		kvm_write_tsc(vcpu, msr_info);
-		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL))
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2333,6 +2333,9 @@ int kvm_set_msr_common(struct kvm_vcpu *
 			return 1;
 		vcpu->arch.smbase = data;
 		break;
+	case MSR_IA32_TSC:
+		kvm_write_tsc(vcpu, msr_info);
+		break;
 	case MSR_SMI_COUNT:
 		if (!msr_info->host_initiated)
 			return 1;
@@ -2572,6 +2575,9 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = vcpu->arch.microcode_version;
 		break;
+	case MSR_IA32_TSC:
+		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + vcpu->arch.tsc_offset;
+		break;
 	case MSR_MTRRcap:
 	case 0x200 ... 0x2ff:
 		return kvm_mtrr_get_msr(vcpu, msr_info->index, &msr_info->data);


