Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C53FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDD32082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDD32082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeJZSBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:01:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58385 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:01:54 -0400
Received: from 79.184.255.63.ipv4.supernova.orange.pl (79.184.255.63) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 52fad5c5cbf5bf13; Fri, 26 Oct 2018 11:25:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] sched: Factor out nr_iowait and nr_iowait_cpu
Date:   Fri, 26 Oct 2018 11:22:11 +0200
Message-ID: <12842273.0tBlJJajS6@aspire.rjw.lan>
In-Reply-To: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
References: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 4, 2018 2:04:02 PM CEST Daniel Lezcano wrote:
> The function nr_iowait_cpu() can be used directly by nr_iowait() instead
> of duplicating code.
> 
> Call nr_iowait_cpu() from nr_iowait()
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/core.c | 41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc98..43efb74 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2875,6 +2875,25 @@ unsigned long long nr_context_switches(void)
>  }
>  
>  /*
> + * Consumers of these two interfaces, like for example the cpufreq menu
> + * governor are using nonsensical data. Boosting frequency for a CPU that has
> + * IO-wait which might not even end up running the task when it does become
> + * runnable.
> + */
> +
> +unsigned long nr_iowait_cpu(int cpu)
> +{
> +	return atomic_read(&cpu_rq(cpu)->nr_iowait);
> +}
> +
> +void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> +{
> +	struct rq *rq = this_rq();
> +	*nr_waiters = atomic_read(&rq->nr_iowait);
> +	*load = rq->load.weight;
> +}
> +
> +/*
>   * IO-wait accounting, and how its mostly bollocks (on SMP).
>   *
>   * The idea behind IO-wait account is to account the idle time that we could
> @@ -2909,31 +2928,11 @@ unsigned long nr_iowait(void)
>  	unsigned long i, sum = 0;
>  
>  	for_each_possible_cpu(i)
> -		sum += atomic_read(&cpu_rq(i)->nr_iowait);
> +		sum += nr_iowait_cpu(i);
>  
>  	return sum;
>  }
>  
> -/*
> - * Consumers of these two interfaces, like for example the cpufreq menu
> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> - * IO-wait which might not even end up running the task when it does become
> - * runnable.
> - */
> -
> -unsigned long nr_iowait_cpu(int cpu)
> -{
> -	struct rq *this = cpu_rq(cpu);
> -	return atomic_read(&this->nr_iowait);
> -}
> -
> -void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> -{
> -	struct rq *rq = this_rq();
> -	*nr_waiters = atomic_read(&rq->nr_iowait);
> -	*load = rq->load.weight;
> -}
> -
>  #ifdef CONFIG_SMP
>  
>  /*
> 

Both [1-2/2] applied with Peter's ACKs, thanks!

