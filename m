Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BC8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314D220839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XHBGUBaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314D220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeHaStq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:49:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeHaStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MOqiY+qUkOIgh5+2M5RPTQ6GsfoDgjaZ/+YIBrUb1es=; b=XHBGUBaa9X4GQrjOtu2SnePd7
        K4H/BRnbhq38Ls9cqMe64xzudCXb/76kTZu8FCqQJg4EMozjl1fmG38uHD9nKXiyLrvBgSkZC5ymx
        8u9Nv/jNXOI9RdQVIFWQwiDxdO0YstMyiswspzod1wO1l/d1FK54IxOje99ZhRdpCOb1wVC+BHVct
        yCeQXZ7JH+Bl+b+ftyUsmEKFV2ag/nQosAclE1ol1Zw+4s1mLXtlIdq1dE+4hSe6IDeu3ARII7eaP
        bzgNCJojRmHTlN1JQphFj5hGgLymAA3tSiTyoMeyFamm+FR0ySoADtPu8dOnMmRB0eH756UKyw6Tc
        SCyM2NM9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvkcW-0001EL-08; Fri, 31 Aug 2018 14:41:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 640822027215E; Fri, 31 Aug 2018 16:41:46 +0200 (CEST)
Date:   Fri, 31 Aug 2018 16:41:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/pelt: fix update_blocked_averages() for dl and rt
Message-ID: <20180831144146.GO24124@hirez.programming.kicks-ass.net>
References: <1535723908-10779-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535723908-10779-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:58:28PM +0200, Vincent Guittot wrote:
> update_blocked_averages() is called to periodiccally decay the stalled load
> of idle CPUs and to sync all loads before running load balance.
> 
> When cfs rq is idle, it trigs a load balance during pick_next_task_fair()
> in order to potentially pull tasks and to use this newly idle CPU. This
> load balance happens whereas prev task from another class has not been put
> and its utilization updated yet. This may lead to wrongly account running
> time as idle time for rt or dl classes.
> 
> Test that no rt or dl task is running when updating their utilization in
> update_blocked_averages().
> 
> We still update rt and dl utilization instead of simply skipping them to
> make sure that all metrics are synced when used during load balance.
> 

Fixes: 371bf4273269 ("sched/rt: Add rt_rq utilization tracking")
Fixes: 3727e0e16340 ("sched/dl: Add dl_rq utilization tracking")

Right?

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 309c93f..a1babaf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7262,6 +7262,7 @@ static void update_blocked_averages(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
>  	struct cfs_rq *cfs_rq, *pos;
> +	const struct sched_class *curr_class = rq->curr->sched_class;
>  	struct rq_flags rf;
>  	bool done = true;
>  
> @@ -7298,8 +7299,8 @@ static void update_blocked_averages(int cpu)
>  		if (cfs_rq_has_blocked(cfs_rq))
>  			done = false;
>  	}
> -	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
> -	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
> +	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
> +	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
>  	update_irq_load_avg(rq, 0);
>  	/* Don't need periodic decay once load/util_avg are null */
>  	if (others_have_blocked(rq))

Did you forget to update the second implementation of
update_blocked_averages() ?
