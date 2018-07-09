Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311D8C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1CC20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1CC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754632AbeGIOlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:41:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754517AbeGIOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:41:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E6C4ED1;
        Mon,  9 Jul 2018 07:41:34 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3248B3F589;
        Mon,  9 Jul 2018 07:41:34 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Punit Agrawal <punit.agrawal@arm.com>,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, will.deacon@arm.com
Subject: [PATCH v5 1/7] KVM: arm/arm64: Share common code in user_mem_abort()
Date:   Mon,  9 Jul 2018 15:41:18 +0100
Message-Id: <20180709144124.29164-1-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709143835.28971-1-punit.agrawal@arm.com>
References: <20180709143835.28971-1-punit.agrawal@arm.com>
X-ARM-No-Footer: FoSSMail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code for operations such as marking the pfn as dirty, and
dcache/icache maintenance during stage 2 fault handling is duplicated
between normal pages and PMD hugepages.

Instead of creating another copy of the operations when we introduce
PUD hugepages, let's share them across the different pagesizes.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 67 ++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 1d90d79706bd..ea3d992e4fb7 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1422,7 +1422,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  unsigned long fault_status)
 {
 	int ret;
-	bool write_fault, exec_fault, writable, hugetlb = false, force_pte = false;
+	bool write_fault, writable, hugetlb = false, force_pte = false;
+	bool exec_fault, needs_exec;
 	unsigned long mmu_seq;
 	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
 	struct kvm *kvm = vcpu->kvm;
@@ -1431,7 +1432,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	kvm_pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool logging_active = memslot_is_logging(memslot);
-	unsigned long flags = 0;
+	unsigned long vma_pagesize, flags = 0;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
@@ -1451,7 +1452,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
+	vma_pagesize = vma_kernel_pagesize(vma);
+	if (vma_pagesize == PMD_SIZE && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
@@ -1520,28 +1522,45 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
 
-	if (!hugetlb && !force_pte)
+	if (!hugetlb && !force_pte) {
+		/*
+		 * Only PMD_SIZE transparent hugepages(THP) are
+		 * currently supported. This code will need to be
+		 * updated to support other THP sizes.
+		 */
 		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
+		if (hugetlb)
+			vma_pagesize = PMD_SIZE;
+	}
+
+	if (writable)
+		kvm_set_pfn_dirty(pfn);
+
+	if (fault_status != FSC_PERM)
+		clean_dcache_guest_page(pfn, vma_pagesize);
 
-	if (hugetlb) {
+	if (exec_fault)
+		invalidate_icache_guest_page(pfn, vma_pagesize);
+
+	/*
+	 * If we took an execution fault we have made the
+	 * icache/dcache coherent above and should now let the s2
+	 * mapping be executable.
+	 *
+	 * Write faults (!exec_fault && FSC_PERM) are orthogonal to
+	 * execute permissions, and we preserve whatever we have.
+	 */
+	needs_exec = exec_fault ||
+		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
+
+	if (hugetlb && vma_pagesize == PMD_SIZE) {
 		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
 		new_pmd = pmd_mkhuge(new_pmd);
-		if (writable) {
+		if (writable)
 			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
-			kvm_set_pfn_dirty(pfn);
-		}
 
-		if (fault_status != FSC_PERM)
-			clean_dcache_guest_page(pfn, PMD_SIZE);
-
-		if (exec_fault) {
+		if (needs_exec)
 			new_pmd = kvm_s2pmd_mkexec(new_pmd);
-			invalidate_icache_guest_page(pfn, PMD_SIZE);
-		} else if (fault_status == FSC_PERM) {
-			/* Preserve execute if XN was already cleared */
-			if (stage2_is_exec(kvm, fault_ipa))
-				new_pmd = kvm_s2pmd_mkexec(new_pmd);
-		}
 
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
@@ -1549,21 +1568,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 		if (writable) {
 			new_pte = kvm_s2pte_mkwrite(new_pte);
-			kvm_set_pfn_dirty(pfn);
 			mark_page_dirty(kvm, gfn);
 		}
 
-		if (fault_status != FSC_PERM)
-			clean_dcache_guest_page(pfn, PAGE_SIZE);
-
-		if (exec_fault) {
+		if (needs_exec)
 			new_pte = kvm_s2pte_mkexec(new_pte);
-			invalidate_icache_guest_page(pfn, PAGE_SIZE);
-		} else if (fault_status == FSC_PERM) {
-			/* Preserve execute if XN was already cleared */
-			if (stage2_is_exec(kvm, fault_ipa))
-				new_pte = kvm_s2pte_mkexec(new_pte);
-		}
 
 		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, flags);
 	}
-- 
2.17.1

