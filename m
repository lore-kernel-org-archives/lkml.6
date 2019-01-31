Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997A121939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="PNOpj08m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfAaU1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:39 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:4315 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfAaU1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966432; x=1580502432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tXHcXp0oejvNpwb2bYW13MOU2GCjQA3lBdfWKRB2by4=;
  b=PNOpj08m3m12wNljLytWtgww7MpeakZujnCSFUt+ytw4bwcQAocSApSB
   HcmYwuj40kKMehh6ahv6yWhC96FDSW6MPAlALZQiqerzrNr6HSI4iVtEh
   fCMl3CBvX2KlpV6/+TAILoEE4US4hSPfXPEkYyx/DXgSBvJIgD6eYf3Jn
   c=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="656822841"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2019 20:27:11 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0VKR49f123804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 31 Jan 2019 20:27:07 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKR3gJ029007;
        Thu, 31 Jan 2019 21:27:04 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKR38k028999;
        Thu, 31 Jan 2019 21:27:03 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 10/14] KVM/nSVM: Use the new mapping API for mapping guest memory
Date:   Thu, 31 Jan 2019 21:24:40 +0100
Message-Id: <1548966284-28642-11-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mapping API for mapping guest memory to avoid depending on
"struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v4 -> v5:
- unmap with dirty flag
---
 arch/x86/kvm/svm.c | 97 +++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f13a3a2..d30a35b 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3062,32 +3062,6 @@ static inline bool nested_svm_nmi(struct vcpu_svm *svm)
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
@@ -3290,10 +3264,11 @@ static inline void copy_vmcb_control_area(struct vmcb *dst_vmcb, struct vmcb *fr
 
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
@@ -3302,9 +3277,14 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
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
@@ -3408,7 +3388,7 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	mark_all_dirty(svm->vmcb);
 
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(&svm->vcpu, &map, true);
 
 	nested_svm_uninit_mmu_context(&svm->vcpu);
 	kvm_mmu_reset_context(&svm->vcpu);
@@ -3474,7 +3454,7 @@ static bool nested_vmcb_checks(struct vmcb *vmcb)
 }
 
 static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
-				 struct vmcb *nested_vmcb, struct page *page)
+				 struct vmcb *nested_vmcb, struct kvm_host_map *map)
 {
 	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
 		svm->vcpu.arch.hflags |= HF_HIF_MASK;
@@ -3558,7 +3538,7 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	svm->vmcb->control.pause_filter_thresh =
 		nested_vmcb->control.pause_filter_thresh;
 
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(&svm->vcpu, map, true);
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(&svm->vcpu);
@@ -3578,17 +3558,23 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 
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
@@ -3596,7 +3582,7 @@ static bool nested_svm_vmrun(struct vcpu_svm *svm)
 		nested_vmcb->control.exit_info_1  = 0;
 		nested_vmcb->control.exit_info_2  = 0;
 
-		nested_svm_unmap(page);
+		kvm_vcpu_unmap(&svm->vcpu, &map, true);
 
 		return false;
 	}
@@ -3640,7 +3626,7 @@ static bool nested_svm_vmrun(struct vcpu_svm *svm)
 
 	copy_vmcb_control_area(hsave, vmcb);
 
-	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, page);
+	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, &map);
 
 	return true;
 }
@@ -3664,21 +3650,26 @@ static void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
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
+	kvm_vcpu_unmap(&svm->vcpu, &map, true);
 
 	return ret;
 }
@@ -3686,21 +3677,26 @@ static int vmload_interception(struct vcpu_svm *svm)
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
+	kvm_vcpu_unmap(&svm->vcpu, &map, true);
 
 	return ret;
 }
@@ -6219,7 +6215,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *nested_vmcb;
-	struct page *page;
+	struct kvm_host_map map;
 	struct {
 		u64 guest;
 		u64 vmcb;
@@ -6233,11 +6229,16 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
 
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

