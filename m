Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD70BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B54214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R6gqY0PU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B54214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeIZSIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:08:18 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46454 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbeIZSHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Qgx3kgv+AkSn1Y+HQ6cCIZsGaoQ/+n1Kc3v/8+oaveQ=; b=R6gqY0PUNyz8/Q1IQLhFD6pzfg
        ZzAVro2Rzf6Fxb7S2/jaIQxsBn8Il+h0HEqraoUApRfgmiooHOzdlGmc1Fi4lqMgayiHfJcfP5sFZ
        WEwR0YSJ93dQuy1FmT0UDCNzU1FhCTU3Dr+8gJA+KHYx8jjfmQ812ftI16ucc3WYj5kWSGLModRkB
        yjwD4vIC8gpKvHTvmUp7koDxFwa8YarZYScCooNK4gV+nkDEOSN2qtz+sR4AU+EEKiBgPwvOwGXXd
        DvI6tmRd7jgqPDJ5EHuB2nholMPNTZlqE7heUVxIg/8v0/45QQ4fRGCEYMWMJWcP8pjNvq/XLvdw7
        wU7Dn30w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oc-0007U9-Ce; Wed, 26 Sep 2018 11:54:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9F819206F1816; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114801.094298493@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 11/18] um/tlb: Convert to generic mmu_gather
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic mmu_gather provides the simple flush_tlb_range() based range
tracking mmu_gather UM needs.

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/include/asm/tlb.h |  156 ----------------------------------------------
 1 file changed, 2 insertions(+), 154 deletions(-)

--- a/arch/um/include/asm/tlb.h
+++ b/arch/um/include/asm/tlb.h
@@ -2,160 +2,8 @@
 #ifndef __UM_TLB_H
 #define __UM_TLB_H
 
-#include <linux/pagemap.h>
-#include <linux/swap.h>
-#include <asm/percpu.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-
-#define tlb_start_vma(tlb, vma) do { } while (0)
-#define tlb_end_vma(tlb, vma) do { } while (0)
-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
-
-/* struct mmu_gather is an opaque type used by the mm code for passing around
- * any data needed by arch specific code for tlb_remove_page.
- */
-struct mmu_gather {
-	struct mm_struct	*mm;
-	unsigned int		need_flush; /* Really unmapped some ptes? */
-	unsigned long		start;
-	unsigned long		end;
-	unsigned int		fullmm; /* non-zero means full mm flush */
-};
-
-static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
-					  unsigned long address)
-{
-	if (tlb->start > address)
-		tlb->start = address;
-	if (tlb->end < address + PAGE_SIZE)
-		tlb->end = address + PAGE_SIZE;
-}
-
-static inline void init_tlb_gather(struct mmu_gather *tlb)
-{
-	tlb->need_flush = 0;
-
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
-extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-			       unsigned long end);
-
-static inline void
-tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
-{
-	flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end);
-}
-
-static inline void
-tlb_flush_mmu_free(struct mmu_gather *tlb)
-{
-	init_tlb_gather(tlb);
-}
-
-static inline void
-tlb_flush_mmu(struct mmu_gather *tlb)
-{
-	if (!tlb->need_flush)
-		return;
-
-	tlb_flush_mmu_tlbonly(tlb);
-	tlb_flush_mmu_free(tlb);
-}
-
-/* arch_tlb_finish_mmu
- *	Called at the end of the shootdown operation to free up any resources
- *	that were required.
- */
-static inline void
-arch_tlb_finish_mmu(struct mmu_gather *tlb,
-		unsigned long start, unsigned long end, bool force)
-{
-	if (force) {
-		tlb->start = start;
-		tlb->end = end;
-		tlb->need_flush = 1;
-	}
-	tlb_flush_mmu(tlb);
-
-	/* keep the page table cache within bounds */
-	check_pgt_cache();
-}
-
-/* tlb_remove_page
- *	Must perform the equivalent to __free_pte(pte_get_and_clear(ptep)),
- *	while handling the additional races in SMP caused by other CPUs
- *	caching valid mappings in their TLBs.
- */
-static inline int __tlb_remove_page(struct mmu_gather *tlb, struct page *page)
-{
-	tlb->need_flush = 1;
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
-/**
- * tlb_remove_tlb_entry - remember a pte unmapping for later tlb invalidation.
- *
- * Record the fact that pte's were really umapped in ->need_flush, so we can
- * later optimise away the tlb invalidate.   This helps when userspace is
- * unmapping already-unmapped pages, which happens quite a lot.
- */
-#define tlb_remove_tlb_entry(tlb, ptep, address)		\
-	do {							\
-		tlb->need_flush = 1;				\
-		__tlb_remove_tlb_entry(tlb, ptep, address);	\
-	} while (0)
-
-#define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
-	tlb_remove_tlb_entry(tlb, ptep, address)
-
-static inline void tlb_change_page_size(struct mmu_gather *tlb, unsigned int page_size)
-{
-}
-
-#define pte_free_tlb(tlb, ptep, addr) __pte_free_tlb(tlb, ptep, addr)
-
-#define pud_free_tlb(tlb, pudp, addr) __pud_free_tlb(tlb, pudp, addr)
-
-#define pmd_free_tlb(tlb, pmdp, addr) __pmd_free_tlb(tlb, pmdp, addr)
-
-#define tlb_migrate_finish(mm) do {} while (0)
+#include <asm-generic/cacheflush.h>
+#include <asm-generic/tlb.h>
 
 #endif


