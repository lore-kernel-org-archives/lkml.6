Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0DAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A3320837
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A3320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbeHWRJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:09:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46548 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730963AbeHWRJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:09:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D17C0ED1;
        Thu, 23 Aug 2018 06:40:04 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C24A3F675;
        Thu, 23 Aug 2018 06:40:03 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:39:59 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180823133958.GA1496@brain-police>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:11:41PM -0700, Linus Torvalds wrote:
> On Wed, Aug 22, 2018 at 9:54 PM Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> >
> >
> > So we do need a different flush instruction for the page tables vs. the
> > normal TLB pages.
> 
> Right. ARM wants it too. x86 is odd in that a regular "invlpg" already
> invalidates all the internal tlb cache nodes.
> 
> So the "new world order" is exactly that patch that PeterZ sent you, that adds a
> 
> +       unsigned int            freed_tables : 1;
> 
> to the 'struct mmu_gather', and then makes all those
> pte/pmd/pud/p4d_free_tlb() functions set that bit.
> 
> So I'm referring to the email PeterZ sent you in this thread that said:
> 
>   Nick, Will is already looking at using this to remove the synchronous
>   invalidation from __p*_free_tlb() for ARM, could you have a look to see
>   if PowerPC-radix could benefit from that too?
> 
>   Basically, using a patch like the below, would give your tlb_flush()
>   information on if tables were removed or not.
> 
> then, in that model, you do *not* need to override these
> pte/pmd/pud/p4d_free_tlb() macros at all (well, you *can* if you want
> to, for doing games with the range modification, but let's sayt that
> you don't need that right now).
> 
> So instead, when you get to the actual "tlb_flush(tlb)", you do
> exactly that - flush the tlb. And the mmu_gather structure shows you
> how much you need to flush. If you see that "freed_tables" is set,
> then you know that you need to also do the special instruction to
> flush the inner level caches. The range continues to show the page
> range.

The only problem with this approach is that we've lost track of the granule
size by the point we get to the tlb_flush(), so we can't adjust the stride of
the TLB invalidations for huge mappings, which actually works nicely in the
synchronous case (e.g. we perform a single invalidation for a 2MB mapping,
rather than iterating over it at a 4k granule).

One thing we could do is switch to synchronous mode if we detect a change in
granule (i.e. treat it like a batch failure).

Will
