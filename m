Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B580C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F128820818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GQV+aWWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfBSKdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfBSKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qjNJCW9VaWoPUrcjw4ZVmCtKdrbi+jA4eRz3lYRrRV0=; b=GQV+aWWD0uF54yBZACk5RksZPH
        9j/UOm3no7u1rIP4L99eOppKfF6/v49uIThiUiOjnkE3Ts1yjOi3polOicPbrO9fwrS2ZCeIcpiUj
        VDkuHhwRKB5m2qSkl4gK0oJBC0eJ8kt+CgFL1wjA95vEjX9M/pyHNGq+TLBVgmfvCp2xvN5v8IcAg
        t1LgKQt2GWKqPHm7udVvWtvOy3WweALFim0i+q3Cmz0HKsQCUFqVtYUl2Wyp10pCCMTwxlWomdUFH
        v9jWsggFZMi+xNXrxEizJo5FGXgpcrvrGFQvG80nxsx3wV+1T0IkpOpZCG36le6OevTPypRm36gjA
        Xsayfeng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hm-0006ZJ-W6; Tue, 19 Feb 2019 10:32:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 53390285202C7; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.090636436@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:31:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH v6 04/18] asm-generic/tlb: Provide generic tlb_flush() based on flush_tlb_range()
References: <20190219103148.192029670@infradead.org>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/tlb.h   |    1 
 arch/powerpc/include/asm/tlb.h |    1 
 arch/riscv/include/asm/tlb.h   |    1 
 arch/x86/include/asm/tlb.h     |    1 
 include/asm-generic/tlb.h      |   95 +++++++++++++++++++++++++++++++++++------
 5 files changed, 87 insertions(+), 12 deletions(-)

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
@@ -95,7 +95,7 @@
  *    flush the entire TLB irrespective of the range. For instance
  *    x86-PAE needs this when changing top-level entries.
  *
- * And requires the architecture to provide and implement tlb_flush().
+ * And allows the architecture to provide and implement tlb_flush():
  *
  * tlb_flush() may, in addition to the above mentioned mmu_gather fields, make
  * use of:
@@ -111,7 +111,10 @@
  *
  *  - tlb_get_unmap_shift() / tlb_get_unmap_size()
  *
- *    returns the smallest TLB entry size unmapped in this range
+ *    returns the smallest TLB entry size unmapped in this range.
+ *
+ * If an architecture does not provide tlb_flush() a default implementation
+ * based on flush_tlb_range() will be used.
  *
  * Additionally there are a few opt-in features:
  *
@@ -245,6 +248,12 @@ struct mmu_gather {
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
@@ -286,8 +295,59 @@ static inline void __tlb_reset_range(str
 	tlb->cleared_pmds = 0;
 	tlb->cleared_puds = 0;
 	tlb->cleared_p4ds = 0;
+	/*
+	 * Do not reset mmu_gather::vma_* fields here, we do not
+	 * call into tlb_start_vma() again to set them if there is an
+	 * intermediate flush.
+	 */
 }
 
+#ifndef tlb_flush
+
+#if defined(tlb_start_vma) || defined(tlb_end_vma)
+#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
+#endif
+
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	if (tlb->fullmm || tlb->need_flush_all) {
+		flush_tlb_mm(tlb->mm);
+	} else if (tlb->end) {
+		struct vm_area_struct vma = {
+			.vm_mm = tlb->mm,
+			.vm_flags = (tlb->vma_exec ? VM_EXEC    : 0) |
+				    (tlb->vma_huge ? VM_HUGETLB : 0),
+		};
+
+		flush_tlb_range(&vma, tlb->start, tlb->end);
+	}
+}
+
+static inline void
+tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
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
+}
+
+#else
+
+static inline void
+tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+
+#endif
+
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
 	if (!tlb->end)
@@ -357,19 +417,30 @@ static inline unsigned long tlb_get_unma
  * the vmas are adjusted to only cover the region to be torn down.
  */
 #ifndef tlb_start_vma
-#define tlb_start_vma(tlb, vma)						\
-do {									\
-	if (!tlb->fullmm)						\
-		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\
-} while (0)
+static inline void tlb_start_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
+{
+	if (tlb->fullmm)
+		return;
+
+	tlb_update_vma_flags(tlb, vma);
+	flush_cache_range(vma, vma->vm_start, vma->vm_end);
+}
 #endif
 
 #ifndef tlb_end_vma
-#define tlb_end_vma(tlb, vma)						\
-do {									\
-	if (!tlb->fullmm)						\
-		tlb_flush_mmu_tlbonly(tlb);				\
-} while (0)
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


