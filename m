Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A638C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD4320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J9UI7BR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD4320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeLMKon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:44:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeLMKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tYDm78DkFS2iKTTNgES9rKe67JJgTH8deF3c7OmVFXs=; b=J9UI7BR3pq136gocDH1OpR6lX
        0wsVvPNDCtmRjKDbpTjxdv5eXbZMMK6NsNSAqyNAQaGCW2DgNE+8mZ4yo5Cko5DJD22TIkaUEZix9
        kprChBvAmqkGXjbWjXHUhBF0H74zY0n8kKRdrz/Tq1YmP62ihSFihNH+pSb9BdvTQ9CRLuM7cCg4g
        T4T7Mo/aePhr8wEl7sriK6tavnEbo5L9cuXjcCyGMnm1w2jKEtBEtF0kwLCdb1Vnp5mtfLMu93846
        xoIjH2b6m9HGCk6Czt4PtXC2ebkPArAtfnP2uLaQMeWGxXrAQYriuAQv0sWIQqV57+O61TZQj9nTo
        YbDxkiYWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXOTx-0000IB-5m; Thu, 13 Dec 2018 10:44:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B2ED207261FE; Thu, 13 Dec 2018 11:44:39 +0100 (CET)
Date:   Thu, 13 Dec 2018 11:44:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Morten.Rasmussen@arm.com
Subject: Re: [PATCH v2] sched/fair: fix 1 task per CPU
Message-ID: <20181213104439.GG5289@hirez.programming.kicks-ass.net>
References: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536590589-437-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 04:43:09PM +0200, Vincent Guittot wrote:
> When CPUs have different capacity because of RT/DL tasks or
> micro-architecture or max frequency differences, there are situation where
> the imbalance is not correctly set to migrate waiting task on the idle CPU.
> 
> The UC uses the force_balance case:
>
> 	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> 	    busiest->group_no_capacity)
> 		goto force_balance;
> 
> But calculate_imbalance fails to set the right amount of load to migrate
> a task because of the special condition:
>
>   busiest->avg_load <= sds->avg_load || local->avg_load >= sds->avg_load)
> 
> Add in fix_small_imbalance, this special case that triggered the force
> balance in order to make sure that the amount of load to migrate will be
> enough.

So I think this patch is going in the wrong direction for a number of
reasons:

 - we'd like to get rid of fix_small_imbalance(), and this adds to it;

 - the whole load_per_task stuff is terminally broken, it _cannot_ work
   right.


What I've suggested in the past is parameterizing the load balancer and
picking different criteria to balance on:

 - nr_running ; if there are idle CPUs around
 - utilization ; if there's idle time (u<1)
 - weight

And I suppose you're hitting one of the nr_running cases here.

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 309c93f..72bc5e8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8048,6 +8048,20 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
>  	local = &sds->local_stat;
>  	busiest = &sds->busiest_stat;
>  
> +	/*
> +	 * There is available capacity in local group and busiest group is
> +	 * overloaded but calculate_imbalance can't compute the amount of load
> +	 * to migrate because load_avg became meaningless due to asymetric
> +	 * capacity between groups. In such case, we only want to migrate at
> +	 * least one tasks of the busiest group and rely of the average load
> +	 * per task to ensure the migration.
> +	 */
> +	if (env->idle != CPU_NOT_IDLE && group_has_capacity(env, local) &&
> +	    busiest->group_no_capacity) {
> +		env->imbalance = busiest->load_per_task;
> +		return;
> +	}
> +
>  	if (!local->sum_nr_running)
>  		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
>  	else if (busiest->load_per_task > local->load_per_task)
> -- 
> 2.7.4
> 
