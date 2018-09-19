Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D337C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5F420858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eDr7FAe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5F420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeISVyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:54:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45390 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbeISVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9WLkTlbQhdFwEP9lmfFlDXbxXHvuUtWVM9pup0dgwC4=; b=eDr7FAe0T7b5JHOhkPDpBJelK
        ufHDRxB5Jst0CH+3EpyjVoaI31C+BK189P6oJLZSHWQESHnUWQeFZUxG908QepQKSOCwgV3mpTkrl
        KujBqxKBPbGybCiqmUzPeI8vTIhO5kFLvJjQ7u+OlAXO0/Qggxaz89QXgma4Udleu2Yo/QXAUn5iu
        Vzcm2nsLyEX/ZN0ijL0TeWRXEU0kytT6jX8z+0JiGlALvh+sYNnU8L20ZaSLcVWWgkfhsusV5DkKv
        JcTC0qGAGZiHsttkEwjrb0TA2yLn7OvboP5yqJ222nY/+lcQCafd77Tu3MG4ZJ9IZirYxSgm+xnHE
        6OufCoFJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2f8H-0003fo-Go; Wed, 19 Sep 2018 16:15:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8E472024E450; Wed, 19 Sep 2018 18:15:14 +0200 (CEST)
Date:   Wed, 19 Sep 2018 18:15:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] s390/tlb: convert to generic mmu_gather
Message-ID: <20180919161514.GK24124@hirez.programming.kicks-ass.net>
References: <20180918125151.31744-1-schwidefsky@de.ibm.com>
 <20180918125151.31744-3-schwidefsky@de.ibm.com>
 <20180919123849.GF24124@hirez.programming.kicks-ass.net>
 <20180919162809.30b5c416@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919162809.30b5c416@mschwideX1>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 04:28:09PM +0200, Martin Schwidefsky wrote:
> On Wed, 19 Sep 2018 14:38:49 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Sep 18, 2018 at 02:51:51PM +0200, Martin Schwidefsky wrote:

> > > +        page_table_free_rcu(tlb, (unsigned long *) pte, address);  
> > 
> > (whitespace damage, fixed)
> > 
> > Also, could you perhaps explain the need for that
> > page_table_alloc/page_table_free code? That is, I get the comment about
> > using 2K page-table fragments out of 4k physical page, but why this
> > custom allocator instead of kmem_cache? It feels like there's a little
> > extra complication, but it's not immediately obvious what.
> 
> The kmem_cache code uses the fields of struct page for its tracking.
> pgtable_page_ctor uses the same fields, e.g. for the ptl. Last time
> I tried to convert the page_table_alloc/page_table_free to kmem_cache
> it just crashed. Plus the split of 4K pages into 2 2K fragments is
> done on a per mm basis, that should help a little bit with fragmentation.

Fair enough, thanks for the information.

> > It's that ASCE limit that makes it impossible to use the generic
> > helpers, right?
> 
> There are two problems, one of them is related to the ASCE limit:
> 
> 1) s390 supports 4 different page table layouts. 2-levels (2^31 bytes) for 31-bit compat,
>    3-levels (2^42 bytes) as the default for 64-bit, 4-levels (2^53) if 4 tera-bytes are
>    not enough and 5-levels (2^64) for the bragging rights.
>    The pxd_free_tlb() turn into nops if the number of page table levels require it.

Shiny, I think we (x86) have to choose at boot time which paging mode we
want and have to stick to it.

> 2) The mm->context.flush_mm indication.
>    That goes back to this beauty in the architecture:
> 
>     * "A valid table entry must not be changed while it is attached
>     * to any CPU and may be used for translation by that CPU except to
>     * (1) invalidate the entry by using INVALIDATE PAGE TABLE ENTRY,
>     * or INVALIDATE DAT TABLE ENTRY, (2) alter bits 56-63 of a page
>     * table entry, or (3) make a change by means of a COMPARE AND SWAP
>     * AND PURGE instruction that purges the TLB."
> 
>    If one CPU is doing a mmu_gather page table operation on the only active thread
>    in the system the individual page table updates are done in a lazy fashion with
>    simple stores. If a second CPU picks up another thread for execution, the
>    attach_count is increased and the page table updates are done with IPTE/IDTE
>    from now on. But there might by TLBs of around that are not flushed yet.
>    We may *not* let the second CPU see these TLBs, otherwise the CPU may start an
>    instruction, then loose the TLB without being able to recreate it. Due to that
>    the CPU can end up with a half finished instruction it can not roll back nor
>    complete, ending in a check-stop. The simplest example is MVC with a length
>    of e.g. 256 bytes. The instruction has to complete with all 256 bytes moved,
>    or no bytes may have at all.
>    That is where the mm->context.flush_mm indication comes into play, if the
>    second CPU finds the bit set at the time it attaches a thread, it will to
>    an IDTE for flush all TLBs for the mm.

Oh man.. what fun. Still, this bit could easily be set in the
__*_free_tlb() functions afaict. Still 1) above is enough.

Thanks!
