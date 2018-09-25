Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D904C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0533620896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0533620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbeIZAIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbeIZAIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:08:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8BF35308A96E;
        Tue, 25 Sep 2018 17:59:22 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB25660BE7;
        Tue, 25 Sep 2018 17:59:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
Date:   Tue, 25 Sep 2018 19:58:38 +0200
Message-Id: <20180925175844.20277-4-vkuznets@redhat.com>
In-Reply-To: <20180925175844.20277-1-vkuznets@redhat.com>
References: <20180925175844.20277-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 25 Sep 2018 17:59:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to specify which MMU root we want to free. This will
be used when nested and non-nested MMUs for L1 are split.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/mmu.c              | 9 +++++----
 arch/x86/kvm/vmx.c              | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 95be30cfb33a..404c3438827b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1327,7 +1327,8 @@ void __kvm_mmu_free_some_pages(struct kvm_vcpu *vcpu);
 int kvm_mmu_load(struct kvm_vcpu *vcpu);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu);
 void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu);
-void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, ulong roots_to_free);
+void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			ulong roots_to_free);
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
 			   struct x86_exception *exception);
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 2bdc63f67886..4491b8894337 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3464,11 +3464,11 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 }
 
 /* roots_to_free must be some combination of the KVM_MMU_ROOT_* flags */
-void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, ulong roots_to_free)
+void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			ulong roots_to_free)
 {
 	int i;
 	LIST_HEAD(invalid_list);
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	bool free_active_root = roots_to_free & KVM_MMU_ROOT_CURRENT;
 
 	BUILD_BUG_ON(KVM_MMU_NUM_PREV_ROOTS >= BITS_PER_LONG);
@@ -4184,7 +4184,8 @@ static void __kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3,
 			      bool skip_tlb_flush)
 {
 	if (!fast_cr3_switch(vcpu, new_cr3, new_role, skip_tlb_flush))
-		kvm_mmu_free_roots(vcpu, KVM_MMU_ROOT_CURRENT);
+		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu,
+				   KVM_MMU_ROOT_CURRENT);
 }
 
 void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3, bool skip_tlb_flush)
@@ -4966,7 +4967,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOTS_ALL);
 	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4b8dc85afe34..2d55adab52de 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9185,7 +9185,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 			    == operand.pcid)
 				roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
 
-		kvm_mmu_free_roots(vcpu, roots_to_free);
+		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, roots_to_free);
 		/*
 		 * If neither the current cr3 nor any of the prev_roots use the
 		 * given PCID, then nothing needs to be done here because a
-- 
2.17.1

