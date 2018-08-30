Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE7C2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AeohKS1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE7C2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeH3O0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:26:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbeH3O0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hKn6wlPY0k/e8BHY6x97zza15GX2i6KOSMZrf7fnC7w=; b=AeohKS1vdUqHR2gP12x3Zao5v
        KRvDKMAwfT7ntWBx2a4zRUcX+htx1jUJkKKYdTAWvTKG3CUCOjXgVBGEegprZ76xNXuLdfrLzFota
        jtjU/6uzBX52wRAZ5BzYF9ldkowSQ/L8Iv3zQdAonfh2+CjCYrValJCUB4AFUGaZvgSSIfprBCHtW
        yzx1TZBmSLzdHSW2KBi0ROFGVlt/AGQZEfYk/a8Ng+sxc9/vK250hCuNGz4CmSuyrS50/O1LJjgvo
        Kvhkl6mafGKXQPHFk8U7R3mU7CBwwNAGOikI4e1csIVc8cvkzwyFvERN/KbUucR3wT2ZAC8kYwlt/
        TvImtJ+wA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvK7J-000704-6t; Thu, 30 Aug 2018 10:23:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 890B82024D73F; Thu, 30 Aug 2018 12:23:54 +0200 (CEST)
Date:   Thu, 30 Aug 2018 12:23:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180830102354.GY24124@hirez.programming.kicks-ass.net>
References: <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <20180824113214.GK24142@hirez.programming.kicks-ass.net>
 <20180824113953.GL24142@hirez.programming.kicks-ass.net>
 <20180827150008.13bce08f@roar.ozlabs.ibm.com>
 <20180827074701.GW24124@hirez.programming.kicks-ass.net>
 <20180827110017.GO24142@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B090CA3@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B090CA3@us01wembx1.internal.synopsys.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 12:13:50AM +0000, Vineet Gupta wrote:
> On 08/27/2018 04:00 AM, Peter Zijlstra wrote:
> >
> > The one obvious thing SH and ARM want is a sensible default for
> > tlb_start_vma(). (also: https://lkml.org/lkml/2004/1/15/6 )
> >
> > The below make tlb_start_vma() default to flush_cache_range(), which
> > should be right and sufficient. The only exceptions that I found where
> > (oddly):
> >
> >   - m68k-mmu
> >   - sparc64
> >   - unicore
> >
> > Those architectures appear to have a non-NOP flush_cache_range(), but
> > their current tlb_start_vma() does not call it.
> 
> So indeed we follow the DaveM's insight from 2004 about tlb_{start,end}_vma() and
> those are No-ops for ARC for the general case. For the historic VIPT aliasing
> dcache they are what they should be per 2004 link above - I presume that is all
> hunky dory with you ?

Yep, I was just confused about those 3 architectures having
flush_cache_range() but not calling it from tlb_start_vma(). The regular
VIPT aliasing thing is all good. And not having them is also fine.

> > Furthermore, I think tlb_flush() is broken on arc and parisc; in
> > particular they don't appear to have any TLB invalidate for the
> > shift_arg_pages() case, where we do not call tlb_*_vma() and fullmm=0.
> 
> Care to explain this issue a bit more ?
> And that is independent of the current discussion.
> 
> > Possibly shift_arg_pages() should be fixed instead.

So the problem is that shift_arg_pages() does not call tlb_start_vma() /
tlb_end_vma(). It also has fullmm=0. Therefore, on ARC, there will not
be a TLB invalidate at all when freeing the page-tables.

And while looking at this more, move_page_tables() also looks dodgy, I
think it always needs a TLB flush of the entire 'old' range.

> > diff --git a/arch/arc/include/asm/tlb.h b/arch/arc/include/asm/tlb.h
> > index a9db5f62aaf3..7af2b373ebe7 100644
> > --- a/arch/arc/include/asm/tlb.h
> > +++ b/arch/arc/include/asm/tlb.h
> > @@ -23,15 +23,6 @@ do {						\
> >   *
> >   * Note, read http://lkml.org/lkml/2004/1/15/6
> >   */
> > -#ifndef CONFIG_ARC_CACHE_VIPT_ALIASING
> > -#define tlb_start_vma(tlb, vma)
> > -#else
> > -#define tlb_start_vma(tlb, vma)						\
> > -do {									\
> > -	if (!tlb->fullmm)						\
> > -		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\
> > -} while(0)
> > -#endif
> >  
> >  #define tlb_end_vma(tlb, vma)						\
> >  do {									\
> 
> [snip..]
> 
> > 				      \
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index e811ef7b8350..1d037fd5bb7a 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -181,19 +181,21 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
> >   * the vmas are adjusted to only cover the region to be torn down.
> >   */
> >  #ifndef tlb_start_vma
> > -#define tlb_start_vma(tlb, vma) do { } while (0)
> > +#define tlb_start_vma(tlb, vma)						\
> > +do {									\
> > +	if (!tlb->fullmm)						\
> > +		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\
> > +} while (0)
> >  #endif
> 
> So for non aliasing arches to be not affected, this relies on flush_cache_range()
> to be no-op ?

Yes; a cursory inspected shows this to be so. With 'obvious' exception
from the above 3 architectures.

> > -#define __tlb_end_vma(tlb, vma)					\
> > -	do {							\
> > -		if (!tlb->fullmm && tlb->end) {			\
> > -			tlb_flush(tlb);				\
> > -			__tlb_reset_range(tlb);			\
> > -		}						\
> > -	} while (0)
> > -
> >  #ifndef tlb_end_vma
> > -#define tlb_end_vma	__tlb_end_vma
> > +#define tlb_end_vma(tlb, vma)						\
> > +	do {								\
> > +		if (!tlb->fullmm && tlb->end) {				\
> > +			tlb_flush(tlb);					\
> > +			__tlb_reset_range(tlb);				\
> > +		}							\
> > +	} while (0)
> >  #endif
> >  
> >  #ifndef __tlb_remove_tlb_entry
> 
> And this one is for shift_arg_pages() but will also cause extraneous flushes for
> other cases - not happening currently !

No, shift_arg_pages() does not in fact call tlb_end_vma().

The reason for the flush in tlb_end_vma() is (as far as we can remember)
to 'better' deal with large gaps between adjacent VMAs.  Without the
flush here, the range would be extended to cover the (potential) dead
space between the VMAs. Resulting in more expensive range flushes.
