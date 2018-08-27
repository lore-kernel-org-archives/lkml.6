Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC161C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894A0208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xfsBp42o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894A0208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH0Lc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:32:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58764 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeH0Lc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ubZJ6NAXPWLoHzvy1jvSHb6b1V5y4RgVUcmImksJcMc=; b=xfsBp42o4Ga3ZzIw8vnEQWKdV
        FINUCfu8bru0CB4eZr1BzMHDRRZwbC9ssqg0ywtTy9KL+wGrFp93m7WabKeC1RyRhlqm0/kgVK6ED
        G1/58i13QQMBRobQbKW/cRCZL1B+UGGkFqALHenhusoVqHOxaqFrVtYUjT2CXqAPcz8zRG1HwjInA
        w1xNuiImYxOEfB+kOMVAMoKWUSnce6H2+MojV9ylPJs+qd57CoNLERkFgQky7gST4PFoRzP+RVg8w
        8HnBpLeC2hojcgOU8Tdxx8UBkSxoJ8bpuz4A531R26AqXfmQ9xz7NaR2rH07V+ueYjbTcLMIDBC94
        F+/o/2t+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuCEo-0000Y2-U2; Mon, 27 Aug 2018 07:47:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A7E32024EB1D; Mon, 27 Aug 2018 09:47:01 +0200 (CEST)
Date:   Mon, 27 Aug 2018 09:47:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180827074701.GW24124@hirez.programming.kicks-ass.net>
References: <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <20180824113214.GK24142@hirez.programming.kicks-ass.net>
 <20180824113953.GL24142@hirez.programming.kicks-ass.net>
 <20180827150008.13bce08f@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827150008.13bce08f@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 03:00:08PM +1000, Nicholas Piggin wrote:
> On Fri, 24 Aug 2018 13:39:53 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Fri, Aug 24, 2018 at 01:32:14PM +0200, Peter Zijlstra wrote:

> > > Hurm.. look at commit:
> > > 
> > >   e77b0852b551 ("mm/mmu_gather: track page size with mmu gather and force flush if page size change")  
> > 
> > Ah, good, it seems that already got cleaned up a lot. But it all moved
> > into the power code.. blergh.
> 
> I lost track of what the problem is here?

Aside from the commit above being absolute crap (which did get fixed up,
luckily) I would really like to get rid of all arch specific mmu_gather.

We can have opt-in bits to the generic code, but the endless back and
forth between common and arch code is an utter pain in the arse.

And there's only like 4 architectures that still have a custom
mmu_gather:

  - sh
  - arm
  - ia64
  - s390

sh is trivial, arm seems doable, with a bit of luck we can do 'rm -rf
arch/ia64' leaving us with s390.

After that everyone uses the common code and we can clean up.

> For powerpc, tlb_start_vma is not the right API to use for this because
> it wants to deal with different page sizes within a vma.

Yes.. I see that. tlb_remove_check_page_size_change() really is a rather
ugly thing, it can cause loads of TLB flushes. Do you really _have_ to
do that? The way ARM and x86 work is that using INVLPG in a 4K stride is
still correct for huge pages, inefficient maybe, but so is flushing
every other page because 'sparse' transparant-huge-pages.

