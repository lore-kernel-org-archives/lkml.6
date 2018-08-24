Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D043C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DE52157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="26WdUqbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DE52157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeHXMKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:10:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38040 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeHXMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RiyfP2A3uT1GKgZKfmASkqAbqk/qx69uq9oaSih1fSM=; b=26WdUqbcmAwWo2faMg8q5YTIX
        35LPB4PF1LO7bVBpJiOhsPViU0DjZqzVn7OjQW7Z/0eU4UadHR0BGudGY/IckVhSlRJ5oJJL/hnqc
        le7y1nmqZZEMr6hVuC1r1EtbOEf42i+U9hDXUcRNkFlB4WUq9Ls4R7wKj0HAUxaIe92JePm8hMoYX
        7fVYtx4XdtCVb9u/3UDrlSiWbSwfl1h1qVqbibXbGC8n0nDFws/bxAvQ9y7yNSSe8xdp5ysSyysOq
        TV4sse8SSRFkMVRU0jHFWgYkK2fJCZkNeV44dyZtpa7r/qAH0E5gcMGbSLVV7OH9iGJPCGNXhfCeM
        9MRs997Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ft7ZW-0007GS-5v; Fri, 24 Aug 2018 08:35:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C796D202E65E0; Fri, 24 Aug 2018 10:35:56 +0200 (CEST)
Date:   Fri, 24 Aug 2018 10:35:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180824083556.GI24124@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 02:54:20PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2018-08-22 at 20:59 -0700, Linus Torvalds wrote:

> > The problem is that x86 _used_ to do this all correctly long long ago.
> > 
> > And then we switched over to the "generic" table flushing (which
> > harkens back to the powerpc code).
> 
> Yes, we wrote it the RCU stuff to solve the races with SW walking,
> which is completely orthogonal with HW walking & TLB content. We didn't
> do the move to generic code though ;-)
> 
> > Which actually turned out to be not generic at all, and did not flush
> > the internal pages like x86 used to (back when x86 just used
> > tlb_remove_page for everything).
> 
> Well, having RCU do the flushing is rather generic, it makes sense
> whenever there's somebody doing a SW walk *and* you don't have IPIs to
> synchronize your flushes (ie, anybody with HW TLB invalidation
> broadcast basically, so ARM and us).

Right, so (many many years ago) I moved it over to generic code because
Sparc-hash wanted fast_gup and I figured having multiple copies of this
stuff wasn't ideal.

Then ARM came along and used it because it does the invalidate
broadcast.

And then when we switched x86 over last year or so; because paravirt; I
had long since forgotten all details and completely overlooked this.

Worse; somewhere along the line we tried to get s390 on this and they
ran into the exact problem being fixed now. That _should_ have been a
big clue, but somehow I never got around to thinking about it properly
and they went back to a private copy of all this.

So double fail on me I suppose :-/

Anyway, its sorted now; although I'd like to write me a fairly big
comment in asm-generic/tlb.h about things, before I forget again.
