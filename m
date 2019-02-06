Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD0A2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfBFR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:26:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55678 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfBFR0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:26:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0293EBD;
        Wed,  6 Feb 2019 09:26:08 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE3A43F719;
        Wed,  6 Feb 2019 09:26:07 -0800 (PST)
Subject: Re: [PATCH 5/5] sched/fair: Skip LLC nohz logic for asymmetric
 systems
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
References: <20190117153411.2390-1-valentin.schneider@arm.com>
 <20190117153411.2390-6-valentin.schneider@arm.com>
 <20190206161452.GL17550@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <5010b09f-6954-fda6-a10f-a8aa05806866@arm.com>
Date:   Wed, 6 Feb 2019 17:26:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206161452.GL17550@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/2019 16:14, Peter Zijlstra wrote:
[...]
>> @@ -9545,6 +9545,17 @@ static void nohz_balancer_kick(struct rq *rq)
>>  	}
>>  
>>  	rcu_read_lock();
>> +
>> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
>> +		/*
>> +		 * For asymmetric systems, we do not want to nicely balance
>> +		 * cache use, instead we want to embrace asymmetry and only
>> +		 * ensure tasks have enough CPU capacity.
>> +		 *
>> +		 * Skip the LLC logic because it's not relevant in that case.
>> +		 */
>> +		goto check_capacity;
>> +
>>  	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>  	if (sds) {
>>  		/*
> 
> Since (before this) the actual order of the various tests doesn't
> matter, it's a logical cascade of conditions for which to KICK_MASK.
> 

Ah, I assumed the order did matter somewhat with the "cheaper" LLC check
first and the more costly loops further down in case we are still looking
for a reason to do a kick.

> We can easily reorder and short-circuit the cascase like so, no?
> 
> The only concern is if sd_llc_shared < sd_asym_capacity; in which case
> we just lost a balance opportunity. Not sure how to best retain that
> though.
> 

I'm afraid I don't follow - we don't lose a balance opportunity with the
below change (compared to the original patch), do we?

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9568,25 +9568,6 @@ static void nohz_balancer_kick(struct rq
>  	}
>  
>  	rcu_read_lock();
> -	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> -	if (sds) {
> -		/*
> -		 * If there is an imbalance between LLC domains (IOW we could
> -		 * increase the overall cache use), we need some less-loaded LLC
> -		 * domain to pull some load. Likewise, we may need to spread
> -		 * load within the current LLC domain (e.g. packed SMT cores but
> -		 * other CPUs are idle). We can't really know from here how busy
> -		 * the others are - so just get a nohz balance going if it looks
> -		 * like this LLC domain has tasks we could move.
> -		 */
> -		nr_busy = atomic_read(&sds->nr_busy_cpus);
> -		if (nr_busy > 1) {
> -			flags = NOHZ_KICK_MASK;
> -			goto unlock;
> -		}
> -
> -	}
> -
>  	sd = rcu_dereference(rq->sd);
>  	if (sd) {
>  		/*
> @@ -9600,6 +9581,20 @@ static void nohz_balancer_kick(struct rq
>  		}
>  	}
>  
> +	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
> +	if (sd) {
> +		/*
> +		 * When ASYM_PACKING; see if there's a more preferred CPU going
> +		 * idle; in which case, kick the ILB to move tasks around.
> +		 */
> +		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> +			if (sched_asym_prefer(i, cpu)) {
> +				flags = NOHZ_KICK_MASK;
> +				goto unlock;
> +			}
> +		}
> +	}
> +
>  	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
>  	if (sd) {
>  		/*
> @@ -9610,21 +9605,36 @@ static void nohz_balancer_kick(struct rq
>  			flags = NOHZ_KICK_MASK;
>  			goto unlock;
>  		}
> +
> +		/*
> +		 * For asymmetric systems, we do not want to nicely balance
> +		 * cache use, instead we want to embrace asymmetry and only
> +		 * ensure tasks have enough CPU capacity.
> +		 *
> +		 * Skip the LLC logic because it's not relevant in that case.
> +		 */
> +		goto unlock;
>  	}
>  
> -	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
> -	if (sd) {
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +	if (sds) {
>  		/*
> -		 * When ASYM_PACKING; see if there's a more preferred CPU going
> -		 * idle; in which case, kick the ILB to move tasks around.
> +		 * If there is an imbalance between LLC domains (IOW we could
> +		 * increase the overall cache use), we need some less-loaded LLC
> +		 * domain to pull some load. Likewise, we may need to spread
> +		 * load within the current LLC domain (e.g. packed SMT cores but
> +		 * other CPUs are idle). We can't really know from here how busy
> +		 * the others are - so just get a nohz balance going if it looks
> +		 * like this LLC domain has tasks we could move.
>  		 */
> -		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
> -			if (sched_asym_prefer(i, cpu)) {
> -				flags = NOHZ_KICK_MASK;
> -				goto unlock;
> -			}
> +		nr_busy = atomic_read(&sds->nr_busy_cpus);
> +		if (nr_busy > 1) {
> +			flags = NOHZ_KICK_MASK;
> +			goto unlock;
>  		}
> +
>  	}
> +
>  unlock:
>  	rcu_read_unlock();
>  out:
> 
