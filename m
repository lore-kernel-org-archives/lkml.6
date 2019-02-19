Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E06BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C827820818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dott+BC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfBSKec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:34:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfBSKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d6CMV2hoQm5MnywciM5LER++5NYy5jN9jsJ9wqpDUgs=; b=Dott+BC9vmocj3ZSL9gYdJdgVe
        66SUpKrkfDQgyJ+nEIOavGswfH7k2Xm1jflWTAqPdDVu/+A06ahJOB9SY8gxPKR7beJgQdsruRuxx
        bYU6bPskXUJKMnPf+07rN0g8bYMjSVYSoTQ5GVv9k6kwBKA+Fxb0fNqJkOyHOJ49gkGJBg7J8EwY2
        rknIhm+LdjjKU9pE8avmJvJBOwB5FAEB8kvSPbLCXzsQesatdnK7lhVmkUx78vtzcVSqcOpV7/PMd
        wHfN5bgXY8N8l+WALh1F5dIOby8l3CubB0fsuVtv7davrXAZM9IwL/YrgFs692Di3Lz89AXqJSYaM
        9N7lCuHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hn-0006ZP-RV; Tue, 19 Feb 2019 10:32:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 677ED2852059D; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.443069009@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:31:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Subject: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic mmu_gather provides everything SH needs (range tracking and
cache coherency).

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sh/include/asm/pgalloc.h |    7 ++
 arch/sh/include/asm/tlb.h     |  130 ------------------------------------------
 2 files changed, 8 insertions(+), 129 deletions(-)

--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -72,6 +72,15 @@ do {							\
 	tlb_remove_page((tlb), (pte));			\
 } while (0)
 
+#if CONFIG_PGTABLE_LEVELS > 2
+#define __pmd_free_tlb(tlb, pmdp, addr)			\
+do {							\
+	struct page *page = virt_to_page(pmdp);		\
+	pgtable_pmd_page_dtor(page);			\
+	tlb_remove_page((tlb), page);			\
+} while (0);
+#endif
+
 static inline void check_pgt_cache(void)
 {
 	quicklist_trim(QUICK_PT, NULL, 25, 16);
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -11,131 +11,8 @@
 
 #ifdef CONFIG_MMU
 #include <linux/swap.h>
-#include <asm/pgalloc.h>
-#include <asm/tlbflush.h>
-#include <asm/mmu_context.h>
-
-/*
- * TLB handling.  This allows us to remove pages from the page
- * tables, and efficiently handle the TLB issues.
- */
-struct mmu_gather {
-	struct mm_struct	*mm;
-	unsigned int		fullmm;
-	unsigned long		start, end;
-};
 
-static inline void init_tlb_gather(struct mmu_gather *tlb)
-{
-	tlb->start = TASK_SIZE;
-	tlb->end = 0;
-
-	if (tlb->fullmm) {
-		tlb->start = 0;
-		tlb->end = TASK_SIZE;
-	}
-}
-
-static inline void
-arch_tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
-		unsigned long start, unsigned long end)
-{
-	tlb->mm = mm;
-	tlb->start = start;
-	tlb->end = end;
-	tlb->fullmm = !(start | (end+1));
-
-	init_tlb_gather(tlb);
-}
-
-static inline void
-arch_tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end, bool force)
-{
-	if (tlb->fullmm || force)
-		flush_tlb_mm(tlb->mm);
-
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
-}
-
-static inline void
-tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep, unsigned long address)
-{
-	if (tlb->start > address)
-		tlb->start = address;
-	if (tlb->end < address + PAGE_SIZE)
-		tlb->end = address + PAGE_SIZE;
-}
-
-#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
-	tlb_remove_tlb_entry(tlb, ptep, address)
-
-/*
- * In the case of tlb vma handling, we can optimise these away in the
- * case where we're doing a full MM flush.  When we're doing a munmap,
- * the vmas are adjusted to only cover the region to be torn down.
- */
-static inline void
-tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
-{
-	if (!tlb->fullmm)
-		flush_cache_range(vma, vma->vm_start, vma->vm_end);
-}
-
-static inline void
-tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
-{
-	if (!tlb->fullmm && tlb->end) {
-		flush_tlb_range(vma, tlb->start, tlb->end);
-		init_tlb_gather(tlb);
-	}
-}
-
-static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
-{
-}
-
-static inline void tlb_flush_mmu_free(struct mmu_gather *tlb)
-{
-}
-
-static inline void tlb_flush_mmu(struct mmu_gather *tlb)
-{
-}
-
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	free_page_and_swap_cache(page);
-	return false; /* avoid calling tlb_flush_mmu */
-}
-
-static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	__tlb_remove_page(tlb, page);
-}
-
-static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
-					  struct page *page, int page_size)
-{
-	return __tlb_remove_page(tlb, page);
-}
-
-static inline void tlb_remove_page_size(struct mmu_gather *tlb,
-					struct page *page, int page_size)
-{
-	return tlb_remove_page(tlb, page);
-}
-
-static inline void tlb_change_page_size(struct mmu_gather *tlb, unsigned int page_size)
-{
-}
-
-#define pte_free_tlb(tlb, ptep, addr)	pte_free((tlb)->mm, ptep)
-#define pmd_free_tlb(tlb, pmdp, addr)	pmd_free((tlb)->mm, pmdp)
-#define pud_free_tlb(tlb, pudp, addr)	pud_free((tlb)->mm, pudp)
-
-#define tlb_migrate_finish(mm)		do { } while (0)
+#include <asm-generic/tlb.h>
 
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SUPERH64)
 extern void tlb_wire_entry(struct vm_area_struct *, unsigned long, pte_t);
@@ -155,11 +32,6 @@ static inline void tlb_unwire_entry(void
 
 #else /* CONFIG_MMU */
 
-#define tlb_start_vma(tlb, vma)				do { } while (0)
-#define tlb_end_vma(tlb, vma)				do { } while (0)
-#define __tlb_remove_tlb_entry(tlb, pte, address)	do { } while (0)
-#define tlb_flush(tlb)					do { } while (0)
-
 #include <asm-generic/tlb.h>
 
 #endif /* CONFIG_MMU */


