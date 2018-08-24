Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78759C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA6E2152B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA6E2152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeHXTZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:25:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbeHXTZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:25:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC40480D;
        Fri, 24 Aug 2018 08:50:02 -0700 (PDT)
Received: from brain-police (unknown [10.37.8.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1852F3F5BC;
        Fri, 24 Aug 2018 08:49:58 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:49:53 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20180824154953.GA15226@brain-police>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <20180824083556.GI24124@hirez.programming.kicks-ass.net>
 <20180824131332.GM24142@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824131332.GM24142@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Aug 24, 2018 at 03:13:32PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 24, 2018 at 10:35:56AM +0200, Peter Zijlstra wrote:
> 
> > Anyway, its sorted now; although I'd like to write me a fairly big
> > comment in asm-generic/tlb.h about things, before I forget again.
> 
> How's something like so? There's a little page_size thingy in this;
> mostly because I couldn't be arsed to split it for now.
> 
> Will has opinions on the page_size thing; I'll let him explain.

They're not especially strong opinions, it's just that I don't think the
page size is necessarily the right thing to track and I'd rather remove that
altogether.

In the patches I've hacked up (I'll post shortly as an RFC), I track the
levels of page-table instead so you can relate the mmu_gather explicitly
with the page-table structure, rather than have to infer it from the page
size. For example, if an architecture could put down huge mappings at the
pte level (e.g. using a contiguous hint in the pte like we have on arm64),
then actually you want to know about the level rather than the size. You can
also track the levels using only 4 bits in the gather structure.

Finally, both approaches have a funny corner case when a VMA contains a
mixture of granule sizes. With the "page size has changed so flush
synchronously" you can theoretically end up with a lot of flushes, where
you'd have been better off just invalidating the whole mm. If you track the
levels instead and postpone a flush using the smallest level you saw, then
you're likely to hit whatever threshold you have and nuke the mm.

Will
