Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeB0CfS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:35:18 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44939 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeB0CfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:35:16 -0500
X-Google-Smtp-Source: AH8x227CEE06grvgmzYhqNh2oKbGYrbIV5z6cFljxaWNNx6s0Qp+uDm2pcy8c5ZHyz5LXyw8QbN41w==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v4] KVM: X86: Allow userspace to define the microcode version
Date: Tue, 27 Feb 2018 10:35:10 +0800
Message-Id: <1519698910-4272-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
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
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v3 -> v4:
 * add the shifts back
v2 -> v3:
 * remove the shifts
 * add the MSR_IA32_UCODE_REV version to the "feature MSRs"
v1 -> v2:
 * add MSR_IA32_UCODE_REV to emulated_msrs

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/x86.c              | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 938d453..6e13f2f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -507,6 +507,7 @@ struct kvm_vcpu_arch {
 	u64 smi_count;
 	bool tpr_access_reporting;
 	u64 ia32_xss;
+	u32 microcode_version;
 
 	/*
 	 * Paging state of the vcpu
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d4985a9..0299b6e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1058,6 +1058,7 @@ static unsigned num_emulated_msrs;
 static u32 msr_based_features[] = {
 	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_F10H_DECFG,
+	MSR_IA32_UCODE_REV,
 };
 
 static unsigned int num_msr_based_features;
@@ -1067,8 +1068,14 @@ static int do_get_msr_feature(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 	struct kvm_msr_entry msr;
 
 	msr.index = index;
-	if (kvm_x86_ops->get_msr_feature(&msr))
-		return 1;
+	switch (msr.index) {
+	case MSR_IA32_UCODE_REV:
+		rdmsrl(msr.index, msr.data);
+		break;
+	default:
+		if (kvm_x86_ops->get_msr_feature(&msr))
+			return 1;
+	}
 
 	*data = msr.data;
 
@@ -2248,7 +2255,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	switch (msr) {
 	case MSR_AMD64_NB_CFG:
-	case MSR_IA32_UCODE_REV:
 	case MSR_IA32_UCODE_WRITE:
 	case MSR_VM_HSAVE_PA:
 	case MSR_AMD64_PATCH_LOADER:
@@ -2256,6 +2262,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DC_CFG:
 		break;
 
+	case MSR_IA32_UCODE_REV:
+		if (msr_info->host_initiated)
+			vcpu->arch.microcode_version = data >> 32;
+		break;
 	case MSR_EFER:
 		return set_efer(vcpu, data);
 	case MSR_K7_HWCR:
@@ -2551,7 +2561,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = 0;
 		break;
 	case MSR_IA32_UCODE_REV:
-		msr_info->data = 0x100000000ULL;
+		msr_info->data = (u64)vcpu->arch.microcode_version << 32;
 		break;
 	case MSR_MTRRcap:
 	case 0x200 ... 0x2ff:
@@ -8233,6 +8243,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.regs_dirty = ~0;
 
 	vcpu->arch.ia32_xss = 0;
+	vcpu->arch.microcode_version = 0x1;
 
 	kvm_x86_ops->vcpu_reset(vcpu, init_event);
 }
-- 
2.7.4
