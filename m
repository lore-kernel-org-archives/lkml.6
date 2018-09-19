Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DCC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C98F2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C98F2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbeISSAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:00:51 -0400
Received: from foss.arm.com ([217.140.101.70]:58372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbeISSAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:00:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D8BC7A9;
        Wed, 19 Sep 2018 05:23:10 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F1633F5BD;
        Wed, 19 Sep 2018 05:23:10 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 3B0FB1AE3029; Wed, 19 Sep 2018 13:23:29 +0100 (BST)
Date:   Wed, 19 Sep 2018 13:23:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180919122328.GB22723@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180914164857.GG6236@arm.com>
 <20180919115158.GD24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919115158.GD24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 01:51:58PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 14, 2018 at 05:48:57PM +0100, Will Deacon wrote:
> 
> > > + *  - mmu_gather::fullmm
> > > + *
> > > + *    A flag set by tlb_gather_mmu() to indicate we're going to free
> > > + *    the entire mm; this allows a number of optimizations.
> > > + *
> > > + *    XXX list optimizations
> > 
> > On arm64, we can elide the invalidation altogether because we won't
> > re-allocate the ASID. We also have an invalidate-by-ASID (mm) instruction,
> > which we could use if we needed to.
> 
> Right, but I was also struggling to put into words the normal fullmm
> case.
> 
> I now ended up with:
> 
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -82,7 +82,11 @@
>   *    A flag set by tlb_gather_mmu() to indicate we're going to free
>   *    the entire mm; this allows a number of optimizations.
>   *
> - *    XXX list optimizations
> + *    - We can ignore tlb_{start,end}_vma(); because we don't
> + *      care about ranges. Everything will be shot down.
> + *
> + *    - (RISC) architectures that use ASIDs can cycle to a new ASID
> + *      and delay the invalidation until ASID space runs out.
>   *
>   *  - mmu_gather::need_flush_all
>   *
> 
> Does that about cover things; or do we need more?

I think that's fine as a starting point. People can always add more.

> > > + *
> > > + *  - mmu_gather::need_flush_all
> > > + *
> > > + *    A flag that can be set by the arch code if it wants to force
> > > + *    flush the entire TLB irrespective of the range. For instance
> > > + *    x86-PAE needs this when changing top-level entries.
> > > + *
> > > + * And requires the architecture to provide and implement tlb_flush().
> > > + *
> > > + * tlb_flush() may, in addition to the above mentioned mmu_gather fields, make
> > > + * use of:
> > > + *
> > > + *  - mmu_gather::start / mmu_gather::end
> > > + *
> > > + *    which (when !need_flush_all; fullmm will have start = end = ~0UL) provides
> > > + *    the range that needs to be flushed to cover the pages to be freed.
> > 
> > I don't understand the mention of need_flush_all here -- I didn't think it
> > was used by the core code at all.
> 
> The core does indeed not use that flag; but if the architecture set
> that, the range is still ignored.
> 
> Can you suggest clearer wording?

The range is only ignored if the default tlb_flush() implementation is used
though, right? Since this text is about the fields that tlb_flush() can use,
I think we can just delete the part in brackets.

Will
