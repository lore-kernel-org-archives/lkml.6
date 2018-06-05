Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751578AbeFEJ1P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:27:15 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44380 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeFEJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:27:12 -0400
X-Google-Smtp-Source: ADUXVKJndFArXQNTtuZyFmKSL+Dka4e/IUJJpU3qUauAxbpRcnkJ5vUvDmIo2ZItljZN9yd2fjTKaiWl4zDrkvJIL6U=
MIME-Version: 1.0
In-Reply-To: <20180531225143.34270-2-srinivas.pandruvada@linux.intel.com>
References: <20180531225143.34270-1-srinivas.pandruvada@linux.intel.com> <20180531225143.34270-2-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Jun 2018 11:27:11 +0200
X-Google-Sender-Auth: 8tIZct9qC9qpdQ-rp3XCIX9ukJU
Message-ID: <CAJZ5v0iPdTUW9hUykXZeh+NAWf1QUPwvBAG-wAnc-NLHVu6SSg@mail.gmail.com>
Subject: Re: [RFC/RFT] [PATCH v3 1/4] cpufreq: intel_pstate: Add HWP boost
 utility and sched util hooks
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

On Fri, Jun 1, 2018 at 12:51 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Added two utility functions to HWP boost up gradually and boost down to
> the default cached HWP request values.
>
> Boost up:
> Boost up updates HWP request minimum value in steps. This minimum value
> can reach upto at HWP request maximum values depends on how frequently,
> this boost up function is called. At max, boost up will take three steps
> to reach the maximum, depending on the current HWP request levels and HWP
> capabilities. For example, if the current settings are:
> If P0 (Turbo max) = P1 (Guaranteed max) = min
>         No boost at all.
> If P0 (Turbo max) > P1 (Guaranteed max) = min
>         Should result in one level boost only for P0.
> If P0 (Turbo max) = P1 (Guaranteed max) > min
>         Should result in two level boost:
>                 (min + p1)/2 and P1.
> If P0 (Turbo max) > P1 (Guaranteed max) > min
>         Should result in three level boost:
>                 (min + p1)/2, P1 and P0.
> We don't set any level between P0 and P1 as there is no guarantee that
> they will be honored.
>
> Boost down:
> After the system is idle for hold time of 3ms, the HWP request is reset
> to the default value from HWP init or user modified one via sysfs.
>
> Caching of HWP Request and Capabilities
> Store the HWP request value last set using MSR_HWP_REQUEST and read
> MSR_HWP_CAPABILITIES. This avoid reading of MSRs in the boost utility
> functions.
>
> These boost utility functions calculated limits are based on the latest
> HWP request value, which can be modified by setpolicy() callback. So if
> user space modifies the minimum perf value, that will be accounted for
> every time the boost up is called. There will be case when there can be
> contention with the user modified minimum perf, in that case user value
> will gain precedence. For example just before HWP_REQUEST MSR is updated
> from setpolicy() callback, the boost up function is called via scheduler
> tick callback. Here the cached MSR value is already the latest and limits
> are updated based on the latest user limits, but on return the MSR write
> callback called from setpolicy() callback will update the HWP_REQUEST
> value. This will be used till next time the boost up function is called.
>
> In addition add a variable to control HWP dynamic boosting. When HWP
> dynamic boost is active then set the HWP specific update util hook. The
> contents in the utility hooks will be filled in the subsequent patches.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 99 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 95 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 17e566afbb41..80bf61ae4b1f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -221,6 +221,9 @@ struct global_params {
>   *                     preference/bias
>   * @epp_saved:         Saved EPP/EPB during system suspend or CPU offline
>   *                     operation
> + * @hwp_req_cached:    Cached value of the last HWP Request MSR
> + * @hwp_cap_cached:    Cached value of the last HWP Capabilities MSR
> + * @hwp_boost_min:     Last HWP boosted min performance
>   *
>   * This structure stores per CPU instance data for all CPUs.
>   */
> @@ -253,6 +256,9 @@ struct cpudata {
>         s16 epp_policy;
>         s16 epp_default;
>         s16 epp_saved;
> +       u64 hwp_req_cached;
> +       u64 hwp_cap_cached;
> +       int hwp_boost_min;

Why int?  That's a register value, so maybe u32?

>  };
>
>  static struct cpudata **all_cpu_data;
> @@ -285,6 +291,7 @@ static struct pstate_funcs pstate_funcs __read_mostly;
>
>  static int hwp_active __read_mostly;
>  static bool per_cpu_limits __read_mostly;
> +static bool hwp_boost __read_mostly;
>
>  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
>
> @@ -689,6 +696,7 @@ static void intel_pstate_get_hwp_max(unsigned int cpu, int *phy_max,
>         u64 cap;
>
>         rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
> +       WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
>         if (global.no_turbo)
>                 *current_max = HWP_GUARANTEED_PERF(cap);
>         else
> @@ -763,6 +771,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>                 intel_pstate_set_epb(cpu, epp);
>         }
>  skip_epp:
> +       WRITE_ONCE(cpu_data->hwp_req_cached, value);
>         wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>  }
>
> @@ -1381,6 +1390,81 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>         intel_pstate_set_min_pstate(cpu);
>  }
>
> +/*
> + * Long hold time will keep high perf limits for long time,
> + * which negatively impacts perf/watt for some workloads,
> + * like specpower. 3ms is based on experiements on some
> + * workoads.
> + */
> +static int hwp_boost_hold_time_ms = 3;
> +
> +static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
> +{
> +       u64 hwp_req = READ_ONCE(cpu->hwp_req_cached);
> +       int max_limit = (hwp_req & 0xff00) >> 8;
> +       int min_limit = (hwp_req & 0xff);
> +       int boost_level1;
> +
> +       /*
> +        * Cases to consider (User changes via sysfs or boot time):
> +        * If, P0 (Turbo max) = P1 (Guaranteed max) = min:
> +        *      No boost, return.
> +        * If, P0 (Turbo max) > P1 (Guaranteed max) = min:
> +        *     Should result in one level boost only for P0.
> +        * If, P0 (Turbo max) = P1 (Guaranteed max) > min:
> +        *     Should result in two level boost:
> +        *         (min + p1)/2 and P1.
> +        * If, P0 (Turbo max) > P1 (Guaranteed max) > min:
> +        *     Should result in three level boost:
> +        *        (min + p1)/2, P1 and P0.
> +        */
> +
> +       /* If max and min are equal or already at max, nothing to boost */
> +       if (max_limit == min_limit || cpu->hwp_boost_min >= max_limit)
> +               return;
> +
> +       if (!cpu->hwp_boost_min)
> +               cpu->hwp_boost_min = min_limit;
> +
> +       /* level at half way mark between min and guranteed */
> +       boost_level1 = (HWP_GUARANTEED_PERF(cpu->hwp_cap_cached) + min_limit) >> 1;
> +
> +       if (cpu->hwp_boost_min < boost_level1)
> +               cpu->hwp_boost_min = boost_level1;
> +       else if (cpu->hwp_boost_min < HWP_GUARANTEED_PERF(cpu->hwp_cap_cached))
> +               cpu->hwp_boost_min = HWP_GUARANTEED_PERF(cpu->hwp_cap_cached);
> +       else if (cpu->hwp_boost_min == HWP_GUARANTEED_PERF(cpu->hwp_cap_cached) &&
> +                max_limit != HWP_GUARANTEED_PERF(cpu->hwp_cap_cached))
> +               cpu->hwp_boost_min = max_limit;
> +       else
> +               return;
> +
> +       hwp_req = (hwp_req & ~GENMASK_ULL(7, 0)) | cpu->hwp_boost_min;
> +       wrmsrl(MSR_HWP_REQUEST, hwp_req);
> +       cpu->last_update = cpu->sample.time;
> +}
> +
> +static inline void intel_pstate_hwp_boost_down(struct cpudata *cpu)
> +{
> +       if (cpu->hwp_boost_min) {
> +               bool expired;
> +
> +               /* Check if we are idle for hold time to boost down */
> +               expired = time_after64(cpu->sample.time, cpu->last_update +
> +                                      (hwp_boost_hold_time_ms * NSEC_PER_MSEC));

It would be good to avoid the multiplication here as it will just add
overhead for no value.

> +               if (expired) {
> +                       wrmsrl(MSR_HWP_REQUEST, cpu->hwp_req_cached);
> +                       cpu->hwp_boost_min = 0;
> +               }
> +       }
> +       cpu->last_update = cpu->sample.time;
> +}
> +
> +static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
> +                                               u64 time, unsigned int flags)
> +{
> +}
> +
>  static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
>  {
>         struct sample *sample = &cpu->sample;
> @@ -1684,7 +1768,7 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
>  {
>         struct cpudata *cpu = all_cpu_data[cpu_num];
>
> -       if (hwp_active)
> +       if (hwp_active && !hwp_boost)
>                 return;
>
>         if (cpu->update_util_set)
> @@ -1692,8 +1776,12 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
>
>         /* Prevent intel_pstate_update_util() from using stale data. */
>         cpu->sample.time = 0;
> -       cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
> -                                    intel_pstate_update_util);
> +       if (hwp_active)
> +               cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
> +                                            intel_pstate_update_util_hwp);
> +       else
> +               cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
> +                                            intel_pstate_update_util);

You can use the ternary operator in the third arg of
cpufreq_add_update_util_hook().

>         cpu->update_util_set = true;
>  }
>
> @@ -1805,8 +1893,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>                 intel_pstate_set_update_util_hook(policy->cpu);
>         }
>
> -       if (hwp_active)
> +       if (hwp_active) {
> +               if (!hwp_boost)
> +                       intel_pstate_clear_update_util_hook(policy->cpu);

This can be called unconditionally as the cpu_data->update_util_set
check will make it return immediately anyway AFAICS.

>                 intel_pstate_hwp_set(policy->cpu);
> +       }
>
>         mutex_unlock(&intel_pstate_limits_lock);
>
> --
