Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755041AbeE2HhR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:37:17 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42454 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754894AbeE2HhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:37:15 -0400
X-Google-Smtp-Source: ADUXVKIZmaXP05dnEsLbx0g9Dgd7eEsiJlOVC2V1WZb5KFe+OmJ3qqd1AfksD8w/8BnVNoPI1J+ihn2ZFkAc9AIv098=
MIME-Version: 1.0
In-Reply-To: <20180524014738.52924-4-srinivas.pandruvada@linux.intel.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com> <20180524014738.52924-4-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 May 2018 09:37:13 +0200
X-Google-Sender-Auth: 2DK4sk5KRCFzOBhkle1MiOz7F2c
Message-ID: <CAJZ5v0hHD-qH45bnw91w+ky=rnrTW4yTYMdizU47S8Y8Avqc_g@mail.gmail.com>
Subject: Re: [RFC/RFT] [PATCH v2 3/6] cpufreq: intel_pstate: Add
 update_util_hook for HWP
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
> When HWP dynamic boost is active then set the HWP specific update util
> hook.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Splitting this patch out of the next one is sort of artificial.

> ---
>  drivers/cpufreq/intel_pstate.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 6ad46e07cad6..382160570b5f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -291,6 +291,7 @@ static struct pstate_funcs pstate_funcs __read_mostly;
>
>  static int hwp_active __read_mostly;
>  static bool per_cpu_limits __read_mostly;
> +static bool hwp_boost __read_mostly;

Because of this, among other things.

>
>  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
>
> @@ -1461,6 +1462,11 @@ static inline bool intel_pstate_hwp_boost_down(struct cpudata *cpu)
>         return false;
>  }
>
> +static inline void intel_pstate_update_util_hwp(struct update_util_data *data,
> +                                               u64 time, unsigned int flags)
> +{
> +}
> +
>  static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
>  {
>         struct sample *sample = &cpu->sample;
> @@ -1764,7 +1770,7 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
>  {
>         struct cpudata *cpu = all_cpu_data[cpu_num];
>
> -       if (hwp_active)
> +       if (hwp_active && !hwp_boost)
>                 return;
>
>         if (cpu->update_util_set)
> @@ -1772,8 +1778,12 @@ static void intel_pstate_set_update_util_hook(unsigned int cpu_num)
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
>         cpu->update_util_set = true;
>  }
>
> @@ -1885,8 +1895,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>                 intel_pstate_set_update_util_hook(policy->cpu);
>         }
>
> -       if (hwp_active)
> +       if (hwp_active) {
> +               if (!hwp_boost)
> +                       intel_pstate_clear_update_util_hook(policy->cpu);
>                 intel_pstate_hwp_set(policy->cpu);
> +       }
>
>         mutex_unlock(&intel_pstate_limits_lock);
>
> --
> 2.13.6
>
