Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D6C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C5620861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="11PFmFjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfAWKt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:49:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42240 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfAWKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fj8gJSjcxfpZKzVD1byPKkWI9L43yHzy8tX65MS9pj4=; b=11PFmFjIetN8fpg3V3zQ6ozre
        2TxgPww9ShwlgxYApOy4WjTQOydFBeO9jlqRxh0fO88/xP44Z27c+RaznEDY6BQ+jSy/FMVRBDsif
        o+SiHpkLoKvOLCqTszlVdQxflAOHpIfhyQt67bgkLv7l6qkZVxGOijStDn2kMGRx4A7R4uPZ6ySZx
        73IioYcmfczbPq+fnplVeY4a/ITEWMIeTYE8l1qNRmlXwHtHKhARqbC/0n7VzG1JS9PBkvkClFmID
        gPuFtfIccwKit83Z1ATLO3LKp6OocuNN1ugsnSD8CBv3t+pfLyQlQYz1iPe/p2ye+B9CcgxeT1n4S
        w8qwh9Emg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmG6M-0002OS-6i; Wed, 23 Jan 2019 10:49:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC472201EC16C; Wed, 23 Jan 2019 11:49:44 +0100 (CET)
Date:   Wed, 23 Jan 2019 11:49:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190123104944.GX27931@hirez.programming.kicks-ass.net>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-10-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:15:06AM +0000, Patrick Bellasi wrote:
> @@ -858,16 +859,23 @@ static inline void
>  uclamp_effective_get(struct task_struct *p, unsigned int clamp_id,
>  		     unsigned int *clamp_value, unsigned int *bucket_id)
>  {
> +	struct uclamp_se *default_clamp;
> +
>  	/* Task specific clamp value */
>  	*clamp_value = p->uclamp[clamp_id].value;
>  	*bucket_id = p->uclamp[clamp_id].bucket_id;
>  
> +	/* RT tasks have different default values */
> +	default_clamp = task_has_rt_policy(p)
> +		? uclamp_default_perf
> +		: uclamp_default;
> +
>  	/* System default restriction */
> -	if (unlikely(*clamp_value < uclamp_default[UCLAMP_MIN].value ||
> -		     *clamp_value > uclamp_default[UCLAMP_MAX].value)) {
> +	if (unlikely(*clamp_value < default_clamp[UCLAMP_MIN].value ||
> +		     *clamp_value > default_clamp[UCLAMP_MAX].value)) {
>  		/* Keep it simple: unconditionally enforce system defaults */
> -		*clamp_value = uclamp_default[clamp_id].value;
> -		*bucket_id = uclamp_default[clamp_id].bucket_id;
> +		*clamp_value = default_clamp[clamp_id].value;
> +		*bucket_id = default_clamp[clamp_id].bucket_id;
>  	}
>  }

So I still don't much like the whole effective thing; but I think you
should use rt_task() instead of task_has_rt_policy().
