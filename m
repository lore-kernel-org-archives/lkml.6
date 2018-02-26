Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbeBZHYI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:24:08 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:33765 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeBZHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:24:05 -0500
X-Google-Smtp-Source: AG47ELsVi55XRfFDqscGADDXGjd1sZAkwRjOpedFlIfA/qKseahVqz6nd8xnQMczHTy2xdxa3PMlpg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: X86: Allow userspace to define the microcode version
Date: Mon, 26 Feb 2018 15:23:58 +0800
Message-Id: <1519629838-4898-1-git-send-email-wanpengli@tencent.com>
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
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/x86.c              | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

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
index 1a3ed81..cc51c61 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2247,7 +2247,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	switch (msr) {
 	case MSR_AMD64_NB_CFG:
-	case MSR_IA32_UCODE_REV:
 	case MSR_IA32_UCODE_WRITE:
 	case MSR_VM_HSAVE_PA:
 	case MSR_AMD64_PATCH_LOADER:
@@ -2255,6 +2254,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DC_CFG:
 		break;
 
+	case MSR_IA32_UCODE_REV:
+		if (msr_info->host_initiated)
+			vcpu->arch.microcode_version = data >> 32;
+		break;
 	case MSR_EFER:
 		return set_efer(vcpu, data);
 	case MSR_K7_HWCR:
@@ -2550,7 +2553,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = 0;
 		break;
 	case MSR_IA32_UCODE_REV:
-		msr_info->data = 0x100000000ULL;
+		msr_info->data = (u64)vcpu->arch.microcode_version << 32;
 		break;
 	case MSR_MTRRcap:
 	case 0x200 ... 0x2ff:
@@ -8232,6 +8235,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	vcpu->arch.regs_dirty = ~0;
 
 	vcpu->arch.ia32_xss = 0;
+	vcpu->arch.microcode_version = 0x1;
 
 	kvm_x86_ops->vcpu_reset(vcpu, init_event);
 }
-- 
2.7.4
