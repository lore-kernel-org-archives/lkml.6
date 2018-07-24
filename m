Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E8BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974F820880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974F820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbeGXQLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:11:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53334 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388172AbeGXQLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:11:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063EA80D;
        Tue, 24 Jul 2018 08:04:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB7B03F237;
        Tue, 24 Jul 2018 08:04:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 77AAA1AE3B5E; Tue, 24 Jul 2018 16:04:49 +0100 (BST)
Date:   Tue, 24 Jul 2018 16:04:49 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Galbraith <efault@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Linux-MM <linux-mm@kvack.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 02/10] mm: workingset: tell cache transitions from
 workingset thrashing
Message-ID: <20180724150448.GA25412@arm.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-3-hannes@cmpxchg.org>
 <CAK8P3a3Nsmt54-ed_gWNev3CBS6_Sv5QGOw4G0sY4ZXOi1R4_Q@mail.gmail.com>
 <20180723152323.GA3699@cmpxchg.org>
 <CAK8P3a15K-TXYuFX-ZsJiroqA1GWX2XS4ioZSjcjJYgh1b_xSA@mail.gmail.com>
 <20180723162735.GA5980@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723162735.GA5980@cmpxchg.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:27:35PM -0400, Johannes Weiner wrote:
> On Mon, Jul 23, 2018 at 05:35:35PM +0200, Arnd Bergmann wrote:
> > On Mon, Jul 23, 2018 at 5:23 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 1b18b4722420..72c9b6778b0a 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -611,11 +611,13 @@ void __init mem_init(void)
> > >         BUILD_BUG_ON(TASK_SIZE_32                       > TASK_SIZE_64);
> > >  #endif
> > >
> > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > >         /*
> > 
> > I tested it on two broken configurations, and found that you have
> > a typo here, it should be 'ifdef', not 'ifndef'. With that change, it
> > seems to build fine.
> > 
> > Tested-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for testing it, I don't have a cross-compile toolchain set up.
> 
> ---

Thanks Arnd, Johannes. I can pick this up for -rc7 via the arm64 tree,
unless it's already queued elsewhere?

Will

> From 34c4c4549f09f971d2d391a8d652d56cb9b05475 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 23 Jul 2018 10:18:23 -0400
> Subject: [PATCH] arm64: fix vmemmap BUILD_BUG_ON() triggering on !vmemmap
>  setups
> 
> Arnd reports the following arm64 randconfig build error with the PSI
> patches that add another page flag:
> 
>   /git/arm-soc/arch/arm64/mm/init.c: In function 'mem_init':
>   /git/arm-soc/include/linux/compiler.h:357:38: error: call to
>   '__compiletime_assert_618' declared with attribute error: BUILD_BUG_ON
>   failed: sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT)
> 
> The additional page flag causes other information stored in
> page->flags to get bumped into their own struct page member:
> 
>   #if SECTIONS_WIDTH+ZONES_WIDTH+NODES_SHIFT+LAST_CPUPID_SHIFT <=
>   BITS_PER_LONG - NR_PAGEFLAGS
>   #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
>   #else
>   #define LAST_CPUPID_WIDTH 0
>   #endif
> 
>   #if defined(CONFIG_NUMA_BALANCING) && LAST_CPUPID_WIDTH == 0
>   #define LAST_CPUPID_NOT_IN_PAGE_FLAGS
>   #endif
> 
> which in turn causes the struct page size to exceed the size set in
> STRUCT_PAGE_MAX_SHIFT. This value is an an estimate used to size the
> VMEMMAP page array according to address space and struct page size.
> 
> However, the check is performed - and triggers here - on a !VMEMMAP
> config, which consumes an additional 22 page bits for the sparse
> section id. When VMEMMAP is enabled, those bits are returned, cpupid
> doesn't need its own member, and the page passes the VMEMMAP check.
> 
> Restrict that check to the situation it was meant to check: that we
> are sizing the VMEMMAP page array correctly.
> 
> Says Arnd:
> 
>     Further experiments show that the build error already existed before,
>     but was only triggered with larger values of CONFIG_NR_CPU and/or
>     CONFIG_NODES_SHIFT that might be used in actual configurations but
>     not in randconfig builds.
> 
>     With longer CPU and node masks, I could recreate the problem with
>     kernels as old as linux-4.7 when arm64 NUMA support got added.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable@vger.kernel.org
> Fixes: 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
> Fixes: 3e1907d5bf5a ("arm64: mm: move vmemmap region right below the linear region")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  arch/arm64/mm/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 1b18b4722420..86d9f9d303b0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -611,11 +611,13 @@ void __init mem_init(void)
>  	BUILD_BUG_ON(TASK_SIZE_32			> TASK_SIZE_64);
>  #endif
>  
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>  	/*
>  	 * Make sure we chose the upper bound of sizeof(struct page)
> -	 * correctly.
> +	 * correctly when sizing the VMEMMAP array.
>  	 */
>  	BUILD_BUG_ON(sizeof(struct page) > (1 << STRUCT_PAGE_MAX_SHIFT));
> +#endif
>  
>  	if (PAGE_SIZE >= 16384 && get_num_physpages() <= 128) {
>  		extern int sysctl_overcommit_memory;
> -- 
> 2.18.0
> 
