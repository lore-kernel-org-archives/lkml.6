Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCTUZ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:25:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45105 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:25:25 -0400
X-Google-Smtp-Source: AG47ELtllt1eMCYi+10VGm+6H9A4ZUmc6AxMVvR4EwantWF9HBMBk9otg/7hn9l40MImMwRtXyInCg==
Date: Tue, 20 Mar 2018 13:25:23 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, thp: do not cause memcg oom for thp
In-Reply-To: <20180320071624.GB23100@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.20.1803201321430.167205@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803191409420.124411@chino.kir.corp.google.com> <20180320071624.GB23100@dhcp22.suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Michal Hocko wrote:

> > Commit 2516035499b9 ("mm, thp: remove __GFP_NORETRY from khugepaged and
> > madvised allocations") changed the page allocator to no longer detect thp
> > allocations based on __GFP_NORETRY.
> > 
> > It did not, however, modify the mem cgroup try_charge() path to avoid oom
> > kill for either khugepaged collapsing or thp faulting.  It is never
> > expected to oom kill a process to allocate a hugepage for thp; reclaim is
> > governed by the thp defrag mode and MADV_HUGEPAGE, but allocations (and
> > charging) should fallback instead of oom killing processes.
> 
> For some reason I thought that the charging path simply bails out for
> costly orders - effectively the same thing as for the global OOM killer.
> But we do not. Is there any reason to not do that though? Why don't we
> simply do
> 

I'm not sure of the expectation of high-order memcg charging without 
__GFP_NORETRY, I only know that khugepaged can now cause memcg oom kills 
when trying to collapse memory, and then subsequently found that the same 
situation exists for faulting instead of falling back to small pages.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d1a917b5b7b7..08accbcd1a18 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1493,7 +1493,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
>  
>  static void mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  {
> -	if (!current->memcg_may_oom)
> +	if (!current->memcg_may_oom || order > PAGE_ALLOC_COSTLY_ORDER)
>  		return;
>  	/*
>  	 * We are in the middle of the charge context here, so we

That may make sense as an additional patch, but for thp allocations we 
don't want to retry reclaim nr_retries times anyway; we want the old 
behavior of __GFP_NORETRY before commit 2516035499b9.  So the above would 
be a follow-up patch that wouldn't replace mine.
