Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C1FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7E7208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7E7208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967548AbeFRJAs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:00:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966965AbeFRJAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:00:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35C011529;
        Mon, 18 Jun 2018 02:00:45 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.210.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53C093F25D;
        Mon, 18 Jun 2018 02:00:42 -0700 (PDT)
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
To:     Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        patrick.bellasi@arm.com, joel@joelfernandes.org,
        daniel.lezcano@linaro.org, quentin.perret@arm.com,
        Ingo Molnar <mingo@redhat.com>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <072d862a-7b9c-3d17-d0cc-a3082b826cf9@arm.com>
Date:   Mon, 18 Jun 2018 11:00:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 02:09 PM, Vincent Guittot wrote:
> Take into account rt utilization when selecting an OPP for cfs tasks in order
> to reflect the utilization of the CPU.

The rt utilization signal is only tracked per-cpu, not per-entity. So it 
is not aware of PELT migrations (attach/detach).

IMHO, this patch deserves some explanation why the temporary 
inflation/deflation of the OPP driving utilization signal in case an 
rt-task migrates off/on (missing detach/attach for rt-signal) doesn't 
harm performance or energy consumption.

There was some talk (mainly on #sched irc) about ... (1) preempted cfs 
tasks (with reduced demand (utilization id only running) signals) using 
this remaining rt utilization of an rt task which migrated off and ... 
(2) going to max when an rt tasks runs ... but a summary of all of that 
in this patch would really help to understand.

> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/cpufreq_schedutil.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 28592b6..32f97fb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -56,6 +56,7 @@ struct sugov_cpu {
>   	/* The fields below are only needed when sharing a policy: */
>   	unsigned long		util_cfs;
>   	unsigned long		util_dl;
> +	unsigned long		util_rt;
>   	unsigned long		max;
>   
>   	/* The field below is for single-CPU policies only: */
> @@ -178,15 +179,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>   	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
>   	sg_cpu->util_cfs = cpu_util_cfs(rq);
>   	sg_cpu->util_dl  = cpu_util_dl(rq);
> +	sg_cpu->util_rt  = cpu_util_rt(rq);
>   }
>   
>   static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>   {
>   	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	unsigned long util;
>   
>   	if (rq->rt.rt_nr_running)
>   		return sg_cpu->max;
>   
> +	util = sg_cpu->util_dl;
> +	util += sg_cpu->util_cfs;
> +	util += sg_cpu->util_rt;
> +
>   	/*
>   	 * Utilization required by DEADLINE must always be granted while, for
>   	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
> @@ -197,7 +204,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>   	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>   	 * ready for such an interface. So, we only do the latter for now.
>   	 */
> -	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> +	return min(sg_cpu->max, util);
>   }
>   
>   static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
> 

