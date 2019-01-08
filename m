Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C526C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0C420827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546959586;
	bh=Mje+PYvn9ol6akJLrh00PZbUSBsR/DCuS5jvzzuDizM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P03E5/qkZ7XbN/1h7BePJPu5SGqSyNz1jUEdqiMGQDg2m9h/fudG/G0W3deuelfgK
	 KccJ3UB1O8l+4yAuCLmnwWAbzjP1S4SaJZMEdLOrlmXF2P6oB73scfTSthpHK0VNsG
	 cKhJUXu+nS/0rF8gzIEJQwuxtZxu1oodkMKWUE00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfAHO7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:59:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:56178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727785AbfAHO7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:59:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68197ABB1;
        Tue,  8 Jan 2019 14:59:43 +0000 (UTC)
Date:   Tue, 8 Jan 2019 15:59:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: schedule high reclaim for remote memcgs on
 high_work
Message-ID: <20190108145942.GZ31793@dhcp22.suse.cz>
References: <20190103015638.205424-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103015638.205424-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-01-19 17:56:38, Shakeel Butt wrote:
> If a memcg is over high limit, memory reclaim is scheduled to run on
> return-to-userland. However it is assumed that the memcg is the current
> process's memcg. With remote memcg charging for kmem or swapping in a
> page charged to remote memcg, current process can trigger reclaim on
> remote memcg. So, schduling reclaim on return-to-userland for remote
> memcgs will ignore the high reclaim altogether. So, punt the high
> reclaim of remote memcgs to high_work.

Have you seen this happening in real life workloads? And is this
offloading what we really want to do? I mean it is clearly the current
task that has triggered the remote charge so why should we offload that
work to a system? Is there any reason we cannot reclaim on the remote
memcg from the return-to-userland path?

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e9db1160ccbc..47439c84667a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2302,19 +2302,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * reclaim on returning to userland.  We can perform reclaim here
>  	 * if __GFP_RECLAIM but let's always punt for simplicity and so that
>  	 * GFP_KERNEL can consistently be used during reclaim.  @memcg is
> -	 * not recorded as it most likely matches current's and won't
> -	 * change in the meantime.  As high limit is checked again before
> -	 * reclaim, the cost of mismatch is negligible.
> +	 * not recorded as the return-to-userland high reclaim will only reclaim
> +	 * from current's memcg (or its ancestor). For other memcgs we punt them
> +	 * to work queue.
>  	 */
>  	do {
>  		if (page_counter_read(&memcg->memory) > memcg->high) {
> -			/* Don't bother a random interrupted task */
> -			if (in_interrupt()) {
> +			/*
> +			 * Don't bother a random interrupted task or if the
> +			 * memcg is not current's memcg's ancestor.
> +			 */
> +			if (in_interrupt() ||
> +			    !mm_match_cgroup(current->mm, memcg)) {
>  				schedule_work(&memcg->high_work);
> -				break;
> +			} else {
> +				current->memcg_nr_pages_over_high += batch;
> +				set_notify_resume(current);
>  			}
> -			current->memcg_nr_pages_over_high += batch;
> -			set_notify_resume(current);
>  			break;
>  		}
>  	} while ((memcg = parent_mem_cgroup(memcg)));
> -- 
> 2.20.1.415.g653613c723-goog
> 

-- 
Michal Hocko
SUSE Labs
