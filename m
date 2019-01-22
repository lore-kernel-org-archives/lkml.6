Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB70C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA1221850
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAWOGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:06:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:53944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfAWOGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:06:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="140622271"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 06:06:32 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     weijiang.yang@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v2 5/7] KVM:VMX: Pass through host CET related MSRs to Guest.
Date:   Wed, 23 Jan 2019 04:59:07 +0800
Message-Id: <20190122205909.24165-6-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122205909.24165-1-weijiang.yang@intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CET runtime settings, i.e., CET state control bits(IA32_U_CET/
IA32_S_CET), CET SSP(IA32_PL3_SSP/IA32_PL0_SSP) and SSP table address
(IA32_INTERRUPT_SSP_TABLE_ADDR) are task/thread specific, therefore,
OS needs to save/restore the states properly during context switch,
e.g., task/thread switching, interrupt/exception handling, it uses
xsaves/xrstors to achieve that.

The difference between VMCS CET area fields and xsave CET area, is that
the former is for state retention during Guest/Host context
switch while the latter is for state retention during OS execution.

Linux currently doesn't support CPL1 and CPL2, so SSPs for these level
are skipped here.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/vmx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 7bbb8b26e901..68c0e5e41cb1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11531,6 +11531,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
 	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
 	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
+
 	vmx->msr_bitmap_mode = 0;
 
 	vmx->loaded_vmcs = &vmx->vmcs01;
@@ -11769,6 +11770,8 @@ static void nested_vmx_entry_exit_ctls_update(struct kvm_vcpu *vcpu)
 static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_cpuid_entry2 *best;
+	unsigned long *msr_bitmap;
 
 	if (cpu_has_secondary_exec_ctrls()) {
 		vmx_compute_secondary_exec_control(vmx);
@@ -11786,6 +11789,19 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 		nested_vmx_cr_fixed1_bits_update(vcpu);
 		nested_vmx_entry_exit_ctls_update(vcpu);
 	}
+
+	msr_bitmap = vmx->vmcs01.msr_bitmap;
+	best = kvm_find_cpuid_entry(vcpu, 7, 0);
+	if ((best && best->function == 0x7) &&
+	    ((best->ecx & bit(X86_FEATURE_SHSTK)) |
+	    (best->edx & bit(X86_FEATURE_IBT)))) {
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_U_CET, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_S_CET, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL0_SSP, MSR_TYPE_RW);
+		vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_PL3_SSP, MSR_TYPE_RW);
+	}
+
 }
 
 static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
-- 
2.17.1

