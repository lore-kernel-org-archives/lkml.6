Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8631CC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3342220875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AcLlzmcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3342220875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbeGXWRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:17:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44360 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbeGXWRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZW+d7LcHvUY0wD+TmRQdqHazSoRmSj6LibW2rnm4GqY=; b=AcLlzmcXpeTyQOh0o1AaJLg6Z
        7JOTMVrED2jEbJHRnxExcum7jP68Bu8qhsbuIF15WFOPgkJpVMiMT83O9HRnMp3f1JDmqhL/Pqwi5
        SHudqAzsBP86AovMFc7yvdlKwgUiTE0MxPGeCpia+2ppWt5vMDNpv1/ceAmS3DL+kGmEp4ZBs3l6e
        iw2EN/SnA4BGY6vp3r+Ispux41bktxa8+nSb3iuQ7ARfMtn1qMUwbFeB2l1RnBpfAqyXw/umtU5OU
        aiOEaDaTZDW3zmahU877z5tCQ/VYiCkP1Fnc8akcoI41/oxQTj/hC9epLGQGssdYw/Zzx6GuUyjLQ
        DUteFFZCQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi4Yd-0004fn-9j; Tue, 24 Jul 2018 21:09:23 +0000
Date:   Tue, 24 Jul 2018 14:09:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>,
        Salman Qazi <sqazi@google.com>, Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Alain Trinh <nullptr@google.com>
Subject: Re: [PATCH] RFC: clear 1G pages with streaming stores on x86
Message-ID: <20180724210923.GA20168@bombadil.infradead.org>
References: <20180724204639.26934-1-cannonmatthews@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724204639.26934-1-cannonmatthews@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:46:39PM -0700, Cannon Matthews wrote:
> Reimplement clear_gigantic_page() to clear gigabytes pages using the
> non-temporal streaming store instructions that bypass the cache
> (movnti), since an entire 1GiB region will not fit in the cache anyway.
> 
> Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
> average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
> and optimizing the control flow over the constituent small pages, this
> can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
> taking only 34 seconds on average, or 67ms/GiB.

This is great data ...

> - The calls to cond_resched() have been reduced from between every 4k
> page to every 64, as between all of the 256K page seemed overly
> frequent.  Does this seem like an appropriate frequency? On an idle
> system with many spare CPUs it get's rescheduled typically once or twice
> out of the 4096 times it calls cond_resched(), which seems like it is
> maybe the right amount, but more insight from a scheduling/latency point
> of view would be helpful.

... which makes the lack of data here disappointing -- what're the
comparable timings if you do check every 4kB or every 64kB instead of
every 256kB?

> The assembly code for the __clear_page_nt routine is more or less
> taken directly from the output of gcc with -O3 for this function with
> some tweaks to support arbitrary sizes and moving memory barriers:
> 
> void clear_page_nt_64i (void *page)
> {
>   for (int i = 0; i < GiB /sizeof(long long int); ++i)
>     {
>       _mm_stream_si64 (((long long int*)page) + i, 0);
>     }
>   sfence();
> }
> 
> In general I would love to hear any thoughts and feedback on this
> approach and any ways it could be improved.
> 
> Some specific questions:
> 
> - What is the appropriate method for defining an arch specific
> implementation like this, is the #ifndef code sufficient, and did stuff
> land in appropriate files?
> 
> - Are there any obvious pitfalls or caveats that have not been
> considered? In particular the iterator over mem_map_next() seemed like a
> no-op on x86, but looked like it could be important in certain
> configurations or architectures I am not familiar with.
> 
> - Are there any x86_64 implementations that do not support SSE2
> instructions like `movnti` ? What is the appropriate way to detect and
> code around that if so?

No.  SSE2 was introduced with the Pentium 4, before x86-64.  The XMM
registers are used as part of the x86-64 calling conventions, so SSE2
is mandatory for x86-64 implementations.

> - Is there anything that could be improved about the assembly code? I
> originally wrote it in C and don't have much experience hand writing x86
> asm, which seems riddled with optimization pitfalls.

I suspect it might be slightly faster if implemented as inline asm in the
x86 clear_gigantic_page() implementation instead of a function call.
Might not affect performance a lot though.

> - Is the highmem codepath really necessary? would 1GiB pages really be
> of much use on a highmem system? We recently removed some other parts of
> the code that support HIGHMEM for gigantic pages (see:
> http://lkml.kernel.org/r/20180711195913.1294-1-mike.kravetz@oracle.com)
> so this seems like a logical continuation.

PAE paging doesn't support 1GB pages, so there's no need for it on x86.

> diff --git a/mm/memory.c b/mm/memory.c
> index 7206a634270b..2515cae4af4e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -70,6 +70,7 @@
>  #include <linux/dax.h>
>  #include <linux/oom.h>
> 
> +
>  #include <asm/io.h>
>  #include <asm/mmu_context.h>
>  #include <asm/pgalloc.h>

Spurious.

