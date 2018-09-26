Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2468CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C12A2152E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C12A2152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeIZWrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:47:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50026 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIZWrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:47:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4093B1B55;
        Wed, 26 Sep 2018 09:33:52 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC3F43F5B3;
        Wed, 26 Sep 2018 09:33:49 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        suzuki.poulose@arm.com, will.deacon@arm.com, dave.martin@arm.com,
        peter.maydell@linaro.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/18] kvm: arm64: Prepare for dynamic stage2 page table layout
Date:   Wed, 26 Sep 2018 17:32:45 +0100
Message-Id: <20180926163258.20218-10-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926163258.20218-1-suzuki.poulose@arm.com>
References: <20180926163258.20218-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our stage2 page table helpers are statically defined based
on the fixed IPA of 40bits and the host page size. As we are
about to add support for configurable IPA size for VMs, we
need to make the page table checks for each VM. This patch
prepares the stage2 helpers to make the transition to a VM
dependent table layout easier. Instead of statically defining
the table helpers based on the page table levels, we now
check the page table levels in the helpers to do the right
thing. In effect, it simply converts the macros to static
inline functions.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kvm_mmu.h              |  12 +-
 arch/arm64/include/asm/stage2_pgtable-nopmd.h |  42 -----
 arch/arm64/include/asm/stage2_pgtable-nopud.h |  39 ----
 arch/arm64/include/asm/stage2_pgtable.h       | 173 ++++++++++++++----
 4 files changed, 139 insertions(+), 127 deletions(-)
 delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopmd.h
 delete mode 100644 arch/arm64/include/asm/stage2_pgtable-nopud.h

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 3a032066e52c..7342d2c51773 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -147,6 +147,12 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
 #define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - _AC(1, ULL))
 #define kvm_vttbr_baddr_mask(kvm)	VTTBR_BADDR_MASK
 
+static inline bool kvm_page_empty(void *ptr)
+{
+	struct page *ptr_page = virt_to_page(ptr);
+	return page_count(ptr_page) == 1;
+}
+
 #include <asm/stage2_pgtable.h>
 
 int create_hyp_mappings(void *from, void *to, pgprot_t prot);
@@ -241,12 +247,6 @@ static inline bool kvm_s2pmd_exec(pmd_t *pmdp)
 	return !(READ_ONCE(pmd_val(*pmdp)) & PMD_S2_XN);
 }
 
-static inline bool kvm_page_empty(void *ptr)
-{
-	struct page *ptr_page = virt_to_page(ptr);
-	return page_count(ptr_page) == 1;
-}
-
 #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
 
 #ifdef __PAGETABLE_PMD_FOLDED
diff --git a/arch/arm64/include/asm/stage2_pgtable-nopmd.h b/arch/arm64/include/asm/stage2_pgtable-nopmd.h
deleted file mode 100644
index 0280dedbf75f..000000000000
--- a/arch/arm64/include/asm/stage2_pgtable-nopmd.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * Copyright (C) 2016 - ARM Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __ARM64_S2_PGTABLE_NOPMD_H_
-#define __ARM64_S2_PGTABLE_NOPMD_H_
-
-#include <asm/stage2_pgtable-nopud.h>
-
-#define __S2_PGTABLE_PMD_FOLDED
-
-#define S2_PMD_SHIFT		S2_PUD_SHIFT
-#define S2_PTRS_PER_PMD		1
-#define S2_PMD_SIZE		(1UL << S2_PMD_SHIFT)
-#define S2_PMD_MASK		(~(S2_PMD_SIZE-1))
-
-#define stage2_pud_none(kvm, pud)		(0)
-#define stage2_pud_present(kvm, pud)		(1)
-#define stage2_pud_clear(kvm, pud)		do { } while (0)
-#define stage2_pud_populate(kvm, pud, pmd)	do { } while (0)
-#define stage2_pmd_offset(kvm, pud, address)	((pmd_t *)(pud))
-
-#define stage2_pmd_free(kvm, pmd)		do { } while (0)
-
-#define stage2_pmd_addr_end(kvm, addr, end)	(end)
-
-#define stage2_pud_huge(kvm, pud)		(0)
-#define stage2_pmd_table_empty(kvm, pmdp)	(0)
-
-#endif
diff --git a/arch/arm64/include/asm/stage2_pgtable-nopud.h b/arch/arm64/include/asm/stage2_pgtable-nopud.h
deleted file mode 100644
index cd6304e203be..000000000000
--- a/arch/arm64/include/asm/stage2_pgtable-nopud.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Copyright (C) 2016 - ARM Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __ARM64_S2_PGTABLE_NOPUD_H_
-#define __ARM64_S2_PGTABLE_NOPUD_H_
-
-#define __S2_PGTABLE_PUD_FOLDED
-
-#define S2_PUD_SHIFT		S2_PGDIR_SHIFT
-#define S2_PTRS_PER_PUD		1
-#define S2_PUD_SIZE		(_AC(1, UL) << S2_PUD_SHIFT)
-#define S2_PUD_MASK		(~(S2_PUD_SIZE-1))
-
-#define stage2_pgd_none(kvm, pgd)		(0)
-#define stage2_pgd_present(kvm, pgd)		(1)
-#define stage2_pgd_clear(kvm, pgd)		do { } while (0)
-#define stage2_pgd_populate(kvm, pgd, pud)	do { } while (0)
-
-#define stage2_pud_offset(kvm, pgd, address)	((pud_t *)(pgd))
-
-#define stage2_pud_free(kvm, x)			do { } while (0)
-
-#define stage2_pud_addr_end(kvm, addr, end)	(end)
-#define stage2_pud_table_empty(kvm, pmdp)	(0)
-
-#endif
diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 11891612be14..384f9e982cba 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -19,6 +19,7 @@
 #ifndef __ARM64_S2_PGTABLE_H_
 #define __ARM64_S2_PGTABLE_H_
 
+#include <linux/hugetlb.h>
 #include <asm/pgtable.h>
 
 /*
@@ -71,71 +72,163 @@
  */
 #define kvm_mmu_cache_min_pages(kvm)	(STAGE2_PGTABLE_LEVELS - 1)
 
-
-#if STAGE2_PGTABLE_LEVELS > 3
-
+/* Stage2 PUD definitions when the level is present */
+#define STAGE2_PGTABLE_HAS_PUD		(STAGE2_PGTABLE_LEVELS > 3)
 #define S2_PUD_SHIFT			ARM64_HW_PGTABLE_LEVEL_SHIFT(1)
 #define S2_PUD_SIZE			(1UL << S2_PUD_SHIFT)
 #define S2_PUD_MASK			(~(S2_PUD_SIZE - 1))
 
-#define stage2_pgd_none(kvm, pgd)		pgd_none(pgd)
-#define stage2_pgd_clear(kvm, pgd)		pgd_clear(pgd)
-#define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
-#define stage2_pgd_populate(kvm, pgd, pud)	pgd_populate(NULL, pgd, pud)
-#define stage2_pud_offset(kvm, pgd, address)	pud_offset(pgd, address)
-#define stage2_pud_free(kvm, pud)		pud_free(NULL, pud)
-
-#define stage2_pud_table_empty(kvm, pudp)	kvm_page_empty(pudp)
+static inline bool stage2_pgd_none(struct kvm *kvm, pgd_t pgd)
+{
+	if (STAGE2_PGTABLE_HAS_PUD)
+		return pgd_none(pgd);
+	else
+		return 0;
+}
+
+static inline void stage2_pgd_clear(struct kvm *kvm, pgd_t *pgdp)
+{
+	if (STAGE2_PGTABLE_HAS_PUD)
+		pgd_clear(pgdp);
+}
+
+static inline bool stage2_pgd_present(struct kvm *kvm, pgd_t pgd)
+{
+	if (STAGE2_PGTABLE_HAS_PUD)
+		return pgd_present(pgd);
+	else
+		return 1;
+}
+
+static inline void stage2_pgd_populate(struct kvm *kvm, pgd_t *pgd, pud_t *pud)
+{
+	if (STAGE2_PGTABLE_HAS_PUD)
+		pgd_populate(NULL, pgd, pud);
+}
+
+static inline pud_t *stage2_pud_offset(struct kvm *kvm,
+				       pgd_t *pgd, unsigned long address)
+{
+	if (STAGE2_PGTABLE_HAS_PUD)
+		return pud_offset(pgd, address);
+	else
+		return (pud_t *)pgd;
+}
+
+static inline void stage2_pud_free(struct kvm *kvm, pud_t *pud)
+{
+	if (STAGE2_PGTABLE_HAS_PUD)
+		pud_free(NULL, pud);
+}
+
+static inline bool stage2_pud_table_empty(struct kvm *kvm, pud_t *pudp)
+{
+	if (STAGE2_PGTABLE_HAS_PUD)
+		return kvm_page_empty(pudp);
+	else
+		return false;
+}
 
 static inline phys_addr_t
 stage2_pud_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
 {
-	phys_addr_t boundary = (addr + S2_PUD_SIZE) & S2_PUD_MASK;
+	if (STAGE2_PGTABLE_HAS_PUD) {
+		phys_addr_t boundary = (addr + S2_PUD_SIZE) & S2_PUD_MASK;
 
-	return (boundary - 1 < end - 1) ? boundary : end;
+		return (boundary - 1 < end - 1) ? boundary : end;
+	} else {
+		return end;
+	}
 }
 
-#endif		/* STAGE2_PGTABLE_LEVELS > 3 */
-
-
-#if STAGE2_PGTABLE_LEVELS > 2
-
+/* Stage2 PMD definitions when the level is present */
+#define STAGE2_PGTABLE_HAS_PMD		(STAGE2_PGTABLE_LEVELS > 2)
 #define S2_PMD_SHIFT			ARM64_HW_PGTABLE_LEVEL_SHIFT(2)
 #define S2_PMD_SIZE			(1UL << S2_PMD_SHIFT)
 #define S2_PMD_MASK			(~(S2_PMD_SIZE - 1))
 
-#define stage2_pud_none(kvm, pud)		pud_none(pud)
-#define stage2_pud_clear(kvm, pud)		pud_clear(pud)
-#define stage2_pud_present(kvm, pud)		pud_present(pud)
-#define stage2_pud_populate(kvm, pud, pmd)	pud_populate(NULL, pud, pmd)
-#define stage2_pmd_offset(kvm, pud, address)	pmd_offset(pud, address)
-#define stage2_pmd_free(kvm, pmd)		pmd_free(NULL, pmd)
-
-#define stage2_pud_huge(kvm, pud)		pud_huge(pud)
-#define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
+static inline bool stage2_pud_none(struct kvm *kvm, pud_t pud)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		return pud_none(pud);
+	else
+		return 0;
+}
+
+static inline void stage2_pud_clear(struct kvm *kvm, pud_t *pud)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		pud_clear(pud);
+}
+
+static inline bool stage2_pud_present(struct kvm *kvm, pud_t pud)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		return pud_present(pud);
+	else
+		return 1;
+}
+
+static inline void stage2_pud_populate(struct kvm *kvm, pud_t *pud, pmd_t *pmd)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		pud_populate(NULL, pud, pmd);
+}
+
+static inline pmd_t *stage2_pmd_offset(struct kvm *kvm,
+				       pud_t *pud, unsigned long address)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		return pmd_offset(pud, address);
+	else
+		return (pmd_t *)pud;
+}
+
+static inline void stage2_pmd_free(struct kvm *kvm, pmd_t *pmd)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		pmd_free(NULL, pmd);
+}
+
+static inline bool stage2_pud_huge(struct kvm *kvm, pud_t pud)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		return pud_huge(pud);
+	else
+		return 0;
+}
+
+static inline bool stage2_pmd_table_empty(struct kvm *kvm, pmd_t *pmdp)
+{
+	if (STAGE2_PGTABLE_HAS_PMD)
+		return kvm_page_empty(pmdp);
+	else
+		return 0;
+}
 
 static inline phys_addr_t
 stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
 {
-	phys_addr_t boundary = (addr + S2_PMD_SIZE) & S2_PMD_MASK;
+	if (STAGE2_PGTABLE_HAS_PMD) {
+		phys_addr_t boundary = (addr + S2_PMD_SIZE) & S2_PMD_MASK;
 
-	return (boundary - 1 < end - 1) ? boundary : end;
+		return (boundary - 1 < end - 1) ? boundary : end;
+	} else {
+		return end;
+	}
 }
 
-#endif		/* STAGE2_PGTABLE_LEVELS > 2 */
-
-#define stage2_pte_table_empty(kvm, ptep)	kvm_page_empty(ptep)
-
-#if STAGE2_PGTABLE_LEVELS == 2
-#include <asm/stage2_pgtable-nopmd.h>
-#elif STAGE2_PGTABLE_LEVELS == 3
-#include <asm/stage2_pgtable-nopud.h>
-#endif
+static inline bool stage2_pte_table_empty(struct kvm *kvm, pte_t *ptep)
+{
+	return kvm_page_empty(ptep);
+}
 
 #define stage2_pgd_size(kvm)	(PTRS_PER_S2_PGD * sizeof(pgd_t))
 
-#define stage2_pgd_index(kvm, addr) \
-	(((addr) >> S2_PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1))
+static inline unsigned long stage2_pgd_index(struct kvm *kvm, phys_addr_t addr)
+{
+	return (((addr) >> S2_PGDIR_SHIFT) & (PTRS_PER_S2_PGD - 1));
+}
 
 static inline phys_addr_t
 stage2_pgd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
-- 
2.19.0

