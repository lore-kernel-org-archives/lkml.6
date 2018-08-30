Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23D3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2DF20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2DF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeH3USn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:18:43 -0400
Received: from foss.arm.com ([217.140.101.70]:44904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeH3USn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 204851BF7;
        Thu, 30 Aug 2018 09:15:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E650F3F557;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id C69BE1AE3A88; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 11/12] arm64: tlb: Avoid synchronous TLBIs when freeing page tables
Date:   Thu, 30 Aug 2018 17:15:45 +0100
Message-Id: <1535645747-9823-12-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By selecting HAVE_RCU_TABLE_INVALIDATE, we can rely on tlb_flush() being
called if we fail to batch table pages for freeing. This in turn allows
us to postpone walk-cache invalidation until tlb_finish_mmu(), which
avoids lots of unnecessary DSBs and means we can shoot down the ASID if
the range is large enough.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                |  1 +
 arch/arm64/include/asm/tlb.h      |  3 ---
 arch/arm64/include/asm/tlbflush.h | 11 -----------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 29e75b47becd..89059ee1eccc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -142,6 +142,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_RCU_TABLE_INVALIDATE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index b078fdec10d5..106fdc951b6e 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -54,7 +54,6 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	__flush_tlb_pgtable(tlb->mm, addr);
 	pgtable_page_dtor(pte);
 	tlb_remove_table(tlb, pte);
 }
@@ -63,7 +62,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	__flush_tlb_pgtable(tlb->mm, addr);
 	tlb_remove_table(tlb, virt_to_page(pmdp));
 }
 #endif
@@ -72,7 +70,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	__flush_tlb_pgtable(tlb->mm, addr);
 	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 37ccdb246b20..c98ed8871030 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -215,17 +215,6 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
  * Used to invalidate the TLB (walk caches) corresponding to intermediate page
  * table levels (pgd/pud/pmd).
  */
-static inline void __flush_tlb_pgtable(struct mm_struct *mm,
-				       unsigned long uaddr)
-{
-	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
-
-	dsb(ishst);
-	__tlbi(vae1is, addr);
-	__tlbi_user(vae1is, addr);
-	dsb(ish);
-}
-
 static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 {
 	unsigned long addr = __TLBI_VADDR(kaddr, 0);
-- 
2.1.4

