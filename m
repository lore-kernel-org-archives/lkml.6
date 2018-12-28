Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849CFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DAE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546026367;
	bh=JhVqk03vJ2SuHy+HQaXKnEx81LWLfNN5NQeN/PiekM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WStu4Ld1IfQ5+/YxXiNj3l7GtYQ6/zDv8EA3VdSPkmo7g31/Grd8LqR/NRMyICQfs
	 hP2eNdKvcTY6lilyJmxy0Nk1h7QIlsk9eTqIexvsFJ2LpcaCdp5gByqX3OvhzRFUYG
	 koa9G7zrUsYlE8YCG4Y7s2OZI94Fh8JsfiqNOhdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbeL1TqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:46:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:39512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729815AbeL1TqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:46:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0A59AEB9;
        Fri, 28 Dec 2018 19:46:01 +0000 (UTC)
Date:   Fri, 28 Dec 2018 20:46:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Fengguang Wu <fengguang.wu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20181228194600.GX16738@dhcp22.suse.cz>
References: <20181226131446.330864849@intel.com>
 <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
 <20181228084105.GQ16738@dhcp22.suse.cz>
 <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com>
 <20181228121515.GS16738@dhcp22.suse.cz>
 <20181228131542.geshbmzvhr3litty@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228131542.geshbmzvhr3litty@wfg-t540p.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Mel and Andrea - the thread started
http://lkml.kernel.org/r/20181226131446.330864849@intel.com]

On Fri 28-12-18 21:15:42, Wu Fengguang wrote:
> On Fri, Dec 28, 2018 at 01:15:15PM +0100, Michal Hocko wrote:
> > On Fri 28-12-18 17:42:08, Wu Fengguang wrote:
> > [...]
> > > Those look unnecessary complexities for this post. This v2 patchset
> > > mainly fulfills our first milestone goal: a minimal viable solution
> > > that's relatively clean to backport. Even when preparing for new
> > > upstreamable versions, it may be good to keep it simple for the
> > > initial upstream inclusion.
> > 
> > On the other hand this is creating a new NUMA semantic and I would like
> > to have something long term thatn let's throw something in now and care
> > about long term later. So I would really prefer to talk about long term
> > plans first and only care about implementation details later.
> 
> That makes good sense. FYI here are the several in-house patches that
> try to leverage (but not yet integrate with) NUMA balancing. The last
> one is brutal force hacking. They obviously break original NUMA
> balancing logic.
> 
> Thanks,
> Fengguang

> >From ef41a542568913c8c62251021c3bc38b7a549440 Mon Sep 17 00:00:00 2001
> From: Liu Jingqi <jingqi.liu@intel.com>
> Date: Sat, 29 Sep 2018 23:29:56 +0800
> Subject: [PATCH 074/166] migrate: set PROT_NONE on the PTEs and let NUMA
>  balancing
> 
> Need to enable CONFIG_NUMA_BALANCING firstly.
> Set PROT_NONE on the PTEs that map to the page,
> and do the actual migration in the context of process which initiate migration.
> 
> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  mm/migrate.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b27a287081c2..d933f6966601 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1530,6 +1530,21 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  	if (page_mapcount(page) > 1 && !migrate_all)
>  		goto out_putpage;
>  
> +	if (flags & MPOL_MF_SW_YOUNG) {
> +		unsigned long start, end;
> +		unsigned long nr_pte_updates = 0;
> +
> +		start = max(addr, vma->vm_start);
> +
> +		/* TODO: if huge page  */
> +		end = ALIGN(addr + (1 << PAGE_SHIFT), PAGE_SIZE);
> +		end = min(end, vma->vm_end);
> +		nr_pte_updates = change_prot_numa(vma, start, end);
> +
> +		err = 0;
> +		goto out_putpage;
> +	}
> +
>  	if (PageHuge(page)) {
>  		if (PageHead(page)) {
>  			/* Check if the page is software young. */
> -- 
> 2.15.0
> 

> >From e617e8c2034387cbed50bafa786cf83528dbe3df Mon Sep 17 00:00:00 2001
> From: Fengguang Wu <fengguang.wu@intel.com>
> Date: Sun, 30 Sep 2018 10:50:58 +0800
> Subject: [PATCH 075/166] migrate: consolidate MPOL_MF_SW_YOUNG behaviors
> 
> - if page already in target node: SetPageReferenced
> - otherwise: change_prot_numa
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  arch/x86/kvm/Kconfig |  1 +
>  mm/migrate.c         | 65 +++++++++++++++++++++++++++++++---------------------
>  2 files changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 4c6dec47fac6..c103373536fc 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -100,6 +100,7 @@ config KVM_EPT_IDLE
>  	tristate "KVM EPT idle page tracking"
>  	depends on KVM_INTEL
>  	depends on PROC_PAGE_MONITOR
> +	depends on NUMA_BALANCING
>  	---help---
>  	  Provides support for walking EPT to get the A bits on Intel
>  	  processors equipped with the VT extensions.
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d933f6966601..d944f031c9ea 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1500,6 +1500,8 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  {
>  	struct vm_area_struct *vma;
>  	struct page *page;
> +	unsigned long end;
> +	unsigned int page_nid;
>  	unsigned int follflags;
>  	int err;
>  	bool migrate_all = flags & MPOL_MF_MOVE_ALL;
> @@ -1522,49 +1524,60 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  	if (!page)
>  		goto out;
>  
> -	err = 0;
> -	if (page_to_nid(page) == node)
> -		goto out_putpage;
> +	page_nid = page_to_nid(page);
>  
>  	err = -EACCES;
>  	if (page_mapcount(page) > 1 && !migrate_all)
>  		goto out_putpage;
>  
> -	if (flags & MPOL_MF_SW_YOUNG) {
> -		unsigned long start, end;
> -		unsigned long nr_pte_updates = 0;
> -
> -		start = max(addr, vma->vm_start);
> -
> -		/* TODO: if huge page  */
> -		end = ALIGN(addr + (1 << PAGE_SHIFT), PAGE_SIZE);
> -		end = min(end, vma->vm_end);
> -		nr_pte_updates = change_prot_numa(vma, start, end);
> -
> -		err = 0;
> -		goto out_putpage;
> -	}
> -
> +	err = 0;
>  	if (PageHuge(page)) {
> -		if (PageHead(page)) {
> -			/* Check if the page is software young. */
> -			if (flags & MPOL_MF_SW_YOUNG)
> +		if (!PageHead(page)) {
> +			err = -EACCES;
> +			goto out_putpage;
> +		}
> +		if (flags & MPOL_MF_SW_YOUNG) {
> +			if (page_nid == node)
>  				SetPageReferenced(page);
> -			isolate_huge_page(page, pagelist);
> -			err = 0;
> +			else if (PageAnon(page)) {
> +				end = addr + (hpage_nr_pages(page) << PAGE_SHIFT);
> +				if (end <= vma->vm_end)
> +					change_prot_numa(vma, addr, end);
> +			}
> +			goto out_putpage;
>  		}
> +		if (page_nid == node)
> +			goto out_putpage;
> +		isolate_huge_page(page, pagelist);
>  	} else {
>  		struct page *head;
>  
>  		head = compound_head(page);
> +
> +		if (flags & MPOL_MF_SW_YOUNG) {
> +			if (page_nid == node)
> +				SetPageReferenced(head);
> +			else {
> +				unsigned long size;
> +				size = hpage_nr_pages(head) << PAGE_SHIFT;
> +				end = addr + size;
> +				if (unlikely(addr & (size - 1)))
> +					err = -EXDEV;
> +				else if (likely(end <= vma->vm_end))
> +					change_prot_numa(vma, addr, end);
> +				else
> +					err = -ERANGE;
> +			}
> +			goto out_putpage;
> +		}
> +		if (page_nid == node)
> +			goto out_putpage;
> +
>  		err = isolate_lru_page(head);
>  		if (err)
>  			goto out_putpage;
>  
>  		err = 0;
> -		/* Check if the page is software young. */
> -		if (flags & MPOL_MF_SW_YOUNG)
> -			SetPageReferenced(head);
>  		list_add_tail(&head->lru, pagelist);
>  		mod_node_page_state(page_pgdat(head),
>  			NR_ISOLATED_ANON + page_is_file_cache(head),
> -- 
> 2.15.0
> 

> >From a2d9740d1639f807868014c16dc9e2620d356f3c Mon Sep 17 00:00:00 2001
> From: Fengguang Wu <fengguang.wu@intel.com>
> Date: Sun, 30 Sep 2018 19:22:27 +0800
> Subject: [PATCH 076/166] mempolicy: force NUMA balancing
> 
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>  mm/memory.c    | 3 ++-
>  mm/mempolicy.c | 5 -----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c467102a5cbc..20c7efdff63b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3775,7 +3775,8 @@ static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>  		*flags |= TNF_FAULT_LOCAL;
>  	}
>  
> -	return mpol_misplaced(page, vma, addr);
> +	return 0;
> +	/* return mpol_misplaced(page, vma, addr); */
>  }
>  
>  static vm_fault_t do_numa_page(struct vm_fault *vmf)
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index da858f794eb6..21dc6ba1d062 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2295,8 +2295,6 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  	int ret = -1;
>  
>  	pol = get_vma_policy(vma, addr);
> -	if (!(pol->flags & MPOL_F_MOF))
> -		goto out;
>  
>  	switch (pol->mode) {
>  	case MPOL_INTERLEAVE:
> @@ -2336,9 +2334,6 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
>  	/* Migrate the page towards the node whose CPU is referencing it */
>  	if (pol->flags & MPOL_F_MORON) {
>  		polnid = thisnid;
> -
> -		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
> -			goto out;
>  	}
>  
>  	if (curnid != polnid)
> -- 
> 2.15.0
> 


-- 
Michal Hocko
SUSE Labs
