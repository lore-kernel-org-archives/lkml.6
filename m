Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C41C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7ED4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ED4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbeK3TRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:17:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:17444 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbeK3TRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:17:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="105480402"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 30 Nov 2018 00:09:24 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id B8D36580213;
        Fri, 30 Nov 2018 00:09:22 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 09/11] KVM: VMX: Update the EPT leaf entry indicated with the SPP enable bit.
Date:   Fri, 30 Nov 2018 16:09:07 +0800
Message-Id: <09004f3e9fbe0a74223bf23f1bbe980398fa854b.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the sub-page write permission VM-execution control is set,
treatment of write accesses to guest-physical accesses
depends on the state of the accumulated write-access bit (position 1)
and sub-page permission bit (position 61) in the EPT leaf paging-structure.

Software will update the EPT leaf entry sub-page permission bit while
kvm_set_subpage. If the EPT write-access bit set to 0 and the SPP bit
set to 1 in the leaf EPT paging-structure entry that maps a 4KB page,
then the hardware will look up a VMM-managed Sub-Page Permission Table
(SPPT), which will also be prepared by setup kvm_set_subpage.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 arch/x86/kvm/mmu.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index b1773c6..d512125 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1668,6 +1668,87 @@ int kvm_arch_write_log_dirty(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static bool __rmap_open_subpage_bit(struct kvm *kvm,
+				    struct kvm_rmap_head *rmap_head)
+{
+	struct rmap_iterator iter;
+	bool flush = false;
+	u64 *sptep;
+	u64 spte;
+
+	for_each_rmap_spte(rmap_head, &iter, sptep) {
+		/*
+		 * SPP works only when the page is unwritable
+		 * and SPP bit is set
+		 */
+		flush |= spte_write_protect(sptep, false);
+		spte = *sptep | PT_SPP_MASK;
+		flush |= mmu_spte_update(sptep, spte);
+	}
+
+	return flush;
+}
+
+static int kvm_mmu_open_subpage_write_protect(struct kvm *kvm,
+					      struct kvm_memory_slot *slot,
+					      gfn_t gfn)
+{
+	struct kvm_rmap_head *rmap_head;
+	bool flush = false;
+
+	/*
+	 * we only support spp in a normal 4K level 1 page frame
+	 * If it a huge page, we drop it.
+	 */
+	rmap_head = __gfn_to_rmap(gfn, PT_PAGE_TABLE_LEVEL, slot);
+
+	if (!rmap_head->val)
+		return -EFAULT;
+
+	flush |= __rmap_open_subpage_bit(kvm, rmap_head);
+
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
+
+	return 0;
+}
+
+static bool __rmap_clear_subpage_bit(struct kvm *kvm,
+				     struct kvm_rmap_head *rmap_head)
+{
+	struct rmap_iterator iter;
+	bool flush = false;
+	u64 *sptep;
+	u64 spte;
+
+	for_each_rmap_spte(rmap_head, &iter, sptep) {
+		spte = (*sptep & ~PT_SPP_MASK) | PT_WRITABLE_MASK;
+		flush |= mmu_spte_update(sptep, spte);
+	}
+
+	return flush;
+}
+
+static int kvm_mmu_clear_subpage_write_protect(struct kvm *kvm,
+					       struct kvm_memory_slot *slot,
+					       gfn_t gfn)
+{
+	struct kvm_rmap_head *rmap_head;
+	bool flush = false;
+
+	rmap_head = __gfn_to_rmap(gfn, PT_PAGE_TABLE_LEVEL, slot);
+
+	if (!rmap_head->val)
+		return -EFAULT;
+
+	flush |= __rmap_clear_subpage_bit(kvm, rmap_head);
+
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
+
+	return 0;
+}
+
 bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 				    struct kvm_memory_slot *slot, u64 gfn)
 {
@@ -4175,12 +4256,31 @@ int kvm_mmu_set_subpages(struct kvm *kvm, struct kvm_subpage *spp_info)
 	int npages = spp_info->npages;
 	struct kvm_memory_slot *slot;
 	u32 *wp_map;
+	int ret;
 	int i;
 
 	for (i = 0; i < npages; i++, gfn++) {
 		slot = gfn_to_memslot(kvm, gfn);
 		if (!slot)
 			return -EFAULT;
+
+		/*
+		 * open SPP bit in EPT leaf entry to write protect the
+		 * sub-pages in corresponding page
+		 */
+		if (access != (u32)((1ULL << 32) - 1))
+			ret = kvm_mmu_open_subpage_write_protect(kvm,
+					slot, gfn);
+		else
+			ret = kvm_mmu_clear_subpage_write_protect(kvm,
+					slot, gfn);
+
+		if (ret) {
+			pr_info("SPP ,didn't get the gfn:%llx from EPT leaf level1\n"
+				"Current we didn't support huge page on SPP\n"
+				"Please try to disable the huge page\n", gfn);
+			return -EFAULT;
+		}
 		wp_map = gfn_to_subpage_wp_info(slot, gfn);
 		*wp_map = access;
 	}
-- 
2.7.4

