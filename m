Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348C7C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CD5208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VokNISWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CD5208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHXPue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:50:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P21AZyQ3vGHucRsFK+wO6VFj5yzNawIOMPe50ofpjg8=; b=VokNISWmEls85bIfiU8EZNTEZ
        gtg7tmuHBtvSPEoI39JvAq8lGU11cSK56/LSpdzOme2ItAK3aeCqEqNRthJAuOy/oIOzx3WwQSBbC
        +6bg474FlLHJkcHkt1HY6T9/jvZN/b0zPymrGLswUZXyC0j74G6AOSHQ6WWipSK4L7d7qEosTzHSE
        Vka/Cqztmnxso+TiGxxDr9SG5uFek5AjSXx2D++iI7Mr+s9AQogSFEwT0UTFe+TwrbWlg1BFmLZ1s
        eIRC+5J5d7gtjZTPd4JH9bOhIyTDV+fc7MnI6xrNeHS1wybiZ3XMdZfVsFQQfJfm9aZxIHclx+zMY
        XeanHdxdQ==;
Received: from [24.132.217.100] (helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftAT8-0000zt-Qq; Fri, 24 Aug 2018 11:48:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 723312024D44B; Fri, 24 Aug 2018 13:39:53 +0200 (CEST)
Date:   Fri, 24 Aug 2018 13:39:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180824113953.GL24142@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <20180824113214.GK24142@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824113214.GK24142@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 01:32:14PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 24, 2018 at 10:47:17AM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 23, 2018 at 02:39:59PM +0100, Will Deacon wrote:
> > > The only problem with this approach is that we've lost track of the granule
> > > size by the point we get to the tlb_flush(), so we can't adjust the stride of
> > > the TLB invalidations for huge mappings, which actually works nicely in the
> > > synchronous case (e.g. we perform a single invalidation for a 2MB mapping,
> > > rather than iterating over it at a 4k granule).
> > > 
> > > One thing we could do is switch to synchronous mode if we detect a change in
> > > granule (i.e. treat it like a batch failure).
> > 
> > We could use tlb_start_vma() to track that, I think. Shouldn't be too
> > hard.
> 
> Hurm.. look at commit:
> 
>   e77b0852b551 ("mm/mmu_gather: track page size with mmu gather and force flush if page size change")

Ah, good, it seems that already got cleaned up a lot. But it all moved
into the power code.. blergh.
