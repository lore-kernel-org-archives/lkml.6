Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5311C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6170C208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SHFhvC4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6170C208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH0PPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:15:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbeH0PPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aktKN+s5uQ2D3o2z3Qfms71MdZE+ETWHcagtvbilydM=; b=SHFhvC4WhhNyVmkzQ6QCX+tbO
        9eGW/yMkHjfiqNnfuUTUAsC3yyTsKw9ZjN4fN0Hr/rmz6ZWFlbYmxY6lbeTghhUTEZcnfwKfVHbJP
        aEeGXn2+iOGMcrJLlLLk9a2mwcBXX7WLl5Rx6R80D0IJkH0Q+OLrtmxRISgKIhtEeohHsWYDOODbC
        pxxQC9mH7FtE08WJqlvHOxh0ohzTL4tHdcUoGGYkzYZH6tgsgGrX/ZhRImB4F3Bz2w65Gq/jWNWpX
        w1j8EyTtwwtii5NH1LRboCJ6xYRFwUpxyhuhdJO7ZIY9svTBcLdkh/wccC38MJBuw7GWv1PLfEYfH
        FYsUd6HFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuFhF-00073i-Ta; Mon, 27 Aug 2018 11:28:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E427C2024EFCD; Mon, 27 Aug 2018 13:28:35 +0200 (CEST)
Date:   Mon, 27 Aug 2018 13:28:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org
Subject: Re: removig ia64, was: Re: [PATCH 3/4] mm/tlb, x86/mm: Support
 invalidating TLB caches for RCU_TABLE_FREE
Message-ID: <20180827112835.GC24124@hirez.programming.kicks-ass.net>
References: <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <20180824113214.GK24142@hirez.programming.kicks-ass.net>
 <20180824113953.GL24142@hirez.programming.kicks-ass.net>
 <20180827150008.13bce08f@roar.ozlabs.ibm.com>
 <20180827074701.GW24124@hirez.programming.kicks-ass.net>
 <20180827085708.GA27172@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827085708.GA27172@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:57:08AM -0700, Christoph Hellwig wrote:
> On Mon, Aug 27, 2018 at 09:47:01AM +0200, Peter Zijlstra wrote:
> > sh is trivial, arm seems doable, with a bit of luck we can do 'rm -rf
> > arch/ia64' leaving us with s390.
> 
> Is removing ia64 a serious plan?

I 'joked' about it a while ago on IRC, and aegl reacted that it might
not be entirely unreasonable.

> It is the cause for a fair share of
> oddities in dma lang, and I did not have much luck getting maintainer
> replies lately, but I didn't know of a plan to get rid of it.
> 
> What is the state of people still using ia64 mainline kernels vs just
> old distros in the still existing machines?

Both arjan and aegl said that the vast majority of people still running
ia64 machines run old distros.


