Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEEAECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EF420861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ddpBAPxM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EF420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeINOq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:46:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeINOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BcAHQIzeGGRnVsD7g3gsfynUSoS0HwcCFco1ifaChNQ=; b=ddpBAPxMJV0h4xKdFO4ezwmW+
        LeCjPZdwFzLQa98+H4p/39WWvZ/7PLPL5lPgKCsj8mjcmYDdViDmFK9aBFCFLVUC5MeXoYb+1huEs
        JYSHoLKmeEOeNEDAXgBd7Nrm2xpI4oGx9xnIRvG07PjoD5V1eRZ/rJZXzXgdMj49qY9jq7Rz1p4Rs
        N0ueroo6twWZ6Pz6j9XHmBmmpBeKUzpNIm4J9CfU/RXnXdZu2DtL0AIMJdiPaMmZ2NPhnQQSJU0pd
        wXv+b1zaoxaHE4nHQUlUMeswZ0QUvWUGUoRbedWpbrCHhVZm3k4PpH3OxzGtGRT1uiUspXj4Xjjyg
        GZKrxALIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0kSw-0006Ai-LR; Fri, 14 Sep 2018 09:32:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51C35202C1A32; Fri, 14 Sep 2018 11:32:40 +0200 (CEST)
Date:   Fri, 14 Sep 2018 11:32:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 06/16] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Message-ID: <20180914093240.GB24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-7-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-7-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:14PM +0100, Patrick Bellasi wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 3fffad3bc8a8..949082555ee8 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -222,8 +222,13 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>  	 * CFS tasks and we use the same metric to track the effective
>  	 * utilization (PELT windows are synchronized) we can directly add them
>  	 * to obtain the CPU's actual utilization.
> +	 *
> +	 * CFS utilization can be boosted or capped, depending on utilization
> +	 * clamp constraints configured for currently RUNNABLE tasks.
>  	 */
>  	util = cpu_util_cfs(rq);
> +	if (util)
> +		util = uclamp_util(rq, util);

Should that not be:

	util = clamp_util(rq, cpu_util_cfs(rq));

Because if !util might we not still want to enforce the min clamp?

>  	util += cpu_util_rt(rq);
>  
>  	/*

> @@ -322,11 +328,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
>  		return;
>  	sg_cpu->iowait_boost_pending = true;
>  
> +	/*
> +	 * Boost FAIR tasks only up to the CPU clamped utilization.
> +	 *
> +	 * Since DL tasks have a much more advanced bandwidth control, it's
> +	 * safe to assume that IO boost does not apply to those tasks.
> +	 * Instead, since RT tasks are not utiliation clamped, we don't want
> +	 * to apply clamping on IO boost while there is blocked RT
> +	 * utilization.
> +	 */
> +	max_boost = sg_cpu->iowait_boost_max;
> +	if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
> +		max_boost = uclamp_util(cpu_rq(sg_cpu->cpu), max_boost);

OK I suppose.

> +
>  	/* Double the boost at each request */
>  	if (sg_cpu->iowait_boost) {
>  		sg_cpu->iowait_boost <<= 1;
> -		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
> -			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
> +		if (sg_cpu->iowait_boost > max_boost)
> +			sg_cpu->iowait_boost = max_boost;
>  		return;
>  	}
>  


> +static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
> +{
> +	struct uclamp_cpu *uc_cpu = &rq->uclamp;
> +
> +	if (uc_cpu->value[clamp_id] == UCLAMP_NOT_VALID)
> +		return uclamp_none(clamp_id);
> +
> +	return uc_cpu->value[clamp_id];
> +}

Would that not be more readable as:

static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
{
	unsigned int val = rq->uclamp.value[clamp_id];

	if (unlikely(val == UCLAMP_NOT_VALID))
		val = uclamp_none(clamp_id);

	return val;
}

And how come NOT_VALID is possible? I thought the idea was to always
have all things a valid value.

