Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965524AbeBPL7O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:59:14 -0500
Received: from foss.arm.com ([217.140.101.70]:38838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965036AbeBPL7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:59:12 -0500
Subject: Re: [PATCH 6/7] sched: Rename root_domain->overload to
 should_idle_balance
To: Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@gmail.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, mingo@redhat.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-7-git-send-email-morten.rasmussen@arm.com>
 <20180216091402.GF8032@localhost.localdomain>
 <20180216094922.GY25201@hirez.programming.kicks-ass.net>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <8d38ed15-9de2-4fe4-a95e-fe4ec1bee59c@arm.com>
Date: Fri, 16 Feb 2018 11:59:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216094922.GY25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/16/2018 09:49 AM, Peter Zijlstra wrote:
> On Fri, Feb 16, 2018 at 10:14:02AM +0100, Juri Lelli wrote:
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 7d324b706e67..4215438667e5 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -650,8 +650,12 @@ struct root_domain {
>>>  	cpumask_var_t span;
>>>  	cpumask_var_t online;
>>>  
>>> -	/* Indicate more than one runnable task for any CPU */
>>> -	bool overload;
>>> +	/*
>>> +	 * Indicate whether the idle balance can be used to solve
>>> +	 * imbalance within the root domain.
>>> +	 * e.g. There is more than one runnable task for any CPU
>>> +	 */
>>> +	bool should_idle_balance;
>>
>> Current name is however consistent with RT/DL's naming convention

I saw that it was already used elsewhere in fair but didn't know about
RT/DL, thanks for pointing that out.

> 
> Yeah, not a fan either. We've consistently used the term to mean
> nr_running>1. The thing to fix there is the stupid bool, not the name.
> 

So yeah the other thing that doesn't help here is that we're cramming 
several meanings into rq->rd->overload:
- is there an overloaded group
- is there a group with misfit task(s)

So it didn't make sense to keep it named "overload". Perhaps a better way of
handling this would be to keep exposing which is which instead of merging it
all in a bool. Something along those lines:

@update_sg_lb_stats():
[...]
 nr_running = rq->nr_running;
 if (nr_running > 1)
-    *overload = true;
+    sds->balance_status |= LB_STATUS_OVERLOAD

[...]

 if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
 !sgs->group_misfit_task_load && rq->misfit_task_load) {
     sgs->group_misfit_task_load = rq->misfit_task_load;
-     *should_idle_balance = true;
+     sds->balance_status |= LB_STATUS_MISFIT
 }

@update_sd_lb_stats():

[...]
 if (!env->sd->parent) {
     /* update overload indicator if we are at root domain */
-     if (env->dst_rq->rd->overload != overload)
-         env->dst_rq->rd->overload = overload;
+     if (env->dst_rq->rd->balance_status != sds->balance_status)
+         env->dst_rq->rd->balance_status = sds->balance_status
 }
