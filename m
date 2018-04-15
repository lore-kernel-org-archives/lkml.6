Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeDOVzF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:55:05 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:21598 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbeDOVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:55:01 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="735371361"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 12/12] KVM/nSVM: Use the new mapping API for mapping guest memory
Date: Sun, 15 Apr 2018 23:53:18 +0200
Message-Id: <1523829198-13236-13-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mapping API for mapping guest memory to avoid depending on
"struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/svm.c | 97 +++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b4ade8d..1706eab 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3026,32 +3026,6 @@ static inline bool nested_svm_nmi(struct vcpu_svm *svm)
 	return false;
 }
 
-static void *nested_svm_map(struct vcpu_svm *svm, u64 gpa, struct page **_page)
-{
-	struct page *page;
-
-	might_sleep();
-
-	page = kvm_vcpu_gfn_to_page(&svm->vcpu, gpa >> PAGE_SHIFT);
-	if (is_error_page(page))
-		goto error;
-
-	*_page = page;
-
-	return kmap(page);
-
-error:
-	kvm_inject_gp(&svm->vcpu, 0);
-
-	return NULL;
-}
-
-static void nested_svm_unmap(struct page *page)
-{
-	kunmap(page);
-	kvm_release_page_dirty(page);
-}
-
 static int nested_svm_intercept_ioio(struct vcpu_svm *svm)
 {
 	unsigned port, size, iopm_len;
@@ -3252,10 +3226,11 @@ static inline void copy_vmcb_control_area(struct vmcb *dst_vmcb, struct vmcb *fr
 
 static int nested_svm_vmexit(struct vcpu_svm *svm)
 {
+	int rc;
 	struct vmcb *nested_vmcb;
 	struct vmcb *hsave = svm->nested.hsave;
 	struct vmcb *vmcb = svm->vmcb;
-	struct page *page;
+	struct kvm_host_map map;
 
 	trace_kvm_nested_vmexit_inject(vmcb->control.exit_code,
 				       vmcb->control.exit_info_1,
@@ -3264,9 +3239,14 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 				       vmcb->control.exit_int_info_err,
 				       KVM_ISA_SVM);
 
-	nested_vmcb = nested_svm_map(svm, svm->nested.vmcb, &page);
-	if (!nested_vmcb)
+	rc = kvm_vcpu_map(&svm->vcpu, gfn_to_gpa(svm->nested.vmcb), &map);
+	if (rc) {
+		if (rc == -EINVAL)
+			kvm_inject_gp(&svm->vcpu, 0);
 		return 1;
+	}
+
+	nested_vmcb = map.hva;
 
 	/* Exit Guest-Mode */
 	leave_guest_mode(&svm->vcpu);
@@ -3365,7 +3345,7 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	mark_all_dirty(svm->vmcb);
 
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(&map);
 
 	nested_svm_uninit_mmu_context(&svm->vcpu);
 	kvm_mmu_reset_context(&svm->vcpu);
@@ -3423,7 +3403,7 @@ static bool nested_vmcb_checks(struct vmcb *vmcb)
 }
 
 static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
-				 struct vmcb *nested_vmcb, struct page *page)
+				 struct vmcb *nested_vmcb, struct kvm_host_map *map)
 {
 	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
 		svm->vcpu.arch.hflags |= HF_HIF_MASK;
@@ -3503,7 +3483,7 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	svm->vmcb->control.event_inj = nested_vmcb->control.event_inj;
 	svm->vmcb->control.event_inj_err = nested_vmcb->control.event_inj_err;
 
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(map);
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(&svm->vcpu);
@@ -3523,17 +3503,23 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 
 static bool nested_svm_vmrun(struct vcpu_svm *svm)
 {
+	int rc;
 	struct vmcb *nested_vmcb;
 	struct vmcb *hsave = svm->nested.hsave;
 	struct vmcb *vmcb = svm->vmcb;
-	struct page *page;
+	struct kvm_host_map map;
 	u64 vmcb_gpa;
 
 	vmcb_gpa = svm->vmcb->save.rax;
 
-	nested_vmcb = nested_svm_map(svm, svm->vmcb->save.rax, &page);
-	if (!nested_vmcb)
+	rc = kvm_vcpu_map(&svm->vcpu, gfn_to_gpa(vmcb_gpa), &map);
+	if (rc) {
+		if (rc == -EINVAL)
+			kvm_inject_gp(&svm->vcpu, 0);
 		return false;
+	}
+
+	nested_vmcb = map.hva;
 
 	if (!nested_vmcb_checks(nested_vmcb)) {
 		nested_vmcb->control.exit_code    = SVM_EXIT_ERR;
@@ -3541,7 +3527,7 @@ static bool nested_svm_vmrun(struct vcpu_svm *svm)
 		nested_vmcb->control.exit_info_1  = 0;
 		nested_vmcb->control.exit_info_2  = 0;
 
-		nested_svm_unmap(page);
+		kvm_vcpu_unmap(&map);
 
 		return false;
 	}
@@ -3585,7 +3571,7 @@ static bool nested_svm_vmrun(struct vcpu_svm *svm)
 
 	copy_vmcb_control_area(hsave, vmcb);
 
-	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, page);
+	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, &map);
 
 	return true;
 }
@@ -3609,21 +3595,26 @@ static void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
 static int vmload_interception(struct vcpu_svm *svm)
 {
 	struct vmcb *nested_vmcb;
-	struct page *page;
+	struct kvm_host_map map;
 	int ret;
 
 	if (nested_svm_check_permissions(svm))
 		return 1;
 
-	nested_vmcb = nested_svm_map(svm, svm->vmcb->save.rax, &page);
-	if (!nested_vmcb)
+	ret = kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map);
+	if (ret) {
+		if (ret == -EINVAL)
+			kvm_inject_gp(&svm->vcpu, 0);
 		return 1;
+	}
+
+	nested_vmcb = map.hva;
 
 	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(nested_vmcb, svm->vmcb);
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(&map);
 
 	return ret;
 }
@@ -3631,21 +3622,26 @@ static int vmload_interception(struct vcpu_svm *svm)
 static int vmsave_interception(struct vcpu_svm *svm)
 {
 	struct vmcb *nested_vmcb;
-	struct page *page;
+	struct kvm_host_map map;
 	int ret;
 
 	if (nested_svm_check_permissions(svm))
 		return 1;
 
-	nested_vmcb = nested_svm_map(svm, svm->vmcb->save.rax, &page);
-	if (!nested_vmcb)
+	ret = kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(svm->vmcb->save.rax), &map);
+	if (ret) {
+		if (ret == -EINVAL)
+			kvm_inject_gp(&svm->vcpu, 0);
 		return 1;
+	}
+
+	nested_vmcb = map.hva;
 
 	svm->next_rip = kvm_rip_read(&svm->vcpu) + 3;
 	ret = kvm_skip_emulated_instruction(&svm->vcpu);
 
 	nested_svm_vmloadsave(svm->vmcb, nested_vmcb);
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(&map);
 
 	return ret;
 }
@@ -6152,7 +6148,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *nested_vmcb;
-	struct page *page;
+	struct kvm_host_map map;
 	struct {
 		u64 guest;
 		u64 vmcb;
@@ -6166,11 +6162,16 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
 
 	if (svm_state_save.guest) {
 		vcpu->arch.hflags &= ~HF_SMM_MASK;
-		nested_vmcb = nested_svm_map(svm, svm_state_save.vmcb, &page);
+		if (kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(svm_state_save.vmcb), &map) == -EINVAL)
+			kvm_inject_gp(&svm->vcpu, 0);
+
+		nested_vmcb = map.hva;
+
 		if (nested_vmcb)
-			enter_svm_guest_mode(svm, svm_state_save.vmcb, nested_vmcb, page);
+			enter_svm_guest_mode(svm, svm_state_save.vmcb, nested_vmcb, &map);
 		else
 			ret = 1;
+
 		vcpu->arch.hflags |= HF_SMM_MASK;
 	}
 	return ret;
-- 
2.7.4
