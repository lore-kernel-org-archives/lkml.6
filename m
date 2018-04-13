Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeDML1I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:27:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55409 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeDMLXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:23:36 -0400
X-Google-Smtp-Source: AIpwx485U/wvdwZlQTBY0kfvZoT6IB0hF+vh+UP5AzYL8mRcxPm5RHn1BLklIl6q1cL+a+rsT4X9HA==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: karahmed@amazon.de, jmattson@google.com, rkrcmar@redhat.com
Subject: [PATCH 1/2] X86/KVM: Properly update 'tsc_offset' to represent the running guest
Date: Fri, 13 Apr 2018 13:23:26 +0200
Message-Id: <1523618608-30574-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
References: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KarimAllah Ahmed <karahmed@amazon.de>

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
[AMD changes, fix update_ia32_tsc_adjust_msr. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/svm.c              | 17 ++++++++++++++++-
 arch/x86/kvm/vmx.c              | 25 ++++++++++++++++++++-----
 arch/x86/kvm/x86.c              |  6 ++++--
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 949c977bc4c9..c25775fad4ed 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1013,6 +1013,7 @@ struct kvm_x86_ops {
 
 	bool (*has_wbinvd_exit)(void);
 
+	u64 (*read_l1_tsc_offset)(struct kvm_vcpu *vcpu);
 	void (*write_tsc_offset)(struct kvm_vcpu *vcpu, u64 offset);
 
 	void (*get_exit_info)(struct kvm_vcpu *vcpu, u64 *info1, u64 *info2);
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3ebc8ad6891..ea7c6d29aca5 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1424,12 +1424,23 @@ static void init_sys_seg(struct vmcb_seg *seg, uint32_t type)
 	seg->base = 0;
 }
 
+static u64 svm_read_l1_tsc_offset(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (is_guest_mode(vcpu))
+		return svm->nested.hsave->control.tsc_offset;
+
+	return vcpu->arch.tsc_offset;
+}
+
 static void svm_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 g_tsc_offset = 0;
 
 	if (is_guest_mode(vcpu)) {
+		/* Write L1's TSC offset.  */
 		g_tsc_offset = svm->vmcb->control.tsc_offset -
 			       svm->nested.hsave->control.tsc_offset;
 		svm->nested.hsave->control.tsc_offset = offset;
@@ -3323,6 +3334,7 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Restore the original control entries */
 	copy_vmcb_control_area(vmcb, hsave);
 
+	vcpu->arch.tsc_offset = svm->vmcb->control.tsc_offset;
 	kvm_clear_exception_queue(&svm->vcpu);
 	kvm_clear_interrupt_queue(&svm->vcpu);
 
@@ -3483,10 +3495,12 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	/* We don't want to see VMMCALLs from a nested guest */
 	clr_intercept(svm, INTERCEPT_VMMCALL);
 
+	vcpu->arch.tsc_offset += nested_vmcb->control.tsc_offset;
+	svm->vmcb->control.tsc_offset = vcpu->arch.tsc_offset;
+
 	svm->vmcb->control.virt_ext = nested_vmcb->control.virt_ext;
 	svm->vmcb->control.int_vector = nested_vmcb->control.int_vector;
 	svm->vmcb->control.int_state = nested_vmcb->control.int_state;
-	svm->vmcb->control.tsc_offset += nested_vmcb->control.tsc_offset;
 	svm->vmcb->control.event_inj = nested_vmcb->control.event_inj;
 	svm->vmcb->control.event_inj_err = nested_vmcb->control.event_inj_err;
 
@@ -7102,6 +7116,7 @@ static int svm_unregister_enc_region(struct kvm *kvm,
 
 	.has_wbinvd_exit = svm_has_wbinvd_exit,
 
+	.read_l1_tsc_offset = svm_read_l1_tsc_offset,
 	.write_tsc_offset = svm_write_tsc_offset,
 
 	.set_tdp_cr3 = set_tdp_cr3,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a13c603bdefb..6553419202ee 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2874,6 +2874,17 @@ static void setup_msrs(struct vcpu_vmx *vmx)
 		vmx_update_msr_bitmap(&vmx->vcpu);
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
  * reads and returns guest's timestamp counter "register"
  * guest_tsc = (host_tsc * tsc multiplier) >> 48 + tsc_offset
@@ -11175,11 +11186,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
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
 
@@ -11489,6 +11497,9 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (enable_shadow_vmcs)
 		copy_shadow_to_vmcs12(vmx);
 
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
+
 	/*
 	 * The nested entry process starts with enforcing various prerequisites
 	 * on vmcs12 as required by the Intel SDM, and act appropriately when
@@ -12035,6 +12046,9 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 
 	leave_guest_mode(vcpu);
 
+	if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
+		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
+
 	if (likely(!vmx->fail)) {
 		if (exit_reason == -1)
 			sync_vmcs12(vcpu, vmcs12);
@@ -12725,6 +12739,7 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 
 	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
 
+	.read_l1_tsc_offset = vmx_read_l1_tsc_offset,
 	.write_tsc_offset = vmx_write_tsc_offset,
 
 	.set_tdp_cr3 = vmx_set_cr3,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0334b250e102..3f3fba58c960 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1490,7 +1490,7 @@ static void kvm_track_tsc_matching(struct kvm_vcpu *vcpu)
 
 static void update_ia32_tsc_adjust_msr(struct kvm_vcpu *vcpu, s64 offset)
 {
-	u64 curr_offset = vcpu->arch.tsc_offset;
+	u64 curr_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
 	vcpu->arch.ia32_tsc_adjust_msr += offset - curr_offset;
 }
 
@@ -1532,7 +1532,9 @@ static u64 kvm_compute_tsc_offset(struct kvm_vcpu *vcpu, u64 target_tsc)
 
 u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
 {
-	return vcpu->arch.tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
+	u64 tsc_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
+
+	return tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
 }
 EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
 
-- 
1.8.3.1
