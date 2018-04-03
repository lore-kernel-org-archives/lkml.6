Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbeDCIFH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 04:05:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752581AbeDCIFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 04:05:06 -0400
Date: Tue, 3 Apr 2018 10:05:03 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: hannes@cmpxchg.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid the unnecessary waiting when force empty a
 cgroup
Message-ID: <20180403080503.GE5501@dhcp22.suse.cz>
References: <1522739529-5602-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522739529-5602-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-04-18 15:12:09, Li RongQing wrote:
> The number of writeback and dirty page can be read out from memcg,
> the unnecessary waiting can be avoided by these counts

This changelog doesn't explain the problem and how the patch fixes it.
Why do wee another throttling when we do already throttle in the reclaim
path?

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  mm/memcontrol.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9ec024b862ac..5258651bd4ec 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2613,9 +2613,13 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  		progress = try_to_free_mem_cgroup_pages(memcg, 1,
>  							GFP_KERNEL, true);
>  		if (!progress) {
> +			unsigned long num;
> +
> +			num = memcg_page_state(memcg, NR_WRITEBACK) +
> +					memcg_page_state(memcg, NR_FILE_DIRTY);
>  			nr_retries--;
> -			/* maybe some writeback is necessary */
> -			congestion_wait(BLK_RW_ASYNC, HZ/10);
> +			if (num)
> +				congestion_wait(BLK_RW_ASYNC, HZ/10);
>  		}
>  
>  	}
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
