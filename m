Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeB1GDp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 01:03:45 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35687 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeB1GDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 01:03:41 -0500
X-Google-Smtp-Source: AG47ELviTYckYWy+cwNIwE1ifF9yXzcrAYALoFM+lQ+LYJU4ZO/an0wFocJ1/cdcP5WDiqb72yLa7A==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH RESEND v5 2/2] KVM: X86: Allow userspace to define the microcode version
Date: Wed, 28 Feb 2018 14:03:31 +0800
Message-Id: <1519797811-4560-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519797811-4560-1-git-send-email-wanpengli@tencent.com>
References: <1519797811-4560-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Linux (among the others) has checks to make sure that certain features 
aren't enabled on a certain family/model/stepping if the microcode version 
isn't greater than or equal to a known good version.

By exposing the real microcode version, we're preventing buggy guests that
don't check that they are running virtualized (i.e., they should trust the
hypervisor) from disabling features that are effectively not buggy.

Suggested-by: Filippo Sironi <sironi@amazon.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v4 -> v5:
 * microcode_version be u64 and initialized suitable, remote hte shifts
v3 -> v4:
 * add the shifts back
v2 -> v3:
 * remove the shifts
 * add the MSR_IA32_UCODE_REV version to the "feature MSRs"
v1 -> v2:
 * add MSR_IA32_UCODE_REV to emulated_msrs

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm.c              |  4 +---
 arch/x86/kvm/vmx.c              |  1 +
 arch/x86/kvm/x86.c              | 11 +++++++++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 938d453..df6720f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -507,6 +507,7 @@ struct kvm_vcpu_arch {
 	u64 smi_count;
 	bool tpr_access_reporting;
 	u64 ia32_xss;
+	u64 microcode_version;
 
 	/*
 	 * Paging state of the vcpu
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f874798..312f33f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1907,6 +1907,7 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u32 dummy;
 	u32 eax = 1;
 
+	vcpu->arch.microcode_version = 0x01000065;
 	svm->spec_ctrl = 0;
 
 	if (!init_event) {
@@ -3962,9 +3963,6 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		msr_info->data = svm->spec_ctrl;
 		break;
-	case MSR_IA32_UCODE_REV:
-		msr_info->data = 0x01000065;
-		break;
 	case MSR_F15H_IC_CFG: {
 
 		int family, model;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9968906..2cdbea7 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5781,6 +5781,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vmx->rmode.vm86_active = 0;
 	vmx->spec_ctrl = 0;
 
+	vcpu->arch.microcode_version = 0x100000000ULL;
 	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
 	kvm_set_cr8(vcpu, 0);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index efc8554..5c93cbc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1058,6 +1058,7 @@ static unsigned num_emulated_msrs;
 static u32 msr_based_features[] = {
 	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_F10H_DECFG,
+	MSR_IA32_UCODE_REV,
 };
 
 static unsigned int num_msr_based_features;
@@ -1065,6 +1066,9 @@ static unsigned int num_msr_based_features;
 static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
+	case MSR_IA32_UCODE_REV:
+		rdmsrl(msr->index, msr->data);
+		break;
 	default:
 		if (kvm_x86_ops->get_msr_feature(msr))
 			return 1;
@@ -2260,7 +2264,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	switch (msr) {
 	case MSR_AMD64_NB_CFG:
-	case MSR_IA32_UCODE_REV:
 	case MSR_IA32_UCODE_WRITE:
 	case MSR_VM_HSAVE_PA:
 	case MSR_AMD64_PATCH_LOADER:
@@ -2268,6 +2271,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DC_CFG:
 		break;
 
+	case MSR_IA32_UCODE_REV:
+		if (msr_info->host_initiated)
+			vcpu->arch.microcode_version = data;
+		break;
 	case MSR_EFER:
 		return set_efer(vcpu, data);
 	case MSR_K7_HWCR:
@@ -2563,7 +2570,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = 0;
 		break;
 	case MSR_IA32_UCODE_REV:
-		msr_info->data = 0x100000000ULL;
+		msr_info->data = vcpu->arch.microcode_version;
 		break;
 	case MSR_MTRRcap:
 	case 0x200 ... 0x2ff:
-- 
2.7.4
