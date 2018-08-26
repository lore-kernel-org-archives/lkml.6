Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09246C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E40208D6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fze305OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E40208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeHZOjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 10:39:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHZOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 10:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=okVl40r08ymCMYFrO8VFfJig/KLop8Io/sRmBMlnL+8=; b=fze305ORNJxwSTwfi0TCCi697
        s8mWsr/Q+Ix1pJvGWXcMP4zBBBNNj3wD0xUkTCn8M/nnUl8eg5pP1xo+5QHq9iGtRnVCrcDXRavKO
        M4qZKIfI4NayLRnzi4LulSLoGc/TEFRdTX+X+XBnUJMxTzkQS+Xqo1Bf7lV+MLiiFjPO0JeuJ/UgU
        YYsy9RABYPQJog1d7ko+iH3WslN+UqEZ9iVBvJHsMXgzzVDr70S0Trisiu4dLmLBUkleFylhggVzb
        6zK5w5ffat7mSZgmSjk1rOgS4kpH/BGKa+GKMOnPIQ6aHlWHz4YCmsXSBz7+V0JAt0gpsO/M42aeh
        v1kVup1QA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftsix-0004RP-JT; Sun, 26 Aug 2018 10:56:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52B672024EB1B; Sun, 26 Aug 2018 12:56:48 +0200 (CEST)
Date:   Sun, 26 Aug 2018 12:56:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180826105648.GU24124@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <CA+55aFxNs5B=j_g_OpAd=Xp_iiO_+idT-ogd_WM2EcL_6brbqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxNs5B=j_g_OpAd=Xp_iiO_+idT-ogd_WM2EcL_6brbqg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 09:20:00AM -0700, Linus Torvalds wrote:
> On Fri, Aug 24, 2018 at 8:52 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > I hacked up this RFC on the back of the recent changes to the mmu_gather
> > stuff in mainline. It's had a bit of testing and it looks pretty good so
> > far.
> 
> Looks good to me.
> 
> Apart from the arm64-specific question I had, I wonder whether we need
> to have that single "freed_tables" bit at all, since you wanted to
> have the four individual bits for the different levels.

I think so; because he also sets those size bits for things like hugetlb
and thp user page frees, not only table page frees. So they're not
exactly the same.

And I think x86 could use this too; if we know we only freed 2M
pages, we can use that in flush_tlb_mm_range() to range flush in 2M
increments instead of 4K.

Something a little like so..

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index cb0a1f470980..cb0898fe9d37 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -8,10 +8,15 @@
 
 #define tlb_flush(tlb)							\
 {									\
-	if (!tlb->fullmm && !tlb->need_flush_all) 			\
-		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end, 0UL);	\
-	else								\
-		flush_tlb_mm_range(tlb->mm, 0UL, TLB_FLUSH_ALL, 0UL);	\
+	unsigned long start = 0UL, end = TLB_FLUSH_ALL;			\
+	unsigned int invl_shift = tlb_get_unmap_shift(tlb);		\
+									\
+	if (!tlb->fullmm && !tlb->need_flush_all) {			\
+		start = tlb->start;					\
+		end = tlb->end;						\
+	}								\
+									\
+	flush_tlb_mm_range(tlb->mm, start, end, invl_shift);		\
 }
 
 #include <asm-generic/tlb.h>
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 511bf5fae8b8..8ac1cac34f63 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -491,23 +491,25 @@ struct flush_tlb_info {
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
+		flush_tlb_mm_range(vma->vm_mm, start, end,	\
+				vma->vm_flags & VM_HUGETLB ? PMD_SHUFT : PAGE_SHIFT)
 
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
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 752dbf4e0e50..806aa74a8fb4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -537,12 +537,12 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
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
@@ -653,12 +653,13 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned long vmflag)
+				unsigned long end, unsigned int invl_shift)
 {
 	int cpu;
 
 	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
 		.mm = mm,
+		.invl_shift = invl_shift;
 	};
 
 	cpu = get_cpu();
@@ -668,8 +669,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 
 	/* Should we flush just the requested range? */
 	if ((end != TLB_FLUSH_ALL) &&
-	    !(vmflag & VM_HUGETLB) &&
-	    ((end - start) >> PAGE_SHIFT) <= tlb_single_page_flush_ceiling) {
+	    ((end - start) >> invl_shift) <= tlb_single_page_flush_ceiling) {
 		info.start = start;
 		info.end = end;
 	} else {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index e811ef7b8350..cdde0cdb23e7 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -175,6 +200,25 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 }
 #endif
 
+static inline unsigned long tlb_get_unmap_shift(struct mmu_gather *tlb)
+{
+	if (tlb->cleared_ptes)
+		return PAGE_SHIFT;
+	if (tlb->cleared_pmds)
+		return PMD_SHIFT;
+	if (tlb->cleared_puds)
+		return PUD_SHIFT;
+	if (tlb->cleared_p4ds)
+		return P4D_SHIFT;
+
+	return PAGE_SHIFT;
+}
+
+static inline unsigned long tlb_get_unmap_size(struct mmu_gather *tlb)
+{
+	return 1ULL << tlb_get_unmap_shift(tlb);
+}
+
 /*
  * In the case of tlb vma handling, we can optimise these away in the
  * case where we're doing a full MM flush.  When we're doing a munmap,
