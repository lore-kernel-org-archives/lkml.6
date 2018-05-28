Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965111AbeE1KMr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:12:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38296 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936446AbeE1KMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:12:39 -0400
X-Google-Smtp-Source: AB8JxZoeVrjHB+JWT1jxuZFSg6q23wnFY2plrcn5n4oApA1g5AgrJdWM1hcufAsKU9dBLRl7e7IqiQ==
Date: Mon, 28 May 2018 12:12:34 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com,
        quentin.perret@arm.com, Luca Abeni <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Joel Fernandes <joelaf@google.com>,
        Alessio Balsini <alessio.balsini@santannapisa.it>
Subject: Re: [PATCH v5 05/10] cpufreq/schedutil: get max utilization
Message-ID: <20180528101234.GA1293@localhost.localdomain>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527253951-22709-6-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 25/05/18 15:12, Vincent Guittot wrote:
> Now that we have both the dl class bandwidth requirement and the dl class
> utilization, we can use the max of the 2 values when agregating the
> utilization of the CPU.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/sched.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4526ba6..0eb07a8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2194,7 +2194,11 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
>  static inline unsigned long cpu_util_dl(struct rq *rq)
>  {
> -	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> +	unsigned long util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;

I'd be tempted to say the we actually want to cap to this one above
instead of using the max (as you are proposing below) or the
(theoretical) power reduction benefits of using DEADLINE for certain
tasks might vanish.

> +
> +	util = max_t(unsigned long, util, READ_ONCE(rq->avg_dl.util_avg));
> +
> +	return util;

Anyway, just a quick thought. I guess we should experiment with this a
bit. Now, I don't unfortunately have a Arm platform at hand for testing.
Claudio, Luca (now Cc-ed), would you be able to fire some tests with
this change?

Oh, adding Joel and Alessio as well that experimented with DEADLINE
lately.

Thanks,

- Juri
