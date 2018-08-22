Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF71C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92722148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ni16kIzT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92722148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbeHVTVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:21:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbeHVTVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Euw82meuEkYw6hhezBwxMgQDl9BWbTIlruHAZPU+qDc=; b=ni16kIzT+l22pD7CEIMENY8vR
        kQrvNtQ7XVc1BhoKYDVq8VcIkfa+b9HIsWT9TvRh7s+PuCgUoUajvwVmuyuCtswaXZP3qeUlO5jNK
        KxMZGB0BrwEnsJsfxUvfJodaNpTV1zwPvHPynkraxzxwXnyzAuHCH5iUNoIC3jQ6WobwcOM+p3mqc
        wYum2mZ9oLDQBWoAOt6d0pfqIO1uFUlSfw0sPK8SSccqkGUjDEOxtcFyIfAtdn3pm68trIKqKB4w5
        Suo8OPL4KP9rg77yQx2M7IMlGWVKxBiCSNAaT4siWyblpX6MkLdwGjQqIt1IFxSP58L78Wxnw3ukN
        Tc3HtcQbg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsVTl-0001Wf-37; Wed, 22 Aug 2018 15:55:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 936672024D714; Wed, 22 Aug 2018 17:55:27 +0200 (CEST)
Date:   Wed, 22 Aug 2018 17:55:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     luto@kernel.org, x86@kernel.org, bp@alien8.de, will.deacon@arm.com,
        riel@surriel.com, jannh@google.com, ascannell@google.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180822155527.GF24124@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822154046.823850812@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 05:30:15PM +0200, Peter Zijlstra wrote:
> ARM
> which later used this put an explicit TLB invalidate in their
> __p*_free_tlb() functions, and PowerPC-radix followed that example.

> +/*
> + * If we want tlb_remove_table() to imply TLB invalidates.
> + */
> +static inline void tlb_table_invalidate(struct mmu_gather *tlb)
> +{
> +#ifdef CONFIG_HAVE_RCU_TABLE_INVALIDATE
> +	/*
> +	 * Invalidate page-table caches used by hardware walkers. Then we still
> +	 * need to RCU-sched wait while freeing the pages because software
> +	 * walkers can still be in-flight.
> +	 */
> +	__tlb_flush_mmu_tlbonly(tlb);
> +#endif
> +}


Nick, Will is already looking at using this to remove the synchronous
invalidation from __p*_free_tlb() for ARM, could you have a look to see
if PowerPC-radix could benefit from that too?

Basically, using a patch like the below, would give your tlb_flush()
information on if tables were removed or not.

---

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -96,12 +96,22 @@ struct mmu_gather {
 #endif
 	unsigned long		start;
 	unsigned long		end;
-	/* we are in the middle of an operation to clear
-	 * a full mm and can make some optimizations */
-	unsigned int		fullmm : 1,
-	/* we have performed an operation which
-	 * requires a complete flush of the tlb */
-				need_flush_all : 1;
+	/*
+	 * we are in the middle of an operation to clear
+	 * a full mm and can make some optimizations
+	 */
+	unsigned int		fullmm : 1;
+
+	/*
+	 * we have performed an operation which
+	 * requires a complete flush of the tlb
+	 */
+	unsigned int		need_flush_all : 1;
+
+	/*
+	 * we have removed page directories
+	 */
+	unsigned int		freed_tables : 1;
 
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
@@ -136,6 +146,7 @@ static inline void __tlb_reset_range(str
 		tlb->start = TASK_SIZE;
 		tlb->end = 0;
 	}
+	tlb->freed_tables = 0;
 }
 
 static inline void tlb_remove_page_size(struct mmu_gather *tlb,
@@ -269,6 +280,7 @@ static inline void tlb_remove_check_page
 #define pte_free_tlb(tlb, ptep, address)			\
 	do {							\
 		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
+		tlb->freed_tables = 1;			\
 		__pte_free_tlb(tlb, ptep, address);		\
 	} while (0)
 #endif
@@ -276,7 +288,8 @@ static inline void tlb_remove_check_page
 #ifndef pmd_free_tlb
 #define pmd_free_tlb(tlb, pmdp, address)			\
 	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);		\
+		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
+		tlb->freed_tables = 1;			\
 		__pmd_free_tlb(tlb, pmdp, address);		\
 	} while (0)
 #endif
@@ -286,6 +299,7 @@ static inline void tlb_remove_check_page
 #define pud_free_tlb(tlb, pudp, address)			\
 	do {							\
 		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
+		tlb->freed_tables = 1;			\
 		__pud_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
@@ -295,7 +309,8 @@ static inline void tlb_remove_check_page
 #ifndef p4d_free_tlb
 #define p4d_free_tlb(tlb, pudp, address)			\
 	do {							\
-		__tlb_adjust_range(tlb, address, PAGE_SIZE);		\
+		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
+		tlb->freed_tables = 1;			\
 		__p4d_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
