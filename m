Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeFEMMA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:12:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36110 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeFEML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:11:58 -0400
X-Google-Smtp-Source: ADUXVKLlZcTYZ/YcKMraUPF67C1Xa+WqtXYw28x5j7MTGSiTlFZPBwQVDMcXS/1GzW1EhDDAeWeNEw==
Date: Tue, 5 Jun 2018 14:11:53 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
Message-ID: <20180605121153.GD16081@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
 <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605105721.GA12193@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 05/06/18 11:57, Quentin Perret wrote:

[...]

> What about the diff below (just a quick hack to show the idea) applied
> on tip/sched/core ?
> 
> ---8<---
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index a8ba6d1f262a..23a4fb1c2c25 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -180,9 +180,12 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  	sg_cpu->util_dl  = cpu_util_dl(rq);
>  }
>  
> +unsigned long scale_rt_capacity(int cpu);
>  static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> +	int cpu = sg_cpu->cpu;
> +	unsigned long util, dl_bw;
>  
>  	if (rq->rt.rt_nr_running)
>  		return sg_cpu->max;
> @@ -197,7 +200,14 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
>  	 * ready for such an interface. So, we only do the latter for now.
>  	 */
> -	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
> +	util = arch_scale_cpu_capacity(NULL, cpu) * scale_rt_capacity(cpu);

Sorry to be pedantinc, but this (ATM) includes DL avg contribution, so,
since we use max below, we will probably have the same problem that we
discussed on Vincent's approach (overestimation of DL contribution while
we could use running_bw).

> +	util >>= SCHED_CAPACITY_SHIFT;
> +	util = arch_scale_cpu_capacity(NULL, cpu) - util;
> +	util += sg_cpu->util_cfs;
> +	dl_bw = (rq->dl.this_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;

Why this_bw instead of running_bw?

Thanks,

- Juri
