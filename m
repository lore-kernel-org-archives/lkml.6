Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4477BECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ABA2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z0At4YmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2ABA2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeISR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:29:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeISR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g+dYSE5aYbhNouPSdm+qXkWadjt9UoqlZ9O18PuXOM0=; b=Z0At4YmNmBZsNH+mk7prOx6nu
        aE8TMI5vSEDj2+fnl2M7wW5XI8J4WfXd7JstlvXQoigaB39vzYMnyJiq4sACCAhmLzvnsB0pS2hLn
        A/X8lbxH2ypfLCcp+sfQFk1LRFNXtxK+92IgryBIXxZFeVgDTjEcnqr1RzDuJC9M7t76B8h118+w3
        ed9xu9Y5lO5UKGjRpFRqxXjfZJeJiKmMdyysYBmTWIM5UK2fVUInMKR3xrtjewpvITzuJP6Hde0pC
        HF2wMLbD1qnVP62RNRcLplWZWnMjN9WHNb6jLBjdaA50X30DZUDStUH6sF56hUZFQaMaU4g8rPx7d
        roq48Hjkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2b1U-0008Pk-2R; Wed, 19 Sep 2018 11:52:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40C042024E441; Wed, 19 Sep 2018 13:51:58 +0200 (CEST)
Date:   Wed, 19 Sep 2018 13:51:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com
Subject: Re: [RFC][PATCH 01/11] asm-generic/tlb: Provide a comment
Message-ID: <20180919115158.GD24124@hirez.programming.kicks-ass.net>
References: <20180913092110.817204997@infradead.org>
 <20180913092811.894806629@infradead.org>
 <20180914164857.GG6236@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914164857.GG6236@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 05:48:57PM +0100, Will Deacon wrote:

> > + *  - mmu_gather::fullmm
> > + *
> > + *    A flag set by tlb_gather_mmu() to indicate we're going to free
> > + *    the entire mm; this allows a number of optimizations.
> > + *
> > + *    XXX list optimizations
> 
> On arm64, we can elide the invalidation altogether because we won't
> re-allocate the ASID. We also have an invalidate-by-ASID (mm) instruction,
> which we could use if we needed to.

Right, but I was also struggling to put into words the normal fullmm
case.

I now ended up with:

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -82,7 +82,11 @@
  *    A flag set by tlb_gather_mmu() to indicate we're going to free
  *    the entire mm; this allows a number of optimizations.
  *
- *    XXX list optimizations
+ *    - We can ignore tlb_{start,end}_vma(); because we don't
+ *      care about ranges. Everything will be shot down.
+ *
+ *    - (RISC) architectures that use ASIDs can cycle to a new ASID
+ *      and delay the invalidation until ASID space runs out.
  *
  *  - mmu_gather::need_flush_all
  *

Does that about cover things; or do we need more?

> > + *
> > + *  - mmu_gather::need_flush_all
> > + *
> > + *    A flag that can be set by the arch code if it wants to force
> > + *    flush the entire TLB irrespective of the range. For instance
> > + *    x86-PAE needs this when changing top-level entries.
> > + *
> > + * And requires the architecture to provide and implement tlb_flush().
> > + *
> > + * tlb_flush() may, in addition to the above mentioned mmu_gather fields, make
> > + * use of:
> > + *
> > + *  - mmu_gather::start / mmu_gather::end
> > + *
> > + *    which (when !need_flush_all; fullmm will have start = end = ~0UL) provides
> > + *    the range that needs to be flushed to cover the pages to be freed.
> 
> I don't understand the mention of need_flush_all here -- I didn't think it
> was used by the core code at all.

The core does indeed not use that flag; but if the architecture set
that, the range is still ignored.

Can you suggest clearer wording?
