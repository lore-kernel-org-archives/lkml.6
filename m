Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C12C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0186C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548237572;
	bh=48I28Wa9i1kZzRd5ktuLojuiUHxADxjZx+QOIEgLNkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w2dcGBdPx0zP/D1afl72JSdDPrCaJ73tWI5VzsFaE+Y2UXnDs7aQvOfG0wNxfU7lM
	 D/8l93phzVIaHJZNiXfp0s0cwTnxgBePugsZbT/zNyOiXDvCTFljo0H/+e6dx1UYCk
	 A6BfROoQMxIVs9OSolmowt5QZAMFc/oUPQCMX6HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfAWJ7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:59:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:44360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726804AbfAWJ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:59:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 393BCB05D;
        Wed, 23 Jan 2019 09:59:28 +0000 (UTC)
Date:   Wed, 23 Jan 2019 10:59:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: vmscan: do not iterate all mem cgroups for
 global direct reclaim
Message-ID: <20190123095926.GS4087@dhcp22.suse.cz>
References: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548187782-108454-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 04:09:42, Yang Shi wrote:
> In current implementation, both kswapd and direct reclaim has to iterate
> all mem cgroups.  It is not a problem before offline mem cgroups could
> be iterated.  But, currently with iterating offline mem cgroups, it
> could be very time consuming.  In our workloads, we saw over 400K mem
> cgroups accumulated in some cases, only a few hundred are online memcgs.
> Although kswapd could help out to reduce the number of memcgs, direct
> reclaim still get hit with iterating a number of offline memcgs in some
> cases.  We experienced the responsiveness problems due to this
> occassionally.

Can you provide some numbers?

> Here just break the iteration once it reclaims enough pages as what
> memcg direct reclaim does.  This may hurt the fairness among memcgs
> since direct reclaim may awlays do reclaim from same memcgs.  But, it
> sounds ok since direct reclaim just tries to reclaim SWAP_CLUSTER_MAX
> pages and memcgs can be protected by min/low.

OK, this makes some sense to me. The purpose of the direct reclaim is
to reclaim some memory and throttle the allocation pace. The iterator is
cached so the next reclaimer on the same hierarchy will simply continue
so the fairness should be more or less achieved.

Btw. is there any reason to keep !global_reclaim() check in place? Why
is it not sufficient to exclude kswapd?

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
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
