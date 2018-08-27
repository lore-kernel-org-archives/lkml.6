Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB599C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB6220837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB6220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeHaFb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:31:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:52115 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeHaFb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:31:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7RMDkGx019084;
        Mon, 27 Aug 2018 17:13:47 -0500
Message-ID: <30def1abb307dc4a2d232e69717d6755a1369492.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Tue, 28 Aug 2018 08:13:45 +1000
In-Reply-To: <20180827190213.6c7d85ca@roar.ozlabs.ibm.com>
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
         <20180827074701.GW24124@hirez.programming.kicks-ass.net>
         <20180827180458.4af9b2ac@roar.ozlabs.ibm.com>
         <4ef8a2aa44db971340b0bcc4f73d639455dd4282.camel@kernel.crashing.org>
         <20180827190213.6c7d85ca@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 19:02 +1000, Nicholas Piggin wrote:
> > More tlbies ? With the cost of the broadasts on the fabric ? I don't
> > think so.. or I'm not understanding your point...
> 
> More tlbies are no good, but there will be some places where it works
> out much better (and fewer tlbies). Worst possible case for current code
> is a big unmap with lots of scattered page sizes. We _should_ get that
> with just a single PID flush at the end, but what we will get today is
> a bunch of PID and VA flushes.
> 
> I don't propose doing that though, I'd rather be explicit about
> tracking start and end range of each page size. Still not "optimal"
> but neither is existing single range for sparse mappings... anyway it
> will need to be profiled, but my point is we don't really fit exactly
> what x86/arm want.

If we have an arch specific part, we could just remember up to N
"large" pages there without actually flushing, and if that overflows,
upgrade to a full flush.

Cheers,
Ben.

