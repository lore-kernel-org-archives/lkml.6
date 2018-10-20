Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B00ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9F21746
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="M+dmKVHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE9F21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJUGfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:35:25 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:51999 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbeJUGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1540074207; x=1571610207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=73TTG0YMaW/U/X2yCJ2mHRKj31PrbWZhh8+H1ro5LN0=;
  b=M+dmKVHZa4vQpPc92qmO8RSlZFSMwCGrS13WaMScE+YuHiMC98LMIsg+
   1WEf6rQ/7L6UGP63RwlDAF+Zd/0W/1wacAbCIKxGngsQ2VXT+ETguX3gG
   oCP7JbehjolbzzQxQBkLqYdWe40FyVsMkP6XIMTrIX+TfOGpdFctipQCu
   I=;
X-IronPort-AV: E=Sophos;i="5.54,405,1534809600"; 
   d="scan'208";a="700848207"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Oct 2018 22:23:07 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9KMMw5Z059623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 20 Oct 2018 22:22:59 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9KMMv5K031669;
        Sun, 21 Oct 2018 00:22:57 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9KMMuIc031662;
        Sun, 21 Oct 2018 00:22:57 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v3 12/13] KVM/nSVM: Use the new mapping API for mapping guest memory
Date:   Sun, 21 Oct 2018 00:22:24 +0200
Message-Id: <1540074145-31285-13-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
References: <1540074145-31285-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new mapping API for mapping guest memory to avoid depending on
"struct page".

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/svm.c | 97 +++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index d96092b..911d853 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3036,32 +3036,6 @@ static inline bool nested_svm_nmi(struct vcpu_svm *svm)
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
@@ -3262,10 +3236,11 @@ static inline void copy_vmcb_control_area(struct vmcb *dst_vmcb, struct vmcb *fr
 
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
@@ -3274,9 +3249,14 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
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
@@ -3375,7 +3355,7 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 
 	mark_all_dirty(svm->vmcb);
 
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(&map);
 
 	nested_svm_uninit_mmu_context(&svm->vcpu);
 	kvm_mmu_reset_context(&svm->vcpu);
@@ -3433,7 +3413,7 @@ static bool nested_vmcb_checks(struct vmcb *vmcb)
 }
 
 static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
-				 struct vmcb *nested_vmcb, struct page *page)
+				 struct vmcb *nested_vmcb, struct kvm_host_map *map)
 {
 	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
 		svm->vcpu.arch.hflags |= HF_HIF_MASK;
@@ -3513,7 +3493,7 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 	svm->vmcb->control.event_inj = nested_vmcb->control.event_inj;
 	svm->vmcb->control.event_inj_err = nested_vmcb->control.event_inj_err;
 
-	nested_svm_unmap(page);
+	kvm_vcpu_unmap(map);
 
 	/* Enter Guest-Mode */
 	enter_guest_mode(&svm->vcpu);
@@ -3533,17 +3513,23 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 
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
@@ -3551,7 +3537,7 @@ static bool nested_svm_vmrun(struct vcpu_svm *svm)
 		nested_vmcb->control.exit_info_1  = 0;
 		nested_vmcb->control.exit_info_2  = 0;
 
-		nested_svm_unmap(page);
+		kvm_vcpu_unmap(&map);
 
 		return false;
 	}
@@ -3595,7 +3581,7 @@ static bool nested_svm_vmrun(struct vcpu_svm *svm)
 
 	copy_vmcb_control_area(hsave, vmcb);
 
-	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, page);
+	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb, &map);
 
 	return true;
 }
@@ -3619,21 +3605,26 @@ static void nested_svm_vmloadsave(struct vmcb *from_vmcb, struct vmcb *to_vmcb)
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
@@ -3641,21 +3632,26 @@ static int vmload_interception(struct vcpu_svm *svm)
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
@@ -6173,7 +6169,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *nested_vmcb;
-	struct page *page;
+	struct kvm_host_map map;
 	struct {
 		u64 guest;
 		u64 vmcb;
@@ -6187,11 +6183,16 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
 
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

