Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C54C46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5252150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5252150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbeHBLwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:52:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbeHBLwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9842881663F6;
        Thu,  2 Aug 2018 10:01:39 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 688D8213ED80;
        Thu,  2 Aug 2018 10:01:38 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 3/9] x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
Date:   Thu,  2 Aug 2018 12:01:26 +0200
Message-Id: <20180802100132.5249-4-vkuznets@redhat.com>
In-Reply-To: <20180802100132.5249-1-vkuznets@redhat.com>
References: <20180802100132.5249-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
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
index 7ae8ae58f3bd..7b157cd43e1f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1325,7 +1325,8 @@ void __kvm_mmu_free_some_pages(struct kvm_vcpu *vcpu);
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
index b013aec73d46..1bcab6f9d1c8 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3435,11 +3435,11 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
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
@@ -4154,7 +4154,8 @@ static void __kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3,
 			      bool skip_tlb_flush)
 {
 	if (!fast_cr3_switch(vcpu, new_cr3, new_role, skip_tlb_flush))
-		kvm_mmu_free_roots(vcpu, KVM_MMU_ROOT_CURRENT);
+		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu,
+				   KVM_MMU_ROOT_CURRENT);
 }
 
 void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3, bool skip_tlb_flush)
@@ -4936,7 +4937,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOTS_ALL);
 	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index eeae217b797b..80cf941a3080 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8893,7 +8893,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 			    == operand.pcid)
 				roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
 
-		kvm_mmu_free_roots(vcpu, roots_to_free);
+		kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, roots_to_free);
 		/*
 		 * If neither the current cr3 nor any of the prev_roots use the
 		 * given PCID, then nothing needs to be done here because a
-- 
2.14.4

