Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751171AbeEUJDn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 05:03:43 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41352 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeEUJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 05:03:41 -0400
X-Google-Smtp-Source: AB8JxZoF86N/JgjuDi5dA4XdnyFzajrBuDFUbHmcPDqD9PT6hH3djbDxeteF2r6R9tRIrTC7r9GpzQ==
Date: Mon, 21 May 2018 14:33:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v3 1/2] cpufreq: schedutil: Fix iowait boost reset
Message-ID: <20180521090338.7z6n7ydy3rx3jnoa@vireshk-i7>
References: <20180521085120.7902-1-patrick.bellasi@arm.com>
 <20180521085120.7902-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521085120.7902-2-patrick.bellasi@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-18, 09:51, Patrick Bellasi wrote:
> A more energy efficient update of the IO wait boosting mechanism has
> been introduced in:
> 
>    commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost more energy efficient")
> 
> where the boost value is expected to be:
> 
>  - doubled at each successive wakeup from IO
>    staring from the minimum frequency supported by a CPU
> 
>  - reset when a CPU is not updated for more then one tick
>    by either disabling the IO wait boost or resetting its value to the
>    minimum frequency if this new update requires an IO boost.
> 
> This approach is supposed to "ignore" boosting for sporadic wakeups from
> IO, while still getting the frequency boosted to the maximum to benefit
> long sequence of wakeup from IO operations.
> 
> However, these assumptions are not always satisfied.
> For example, when an IO boosted CPU enters idle for more the one tick
> and then wakes up after an IO wait, since in sugov_set_iowait_boost() we
> first check the IOWAIT flag, we keep doubling the iowait boost instead
> of restarting from the minimum frequency value.
> 
> This misbehavior could happen mainly on non-shared frequency domains,
> thus defeating the energy efficiency optimization, but it can also
> happen on shared frequency domain systems.
> 
> Let fix this issue in sugov_set_iowait_boost() by:
>  - first check the IO wait boost reset conditions
>    to eventually reset the boost value
>  - then applying the correct IO boost value
>    if required by the caller
> 
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Fixes: a5a0809bc58e ("cpufreq: schedutil: Make iowait boost more energy efficient")
> 
> ---
> Changes in v3:
>  - split the fix into a separated patch (this one)
>  - added "Fixes" tag (Viresh)
> ---
>  kernel/sched/cpufreq_schedutil.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index e13df951aca7..c4063e578e4d 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -203,6 +203,16 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
>  
>  static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
>  {
> +	/* Clear iowait_boost if the CPU apprears to have been idle. */
> +	if (sg_cpu->iowait_boost) {
> +		s64 delta_ns = time - sg_cpu->last_update;
> +
> +		if (delta_ns > TICK_NSEC) {
> +			sg_cpu->iowait_boost = 0;
> +			sg_cpu->iowait_boost_pending = false;
> +		}
> +	}
> +
>  	if (flags & SCHED_CPUFREQ_IOWAIT) {
>  		if (sg_cpu->iowait_boost_pending)
>  			return;
> @@ -216,14 +226,6 @@ static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned
>  		} else {
>  			sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
>  		}
> -	} else if (sg_cpu->iowait_boost) {
> -		s64 delta_ns = time - sg_cpu->last_update;
> -
> -		/* Clear iowait_boost if the CPU apprears to have been idle. */
> -		if (delta_ns > TICK_NSEC) {
> -			sg_cpu->iowait_boost = 0;
> -			sg_cpu->iowait_boost_pending = false;
> -		}
>  	}
>  }
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
