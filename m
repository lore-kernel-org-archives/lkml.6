Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755323AbeE2Hrl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:47:41 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37129 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755179AbeE2Hrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:47:36 -0400
X-Google-Smtp-Source: ADUXVKIZtL5j/rQY5Opkvfl+LGY7iMn1LzIHUDISG7xNYVTzBAvFXhOUrA15d6427gxHoZIjsegV704vupjvDoCFISY=
MIME-Version: 1.0
In-Reply-To: <20180524014738.52924-3-srinivas.pandruvada@linux.intel.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com> <20180524014738.52924-3-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 May 2018 09:47:35 +0200
X-Google-Sender-Auth: DLnwyjl2Sot2eSKGIJcQ7eIabog
Message-ID: <CAJZ5v0hCTAG8y07Y5ARotBPZJ2xjpBNbvd8MGUXc8NP09ode6A@mail.gmail.com>
Subject: Re: [RFC/RFT] [PATCH v2 2/6] cpufreq: intel_pstate: Add HWP boost
 utility functions
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
> Added two utility functions to HWP boost up gradually and boost down to
> the default cached HWP request values.
>
> Boost up:
> Boost up updates HWP request minimum value in steps. This minimum value
> can reach upto at HWP request maximum values depends on how frequently,
> the IOWAIT flag is set. At max, boost up will take three steps to reach
> the maximum, depending on the current HWP request levels and HWP
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
> to the default cached value from HWP init or user modified one via sysfs.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 74 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index baed29c768e7..6ad46e07cad6 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -223,6 +223,7 @@ struct global_params {
>   *                     operation
>   * @hwp_req_cached:    Cached value of the last HWP Request MSR
>   * @hwp_cap_cached:    Cached value of the last HWP Capabilities MSR
> + * @hwp_boost_min:     Last HWP boosted min performance
>   *
>   * This structure stores per CPU instance data for all CPUs.
>   */
> @@ -257,6 +258,7 @@ struct cpudata {
>         s16 epp_saved;
>         u64 hwp_req_cached;
>         u64 hwp_cap_cached;
> +       int hwp_boost_min;
>  };
>
>  static struct cpudata **all_cpu_data;
> @@ -1387,6 +1389,78 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
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

If user space updates the limits after this read, our decision below
may be based on a stale value, may it not?

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
> +static inline bool intel_pstate_hwp_boost_down(struct cpudata *cpu)
> +{
> +       if (cpu->hwp_boost_min) {
> +               bool expired;
> +
> +               /* Check if we are idle for hold time to boost down */
> +               expired = time_after64(cpu->sample.time, cpu->last_update +
> +                                      (hwp_boost_hold_time_ms * NSEC_PER_MSEC));
> +               if (expired) {
> +                       wrmsrl(MSR_HWP_REQUEST, cpu->hwp_req_cached);
> +                       cpu->hwp_boost_min = 0;
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
>  {
>         struct sample *sample = &cpu->sample;
> --
> 2.13.6
>
