Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C6FC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E833E21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dG7yd+j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E833E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIMOiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:38:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeIMOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jgrjUnzXtEdFVgHINLQMwf19p5Mc/gjokyImpgoVnII=; b=dG7yd+j3hwiQWUBzF/T8E5qxOO
        FoRrlpP092nw81flcWecqF/OuPeOcB6KMxMSoA3C3V0pVh4wUrg3M2eggdHHfTX94/nUHGOPKAnpz
        5YmR7QzbZaBIkra0K9ZanS4trhOGz77ug42Az+irfHcoAhIS44tUCuaNV3GIFu0cHPpceaFlxSxdr
        Ft9qNrgzk4Y6bM/5FMEJ1HotlrLxmwliOMwjzqRWUVw48WfS4hvN5mIiK2ed3imS6lczr+GZEX7ZP
        3r0DAnJ/KHW3kzasBluftuLbgczxolfSC52jW8B7UmUXGX9OUR+EQH7BLjVwaqt7CYL6F4eBFSDCi
        s46JL1Bg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Nw0-0000uo-92; Thu, 13 Sep 2018 09:29:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4300120587E4D; Thu, 13 Sep 2018 11:29:10 +0200 (CEST)
Message-ID: <20180913092812.012757318@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Sep 2018 11:21:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [RFC][PATCH 03/11] x86/mm: Page size aware flush_tlb_mm_range()
References: <20180913092110.817204997@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new tlb_get_unmap_shift() to determine the stride of the
INVLPG loop.

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/tlb.h      |   21 ++++++++++++++-------
 arch/x86/include/asm/tlbflush.h |   10 ++++++----
 arch/x86/mm/tlb.c               |   10 +++++-----
 3 files changed, 25 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -6,16 +6,23 @@
 #define tlb_end_vma(tlb, vma) do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
-#define tlb_flush(tlb)							\
-{									\
-	if (!tlb->fullmm && !tlb->need_flush_all) 			\
-		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end, 0UL);	\
-	else								\
-		flush_tlb_mm_range(tlb->mm, 0UL, TLB_FLUSH_ALL, 0UL);	\
-}
+static inline void tlb_flush(struct mmu_gather *tlb);
 
 #include <asm-generic/tlb.h>
 
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	unsigned long start = 0UL, end = TLB_FLUSH_ALL;
+	unsigned int invl_shift = tlb_get_unmap_shift(tlb);
+
+	if (!tlb->fullmm && !tlb->need_flush_all) {
+		start = tlb->start;
+		end = tlb->end;
+	}
+
+	flush_tlb_mm_range(tlb->mm, start, end, invl_shift);
+}
+
 /*
  * While x86 architecture in general requires an IPI to perform TLB
  * shootdown, enablement code for several hypervisors overrides
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -507,23 +507,25 @@ struct flush_tlb_info {
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
+	unsigned int		invl_shift;
 };
 
 #define local_flush_tlb() __flush_tlb()
 
 #define flush_tlb_mm(mm)	flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL)
 
-#define flush_tlb_range(vma, start, end)	\
-		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)
+#define flush_tlb_range(vma, start, end)			\
+		flush_tlb_mm_range((vma)->vm_mm, start, end,	\
+				(vma)->vm_flags & VM_HUGETLB ? PMD_SHIFT : PAGE_SHIFT)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned long vmflag);
+				unsigned long end, unsigned int invl_shift);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
-	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, VM_NONE);
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT);
 }
 
 void native_flush_tlb_others(const struct cpumask *cpumask,
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -522,12 +522,12 @@ static void flush_tlb_func_common(const
 	    f->new_tlb_gen == mm_tlb_gen) {
 		/* Partial flush */
 		unsigned long addr;
-		unsigned long nr_pages = (f->end - f->start) >> PAGE_SHIFT;
+		unsigned long nr_pages = (f->end - f->start) >> f->invl_shift;
 
 		addr = f->start;
 		while (addr < f->end) {
 			__flush_tlb_one_user(addr);
-			addr += PAGE_SIZE;
+			addr += 1UL << f->invl_shift;
 		}
 		if (local)
 			count_vm_tlb_events(NR_TLB_LOCAL_FLUSH_ONE, nr_pages);
@@ -616,12 +616,13 @@ void native_flush_tlb_others(const struc
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned long vmflag)
+				unsigned long end, unsigned int invl_shift)
 {
 	int cpu;
 
 	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
 		.mm = mm,
+		.invl_shift = invl_shift,
 	};
 
 	cpu = get_cpu();
@@ -631,8 +632,7 @@ void flush_tlb_mm_range(struct mm_struct
 
 	/* Should we flush just the requested range? */
 	if ((end != TLB_FLUSH_ALL) &&
-	    !(vmflag & VM_HUGETLB) &&
-	    ((end - start) >> PAGE_SHIFT) <= tlb_single_page_flush_ceiling) {
+	    ((end - start) >> invl_shift) <= tlb_single_page_flush_ceiling) {
 		info.start = start;
 		info.end = end;
 	} else {


