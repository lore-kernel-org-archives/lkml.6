Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FB5C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59B4208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59B4208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbeGaM7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 08:59:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45114 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731639AbeGaM7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 08:59:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8979FAE92;
        Tue, 31 Jul 2018 11:19:25 +0000 (UTC)
Date:   Tue, 31 Jul 2018 13:19:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH v2] mm: terminate the reclaim early when direct reclaiming
Message-ID: <20180731111924.GI4557@dhcp22.suse.cz>
References: <1533035368-30911-1-git-send-email-zhaoyang.huang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533035368-30911-1-git-send-email-zhaoyang.huang@spreadtrum.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 19:09:28, Zhaoyang Huang wrote:
> This patch try to let the direct reclaim finish earlier than it used
> to be. The problem comes from We observing that the direct reclaim
> took a long time to finish when memcg is enabled. By debugging, we
> find that the reason is the softlimit is too low to meet the loop
> end criteria. So we add two barriers to judge if it has reclaimed
> enough memory as same criteria as it is in shrink_lruvec:
> 1. for each memcg softlimit reclaim.
> 2. before starting the global reclaim in shrink_zone.

Then I would really recommend to not use soft limit at all. It has
always been aggressive. I have propose to make it less so in the past we
have decided to go that way because we simply do not know whether
somebody depends on that behavior. Your changelog doesn't really tell
the whole story. Why is this a problem all of the sudden? Nothing has
really changed recently AFAICT. Cgroup v1 interface is mostly for
backward compatibility, we have much better ways to accomplish
workloads isolation in cgroup v2.

So why does it matter all of the sudden?

Besides that EXPORT_SYMBOL for such a low level functionality as the
memory reclaim is a big no-no.

So without a much better explanation and with a low level symbol
exported NAK from me.

> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
> ---
>  include/linux/memcontrol.h |  3 ++-
>  mm/memcontrol.c            |  3 +++
>  mm/vmscan.c                | 38 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6c6fb11..a7e82c7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -325,7 +325,8 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
>  void mem_cgroup_uncharge_list(struct list_head *page_list);
>  
>  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
> -
> +bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
> +			unsigned long nr_scanned, gfp_t gfp_mask, int order);
>  static struct mem_cgroup_per_node *
>  mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c0280b..e4efd46 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2577,6 +2577,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  			(next_mz == NULL ||
>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
>  			break;
> +		if (direct_reclaim_reach_watermark(pgdat, nr_reclaimed,
> +					*total_scanned, gfp_mask, order))
> +			break;
>  	} while (!nr_reclaimed);
>  	if (next_mz)
>  		css_put(&next_mz->memcg->css);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 03822f8..19503f3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2518,6 +2518,34 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
>  		(memcg && memcg_congested(pgdat, memcg));
>  }
>  
> +bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
> +		unsigned long nr_scanned, gfp_t gfp_mask,
> +		int order)
> +{
> +	struct scan_control sc = {
> +		.gfp_mask = gfp_mask,
> +		.order = order,
> +		.priority = DEF_PRIORITY,
> +		.nr_reclaimed = nr_reclaimed,
> +		.nr_scanned = nr_scanned,
> +	};
> +	if (!current_is_kswapd())
> +		return false;
> +	if (!IS_ENABLED(CONFIG_COMPACTION))
> +		return false;
> +	/*
> +	 * In fact, we add 1 to nr_reclaimed and nr_scanned to let should_continue_reclaim
> +	 * NOT return by finding they are zero, which means compaction_suitable()
> +	 * takes effect here to judge if we have reclaimed enough pages for passing
> +	 * the watermark and no necessary to check other memcg anymore.
> +	 */
> +	if (!should_continue_reclaim(pgdat,
> +				sc.nr_reclaimed + 1, sc.nr_scanned + 1, &sc))
> +		return true;
> +	return false;
> +}
> +EXPORT_SYMBOL(direct_reclaim_reach_watermark);
> +
>  static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	struct reclaim_state *reclaim_state = current->reclaim_state;
> @@ -2802,7 +2830,15 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  			sc->nr_scanned += nr_soft_scanned;
>  			/* need some check for avoid more shrink_zone() */
>  		}
> -
> +		/*
> +		 * we maybe have stolen enough pages from soft limit reclaim, so we return
> +		 * back if we are direct reclaim
> +		 */
> +		if (direct_reclaim_reach_watermark(zone->zone_pgdat, sc->nr_reclaimed,
> +						sc->nr_scanned, sc->gfp_mask, sc->order)) {
> +			sc->gfp_mask = orig_mask;
> +			return;
> +		}
>  		/* See comment about same check for global reclaim above */
>  		if (zone->zone_pgdat == last_pgdat)
>  			continue;
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
