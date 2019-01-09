Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2304BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF04214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547019254;
	bh=8PytefKK9/XxWer9pGiOQ1OyEEKym+nw+2qwtq1wDKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LBjdDFjHHLRNhBAMo0QI4Ac4IpYa7rJxgRYL78NTqHgtd8sebtaenyqC0PlK+VxpQ
	 QC9qg7bzRCVUiyLsYDlwP8vArukGoP60s4z4+I2dPAd/JBhMxId0MMOX/Fqnvp/6QE
	 TtIvSO2ULCdvu9ZoVe3W7L+1ZVkTU0v31L23C9sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfAIHeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:34:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:45846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728590AbfAIHeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:34:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2F906ACB8;
        Wed,  9 Jan 2019 07:34:11 +0000 (UTC)
Date:   Wed, 9 Jan 2019 08:34:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net,
        tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_owner: fix for deferred struct page init
Message-ID: <20190109073409.GA2027@dhcp22.suse.cz>
References: <20181220092202.GD14234@dhcp22.suse.cz>
 <20181220185031.43146-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220185031.43146-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 20-12-18 13:50:31, Qian Cai wrote:
> When booting a system with "page_owner=on",
> 
> start_kernel
>   page_ext_init
>     invoke_init_callbacks
>       init_section_page_ext
>         init_page_owner
>           init_early_allocated_pages
>             init_zones_in_node
>               init_pages_in_zone
>                 lookup_page_ext
>                   page_to_nid
> 
> The issue here is that page_to_nid() will not work since some page
> flags have no node information until later in page_alloc_init_late() due
> to DEFERRED_STRUCT_PAGE_INIT. Hence, it could trigger an out-of-bounds
> access with an invalid nid.
> 
> [    8.666047] UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
> [    8.672603] index 7 is out of range for type 'zone [5]'
> 
> Also, kernel will panic since flags were poisoned earlier with,
> 
> CONFIG_DEBUG_VM_PGFLAGS=y
> CONFIG_NODE_NOT_IN_PAGE_FLAGS=n
> 
> start_kernel
>   setup_arch
>     pagetable_init
>       paging_init
>         sparse_init
>           sparse_init_nid
>             memblock_alloc_try_nid_raw
> 
> Although later it tries to set page flags for pages in reserved bootmem
> regions,
> 
> mm_init
>   mem_init
>     memblock_free_all
>       free_low_memory_core_early
>         reserve_bootmem_region
> 
> there could still have some freed pages from the page allocator but yet
> to be initialized due to DEFERRED_STRUCT_PAGE_INIT. It have already been
> dealt with a bit in page_ext_init().
> 
> * Take into account DEFERRED_STRUCT_PAGE_INIT.
> */
> if (early_pfn_to_nid(pfn) != nid)
> 	continue;
> 
> However it did not handle it well in init_pages_in_zone() which end up
> calling page_to_nid().
> 
> [   11.917212] page:ffffea0004200000 is uninitialized and poisoned
> [   11.917220] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
> ffffffffffffffff
> [   11.921745] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
> ffffffffffffffff
> [   11.924523] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> [   11.926498] page_owner info is not active (free page?)
> [   12.329560] kernel BUG at include/linux/mm.h:990!
> [   12.337632] RIP: 0010:init_page_owner+0x486/0x520
> 
> Since there is no other routines depend on page_ext_init() in
> start_kernel() and no real benefit to call it so early, just move it
> after page_alloc_init_late() to ensure that there is no deferred pages
> need to de dealt with.

The last paragraph should be updated. I would propose something like
this.

"
This means that assumptions behind fe53ca54270a ("mm: use
early_pfn_to_nid in page_ext_init") are incomplete. Therefore revert the
commit for now. A proper way to move the page_owner initialization to
sooner is to hook into memmap initialization.
"
> 

Fixes: fe53ca54270a ("mm: use early_pfn_to_nid in page_ext_init")

> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> v2: postpone init_page_ext() to after page_alloc_init_late().
> 
>  init/main.c   | 2 +-
>  mm/page_ext.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 2b7b7fe173c9..1aeb062b2cb7 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -696,7 +696,6 @@ asmlinkage __visible void __init start_kernel(void)
>  		initrd_start = 0;
>  	}
>  #endif
> -	page_ext_init();
>  	kmemleak_init();
>  	setup_per_cpu_pageset();
>  	numa_policy_init();
> @@ -1147,6 +1146,7 @@ static noinline void __init kernel_init_freeable(void)
>  	sched_init_smp();
>  
>  	page_alloc_init_late();
> +	page_ext_init();
>  
>  	do_basic_setup();
>  
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index ae44f7adbe07..d76fd51e312a 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -399,9 +399,8 @@ void __init page_ext_init(void)
>  			 * -------------pfn-------------->
>  			 * N0 | N1 | N2 | N0 | N1 | N2|....
>  			 *
> -			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
>  			 */
> -			if (early_pfn_to_nid(pfn) != nid)
> +			if (pfn_to_nid(pfn) != nid)
>  				continue;
>  			if (init_section_page_ext(pfn, nid))
>  				goto oom;
> -- 
> 2.17.2 (Apple Git-113)

-- 
Michal Hocko
SUSE Labs
