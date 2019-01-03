Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46CEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD08121871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546534773;
	bh=GUcK7adDrEvUldoyjlN3VqhjNeKxgNIqLXnMrx3NPu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=elZ7d36NHAeMgY4//SqfQHahfjHruBA5kwGLSg9CjKFIHJVSm9Tj5whA1XMbk7CjD
	 10BLYhqP8oI1LjAOhl6TFdRjM1pqAfFJvg5U/RJNIoc9gM2+oGqxI+93Pdf3KstT5v
	 JU23YvHitgC0LEvpuXSByb1Ni32PDtoerrkgCqpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfACQ7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:59:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:47354 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731225AbfACQ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:59:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F7E4AEB9;
        Thu,  3 Jan 2019 16:59:29 +0000 (UTC)
Date:   Thu, 3 Jan 2019 17:59:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, yang.shi@linaro.org, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
Message-ID: <20190103165927.GU31793@dhcp22.suse.cz>
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw>
 <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-01-19 11:38:31, Qian Cai wrote:
> On 1/3/19 6:51 AM, Michal Hocko wrote:
> > On Thu 20-12-18 15:31:56, Qian Cai wrote:
> >> When booting a system with "page_owner=on",
> >>
> >> start_kernel
> >>   page_ext_init
> >>     invoke_init_callbacks
> >>       init_section_page_ext
> >>         init_page_owner
> >>           init_early_allocated_pages
> >>             init_zones_in_node
> >>               init_pages_in_zone
> >>                 lookup_page_ext
> >>                   page_to_nid
> >>
> >> The issue here is that page_to_nid() will not work since some page
> >> flags have no node information until later in page_alloc_init_late() due
> >> to DEFERRED_STRUCT_PAGE_INIT. Hence, it could trigger an out-of-bounds
> >> access with an invalid nid.
> >>
> >> [    8.666047] UBSAN: Undefined behaviour in ./include/linux/mm.h:1104:50
> >> [    8.672603] index 7 is out of range for type 'zone [5]'
> >>
> >> Also, kernel will panic since flags were poisoned earlier with,
> >>
> >> CONFIG_DEBUG_VM_PGFLAGS=y
> >> CONFIG_NODE_NOT_IN_PAGE_FLAGS=n
> >>
> >> start_kernel
> >>   setup_arch
> >>     pagetable_init
> >>       paging_init
> >>         sparse_init
> >>           sparse_init_nid
> >>             memblock_alloc_try_nid_raw
> >>
> >> Although later it tries to set page flags for pages in reserved bootmem
> >> regions,
> >>
> >> mm_init
> >>   mem_init
> >>     memblock_free_all
> >>       free_low_memory_core_early
> >>         reserve_bootmem_region
> >>
> >> there could still have some freed pages from the page allocator but yet
> >> to be initialized due to DEFERRED_STRUCT_PAGE_INIT. It have already been
> >> dealt with a bit in page_ext_init().
> >>
> >> * Take into account DEFERRED_STRUCT_PAGE_INIT.
> >> */
> >> if (early_pfn_to_nid(pfn) != nid)
> >> 	continue;
> >>
> >> However, it did not handle it well in init_pages_in_zone() which end up
> >> calling page_to_nid().
> >>
> >> [   11.917212] page:ffffea0004200000 is uninitialized and poisoned
> >> [   11.917220] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
> >> ffffffffffffffff
> >> [   11.921745] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
> >> ffffffffffffffff
> >> [   11.924523] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> >> [   11.926498] page_owner info is not active (free page?)
> >> [   12.329560] kernel BUG at include/linux/mm.h:990!
> >> [   12.337632] RIP: 0010:init_page_owner+0x486/0x520
> >>
> >> Since there is no other routines depend on page_ext_init() in
> >> start_kernel(), just move it after page_alloc_init_late() to ensure that
> >> there is no deferred pages need to de dealt with. If deselected
> >> DEFERRED_STRUCT_PAGE_INIT, it is still better to call page_ext_init()
> >> earlier, so page owner could catch more early page allocation call
> >> sites. This gives us a good compromise between catching good and bad
> >> call sites (See the v1 patch [1]) in case of DEFERRED_STRUCT_PAGE_INIT.
> >>
> >> [1] https://lore.kernel.org/lkml/20181220060303.38686-1-cai@lca.pw/
> >>
> >> Fixes: fe53ca54270 (mm: use early_pfn_to_nid in page_ext_init)
> >> Suggested-by: Michal Hocko <mhocko@kernel.org>
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >> ---
> >>
> >> v3: still call page_ext_init() earlier if DEFERRED_STRUCT_PAGE_INIT=n.
> >>
> >> v2: postpone page_ext_init() to after page_alloc_init_late().
> >>
> >>  init/main.c   | 5 +++++
> >>  mm/page_ext.c | 3 +--
> >>  2 files changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/init/main.c b/init/main.c
> >> index 2b7b7fe173c9..5d9904370f76 100644
> >> --- a/init/main.c
> >> +++ b/init/main.c
> >> @@ -696,7 +696,9 @@ asmlinkage __visible void __init start_kernel(void)
> >>  		initrd_start = 0;
> >>  	}
> >>  #endif
> >> +#ifndef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >>  	page_ext_init();
> >> +#endif
> >>  	kmemleak_init();
> >>  	setup_per_cpu_pageset();
> >>  	numa_policy_init();
> >> @@ -1147,6 +1149,9 @@ static noinline void __init kernel_init_freeable(void)
> >>  	sched_init_smp();
> >>  
> >>  	page_alloc_init_late();
> >> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >> +	page_ext_init();
> >> +#endif
> >>  
> >>  	do_basic_setup();
> > 
> > Is this really necessary? Why cannot we simply postpone page_ext_init
> > unconditioanally?
> 
> As mentioned above, "If deselected DEFERRED_STRUCT_PAGE_INIT, it is still better
> to call page_ext_init() earlier, so page owner could catch more early page
> allocation call sites."

Do you have any numbers to show how many allocation are we losing that
way? In other words, do we care enough to create an ugly code?

> >> diff --git a/mm/page_ext.c b/mm/page_ext.c
> >> index ae44f7adbe07..d76fd51e312a 100644
> >> --- a/mm/page_ext.c
> >> +++ b/mm/page_ext.c
> >> @@ -399,9 +399,8 @@ void __init page_ext_init(void)
> >>  			 * -------------pfn-------------->
> >>  			 * N0 | N1 | N2 | N0 | N1 | N2|....
> >>  			 *
> >> -			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
> >>  			 */
> >> -			if (early_pfn_to_nid(pfn) != nid)
> >> +			if (pfn_to_nid(pfn) != nid)
> >>  				continue;
> >>  			if (init_section_page_ext(pfn, nid))
> >>  				goto oom;
> > 
> > Also this doesn't seem to be related, right?
> 
> No, it is related. Because of this patch, page_ext_init() is called after all
> the memory has already been initialized,
> so no longer necessary to call early_pfn_to_nid().

Yes, but it looks like a follow up cleanup/optimization to me.
-- 
Michal Hocko
SUSE Labs
