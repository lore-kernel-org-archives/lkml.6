Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89037C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7D621521
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbeHBLwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:52:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbeHBLwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:52:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB48E819700E;
        Thu,  2 Aug 2018 10:01:43 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B71F2213ED6A;
        Thu,  2 Aug 2018 10:01:42 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 6/9] x86/kvm/mmu: make space for source data caching in struct kvm_mmu
Date:   Thu,  2 Aug 2018 12:01:29 +0200
Message-Id: <20180802100132.5249-7-vkuznets@redhat.com>
In-Reply-To: <20180802100132.5249-1-vkuznets@redhat.com>
References: <20180802100132.5249-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:43 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
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
index c5f116f9783d..830166ab4d59 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -272,6 +272,18 @@ union kvm_mmu_page_role {
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
@@ -359,7 +371,7 @@ struct kvm_mmu {
 	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 			   u64 *spte, const void *pte);
 	hpa_t root_hpa;
-	union kvm_mmu_page_role base_role;
+	union kvm_mmu_role mmu_role;
 	u8 root_level;
 	u8 shadow_root_level;
 	u8 ept_ad;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 85ec027299d6..c538e47e471b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2331,7 +2331,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	int collisions = 0;
 	LIST_HEAD(invalid_list);
 
-	role = vcpu->arch.mmu->base_role;
+	role = vcpu->arch.mmu->mmu_role.base_role;
 	role.level = level;
 	role.direct = direct;
 	if (role.direct)
@@ -4377,7 +4377,8 @@ static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
 void
 reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu, struct kvm_mmu *context)
 {
-	bool uses_nx = context->nx || context->base_role.smep_andnot_wp;
+	bool uses_nx = context->nx ||
+		context->mmu_role.base_role.smep_andnot_wp;
 	struct rsvd_bits_validate *shadow_zero_check;
 	int i;
 
@@ -4696,7 +4697,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
 
-	context->base_role.word = mmu_base_role_mask.word &
+	context->mmu_role.base_role.word = mmu_base_role_mask.word &
 				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
 	context->page_fault = tdp_page_fault;
 	context->sync_page = nonpaging_sync_page;
@@ -4777,7 +4778,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 	else
 		paging32_init_context(vcpu, context);
 
-	context->base_role.word = mmu_base_role_mask.word &
+	context->mmu_role.base_role.word = mmu_base_role_mask.word &
 				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
@@ -4786,7 +4787,7 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 static union kvm_mmu_page_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
 {
-	union kvm_mmu_page_role role = vcpu->arch.mmu->base_role;
+	union kvm_mmu_page_role role = vcpu->arch.mmu->mmu_role.base_role;
 
 	role.level = PT64_ROOT_4LEVEL;
 	role.direct = false;
@@ -4816,7 +4817,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->update_pte = ept_update_pte;
 	context->root_level = PT64_ROOT_4LEVEL;
 	context->direct_map = false;
-	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
+	context->mmu_role.base_role.word =
+		root_page_role.word & mmu_base_role_mask.word;
 	context->get_pdptr = kvm_pdptr_read;
 
 	update_permission_bitmask(vcpu, context, true);
@@ -5131,10 +5133,13 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 
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
index 494148818b8d..0d41116bef1f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9028,7 +9028,7 @@ static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 
 		kvm_mmu_unload(vcpu);
 		mmu->ept_ad = accessed_dirty;
-		mmu->base_role.ad_disabled = !accessed_dirty;
+		mmu->mmu_role.base_role.ad_disabled = !accessed_dirty;
 		vmcs12->ept_pointer = address;
 		/*
 		 * TODO: Check what's the correct approach in case
-- 
2.14.4

