Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B535FC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A322086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A322086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbeIRVmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:42:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730298AbeIRVmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:42:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AE2E307D86D;
        Tue, 18 Sep 2018 16:09:22 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C3F616BF8;
        Tue, 18 Sep 2018 16:09:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 RESEND 6/9] x86/kvm/mmu: make space for source data caching in struct kvm_mmu
Date:   Tue, 18 Sep 2018 18:09:03 +0200
Message-Id: <20180918160906.9241-7-vkuznets@redhat.com>
In-Reply-To: <20180918160906.9241-1-vkuznets@redhat.com>
References: <20180918160906.9241-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 18 Sep 2018 16:09:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to MMU reconfiguration avoidance we need a space to
cache source data. As this partially intersects with kvm_mmu_page_role,
create 64bit sized union kvm_mmu_role holding both base_role and
extended data. No functional change.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 14 +++++++++++++-
 arch/x86/kvm/mmu.c              | 19 ++++++++++++-------
 arch/x86/kvm/vmx.c              |  2 +-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 527aaf45eba6..6ca7d28d57e9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -273,6 +273,18 @@ union kvm_mmu_page_role {
 	};
 };
 
+union kvm_mmu_scache {
+	unsigned int word;
+};
+
+union kvm_mmu_role {
+	unsigned long as_u64;
+	struct {
+		union kvm_mmu_page_role base_role;
+		union kvm_mmu_scache scache;
+	};
+};
+
 struct kvm_rmap_head {
 	unsigned long val;
 };
@@ -360,7 +372,7 @@ struct kvm_mmu {
 	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 			   u64 *spte, const void *pte);
 	hpa_t root_hpa;
-	union kvm_mmu_page_role base_role;
+	union kvm_mmu_role mmu_role;
 	u8 root_level;
 	u8 shadow_root_level;
 	u8 ept_ad;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 5f167823c50d..8d8e6fa75fa3 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2359,7 +2359,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	int collisions = 0;
 	LIST_HEAD(invalid_list);
 
-	role = vcpu->arch.mmu->base_role;
+	role = vcpu->arch.mmu->mmu_role.base_role;
 	role.level = level;
 	role.direct = direct;
 	if (role.direct)
@@ -4407,7 +4407,8 @@ static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
 void
 reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
 {
-	bool uses_nx = context->nx || context->base_role.smep_andnot_wp;
+	bool uses_nx = context->nx ||
+		context->mmu_role.base_role.smep_andnot_wp;
 	struct rsvd_bits_validate *shadow_zero_check;
 	int i;
 
@@ -4726,7 +4727,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
 
-	context->base_role.word = mmu_base_role_mask.word &
+	context->mmu_role.base_role.word = mmu_base_role_mask.word &
 				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
 	context->page_fault = tdp_page_fault;
 	context->sync_page = nonpaging_sync_page;
@@ -4807,7 +4808,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 	else
 		paging32_init_context(vcpu, context);
 
-	context->base_role.word = mmu_base_role_mask.word &
+	context->mmu_role.base_role.word = mmu_base_role_mask.word &
 				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
@@ -4816,7 +4817,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 static union kvm_mmu_page_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
 {
-	union kvm_mmu_page_role role = vcpu->arch.mmu->base_role;
+	union kvm_mmu_page_role role = vcpu->arch.mmu->mmu_role.base_role;
 
 	role.level = PT64_ROOT_4LEVEL;
 	role.direct = false;
@@ -4846,7 +4847,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->update_pte = ept_update_pte;
 	context->root_level = PT64_ROOT_4LEVEL;
 	context->direct_map = false;
-	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
+	context->mmu_role.base_role.word =
+		root_page_role.word & mmu_base_role_mask.word;
 	context->get_pdptr = kvm_pdptr_read;
 
 	update_permission_bitmask(vcpu, context, true);
@@ -5161,10 +5163,13 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 
 		local_flush = true;
 		while (npte--) {
+			unsigned int base_role =
+				vcpu->arch.mmu->mmu_role.base_role.word;
+
 			entry = *spte;
 			mmu_page_zap_pte(vcpu->kvm, sp, spte);
 			if (gentry &&
-			      !((sp->role.word ^ vcpu->arch.mmu->base_role.word)
+			      !((sp->role.word ^ base_role)
 			      & mmu_base_role_mask.word) && rmap_can_add(vcpu))
 				mmu_pte_write_new_pte(vcpu, sp, spte, &gentry);
 			if (need_remote_flush(entry, *spte))
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 29af40b9239f..79e0b0570dd1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9290,7 +9290,7 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 
 		kvm_mmu_unload(vcpu);
 		mmu->ept_ad = accessed_dirty;
-		mmu->base_role.ad_disabled = !accessed_dirty;
+		mmu->mmu_role.base_role.ad_disabled = !accessed_dirty;
 		vmcs12->ept_pointer = address;
 		/*
 		 * TODO: Check what's the correct approach in case
-- 
2.14.4

