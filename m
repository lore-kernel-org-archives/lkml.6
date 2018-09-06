Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA9E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA9E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeIFQgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:36:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:62802 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbeIFQgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:36:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 05:01:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="71046834"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 06 Sep 2018 05:00:58 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
Cc:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, wei.w.wang@intel.com
Subject: [PATCH v2 5/8] KVM/x86: enable the guest to access the debugctl msr
Date:   Thu,  6 Sep 2018 19:30:53 +0800
Message-Id: <1536233456-12173-6-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugctl MSR is not completely identical on AMD and Intel CPUs, for
example, FREEZE_LBRS_ON_PMI is supported by Intel CPUs only. svm.c has
handled the access to the debugctl msr, and this patch handles the
access to the debugctl msr on Intel CPUs in vmx.c. Accordingly, the
common debugctl msr handling code in kvm_get/set_msr_common is removed.

Signed-off-by: Like Xu <like.xu@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kvm/vmx.c | 15 +++++++++++++++
 arch/x86/kvm/x86.c | 13 -------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index d5eba8e..d0ea360 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4093,6 +4093,11 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		msr_info->data = to_vmx(vcpu)->arch_capabilities;
 		break;
+	case MSR_IA32_DEBUGCTLMSR:
+		if (!vcpu->kvm->arch.guest_lbr)
+			return 1;
+		msr_info->data = vmcs_read64(GUEST_IA32_DEBUGCTL);
+		break;
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
@@ -4266,6 +4271,16 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vmx->arch_capabilities = data;
 		break;
+	case MSR_IA32_DEBUGCTLMSR:
+		if (!vcpu->kvm->arch.guest_lbr)
+			return 1;
+		/*
+		 * Currently, only FREEZE_LBRS_ON_PMI and DEBUGCTLMSR_LBR are
+		 * supported.
+		 */
+		data &= (DEBUGCTLMSR_FREEZE_LBRS_ON_PMI | DEBUGCTLMSR_LBR);
+		vmcs_write64(GUEST_IA32_DEBUGCTL, data);
+		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
 			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3eaf1b8..4bbb9eb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2369,18 +2369,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		}
 		break;
-	case MSR_IA32_DEBUGCTLMSR:
-		if (!data) {
-			/* We support the non-activated case already */
-			break;
-		} else if (data & ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_BTF)) {
-			/* Values other than LBR and BTF are vendor-specific,
-			   thus reserved and should throw a #GP */
-			return 1;
-		}
-		vcpu_unimpl(vcpu, "%s: MSR_IA32_DEBUGCTLMSR 0x%llx, nop\n",
-			    __func__, data);
-		break;
 	case 0x200 ... 0x2ff:
 		return kvm_mtrr_set_msr(vcpu, msr, data);
 	case MSR_IA32_APICBASE:
@@ -2623,7 +2611,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	switch (msr_info->index) {
 	case MSR_IA32_PLATFORM_ID:
 	case MSR_IA32_EBL_CR_POWERON:
-	case MSR_IA32_DEBUGCTLMSR:
 	case MSR_IA32_LASTBRANCHFROMIP:
 	case MSR_IA32_LASTBRANCHTOIP:
 	case MSR_IA32_LASTINTFROMIP:
-- 
2.7.4

