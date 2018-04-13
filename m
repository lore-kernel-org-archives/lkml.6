Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeDMLXn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:23:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32887 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754491AbeDMLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:23:37 -0400
X-Google-Smtp-Source: AIpwx49DMiRJk6AOnkya/W990/7gVdkyMvcGLxyOEn/6vkdUUa+1YKs9Gb2/HUPNHl2rQ3pEU7hwkw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: karahmed@amazon.de, jmattson@google.com, rkrcmar@redhat.com
Subject: [PATCH 2/2] kvm: x86: move MSR_IA32_TSC handling to x86.c
Date: Fri, 13 Apr 2018 13:23:27 +0200
Message-Id: <1523618608-30574-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
References: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not specific to Intel/AMD anymore.  The TSC offset is available
in vcpu->arch.tsc_offset.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm.c |  9 ---------
 arch/x86/kvm/vmx.c | 20 --------------------
 arch/x86/kvm/x86.c |  6 ++++++
 3 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index ea7c6d29aca5..e636ef8cf3ce 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4050,12 +4050,6 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -4208,9 +4202,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm->vmcb->save.g_pat = data;
 		mark_dirty(svm->vmcb, VMCB_NPT);
 		break;
-	case MSR_IA32_TSC:
-		kvm_write_tsc(vcpu, msr);
-		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6553419202ee..e26c1f1c0a08 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2886,20 +2886,6 @@ static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
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
@@ -3529,9 +3515,6 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 #endif
 	case MSR_EFER:
 		return kvm_get_msr_common(vcpu, msr_info);
-	case MSR_IA32_TSC:
-		msr_info->data = guest_read_tsc(vcpu);
-		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
@@ -3651,9 +3634,6 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vmcs_write64(GUEST_BNDCFGS, data);
 		break;
-	case MSR_IA32_TSC:
-		kvm_write_tsc(vcpu, msr_info);
-		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3f3fba58c960..51ecd381793b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2364,6 +2364,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.smbase = data;
 		break;
+	case MSR_IA32_TSC:
+		kvm_write_tsc(vcpu, msr_info);
+		break;
 	case MSR_SMI_COUNT:
 		if (!msr_info->host_initiated)
 			return 1;
@@ -2607,6 +2610,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = vcpu->arch.microcode_version;
 		break;
+	case MSR_IA32_TSC:
+		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + vcpu->arch.tsc_offset;
+		break;
 	case MSR_MTRRcap:
 	case 0x200 ... 0x2ff:
 		return kvm_mtrr_get_msr(vcpu, msr_info->index, &msr_info->data);
-- 
1.8.3.1
