Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27CFC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8953520673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8953520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbeK3TRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:17:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:64069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeK3TRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:17:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:08:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="117325021"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2018 00:08:40 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id 958CA580213;
        Fri, 30 Nov 2018 00:08:38 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 04/11] KVM: VMX: Introduce the SPPTP and SPP page table.
Date:   Fri, 30 Nov 2018 16:08:23 +0800
Message-Id: <d516baf528eda5cad23b4a106f6638c988b322eb.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPPT has 4-level paging structure that is similar to EPT
except L1E.

The sub-page permission table is referenced via a 64-bit control field
called Sub-Page Permission Table Pointer (SPPTP) which contains a
4K-aligned physical address. the index and encoding for this VMCS field
is defined 0x2030 at this time

The format of SPPTP is shown in below figure

-------------------------------------------------------------------------
| Bit    | Contents                                                     |
|        |                                                              |
:-----------------------------------------------------------------------|
| 11:0   | Reserved (0)                                                 |
| N-1:12 | Physical address of 4KB aligned SPPT L4E Table               |
| 51:N   | Reserved (0)                                                 |
| 63:52  | Reserved (0)                                                 |
------------------------------------------------------------------------|

Note: N is the physical address width supported by the processor.

This patch introduced the Spp paging structures, which root page will
created at kvm mmu page initialization. and free at mmu page free.

Same as EPT page table, We initialized the SPPT,
and write the SPPT point into VMCS field.
Also we added a mmu page role type spp to distinguish it is a spp page
or a EPT page.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: He Chen <he.chen@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  4 +++-
 arch/x86/kvm/mmu.c              | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55e51ff..46312b9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -270,7 +270,8 @@ union kvm_mmu_page_role {
 		unsigned smap_andnot_wp:1;
 		unsigned ad_disabled:1;
 		unsigned guest_mode:1;
-		unsigned :6;
+		unsigned spp:1;
+		unsigned reserved:5;
 
 		/*
 		 * This is left at the top of the word so that
@@ -397,6 +398,7 @@ struct kvm_mmu {
 	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 			   u64 *spte, const void *pte);
 	hpa_t root_hpa;
+	hpa_t sppt_root;
 	union kvm_mmu_role mmu_role;
 	u8 root_level;
 	u8 shadow_root_level;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cf5f572..d1f1fe1 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2366,6 +2366,29 @@ static void clear_sp_write_flooding_count(u64 *spte)
 	__clear_sp_write_flooding_count(sp);
 }
 
+static struct kvm_mmu_page *kvm_mmu_get_spp_page(struct kvm_vcpu *vcpu,
+						 gfn_t gfn,
+						 unsigned int level)
+
+{
+	struct kvm_mmu_page *sp;
+	union kvm_mmu_page_role role;
+
+	role = vcpu->arch.mmu->mmu_role.base;
+	role.level = level;
+	role.direct = true;
+	role.spp = true;
+
+	sp = kvm_mmu_alloc_page(vcpu, true);
+	sp->gfn = gfn;
+	sp->role = role;
+	hlist_add_head(&sp->hash_link,
+		       &vcpu->kvm->arch.mmu_page_hash
+		       [kvm_page_table_hashfn(gfn)]);
+	clear_page(sp->spt);
+	return sp;
+}
+
 static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gfn_t gfn,
 					     gva_t gaddr,
@@ -3509,6 +3532,9 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		    (mmu->root_level >= PT64_ROOT_4LEVEL || mmu->direct_map)) {
 			mmu_free_root_page(vcpu->kvm, &mmu->root_hpa,
 					   &invalid_list);
+			mmu_free_root_page(vcpu->kvm, &mmu->sppt_root,
+					   &invalid_list);
+
 		} else {
 			for (i = 0; i < 4; ++i)
 				if (mmu->pae_root[i] != 0)
@@ -3538,7 +3564,7 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
 
 static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu_page *sp;
+	struct kvm_mmu_page *sp, *spp_sp;
 	unsigned i;
 
 	if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
@@ -3549,9 +3575,13 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		}
 		sp = kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
+		spp_sp = kvm_mmu_get_spp_page(vcpu, 0,
+				vcpu->arch.mmu->shadow_root_level);
 		++sp->root_count;
+		++spp_sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = __pa(sp->spt);
+		vcpu->arch.mmu->sppt_root = __pa(spp_sp->spt);
 	} else if (vcpu->arch.mmu->shadow_root_level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
 			hpa_t root = vcpu->arch.mmu->pae_root[i];
@@ -4986,6 +5016,7 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu, bool reset_roots)
 		uint i;
 
 		vcpu->arch.mmu->root_hpa = INVALID_PAGE;
+		vcpu->arch.mmu->sppt_root = INVALID_PAGE;
 
 		for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
 			vcpu->arch.mmu->prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
-- 
2.7.4

