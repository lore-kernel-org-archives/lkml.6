Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFC5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C98420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C98420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeLKRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:12:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53550 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbeLKRMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:12:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D6715AB;
        Tue, 11 Dec 2018 09:12:08 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5860B3F6A8;
        Tue, 11 Dec 2018 09:12:06 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        anshuman.khandual@arm.com
Subject: [PATCH v10 1/8] KVM: arm/arm64: Share common code in user_mem_abort()
Date:   Tue, 11 Dec 2018 17:10:34 +0000
Message-Id: <1544548241-6417-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punit.agrawal@arm.com>

The code for operations such as marking the pfn as dirty, and
dcache/icache maintenance during stage 2 fault handling is duplicated
between normal pages and PMD hugepages.

Instead of creating another copy of the operations when we introduce
PUD hugepages, let's share them across the different pagesizes.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/mmu.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 5eca48b..5959520 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1475,7 +1475,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  unsigned long fault_status)
 {
 	int ret;
-	bool write_fault, exec_fault, writable, hugetlb = false, force_pte = false;
+	bool write_fault, exec_fault, writable, force_pte = false;
 	unsigned long mmu_seq;
 	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
 	struct kvm *kvm = vcpu->kvm;
@@ -1484,7 +1484,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	kvm_pfn_t pfn;
 	pgprot_t mem_type = PAGE_S2;
 	bool logging_active = memslot_is_logging(memslot);
-	unsigned long flags = 0;
+	unsigned long vma_pagesize, flags = 0;
 
 	write_fault = kvm_is_write_fault(vcpu);
 	exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
@@ -1504,11 +1504,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		return -EFAULT;
 	}
 
-	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
-		hugetlb = true;
+	vma_pagesize = vma_kernel_pagesize(vma);
+	if (vma_pagesize == PMD_SIZE && !logging_active) {
 		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
 	} else {
 		/*
+		 * Fallback to PTE if it's not one of the Stage 2
+		 * supported hugepage sizes
+		 */
+		vma_pagesize = PAGE_SIZE;
+
+		/*
 		 * Pages belonging to memslots that don't have the same
 		 * alignment for userspace and IPA cannot be mapped using
 		 * block descriptors even if the pages belong to a THP for
@@ -1573,23 +1579,33 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (mmu_notifier_retry(kvm, mmu_seq))
 		goto out_unlock;
 
-	if (!hugetlb && !force_pte)
-		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
+	if (vma_pagesize == PAGE_SIZE && !force_pte) {
+		/*
+		 * Only PMD_SIZE transparent hugepages(THP) are
+		 * currently supported. This code will need to be
+		 * updated to support other THP sizes.
+		 */
+		if (transparent_hugepage_adjust(&pfn, &fault_ipa))
+			vma_pagesize = PMD_SIZE;
+	}
 
-	if (hugetlb) {
+	if (writable)
+		kvm_set_pfn_dirty(pfn);
+
+	if (fault_status != FSC_PERM)
+		clean_dcache_guest_page(pfn, vma_pagesize);
+
+	if (exec_fault)
+		invalidate_icache_guest_page(pfn, vma_pagesize);
+
+	if (vma_pagesize == PMD_SIZE) {
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
@@ -1602,16 +1618,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
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
2.7.4

