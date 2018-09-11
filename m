Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4661EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A8320833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A8320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbeIKRKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbeIKRKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:10:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 076C0AFC4;
        Tue, 11 Sep 2018 12:11:42 +0000 (UTC)
Date:   Tue, 11 Sep 2018 14:11:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH RFC] mm: don't raise MEMCG_OOM event due to failed
 high-order allocation
Message-ID: <20180911121141.GS10951@dhcp22.suse.cz>
References: <20180910215622.4428-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910215622.4428-1-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-09-18 14:56:22, Roman Gushchin wrote:
> The memcg OOM killer is never invoked due to a failed high-order
> allocation, however the MEMCG_OOM event can be easily raised.
> 
> Under some memory pressure it can happen easily because of a
> concurrent allocation. Let's look at try_charge(). Even if we were
> able to reclaim enough memory, this check can fail due to a race
> with another allocation:
> 
>     if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
>         goto retry;
> 
> For regular pages the following condition will save us from triggering
> the OOM:
> 
>    if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
>        goto retry;
> 
> But for high-order allocation this condition will intentionally fail.
> The reason behind is that we'll likely fall to regular pages anyway,
> so it's ok and even preferred to return ENOMEM.
> 
> In this case the idea of raising the MEMCG_OOM event looks dubious.

Why is this a problem though? IIRC this event was deliberately placed
outside of the oom path because we wanted to count allocation failures
and this is also documented that way

          oom
                The number of time the cgroup's memory usage was
                reached the limit and allocation was about to fail.

                Depending on context result could be invocation of OOM
                killer and retrying allocation or failing a

One could argue that we do not apply the same logic to GFP_NOWAIT
requests but in general I would like to see a good reason to change
the behavior and if it is really the right thing to do then we need to
update the documentation as well.

> Fix this by moving MEMCG_OOM raising to  mem_cgroup_oom() after
> allocation order check, so that the event won't be raised for high
> order allocations.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index fcec9b39e2a3..103ca3c31c04 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1669,6 +1669,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  	if (order > PAGE_ALLOC_COSTLY_ORDER)
>  		return OOM_SKIPPED;
>  
> +	memcg_memory_event(memcg, MEMCG_OOM);
> +
>  	/*
>  	 * We are in the middle of the charge context here, so we
>  	 * don't want to block when potentially sitting on a callstack
> @@ -2250,8 +2252,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (fatal_signal_pending(current))
>  		goto force;
>  
> -	memcg_memory_event(mem_over_limit, MEMCG_OOM);
> -
>  	/*
>  	 * keep retrying as long as the memcg oom killer is able to make
>  	 * a forward progress or bypass the charge if the oom killer
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
