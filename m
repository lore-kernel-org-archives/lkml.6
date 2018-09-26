Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCD8ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E51B214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RbjHnQ7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E51B214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeIZSHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeIZSHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D2BrPEaVEi1W4wGOOeArDPZr4Vg22Yb2gdLEGz+CpyM=; b=RbjHnQ7OgBnwdK0sek7gQJzL6N
        YSug9OJPzHq9v8E80JyL0xTSMI2hFdE00yF7RdGR6Kw9n1KrKWaa7Bi5k7uM7nXn/9DM0a3cQiB5a
        NKJfYEN6yUHrhDjzH7XSX/HBww10CFzefeDhhDbXl6WfiZfi61HtgIdZEYJCbeCkejQoZ/Ai40a5k
        TNsvUT+pIrSh8+WhZrB0SvEIUbJ35GLz7sz/0tj0H2XEmhfiBhrHqzVP6aAIqDwWAwzh9fYgHjWth
        R3Ut8Um9j0O7kPtcVWIXBrfzQmmeflRWJUEoKy32/ihSZdqlic76HxtBZizLg05jFgBkH1zR4c+0m
        z0B2TnbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oc-0007U5-Bt; Wed, 26 Sep 2018 11:54:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8AD99206F180C; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114800.770817616@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 05/18] asm-generic/tlb: Provide generic tlb_flush
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a generic tlb_flush() implementation that relies on
flush_tlb_range(). This is a little awkward because flush_tlb_range()
assumes a VMA for range invalidation, but we no longer have one.

Audit of all flush_tlb_range() implementations shows only vma->vm_mm
and vma->vm_flags are used, and of the latter only VM_EXEC (I-TLB
invalidates) and VM_HUGETLB (large TLB invalidate) are used.

Therefore, track VM_EXEC and VM_HUGETLB in two more bits, and create a
'fake' VMA.

This allows architectures that have a reasonably efficient
flush_tlb_range() to not require any additional effort.

Cc: Nick Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/tlb.h   |    1 
 arch/powerpc/include/asm/tlb.h |    1 
 arch/riscv/include/asm/tlb.h   |    1 
 arch/x86/include/asm/tlb.h     |    1 
 include/asm-generic/tlb.h      |   80 +++++++++++++++++++++++++++++++++++------
 5 files changed, 74 insertions(+), 10 deletions(-)

--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -27,6 +27,7 @@ static inline void __tlb_remove_table(vo
 	free_page_and_swap_cache((struct page *)_table);
 }
 
+#define tlb_flush tlb_flush
 static void tlb_flush(struct mmu_gather *tlb);
 
 #include <asm-generic/tlb.h>
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -28,6 +28,7 @@
 #define tlb_end_vma(tlb, vma)	do { } while (0)
 #define __tlb_remove_tlb_entry	__tlb_remove_tlb_entry
 
+#define tlb_flush tlb_flush
 extern void tlb_flush(struct mmu_gather *tlb);
 
 /* Get the generic bits... */
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -18,6 +18,7 @@ struct mmu_gather;
 
 static void tlb_flush(struct mmu_gather *tlb);
 
+#define tlb_flush tlb_flush
 #include <asm-generic/tlb.h>
 
 static inline void tlb_flush(struct mmu_gather *tlb)
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -6,6 +6,7 @@
 #define tlb_end_vma(tlb, vma) do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
+#define tlb_flush tlb_flush
 static inline void tlb_flush(struct mmu_gather *tlb);
 
 #include <asm-generic/tlb.h>
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -241,6 +241,12 @@ struct mmu_gather {
 	unsigned int		cleared_puds : 1;
 	unsigned int		cleared_p4ds : 1;
 
+	/*
+	 * tracks VM_EXEC | VM_HUGETLB in tlb_start_vma
+	 */
+	unsigned int		vma_exec : 1;
+	unsigned int		vma_huge : 1;
+
 	unsigned int		batch_count;
 
 	struct mmu_gather_batch *active;
@@ -282,7 +288,35 @@ static inline void __tlb_reset_range(str
 	tlb->cleared_pmds = 0;
 	tlb->cleared_puds = 0;
 	tlb->cleared_p4ds = 0;
+	/*
+	 * Do not reset mmu_gather::vma_* fields here, we do not
+	 * call into tlb_start_vma() again to set them if there is an
+	 * intermediate flush.
+	 */
+}
+
+#ifndef tlb_flush
+
+#if defined(tlb_start_vma) || defined(tlb_end_vma)
+#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
+#endif
+
+#define tlb_flush tlb_flush
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	if (tlb->fullmm || tlb->need_flush_all) {
+		flush_tlb_mm(tlb->mm);
+	} else {
+		struct vm_area_struct vma = {
+			.vm_mm = tlb->mm,
+			.vm_flags = (tlb->vma_exec ? VM_EXEC    : 0) |
+				    (tlb->vma_huge ? VM_HUGETLB : 0),
+		};
+
+		flush_tlb_range(&vma, tlb->start, tlb->end);
+	}
 }
+#endif
 
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
@@ -353,19 +387,45 @@ static inline unsigned long tlb_get_unma
  * the vmas are adjusted to only cover the region to be torn down.
  */
 #ifndef tlb_start_vma
-#define tlb_start_vma(tlb, vma)						\
-do {									\
-	if (!tlb->fullmm)						\
-		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\
-} while (0)
+#define tlb_start_vma tlb_start_vma
+static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+	if (tlb->fullmm)
+		return;
+
+	/*
+	 * flush_tlb_range() implementations that look at VM_HUGETLB (tile,
+	 * mips-4k) flush only large pages.
+	 *
+	 * flush_tlb_range() implementations that flush I-TLB also flush D-TLB
+	 * (tile, xtensa, arm), so it's ok to just add VM_EXEC to an existing
+	 * range.
+	 *
+	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
+	 * these values the batch is empty.
+	 */
+	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
+	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
+
+	flush_cache_range(vma, vma->vm_start, vma->vm_end);
+}
 #endif
 
 #ifndef tlb_end_vma
-#define tlb_end_vma(tlb, vma)						\
-do {									\
-	if (!tlb->fullmm)						\
-		tlb_flush_mmu_tlbonly(tlb);				\
-} while (0)
+#define tlb_end_vma tlb_end_vma
+static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+	if (tlb->fullmm)
+		return;
+
+	/*
+	 * Do a TLB flush and reset the range at VMA boundaries; this avoids
+	 * the ranges growing with the unused space between consecutive VMAs,
+	 * but also the mmu_gather::vma_* flags from tlb_start_vma() rely on
+	 * this.
+	 */
+	tlb_flush_mmu_tlbonly(tlb);
+}
 #endif
 
 #ifndef __tlb_remove_tlb_entry


