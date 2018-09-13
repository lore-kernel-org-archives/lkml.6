Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24762C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C91206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DBoSpxOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C91206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeIMOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:38:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54574 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeIMOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SUb/FsNdk3D3aNn2XSnRfO/6PJM/aNspqX3A3hmuSZY=; b=DBoSpxOJeBYKM8THNd2Pn+ZGVo
        QXGQCcqFqsS2V25y1REJiIeW0hQnSVmWOs8ALiLx0r18Q2rSvEURQo0KC+0sogpPFfhejx088CS8w
        LGjl1GQzmBTcDiIzgLrEf3dpFWaMufxmCLZ2Hlhssd8jcnLTu7WbboMyQE0QK5DYYCgBpOOwWsv2R
        pEUJQfhPLgCftm2hgZTsZ92WSd65A0RHe86ylnG91s4tq9p+iwysxE6u7krLJzk/usV0hqsRVUTgG
        5ik8aqqbn/ytwPE9wLaNOfloKGARJQ+JYoFU8v4IAXZS1n2v9Hup5nVNLgmmgvTq7sTY3NN/7JtY2
        +SZD1o9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Nw1-0000yo-Ub; Thu, 13 Sep 2018 09:29:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4B0C620587E52; Thu, 13 Sep 2018 11:29:10 +0200 (CEST)
Message-ID: <20180913092812.132208484@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Sep 2018 11:21:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Subject: [RFC][PATCH 05/11] asm-generic/tlb: Provide generic tlb_flush
References: <20180913092110.817204997@infradead.org>
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

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
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
+			.vm_flags = tlb->vma_exec ? VM_EXEC    : 0 |
+				    tlb->vma_huge ? VM_HUGETLB : 0,
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


