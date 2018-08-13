Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD6C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0421721
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A0421721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbeHMNZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:25:57 -0400
Received: from foss.arm.com ([217.140.101.70]:56802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbeHMNZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:25:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52A8615A2;
        Mon, 13 Aug 2018 03:44:15 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBBE73F5D0;
        Mon, 13 Aug 2018 03:44:14 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, marc.zyngier@arm.com,
        christoffer.dall@arm.com, stable@vger.kernel.org
Subject: [PATCH v3 1/2] KVM: arm/arm64: Skip updating PMD entry if no change
Date:   Mon, 13 Aug 2018 11:43:50 +0100
Message-Id: <20180813104351.24595-2-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180813104351.24595-1-punit.agrawal@arm.com>
References: <20180813104351.24595-1-punit.agrawal@arm.com>
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contention on updating a PMD entry by a large number of vcpus can lead
to duplicate work when handling stage 2 page faults. As the page table
update follows the break-before-make requirement of the architecture,
it can lead to repeated refaults due to clearing the entry and
flushing the tlbs.

This problem is more likely when -

* there are large number of vcpus
* the mapping is large block mapping

such as when using PMD hugepages (512MB) with 64k pages.

Fix this by skipping the page table update if there is no change in
the entry being updated.

Fixes: ad361f093c1e ("KVM: ARM: Support hugetlbfs backed huge pages")
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: stable@vger.kernel.org
---
 virt/kvm/arm/mmu.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 1d90d79706bd..2bb0b5dba412 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1015,19 +1015,35 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 	pmd = stage2_get_pmd(kvm, cache, addr);
 	VM_BUG_ON(!pmd);
 
-	/*
-	 * Mapping in huge pages should only happen through a fault.  If a
-	 * page is merged into a transparent huge page, the individual
-	 * subpages of that huge page should be unmapped through MMU
-	 * notifiers before we get here.
-	 *
-	 * Merging of CompoundPages is not supported; they should become
-	 * splitting first, unmapped, merged, and mapped back in on-demand.
-	 */
-	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
-
 	old_pmd = *pmd;
 	if (pmd_present(old_pmd)) {
+		/*
+		 * Multiple vcpus faulting on the same PMD entry, can
+		 * lead to them sequentially updating the PMD with the
+		 * same value. Following the break-before-make
+		 * (pmd_clear() followed by tlb_flush()) process can
+		 * hinder forward progress due to refaults generated
+		 * on missing translations.
+		 *
+		 * Skip updating the page table if the entry is
+		 * unchanged.
+		 */
+		if (pmd_val(old_pmd) == pmd_val(*new_pmd))
+			return 0;
+
+		/*
+		 * Mapping in huge pages should only happen through a
+		 * fault.  If a page is merged into a transparent huge
+		 * page, the individual subpages of that huge page
+		 * should be unmapped through MMU notifiers before we
+		 * get here.
+		 *
+		 * Merging of CompoundPages is not supported; they
+		 * should become splitting first, unmapped, merged,
+		 * and mapped back in on-demand.
+		 */
+		VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));
+
 		pmd_clear(pmd);
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	} else {
-- 
2.18.0

