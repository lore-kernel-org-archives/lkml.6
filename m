Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756190AbeEIGph (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:45:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46108 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755889AbeEIGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:45:35 -0400
X-Google-Smtp-Source: AB8JxZpc5kfOuCuftM4YK1CtuVvh0BqmQl0fxZh+sg2uPwRDCueLfKrFIU2kO+ux4kk/t3E1BsnAog==
Date: Wed, 9 May 2018 08:45:30 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] sched/cpufreq/schedutil: handling urgent frequency
 requests
Message-ID: <20180509064530.GA1681@localhost.localdomain>
References: <1525704215-8683-1-git-send-email-claudio@evidence.eu.com>
 <20180508065435.bcht6dyb3rpp6gk5@vireshk-i7>
 <20180509045425.GA158882@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509045425.GA158882@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/18 21:54, Joel Fernandes wrote:

[...]

> Just for discussion sake, is there any need for work_in_progress? If we can
> queue multiple work say kthread_queue_work can handle it, then just queuing
> works whenever they are available should be Ok and the kthread loop can
> handle them. __cpufreq_driver_target is also protected by the work lock if
> there is any concern that can have races... only thing is rate-limiting of
> the requests, but we are doing a rate limiting, just not for the "DL
> increased utilization" type requests (which I don't think we are doing at the
> moment for urgent DL requests anyway).
> 
> Following is an untested diff to show the idea. What do you think?
> 
> thanks,
> 
> - Joel
> 
> ----8<---
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index d2c6083304b4..862634ff4bf3 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -38,7 +38,6 @@ struct sugov_policy {
>  	struct			mutex work_lock;
>  	struct			kthread_worker worker;
>  	struct task_struct	*thread;
> -	bool			work_in_progress;
>  
>  	bool			need_freq_update;
>  };
> @@ -92,16 +91,8 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  	    !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>  		return false;
>  
> -	if (sg_policy->work_in_progress)
> -		return false;
> -
>  	if (unlikely(sg_policy->need_freq_update)) {
>  		sg_policy->need_freq_update = false;
> -		/*
> -		 * This happens when limits change, so forget the previous
> -		 * next_freq value and force an update.
> -		 */
> -		sg_policy->next_freq = UINT_MAX;
>  		return true;
>  	}
>  
> @@ -129,7 +120,6 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>  		policy->cur = next_freq;
>  		trace_cpu_frequency(next_freq, smp_processor_id());
>  	} else {
> -		sg_policy->work_in_progress = true;
>  		irq_work_queue(&sg_policy->irq_work);

Isn't this potentially introducing unneeded irq pressure (and doing the
whole wakeup the kthread thing), while the already active kthread could
simply handle multiple back-to-back requests before going to sleep?

Best,

- Juri
