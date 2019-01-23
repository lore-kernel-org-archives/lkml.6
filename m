Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F3720861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfAWK2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:28:08 -0500
Received: from relay.sw.ru ([185.231.240.75]:53280 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAWK2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:28:08 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gmFlL-0006Uz-IP; Wed, 23 Jan 2019 13:28:03 +0300
Subject: Re: [RFC PATCH] mm: vmscan: do not iterate all mem cgroups for global
 direct reclaim
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@suse.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <fa1d9a1f-99c8-a4ae-da7f-ed90336497e9@virtuozzo.com>
Date:   Wed, 23 Jan 2019 13:28:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.2019 23:09, Yang Shi wrote:
> In current implementation, both kswapd and direct reclaim has to iterate
> all mem cgroups.  It is not a problem before offline mem cgroups could
> be iterated.  But, currently with iterating offline mem cgroups, it
> could be very time consuming.  In our workloads, we saw over 400K mem
> cgroups accumulated in some cases, only a few hundred are online memcgs.
> Although kswapd could help out to reduce the number of memcgs, direct
> reclaim still get hit with iterating a number of offline memcgs in some
> cases.  We experienced the responsiveness problems due to this
> occassionally.
> 
> Here just break the iteration once it reclaims enough pages as what
> memcg direct reclaim does.  This may hurt the fairness among memcgs
> since direct reclaim may awlays do reclaim from same memcgs.  But, it
> sounds ok since direct reclaim just tries to reclaim SWAP_CLUSTER_MAX
> pages and memcgs can be protected by min/low.

In case of we stop after SWAP_CLUSTER_MAX pages are reclaimed; it's possible
the following situation. Memcgs, which are closest to root_mem_cgroup, will
become empty, and you will have to iterate over empty memcg hierarchy long time,
just to find a not empty memcg.

I'd suggest, we should not lose fairness. We may introduce
mem_cgroup::last_reclaim_child parameter to save a child
(or its id), where the last reclaim was interrupted. Then
next reclaim should start from this child:

   memcg = mem_cgroup_iter(root, find_child(root->last_reclaim_child), &reclaim);
   do {  

      if ((!global_reclaim(sc) || !current_is_kswapd()) && 
           sc->nr_reclaimed >= sc->nr_to_reclaim) { 
               root->last_reclaim_child = memcg->id;
               mem_cgroup_iter_break(root, memcg);
               break; 
      }

Kirill
 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/vmscan.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a714c4f..ced5a16 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2764,16 +2764,15 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  				   sc->nr_reclaimed - reclaimed);
>  
>  			/*
> -			 * Direct reclaim and kswapd have to scan all memory
> -			 * cgroups to fulfill the overall scan target for the
> -			 * node.
> +			 * Kswapd have to scan all memory cgroups to fulfill
> +			 * the overall scan target for the node.
>  			 *
>  			 * Limit reclaim, on the other hand, only cares about
>  			 * nr_to_reclaim pages to be reclaimed and it will
>  			 * retry with decreasing priority if one round over the
>  			 * whole hierarchy is not sufficient.
>  			 */
> -			if (!global_reclaim(sc) &&
> +			if ((!global_reclaim(sc) || !current_is_kswapd()) &&
>  					sc->nr_reclaimed >= sc->nr_to_reclaim) {
>  				mem_cgroup_iter_break(root, memcg);
>  				break;
> 
