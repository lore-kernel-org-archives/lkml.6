Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2FBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64512146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dFYG6VAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfBSKdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55578 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfBSKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1m499lCoWZDawBwduH5mia3SdJ+bH6wWKMriVQsCXbM=; b=dFYG6VAK1LK+4vkgXN0vUIsqq6
        5fk4Ykx9noitYB0eJyqW1qO8Q7PGgAjnssomkzP9XeppAeiW2TEx0TrfM5DUMHDs1xdWzFGndumss
        PniHG02dFakkjoWJu6EbacmsGYQzXCHGEB6c4TTk33Da1gvaTUvQAIq2l+MiB2Z69fS6ceTTT8jDN
        1AaBvXf0V+ZrjSUR7QrGlwOPBXx0t6bzYA+uUhrNnu0mTnDu3bNz9MWr643UYdj1T4Ux+2RqnDlJ9
        goOlZiJE9FufW0cR0uBywsIk1rJhozVPoroSLqKLnkhutKAr4Nt7bBCTZ8rOqR/Q3yTc+OjFKP27U
        4gfRfKdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hn-0000di-I4; Tue, 19 Feb 2019 10:32:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 550AC285202C6; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.148854086@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:31:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH v6 05/18] asm-generic/tlb: Provide generic tlb_flush() based on flush_tlb_mm()
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an architecture does not have (an efficient) flush_tlb_range(),
but instead always uses full TLB invalidates, the current generic
tlb_flush() is sub-optimal, for it will generate extra flushes in
order to keep the range small.

But if we cannot do range flushes, that is a moot concern. Optionally
provide this simplified default.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -114,7 +114,8 @@
  *    returns the smallest TLB entry size unmapped in this range.
  *
  * If an architecture does not provide tlb_flush() a default implementation
- * based on flush_tlb_range() will be used.
+ * based on flush_tlb_range() will be used, unless MMU_GATHER_NO_RANGE is
+ * specified, in which case we'll default to flush_tlb_mm().
  *
  * Additionally there are a few opt-in features:
  *
@@ -140,6 +141,9 @@
  *  the page-table pages. Required if you use HAVE_RCU_TABLE_FREE and your
  *  architecture uses the Linux page-tables natively.
  *
+ *  MMU_GATHER_NO_RANGE
+ *
+ *  Use this if your architecture lacks an efficient flush_tlb_range().
  */
 #define HAVE_GENERIC_MMU_GATHER
 
@@ -302,12 +306,45 @@ static inline void __tlb_reset_range(str
 	 */
 }
 
+#ifdef CONFIG_MMU_GATHER_NO_RANGE
+
+#if defined(tlb_flush) || defined(tlb_start_vma) || defined(tlb_end_vma)
+#error MMU_GATHER_NO_RANGE relies on default tlb_flush(), tlb_start_vma() and tlb_end_vma()
+#endif
+
+/*
+ * When an architecture does not have efficient means of range flushing TLBs
+ * there is no point in doing intermediate flushes on tlb_end_vma() to keep the
+ * range small. We equally don't have to worry about page granularity or other
+ * things.
+ *
+ * All we need to do is issue a full flush for any !0 range.
+ */
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	if (tlb->end)
+		flush_tlb_mm(tlb->mm);
+}
+
+static inline void
+tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+
+#define tlb_end_vma tlb_end_vma
+static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
+
+#else /* CONFIG_MMU_GATHER_NO_RANGE */
+
 #ifndef tlb_flush
 
 #if defined(tlb_start_vma) || defined(tlb_end_vma)
 #error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
 #endif
 
+/*
+ * When an architecture does not provide its own tlb_flush() implementation
+ * but does have a reasonably efficient flush_vma_range() implementation
+ * use that.
+ */
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	if (tlb->fullmm || tlb->need_flush_all) {
@@ -348,6 +385,8 @@ tlb_update_vma_flags(struct mmu_gather *
 
 #endif
 
+#endif /* CONFIG_MMU_GATHER_NO_RANGE */
+
 static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
 {
 	if (!tlb->end)


