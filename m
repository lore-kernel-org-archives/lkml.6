Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDLUTY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:19:24 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:43546 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbeDLUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:19:23 -0400
X-IronPort-AV: E=Sophos;i="5.48,443,1517875200";
   d="scan'208";a="715754147"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v4 1/2] X86/KVM: Properly update 'tsc_offset' to represent the running guest
Date: Thu, 12 Apr 2018 22:19:06 +0200
Message-Id: <1523564347-8896-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update 'tsc_offset' on vmenty/vmexit of L2 guests to ensure that it always
captures the TSC_OFFSET of the running guest whether it is the L1 or L2
guest.

Cc: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:

- Rewrote the patch to always update tsc_offset to represent the current
  guest (pbonzini@)
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/vmx.c              | 25 ++++++++++++++++++++-----
 arch/x86/kvm/x86.c              |  9 ++++++++-
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9fa4f57..3bedfef 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1015,6 +1015,7 @@ struct kvm_x86_ops {
 
 	bool (*has_wbinvd_exit)(void);
 
+	u64 (*read_l1_tsc_offset)(struct kvm_vcpu *vcpu);
 	void (*write_tsc_offset)(struct kvm_vcpu *vcpu, u64 offset);
 
 	void (*get_exit_info)(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index cff2f50..9e7dd39 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2895,6 +2895,17 @@ static u64 guest_read_tsc(struct kvm_vcpu *vcpu)
 	return kvm_scale_tsc(vcpu, host_tsc) + tsc_offset;
 }
 
+static u64 vmx_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	if (is_guest_mode(vcpu) &&
+	    (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING))
+		return vcpu->arch.tsc_offset - vmcs12->tsc_offset;
+
+	return vcpu->arch.tsc_offset;
+}
+
 /*
  * writes 'offset' into guest's timestamp counter offset register
  */
@@ -11163,11 +11174,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
 	}
 
-	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
-		vmcs_write64(TSC_OFFSET,
-			vcpu->arch.tsc_offset + vmcs12->tsc_offset);
-	else
-		vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
+	vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
+
 	if (kvm_has_tsc_control)
 		decache_tsc_multiplier(vmx);
 
@@ -11469,6 +11477,9 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (enable_shadow_vmcs)
 		copy_shadow_to_vmcs12(vmx);
 
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
+
 	/*
 	 * The nested entry process starts with enforcing various prerequisites
 	 * on vmcs12 as required by the Intel SDM, and act appropriately when
@@ -12015,6 +12026,9 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 
 	leave_guest_mode(vcpu);
 
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+
 	if (likely(!vmx->fail)) {
 		if (exit_reason == -1)
 			sync_vmcs12(vcpu, vmcs12);
@@ -12688,6 +12702,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 
 	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
 
+	.read_l1_tsc_offset = vmx_read_l1_tsc_offset,
 	.write_tsc_offset = vmx_write_tsc_offset,
 
 	.set_tdp_cr3 = vmx_set_cr3,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac42c85..3fb1353 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1532,7 +1532,14 @@ static u64 kvm_compute_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
 {
-	return vcpu->arch.tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
+	u64 tsc_offset;
+
+	if (kvm_x86_ops->read_l1_tsc_offset)
+		tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
+	else
+		tsc_offset = vcpu->arch.tsc_offset;
+
+	return tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
 }
 EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
 
-- 
2.7.4
