Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF1EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D042087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLSAvtni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D042087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbeH1Rkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:40:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH1Rkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5CPMsxfIsN4PKYXS+4hWOji19JVEqDgtUNxy1cVzNc4=; b=ZLSAvtniEydZws3SQHp/t8KZQ
        7L6RilZTfGudJN/B7IuUMjQ4OubSrhxV67TRH9sSn1jxJTzh5dvOrfMzVR46Npx15ilsHkEn4qn6d
        Bmq3VU6VXV1Ocj3/0W9LefpVvp/HK3G6L2pLWrmva4L9+8HeHt62totKJ0PjSYspXzRafQzvvm2Tb
        52PUf22OTYO2h2TvQoi2KTN2fnhvwnUTeJYKo3CMPpKmhGb9UPDAZaKiR/JMtLkLMEbr0T7dV0nl4
        bzgt2VOUhPP5X+68buV9oF+slkuny4lzlHwea5p+uvj6krOaY2DUXVPR50ecALyj48mwWwH/W04eJ
        72fnS7Rpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fueMN-0002ip-Kr; Tue, 28 Aug 2018 13:48:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B85C2024D706; Tue, 28 Aug 2018 15:48:42 +0200 (CEST)
Date:   Tue, 28 Aug 2018 15:48:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        benh@au1.ibm.com, torvalds@linux-foundation.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 08/11] asm-generic/tlb: Track freeing of page-table
 directories in struct mmu_gather
Message-ID: <20180828134842.GQ24142@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-9-git-send-email-will.deacon@arm.com>
 <20180827144457.3f4036e3@roar.ozlabs.ibm.com>
 <20180828134638.GK24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828134638.GK24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 03:46:38PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 27, 2018 at 02:44:57PM +1000, Nicholas Piggin wrote:
> 
> > powerpc may be able to use the unmap granule thing to improve
> > its page size dependent flushes, but it might prefer to go
> > a different way and track start-end for different page sizes.
> 
> I don't really see how tracking multiple ranges would help much with
> THP. The ranges would end up being almost the same if there is a good
> mix of page sizes.
> 
> But something like:
> 
> void tlb_flush_one(struct mmu_gather *tlb, unsigned long addr)
> {
> 	if (tlb->cleared_ptes && (addr << BITS_PER_LONG - PAGE_SHIFT))
> 		tblie_pte(addr);
> 	if (tlb->cleared_pmds && (addr << BITS_PER_LONG - PMD_SHIFT))
> 		tlbie_pmd(addr);
> 	if (tlb->cleared_puds && (addr << BITS_PER_LONG - PUD_SHIFT))
> 		tlbie_pud(addr);
> }

Sorry, those all should (of course) be !(addr << ...).

> void tlb_flush_range(struct mmu_gather *tlb)
> {
> 	unsigned long stride = 1UL << tlb_get_unmap_shift(tlb);
> 	unsigned long addr;
> 
> 	for (addr = tlb->start; addr < tlb->end; addr += stride)
> 		tlb_flush_one(tlb, addr);
> 
> 	ptesync();
> }

And one could; like x86 has; add a threshold above which you just kill
the complete mm.
