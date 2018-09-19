Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFCA2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m2vIcWje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFCA2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeISSQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:16:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbeISSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gdmlnihdyKW+x3QbLohzUu8kKtbNWAYX/WDsFSCvjvA=; b=m2vIcWjeDw2Yl6j6DWRe0rlIC
        ic8QHpoqcJhooA4XEUXd5Jh38AQrn2Jr4KLIf1pQP+hWIpxRasQ7O1d3BEV8fUDW6I+pOQ0xRHXru
        nlr30UMcV2ZQ66cSijeGnqPkS0FAbs3jVrhijoWcepVR9u07NgVLN0nym1sUGmVPNMLhMixu1yRbN
        zX4xsG0Zs2xWaFSDYHpSQgyJRdPG/H6z0vMXNoaQwaHf/KgKJGCMe9rNuoRvw8m2tyZEeQ+KStEWW
        CzF5/K80Ei9ki6OGemYQ6NX38ln0h6mF7U2w1n4t3AAxKG0NF0abIFy/OmXK8i2THir4mYUyWoMMn
        OnAgJtsVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2bkp-0007Zb-FF; Wed, 19 Sep 2018 12:38:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2378E2024E448; Wed, 19 Sep 2018 14:38:49 +0200 (CEST)
Date:   Wed, 19 Sep 2018 14:38:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] s390/tlb: convert to generic mmu_gather
Message-ID: <20180919123849.GF24124@hirez.programming.kicks-ass.net>
References: <20180918125151.31744-1-schwidefsky@de.ibm.com>
 <20180918125151.31744-3-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918125151.31744-3-schwidefsky@de.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 02:51:51PM +0200, Martin Schwidefsky wrote:
> +#define pte_free_tlb pte_free_tlb
> +#define pmd_free_tlb pmd_free_tlb
> +#define p4d_free_tlb p4d_free_tlb
> +#define pud_free_tlb pud_free_tlb

> @@ -121,9 +62,18 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
>   * page table from the tlb.
>   */
>  static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> +                                unsigned long address)
>  {
> +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> +	tlb->mm->context.flush_mm = 1;
> +	tlb->freed_tables = 1;
> +	tlb->cleared_ptes = 1;
> +	/*
> +	 * page_table_free_rcu takes care of the allocation bit masks
> +	 * of the 2K table fragments in the 4K page table page,
> +	 * then calls tlb_remove_table.
> +	 */
> +        page_table_free_rcu(tlb, (unsigned long *) pte, address);

(whitespace damage, fixed)

Also, could you perhaps explain the need for that
page_table_alloc/page_table_free code? That is, I get the comment about
using 2K page-table fragments out of 4k physical page, but why this
custom allocator instead of kmem_cache? It feels like there's a little
extra complication, but it's not immediately obvious what.

>  }

We _could_ use __pte_free_tlb() here I suppose, but...

>  /*
> @@ -139,6 +89,10 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>  	if (tlb->mm->context.asce_limit <= _REGION3_SIZE)
>  		return;
>  	pgtable_pmd_page_dtor(virt_to_page(pmd));
> +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> +	tlb->mm->context.flush_mm = 1;
> +	tlb->freed_tables = 1;
> +	tlb->cleared_puds = 1;
>  	tlb_remove_table(tlb, pmd);
>  }
>  
> @@ -154,6 +108,10 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>  {
>  	if (tlb->mm->context.asce_limit <= _REGION1_SIZE)
>  		return;
> +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> +	tlb->mm->context.flush_mm = 1;
> +	tlb->freed_tables = 1;
> +	tlb->cleared_p4ds = 1;
>  	tlb_remove_table(tlb, p4d);
>  }
>  
> @@ -169,19 +127,11 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  {
>  	if (tlb->mm->context.asce_limit <= _REGION2_SIZE)
>  		return;
> +	tlb->mm->context.flush_mm = 1;
> +	tlb->freed_tables = 1;
> +	tlb->cleared_puds = 1;
>  	tlb_remove_table(tlb, pud);
>  }

It's that ASCE limit that makes it impossible to use the generic
helpers, right?


