Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E351C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F8D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfAVMaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:30:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52428 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbfAVMaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:30:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 994C9A78;
        Tue, 22 Jan 2019 04:30:14 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1A253F614;
        Tue, 22 Jan 2019 04:30:11 -0800 (PST)
Date:   Tue, 22 Jan 2019 12:30:10 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190122123007.dkavjh73w223pa6y@queper01-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115101513.2822-10-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 Jan 2019 at 10:15:06 (+0000), Patrick Bellasi wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 520ee2b785e7..38a05a4f78cc 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -201,9 +201,6 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
>  	unsigned long dl_util, util, irq;
>  	struct rq *rq = cpu_rq(cpu);
>  
> -	if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
> -		return max;
> -
>  	/*
>  	 * Early check to see if IRQ/steal time saturates the CPU, can be
>  	 * because of inaccuracies in how we track these -- see
> @@ -219,15 +216,19 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
>  	 * utilization (PELT windows are synchronized) we can directly add them
>  	 * to obtain the CPU's actual utilization.
>  	 *
> -	 * CFS utilization can be boosted or capped, depending on utilization
> -	 * clamp constraints requested by currently RUNNABLE tasks.
> +	 * CFS and RT utilization can be boosted or capped, depending on
> +	 * utilization clamp constraints requested by currently RUNNABLE
> +	 * tasks.
>  	 * When there are no CFS RUNNABLE tasks, clamps are released and
>  	 * frequency will be gracefully reduced with the utilization decay.
>  	 */
> -	util = (type == ENERGY_UTIL)
> -		? util_cfs
> -		: uclamp_util(rq, util_cfs);
> -	util += cpu_util_rt(rq);
> +	util = cpu_util_rt(rq);
> +	if (type == FREQUENCY_UTIL) {
> +		util += cpu_util_cfs(rq);
> +		util  = uclamp_util(rq, util);

So with this we don't go to max to anymore for CONFIG_UCLAMP_TASK=n no ?

Thanks,
Quentin
