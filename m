Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF09DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953972089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953972089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeJICmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeJICmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA90B1152B;
        Mon,  8 Oct 2018 19:28:49 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.205.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 250CC5D9D6;
        Mon,  8 Oct 2018 19:28:46 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] x86/kvm/mmu: check if tdp/shadow MMU reconfiguration is needed
Date:   Mon,  8 Oct 2018 21:28:12 +0200
Message-Id: <20181008192813.30624-9-vkuznets@redhat.com>
In-Reply-To: <20181008192813.30624-1-vkuznets@redhat.com>
References: <20181008192813.30624-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 08 Oct 2018 19:28:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU reconfiguration in init_kvm_tdp_mmu()/kvm_init_shadow_mmu() can be
avoided if the source data used to configure it didn't change; enhance
MMU extended role with the required fields and consolidate common code in
kvm_calc_mmu_role_common().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
Changes since v3:
- Use '!!' instead of '!= 0' for ext.cr4_la57 [Sean Christopherson]
---
 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/mmu.c              | 95 +++++++++++++++++++++------------
 2 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d2a20670e689..82e0638d78fa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -293,10 +293,12 @@ union kvm_mmu_extended_role {
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
index 9d400a06c5f2..9ed046fbab5e 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4728,27 +4728,46 @@ static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu)
 {
 	union kvm_mmu_extended_role ext = {0};
 
+	ext.cr0_pg = !!is_paging(vcpu);
 	ext.cr4_smep = !!kvm_read_cr4_bits(vcpu, X86_CR4_SMEP);
 	ext.cr4_smap = !!kvm_read_cr4_bits(vcpu, X86_CR4_SMAP);
 	ext.cr4_pse = !!is_pse(vcpu);
 	ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
+	ext.cr4_la57 = !!kvm_read_cr4_bits(vcpu, X86_CR4_LA57);
 
 	ext.valid = 1;
 
 	return ext;
 }
 
-static union kvm_mmu_page_role
-kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
+static union kvm_mmu_role kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu,
+						   bool base_only)
+{
+	union kvm_mmu_role role = {0};
+
+	role.base.access = ACC_ALL;
+	role.base.nxe = !!is_nx(vcpu);
+	role.base.cr4_pae = !!is_pae(vcpu);
+	role.base.cr0_wp = is_write_protection(vcpu);
+	role.base.smm = is_smm(vcpu);
+	role.base.guest_mode = is_guest_mode(vcpu);
+
+	if (base_only)
+		return role;
+
+	role.ext = kvm_calc_mmu_role_ext(vcpu);
+
+	return role;
+}
+
+static union kvm_mmu_role
+kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
 {
-	union kvm_mmu_page_role role = {0};
+	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, base_only);
 
-	role.guest_mode = is_guest_mode(vcpu);
-	role.smm = is_smm(vcpu);
-	role.ad_disabled = (shadow_accessed_mask == 0);
-	role.level = kvm_x86_ops->get_tdp_level(vcpu);
-	role.direct = true;
-	role.access = ACC_ALL;
+	role.base.ad_disabled = (shadow_accessed_mask == 0);
+	role.base.level = kvm_x86_ops->get_tdp_level(vcpu);
+	role.base.direct = true;
 
 	return role;
 }
@@ -4756,9 +4775,14 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
 static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
+	union kvm_mmu_role new_role =
+		kvm_calc_tdp_mmu_root_page_role(vcpu, false);
 
-	context->mmu_role.base.word = mmu_base_role_mask.word &
-				  kvm_calc_tdp_mmu_root_page_role(vcpu).word;
+	new_role.base.word &= mmu_base_role_mask.word;
+	if (new_role.as_u64 == context->mmu_role.as_u64)
+		return;
+
+	context->mmu_role.as_u64 = new_role.as_u64;
 	context->page_fault = tdp_page_fault;
 	context->sync_page = nonpaging_sync_page;
 	context->invlpg = nonpaging_invlpg;
@@ -4798,29 +4822,23 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
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
+kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
+{
+	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, base_only);
+
+	role.base.smep_andnot_wp = role.ext.cr4_smep &&
+		!is_write_protection(vcpu);
+	role.base.smap_andnot_wp = role.ext.cr4_smap &&
+		!is_write_protection(vcpu);
+	role.base.direct = !is_paging(vcpu);
 
 	if (!is_long_mode(vcpu))
-		role.level = PT32E_ROOT_LEVEL;
+		role.base.level = PT32E_ROOT_LEVEL;
 	else if (is_la57_mode(vcpu))
-		role.level = PT64_ROOT_5LEVEL;
+		role.base.level = PT64_ROOT_5LEVEL;
 	else
-		role.level = PT64_ROOT_4LEVEL;
+		role.base.level = PT64_ROOT_4LEVEL;
 
 	return role;
 }
@@ -4828,6 +4846,12 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu)
 void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
+	union kvm_mmu_role new_role =
+		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
+
+	new_role.base.word &= mmu_base_role_mask.word;
+	if (new_role.as_u64 == context->mmu_role.as_u64)
+		return;
 
 	if (!is_paging(vcpu))
 		nonpaging_init_context(vcpu, context);
@@ -4838,8 +4862,7 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 	else
 		paging32_init_context(vcpu, context);
 
-	context->mmu_role.base.word = mmu_base_role_mask.word &
-				  kvm_calc_shadow_mmu_root_page_role(vcpu).word;
+	context->mmu_role.as_u64 = new_role.as_u64;
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
@@ -4977,10 +5000,14 @@ EXPORT_SYMBOL_GPL(kvm_init_mmu);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu)
 {
+	union kvm_mmu_role role;
+
 	if (tdp_enabled)
-		return kvm_calc_tdp_mmu_root_page_role(vcpu);
+		role = kvm_calc_tdp_mmu_root_page_role(vcpu, true);
 	else
-		return kvm_calc_shadow_mmu_root_page_role(vcpu);
+		role = kvm_calc_shadow_mmu_root_page_role(vcpu, true);
+
+	return role.base;
 }
 
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
-- 
2.17.1

