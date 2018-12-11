Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FF2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93A72081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93A72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeLKRMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:12:51 -0500
Received: from foss.arm.com ([217.140.101.70]:53570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeLKRMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:12:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35AB01684;
        Tue, 11 Dec 2018 09:12:12 -0800 (PST)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 695C13F6A8;
        Tue, 11 Dec 2018 09:12:10 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        anshuman.khandual@arm.com
Subject: [PATCH v10 3/8] KVM: arm/arm64: Introduce helpers to manipulate page table entries
Date:   Tue, 11 Dec 2018 17:10:36 +0000
Message-Id: <1544548241-6417-4-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
References: <1544548241-6417-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Punit Agrawal <punit.agrawal@arm.com>

Introduce helpers to abstract architectural handling of the conversion
of pfn to page table entries and marking a PMD page table entry as a
block entry.

The helpers are introduced in preparation for supporting PUD hugepages
at stage 2 - which are supported on arm64 but do not exist on arm.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/include/asm/kvm_mmu.h   |  5 +++++
 arch/arm64/include/asm/kvm_mmu.h |  5 +++++
 virt/kvm/arm/mmu.c               | 14 ++++++++------
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 1098ffc..e6eff8b 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -82,6 +82,11 @@ void kvm_clear_hyp_idmap(void);
 #define kvm_mk_pud(pmdp)	__pud(__pa(pmdp) | PMD_TYPE_TABLE)
 #define kvm_mk_pgd(pudp)	({ BUILD_BUG(); 0; })
 
+#define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
+#define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
+
+#define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
+
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= L_PTE_S2_RDWR;
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 65865736..13d4827 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -184,6 +184,11 @@ void kvm_clear_hyp_idmap(void);
 #define kvm_mk_pgd(pudp)					\
 	__pgd(__phys_to_pgd_val(__pa(pudp)) | PUD_TYPE_TABLE)
 
+#define kvm_pfn_pte(pfn, prot)		pfn_pte(pfn, prot)
+#define kvm_pfn_pmd(pfn, prot)		pfn_pmd(pfn, prot)
+
+#define kvm_pmd_mkhuge(pmd)		pmd_mkhuge(pmd)
+
 static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
 {
 	pte_val(pte) |= PTE_S2_RDWR;
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 6912529..fb5325f 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -607,7 +607,7 @@ static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
 	addr = start;
 	do {
 		pte = pte_offset_kernel(pmd, addr);
-		kvm_set_pte(pte, pfn_pte(pfn, prot));
+		kvm_set_pte(pte, kvm_pfn_pte(pfn, prot));
 		get_page(virt_to_page(pte));
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
@@ -1202,7 +1202,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
 	pfn = __phys_to_pfn(pa);
 
 	for (addr = guest_ipa; addr < end; addr += PAGE_SIZE) {
-		pte_t pte = pfn_pte(pfn, PAGE_S2_DEVICE);
+		pte_t pte = kvm_pfn_pte(pfn, PAGE_S2_DEVICE);
 
 		if (writable)
 			pte = kvm_s2pte_mkwrite(pte);
@@ -1611,8 +1611,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
 
 	if (vma_pagesize == PMD_SIZE) {
-		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
-		new_pmd = pmd_mkhuge(new_pmd);
+		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
+
+		new_pmd = kvm_pmd_mkhuge(new_pmd);
+
 		if (writable)
 			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
 
@@ -1621,7 +1623,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
 	} else {
-		pte_t new_pte = pfn_pte(pfn, mem_type);
+		pte_t new_pte = kvm_pfn_pte(pfn, mem_type);
 
 		if (writable) {
 			new_pte = kvm_s2pte_mkwrite(new_pte);
@@ -1878,7 +1880,7 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 	 * just like a translation fault and clean the cache to the PoC.
 	 */
 	clean_dcache_guest_page(pfn, PAGE_SIZE);
-	stage2_pte = pfn_pte(pfn, PAGE_S2);
+	stage2_pte = kvm_pfn_pte(pfn, PAGE_S2);
 	handle_hva_to_gpa(kvm, hva, end, &kvm_set_spte_handler, &stage2_pte);
 }
 
-- 
2.7.4

