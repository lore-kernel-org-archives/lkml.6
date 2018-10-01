Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0099C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70756213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70756213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJAWdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:33:46 -0400
Received: from foss.arm.com ([217.140.101.70]:51806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbeJAWdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:33:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0B751596;
        Mon,  1 Oct 2018 08:55:19 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D7553F5D3;
        Mon,  1 Oct 2018 08:55:19 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Punit Agrawal <punit.agrawal@arm.com>, marc.zyngier@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH v8 2/9] KVM: arm/arm64: Share common code in user_mem_abort()
Date:   Mon,  1 Oct 2018 16:54:36 +0100
Message-Id: <20181001155443.23032-3-punit.agrawal@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181001155443.23032-1-punit.agrawal@arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
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
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/mmu.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index c23a1b323aad..5b76ee204000 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1490,7 +1490,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	kvm_pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool logging_active = memslot_is_logging(memslot);
-	unsigned long flags = 0;
+	unsigned long vma_pagesize, flags = 0;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
@@ -1510,10 +1510,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
+	vma_pagesize = vma_kernel_pagesize(vma);
+	if (vma_pagesize == PMD_SIZE && !logging_active) {
 		hugetlb = true;
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
+		/*
+		 * Fallback to PTE if it's not one of the Stage 2
+		 * supported hugepage sizes
+		 */
+		vma_pagesize = PAGE_SIZE;
+
 		/*
 		 * Pages belonging to memslots that don't have the same
 		 * alignment for userspace and IPA cannot be mapped using
@@ -1579,23 +1586,34 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
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
 
-	if (hugetlb) {
+	if (fault_status != FSC_PERM)
+		clean_dcache_guest_page(pfn, vma_pagesize);
+
+	if (exec_fault)
+		invalidate_icache_guest_page(pfn, vma_pagesize);
+
+	if (hugetlb && vma_pagesize == PMD_SIZE) {
 		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
 		new_pmd = pmd_mkhuge(new_pmd);
-		if (writable) {
+		if (writable)
 			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
-			kvm_set_pfn_dirty(pfn);
-		}
-
-		if (fault_status != FSC_PERM)
-			clean_dcache_guest_page(pfn, PMD_SIZE);
 
 		if (exec_fault) {
 			new_pmd = kvm_s2pmd_mkexec(new_pmd);
-			invalidate_icache_guest_page(pfn, PMD_SIZE);
 		} else if (fault_status == FSC_PERM) {
 			/* Preserve execute if XN was already cleared */
 			if (stage2_is_exec(kvm, fault_ipa))
@@ -1608,16 +1626,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 		if (writable) {
 			new_pte = kvm_s2pte_mkwrite(new_pte);
-			kvm_set_pfn_dirty(pfn);
 			mark_page_dirty(kvm, gfn);
 		}
 
-		if (fault_status != FSC_PERM)
-			clean_dcache_guest_page(pfn, PAGE_SIZE);
-
 		if (exec_fault) {
 			new_pte = kvm_s2pte_mkexec(new_pte);
-			invalidate_icache_guest_page(pfn, PAGE_SIZE);
 		} else if (fault_status == FSC_PERM) {
 			/* Preserve execute if XN was already cleared */
 			if (stage2_is_exec(kvm, fault_ipa))
-- 
2.18.0

