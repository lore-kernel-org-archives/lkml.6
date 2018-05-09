Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933830AbeEIHpM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:45:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57673 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933818AbeEIHpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:45:10 -0400
Date: Wed, 9 May 2018 09:45:08 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memcontrol: drain stocks on resize limit
Message-ID: <20180509074508.GC32366@dhcp22.suse.cz>
References: <20180504205548.110696-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504205548.110696-1-shakeelb@google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-05-18 13:55:48, Shakeel Butt wrote:
> Resizing the memcg limit for cgroup-v2 drains the stocks before
> triggering the memcg reclaim. Do the same for cgroup-v1 to make the
> behavior consistent.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 25b148c2d222..e2d33a37f971 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2463,6 +2463,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  				 unsigned long max, bool memsw)
>  {
>  	bool enlarge = false;
> +	bool drained = false;
>  	int ret;
>  	bool limits_invariant;
>  	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
> @@ -2493,6 +2494,12 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  		if (!ret)
>  			break;
>  
> +		if (!drained) {
> +			drain_all_stock(memcg);
> +			drained = true;
> +			continue;
> +		}
> +
>  		if (!try_to_free_mem_cgroup_pages(memcg, 1,
>  					GFP_KERNEL, !memsw)) {
>  			ret = -EBUSY;
> -- 
> 2.17.0.441.gb46fe60e1d-goog

-- 
Michal Hocko
SUSE Labs
