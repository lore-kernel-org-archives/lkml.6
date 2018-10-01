Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28154C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED266208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED266208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbeJAU6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbeJAU6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24BD1C058CB6;
        Mon,  1 Oct 2018 14:20:52 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98A9C6E51C;
        Mon,  1 Oct 2018 14:20:49 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] x86/kvm/nVMX: introduce source data cache for kvm_init_shadow_ept_mmu()
Date:   Mon,  1 Oct 2018 16:20:08 +0200
Message-Id: <20181001142010.21132-8-vkuznets@redhat.com>
In-Reply-To: <20181001142010.21132-1-vkuznets@redhat.com>
References: <20181001142010.21132-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 01 Oct 2018 14:20:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU re-initialization is expensive, in particular,
update_permission_bitmask() and update_pkru_bitmask() are.

Cache the data used to setup shadow EPT MMU and avoid full re-init when
it is unchanged.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v2:
- Preserve mmu_role.base in kvm_calc_shadow_ept_root_page_role()
  [Sean Christopherson]
- Rename kvm_calc_mmu_role_common() -> kvm_calc_mmu_role_ext() to
  support the change.
---
 arch/x86/include/asm/kvm_host.h | 14 +++++++++
 arch/x86/kvm/mmu.c              | 53 +++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1821b0215230..87ddaa1579e7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -274,7 +274,21 @@ union kvm_mmu_page_role {
 };
 
 union kvm_mmu_extended_role {
+/*
+ * This structure complements kvm_mmu_page_role caching everything needed for
+ * MMU configuration. If nothing in both these structures changed, MMU
+ * re-configuration can be skipped. @valid bit is set on first usage so we don't
+ * treat all-zero structure as valid data.
+ */
 	u32 word;
+	struct {
+		unsigned int valid:1;
+		unsigned int execonly:1;
+		unsigned int cr4_pse:1;
+		unsigned int cr4_pke:1;
+		unsigned int cr4_smap:1;
+		unsigned int cr4_smep:1;
+	};
 };
 
 union kvm_mmu_role {
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 60c916286bf4..d303f722d671 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4708,6 +4708,20 @@ static void paging32E_init_context(struct kvm_vcpu *vcpu,
 	paging64_init_context_common(vcpu, context, PT32E_ROOT_LEVEL);
 }
 
+static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu)
+{
+	union kvm_mmu_extended_role ext = {0};
+
+	ext.cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
+	ext.cr4_smap = kvm_read_cr4_bits(vcpu, X86_CR4_SMAP) != 0;
+	ext.cr4_pse = !!is_pse(vcpu);
+	ext.cr4_pke = kvm_read_cr4_bits(vcpu, X86_CR4_PKE) != 0;
+
+	ext.valid = 1;
+
+	return ext;
+}
+
 static union kvm_mmu_page_role
 kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
 {
@@ -4814,19 +4828,23 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 
-static union kvm_mmu_page_role
-kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
+static union kvm_mmu_role
+kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
+				   bool execonly)
 {
-	union kvm_mmu_page_role role = vcpu->arch.mmu->mmu_role.base;
+	union kvm_mmu_role role;
 
-	/* Role is inherited from root_mmu */
-	role.word = vcpu->arch.root_mmu.base_role.word;
+	/* Base role is inherited from root_mmu */
+	role.base.word = vcpu->arch.root_mmu.mmu_role.base.word;
+	role.ext = kvm_calc_mmu_role_ext(vcpu);
 
-	role.level = PT64_ROOT_4LEVEL;
-	role.direct = false;
-	role.ad_disabled = !accessed_dirty;
-	role.guest_mode = true;
-	role.access = ACC_ALL;
+	role.base.level = PT64_ROOT_4LEVEL;
+	role.base.direct = false;
+	role.base.ad_disabled = !accessed_dirty;
+	role.base.guest_mode = true;
+	role.base.access = ACC_ALL;
+
+	role.ext.execonly = execonly;
 
 	return role;
 }
@@ -4835,10 +4853,16 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     bool accessed_dirty, gpa_t new_eptp)
 {
 	struct kvm_mmu *context = vcpu->arch.mmu;
-	union kvm_mmu_page_role root_page_role =
-		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty);
+	union kvm_mmu_role new_role =
+		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
+						   execonly);
+
+	__kvm_mmu_new_cr3(vcpu, new_eptp, new_role.base, false);
+
+	new_role.base.word &= mmu_base_role_mask.word;
+	if (new_role.as_u64 == context->mmu_role.as_u64)
+		return;
 
-	__kvm_mmu_new_cr3(vcpu, new_eptp, root_page_role, false);
 	context->shadow_root_level = PT64_ROOT_4LEVEL;
 
 	context->nx = true;
@@ -4850,8 +4874,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->update_pte = ept_update_pte;
 	context->root_level = PT64_ROOT_4LEVEL;
 	context->direct_map = false;
-	context->mmu_role.base.word =
-		root_page_role.word & mmu_base_role_mask.word;
+	context->mmu_role.as_u64 = new_role.as_u64;
 
 	update_permission_bitmask(vcpu, context, true);
 	update_pkru_bitmask(vcpu, context, true);
-- 
2.17.1

