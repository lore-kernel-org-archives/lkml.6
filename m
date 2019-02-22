Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2178CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AD9207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550819409;
	bh=T3DuHu8zi7Rs6rqUPIwtBA0kGWqU90a1m52mla277sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SLUZyw5TfBja/IrMvYIFvefLhfaDmZDOGZp4PjhyyX6nwDtyQQHabpg2GFfq9oUzT
	 lbLl7K2hJLrUsPRi9z9SheAI7H/p4CS9h5lZRTnOkp5GDrnh3LFcZid8lXXMshvfPj
	 PugLFLZ1NTfeWqpXciBrZLzsZS6U0q62fzYXyprE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfBVHKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:10:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:34132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfBVHKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:10:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9767AB98;
        Fri, 22 Feb 2019 07:10:04 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:10:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Junil Lee <junil0814.lee@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        pasha.tatashin@oracle.com, kirill.shutemov@linux.intel.com,
        jrdr.linux@gmail.com, dan.j.williams@intel.com,
        alexander.h.duyck@linux.intel.com, andreyknvl@google.com,
        arunks@codeaurora.org, keith.busch@intel.com, guro@fb.com,
        hannes@cmpxchg.org, rientjes@google.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        yuzhoujian@didichuxing.com
Subject: Re: [PATCH] mm, oom: OOM killer use rss size without shmem
Message-ID: <20190222071001.GA10588@dhcp22.suse.cz>
References: <1550810253-152925-1-git-send-email-junil0814.lee@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550810253-152925-1-git-send-email-junil0814.lee@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-02-19 13:37:33, Junil Lee wrote:
> The oom killer use get_mm_rss() function to estimate how free memory
> will be reclaimed when the oom killer select victim task.
> 
> However, the returned rss size by get_mm_rss() function was changed from
> "mm, shmem: add internal shmem resident memory accounting" commit.
> This commit makes the get_mm_rss() return size including SHMEM pages.

This was actually the case even before eca56ff906bdd because SHMEM was
just accounted to MM_FILEPAGES so this commit hasn't changed much
really.

Besides that we cannot really rule out SHMEM pages simply. They are
backing MAP_ANON|MAP_SHARED which might be unmapped and freed during the
oom victim exit. Moreover this is essentially the same as file backed
pages or even MAP_PRIVATE|MAP_ANON pages. Bothe can be pinned by other
processes e.g. via private pages via CoW mappings and file pages by
filesystem or simply mlocked by another process. So this really gross
evaluation will never be perfect. We would basically have to do exact
calculation of the freeable memory of each process and that is just not
feasible.

That being said, I do not think the patch is an improvement in that
direction. It just turnes one fuzzy evaluation by another that even
misses a lot of memory potentially.

> The oom killer can't get free memory from SHMEM pages directly after
> kill victim process, it leads to mis-calculate victim points.
> 
> Therefore, make new API as get_mm_rss_wo_shmem() which returns the rss
> value excluding SHMEM_PAGES.
> 
> Signed-off-by: Junil Lee <junil0814.lee@lge.com>
> ---
>  include/linux/mm.h | 6 ++++++
>  mm/oom_kill.c      | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2d483db..bca3acc 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1701,6 +1701,12 @@ static inline int mm_counter(struct page *page)
>  	return mm_counter_file(page);
>  }
>  
> +static inline unsigned long get_mm_rss_wo_shmem(struct mm_struct *mm)
> +{
> +	return get_mm_counter(mm, MM_FILEPAGES) +
> +		get_mm_counter(mm, MM_ANONPAGES);
> +}
> +
>  static inline unsigned long get_mm_rss(struct mm_struct *mm)
>  {
>  	return get_mm_counter(mm, MM_FILEPAGES) +
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 3a24848..e569737 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -230,7 +230,7 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
>  	 * The baseline for the badness score is the proportion of RAM that each
>  	 * task's rss, pagetable and swap space use.
>  	 */
> -	points = get_mm_rss(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
> +	points = get_mm_rss_wo_shmem(p->mm) + get_mm_counter(p->mm, MM_SWAPENTS) +
>  		mm_pgtables_bytes(p->mm) / PAGE_SIZE;
>  	task_unlock(p);
>  
> @@ -419,7 +419,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
>  
>  		pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
>  			task->pid, from_kuid(&init_user_ns, task_uid(task)),
> -			task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
> +			task->tgid, task->mm->total_vm, get_mm_rss_wo_shmem(task->mm),
>  			mm_pgtables_bytes(task->mm),
>  			get_mm_counter(task->mm, MM_SWAPENTS),
>  			task->signal->oom_score_adj, task->comm);
> -- 
> 2.6.2
> 

-- 
Michal Hocko
SUSE Labs
