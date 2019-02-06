Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8B12186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfBFRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:25:36 -0500
Received: from foss.arm.com ([217.140.101.70]:55658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfBFRZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:25:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1504EEBD;
        Wed,  6 Feb 2019 09:25:34 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007693F719;
        Wed,  6 Feb 2019 09:25:32 -0800 (PST)
Subject: Re: [PATCH 4/5] sched/fair: Tune down misfit nohz kicks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
References: <20190117153411.2390-1-valentin.schneider@arm.com>
 <20190117153411.2390-5-valentin.schneider@arm.com>
 <20190206160413.GK17550@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2d9c0edd-d00a-ddb1-d81f-f8da11f24304@arm.com>
Date:   Wed, 6 Feb 2019 17:25:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206160413.GK17550@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/02/2019 16:04, Peter Zijlstra wrote:
[...]
>> @@ -9561,6 +9573,14 @@ static void nohz_balancer_kick(struct rq *rq)
> 
> 	sd = rcu_dereference(rq->sd);
> 	if (sd) {
> 		if ((rq->cfs.h_nr_running >= 1) &&
> 		    check_cpu_capacity(rq, sd)) {
> 			flags = NOHZ_KICK_MASK;
> 			goto unlock;
>>  		}
>>  	}
>>  
>> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
>> +	if (sd) {
>> +		if (check_misfit_status(rq, sd)) {
>> +			flags = NOHZ_KICK_MASK;
>> +			goto unlock;
>> +		}
>> +	}
> 
> So while the exact @sd to use for check_cpu_capacity() likely doesn't
> matter; this is a 'implicit' test for actually having asym_capacity.
> 

I did feel compelled to use the "right" @sd to have a coherent
imbalance_pct being used - on big.LITTLE, the @sd above this hunk would be
MC (117 imbalance_pct) whereas the sd_asym_cpucapacity one would be
DIE (125 imbalance_pct).

> Fair enough I suppose. However, now that you wrote such a nice comment
> for the sd_llc_shared case, these other two cases are sad to not have a
> comment.
> 
> So how about you add something like:
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9589,8 +9589,12 @@ static void nohz_balancer_kick(struct rq
>  
>  	sd = rcu_dereference(rq->sd);
>  	if (sd) {
> -		if ((rq->cfs.h_nr_running >= 1) &&
> -		    check_cpu_capacity(rq, sd)) {
> +		/*
> +		 * If there's a CFS task and the current CPU has reduced
> +		 * capacity; kick the ILB to see if there's a better CPU to run
> +		 * on.
> +		 */
> +		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
>  			flags = NOHZ_KICK_MASK;
>  			goto unlock;
>  		}
> @@ -9598,6 +9602,10 @@ static void nohz_balancer_kick(struct rq
>  
>  	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
>  	if (sd) {
> +		/*
> +		 * When ASYM_CAPACITY; see if there's a higher capacity CPU to
> +		 * run the misfit task on.
> +		 */
>  		if (check_misfit_status(rq, sd)) {
>  			flags = NOHZ_KICK_MASK;
>  			goto unlock;
> @@ -9606,6 +9614,10 @@ static void nohz_balancer_kick(struct rq
>  
>  	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
>  	if (sd) {
> +		/*
> +		 * When ASYM_PACKING; see if there's a more preferred CPU going
> +		 * idle; in which case, kick the ILB to move tasks around.
> +		 */

s/going idle/currently idle/, no?

>  		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
>  			if (sched_asym_prefer(i, cpu)) {
>  				flags = NOHZ_KICK_MASK;
> 
