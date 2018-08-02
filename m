Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36FCC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F022150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F022150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeHBLwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:52:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbeHBLwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:52:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEC7C7DAC9;
        Thu,  2 Aug 2018 10:01:46 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED6C213ED6A;
        Thu,  2 Aug 2018 10:01:45 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 8/9] x86/kvm/mmu: check if tdp/shadow MMU reconfiguration is needed
Date:   Thu,  2 Aug 2018 12:01:31 +0200
Message-Id: <20180802100132.5249-9-vkuznets@redhat.com>
In-Reply-To: <20180802100132.5249-1-vkuznets@redhat.com>
References: <20180802100132.5249-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 10:01:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 10:01:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU reconfiguration in init_kvm_tdp_mmu()/kvm_init_shadow_mmu() can be
avoided if the source data used to configure it didn't change; enhance
kvm_mmu_scache with the required fields and consolidate common code in
kvm_calc_mmu_role_common().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/mmu.c              | 86 ++++++++++++++++++++++++-----------------
 2 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d44668dcf655..f3f5cacb5727 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -283,10 +283,12 @@ union kvm_mmu_scache {
 	struct {
 		unsigned int valid:1;
 		unsigned int execonly:1;
+		unsigned int cr0_pg:1;
 		unsigned int cr4_pse:1;
 		unsigned int cr4_pke:1;
 		unsigned int cr4_smap:1;
 		unsigned int cr4_smep:1;
+		unsigned int cr4_la57:1;
 	};
 };
 
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c46f875bf937..c621d9892a37 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4679,34 +4679,40 @@ static void paging32E_init_context(struct kvm_vcpu *vcpu,
 }
 
 static union kvm_mmu_role
-kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu)
+kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu, bool mmu_init)
 {
 	union kvm_mmu_role role = {0};
 
 	role.base_role.access = ACC_ALL;
+	role.base_role.nxe = !!is_nx(vcpu);
+	role.base_role.cr4_pae = !!is_pae(vcpu);
 	role.base_role.cr0_wp = is_write_protection(vcpu);
+	role.base_role.smm = is_smm(vcpu);
+	role.base_role.guest_mode = is_guest_mode(vcpu);
 
+	if (!mmu_init)
+		return role;
+
+	role.scache.cr0_pg = !!is_paging(vcpu);
 	role.scache.cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
 	role.scache.cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
 	role.scache.cr4_pse = !!is_pse(vcpu);
 	role.scache.cr4_pke = kvm_read_cr4_bits(vcpu, X86_CR4_PKE) != 0;
+	role.scache.cr4_la57 = kvm_read_cr4_bits(vcpu, X86_CR4_LA57) != 0;
 
 	role.scache.valid = 1;
 
 	return role;
 }
 
-static union kvm_mmu_page_role
-kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
+static union kvm_mmu_role
+kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu, bool mmu_init)
 {
-	union kvm_mmu_page_role role = {0};
+	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, mmu_init);
 
-	role.guest_mode = is_guest_mode(vcpu);
-	role.smm = is_smm(vcpu);
-	role.ad_disabled = (shadow_accessed_mask == 0);
-	role.level = kvm_x86_ops->get_tdp_level(vcpu);
-	role.direct = true;
-	role.access = ACC_ALL;
+	role.base_role.ad_disabled = (shadow_accessed_mask == 0);
+	role.base_role.level = kvm_x86_ops->get_tdp_level(vcpu);
+	role.base_role.direct = true;
 
 	return role;
 }
@@ -4714,9 +4720,14 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
 static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
+	union kvm_mmu_role new_role =
+		kvm_calc_tdp_mmu_root_page_role(vcpu, true);
 
-	context->mmu_role.base_role.word = mmu_base_role_mask.word &
-				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
+	new_role.base_role.word &= mmu_base_role_mask.word;
+	if (new_role.as_u64 == context->mmu_role.as_u64)
+		return;
+
+	context->mmu_role.as_u64 = new_role.as_u64;
 	context->page_fault = tdp_page_fault;
 	context->sync_page = nonpaging_sync_page;
 	context->invlpg = nonpaging_invlpg;
@@ -4756,29 +4767,23 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 	reset_tdp_shadow_zero_bits_mask(vcpu, context);
 }
 
-static union kvm_mmu_page_role
-kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu)
-{
-	union kvm_mmu_page_role role = {0};
-	bool smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP);
-	bool smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP);
-
-	role.nxe = is_nx(vcpu);
-	role.cr4_pae = !!is_pae(vcpu);
-	role.cr0_wp  = is_write_protection(vcpu);
-	role.smep_andnot_wp = smep && !is_write_protection(vcpu);
-	role.smap_andnot_wp = smap && !is_write_protection(vcpu);
-	role.guest_mode = is_guest_mode(vcpu);
-	role.smm = is_smm(vcpu);
-	role.direct = !is_paging(vcpu);
-	role.access = ACC_ALL;
+static union kvm_mmu_role
+kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool mmu_init)
+{
+	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, mmu_init);
+
+	role.base_role.smep_andnot_wp = role.scache.cr4_smep &&
+		!is_write_protection(vcpu);
+	role.base_role.smap_andnot_wp = role.scache.cr4_smap &&
+		!is_write_protection(vcpu);
+	role.base_role.direct = !is_paging(vcpu);
 
 	if (!is_long_mode(vcpu))
-		role.level = PT32E_ROOT_LEVEL;
+		role.base_role.level = PT32E_ROOT_LEVEL;
 	else if (is_la57_mode(vcpu))
-		role.level = PT64_ROOT_5LEVEL;
+		role.base_role.level = PT64_ROOT_5LEVEL;
 	else
-		role.level = PT64_ROOT_4LEVEL;
+		role.base_role.level = PT64_ROOT_4LEVEL;
 
 	return role;
 }
@@ -4786,6 +4791,12 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu)
 void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
+	union kvm_mmu_role new_role =
+		kvm_calc_shadow_mmu_root_page_role(vcpu, true);
+
+	new_role.base_role.word &= mmu_base_role_mask.word;
+	if (new_role.as_u64 == context->mmu_role.as_u64)
+		return;
 
 	if (!is_paging(vcpu))
 		nonpaging_init_context(vcpu, context);
@@ -4796,8 +4807,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 	else
 		paging32_init_context(vcpu, context);
 
-	context->mmu_role.base_role.word = mmu_base_role_mask.word &
-				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
+	context->mmu_role.as_u64 = new_role.as_u64;
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
@@ -4806,7 +4816,7 @@ static union kvm_mmu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 				   bool execonly)
 {
-	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu);
+	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, true);
 
 	role.base_role.level = PT64_ROOT_4LEVEL;
 	role.base_role.direct = false;
@@ -4931,10 +4941,14 @@ EXPORT_SYMBOL_GPL(kvm_init_mmu);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu)
 {
+	union kvm_mmu_role role;
+
 	if (tdp_enabled)
-		return kvm_calc_tdp_mmu_root_page_role(vcpu);
+		role = kvm_calc_tdp_mmu_root_page_role(vcpu, false);
 	else
-		return kvm_calc_shadow_mmu_root_page_role(vcpu);
+		role = kvm_calc_shadow_mmu_root_page_role(vcpu, false);
+
+	return role.base_role;
 }
 
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
-- 
2.14.4

