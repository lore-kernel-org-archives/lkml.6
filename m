Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C13C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28B22089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28B22089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJICmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeJICmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:42:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E96E308427C;
        Mon,  8 Oct 2018 19:28:46 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.205.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2550661B96;
        Mon,  8 Oct 2018 19:28:43 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] x86/kvm/nVMX: introduce source data cache for kvm_init_shadow_ept_mmu()
Date:   Mon,  8 Oct 2018 21:28:11 +0200
Message-Id: <20181008192813.30624-8-vkuznets@redhat.com>
In-Reply-To: <20181008192813.30624-1-vkuznets@redhat.com>
References: <20181008192813.30624-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 08 Oct 2018 19:28:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU re-initialization is expensive, in particular,
update_permission_bitmask() and update_pkru_bitmask() are.

Cache the data used to setup shadow EPT MMU and avoid full re-init when
it is unchanged.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Sean Christopherson <sean.j.christopherson@intel.com>
---
Changes since v3:
- Use '!!' instead of '!= 0' when doing kvm_read_cr4_bits()
  [Sean Christopherson]
---
 arch/x86/include/asm/kvm_host.h | 14 +++++++++
 arch/x86/kvm/mmu.c              | 53 +++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fe50372e4889..d2a20670e689 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -283,7 +283,21 @@ union kvm_mmu_page_role {
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
index 3301973527aa..9d400a06c5f2 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4724,6 +4724,20 @@ static void paging32E_init_context(struct kvm_vcpu *vcpu,
 	paging64_init_context_common(vcpu, context, PT32E_ROOT_LEVEL);
 }
 
+static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu)
+{
+	union kvm_mmu_extended_role ext = {0};
+
+	ext.cr4_smep = !!kvm_read_cr4_bits(vcpu, X86_CR4_SMEP);
+	ext.cr4_smap = !!kvm_read_cr4_bits(vcpu, X86_CR4_SMAP);
+	ext.cr4_pse = !!is_pse(vcpu);
+	ext.cr4_pke = !!kvm_read_cr4_bits(vcpu, X86_CR4_PKE);
+
+	ext.valid = 1;
+
+	return ext;
+}
+
 static union kvm_mmu_page_role
 kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu)
 {
@@ -4830,19 +4844,23 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 
-static union kvm_mmu_page_role
-kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
+static union kvm_mmu_role
+kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
+				   bool execonly)
 {
-	union kvm_mmu_page_role role;
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
@@ -4851,10 +4869,16 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
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
@@ -4866,8 +4890,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
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

