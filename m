Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeE2HoT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:44:19 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42119 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbeE2HoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:44:17 -0400
X-Google-Smtp-Source: ADUXVKKU05VB8MWifeFmcP24Hrc9+ub+9oaQzZGt51z23Zgz9wdKuhrs4fHwRxTQuDQ1ud0jZ23TIzyFFNR7Uc8436A=
MIME-Version: 1.0
In-Reply-To: <20180524014738.52924-5-srinivas.pandruvada@linux.intel.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com> <20180524014738.52924-5-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 May 2018 09:44:16 +0200
X-Google-Sender-Auth: C87nt5xA2G4ip7vmcj40cTiCw3c
Message-ID: <CAJZ5v0iG+jNC77KCHNUAt5tAtrtgryz2U4P1s_d9vB0HzLyOFw@mail.gmail.com>
Subject: Re: [RFC/RFT] [PATCH v2 4/6] cpufreq: intel_pstate: HWP boost
 performance on IO wakeup
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 3:47 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> This change uses SCHED_CPUFREQ_IOWAIT flag to boost HWP performance.
> Since SCHED_CPUFREQ_IOWAIT flag is set frequently, we don't start
> boosting steps unless we see two consecutive flags in two ticks. This
> avoids boosting due to IO because of regular system activities.
>
> To avoid synchronization issues, the actual processing of the flag is
> done on the local CPU callback.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 382160570b5f..6d0ebe4fe1c7 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -223,6 +223,8 @@ struct global_params {
>   *                     operation
>   * @hwp_req_cached:    Cached value of the last HWP Request MSR
>   * @hwp_cap_cached:    Cached value of the last HWP Capabilities MSR
> + * @last_io_update:    Last time when IO wake flag was set
> + * @sched_flags:       Store scheduler flags for possible cross CPU update
>   * @hwp_boost_min:     Last HWP boosted min performance
>   *
>   * This structure stores per CPU instance data for all CPUs.
> @@ -258,6 +260,8 @@ struct cpudata {
>         s16 epp_saved;
>         u64 hwp_req_cached;
>         u64 hwp_cap_cached;
> +       u64 last_io_update;
> +       unsigned long sched_flags;
>         int hwp_boost_min;
>  };
>
> @@ -1462,9 +1466,49 @@ static inline bool intel_pstate_hwp_boost_down(struct cpudata *cpu)
>         return false;
>  }
>
> +static inline void intel_pstate_update_util_hwp_local(struct cpudata *cpu,
> +                                                     u64 time)
> +{
> +       bool io_flag;
> +
> +       cpu->sample.time = time;
> +       io_flag = test_and_clear_bit(SCHED_CPUFREQ_IOWAIT, &cpu->sched_flags);

I don't think you need to use bit ops here.

_update_util() runs under rq->lock for the target CPU, so it will not
run concurrently on two different CPUs for the same target anyway.

> +       if (io_flag) {
> +               bool do_io = false;
> +
> +               /*
> +                * Set iowait_boost flag and update time. Since IO WAIT flag
> +                * is set all the time, we can't just conclude that there is
> +                * some IO bound activity is scheduled on this CPU with just
> +                * one occurrence. If we receive at least two in two
> +                * consecutive ticks, then we treat as boost candidate.
> +                */
> +               if (time_before64(time, cpu->last_io_update + 2 * TICK_NSEC))
> +                       do_io = true;
> +
> +               cpu->last_io_update = time;
> +
> +               if (do_io)
> +                       intel_pstate_hwp_boost_up(cpu);

But what happens if user space wants to update the limits while
boosting is in effect?  Shouldn't it take hwp_boost_min into account
then?

> +
> +       } else {
> +               if (intel_pstate_hwp_boost_down(cpu))
> +                       return;
> +       }
> +
> +       cpu->last_update = time;
> +}
> +
>  static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
>                                                 u64 time, unsigned int flags)
>  {
> +       struct cpudata *cpu = container_of(data, struct cpudata, update_util);
> +
> +       if (flags & SCHED_CPUFREQ_IOWAIT)
> +               set_bit(SCHED_CPUFREQ_IOWAIT, &cpu->sched_flags);
> +
> +       if (smp_processor_id() == cpu->cpu)
> +               intel_pstate_update_util_hwp_local(cpu, time);
>  }
>
>  static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
> --
> 2.13.6
>
