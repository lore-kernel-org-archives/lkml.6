Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968443AbeE2WUo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:20:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:21533 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030227AbeE2WR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:17:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,458,1520924400";
   d="scan'208";a="228333066"
Message-ID: <1527632274.2951.41.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH v2 3/6] cpufreq: intel_pstate: Add
 update_util_hook for HWP
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 29 May 2018 15:17:54 -0700
In-Reply-To: <CAJZ5v0hHD-qH45bnw91w+ky=rnrTW4yTYMdizU47S8Y8Avqc_g@mail.gmail.com>
References: <20180524014738.52924-1-srinivas.pandruvada@linux.intel.com>
         <20180524014738.52924-4-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0hHD-qH45bnw91w+ky=rnrTW4yTYMdizU47S8Y8Avqc_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-05-29 at 09:37 +0200, Rafael J. Wysocki wrote:
> On Thu, May 24, 2018 at 3:47 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > When HWP dynamic boost is active then set the HWP specific update
> > util
> > hook.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> 
> Splitting this patch out of the next one is sort of artificial.
I will merge to the patch where the hwp_boost is getting used.

Thanks,
Srinivas

> 
> > ---
> >  drivers/cpufreq/intel_pstate.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 6ad46e07cad6..382160570b5f 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -291,6 +291,7 @@ static struct pstate_funcs pstate_funcs
> > __read_mostly;
> > 
> >  static int hwp_active __read_mostly;
> >  static bool per_cpu_limits __read_mostly;
> > +static bool hwp_boost __read_mostly;
> 
> Because of this, among other things.
> 
> > 
> >  static struct cpufreq_driver *intel_pstate_driver __read_mostly;
> > 
> > @@ -1461,6 +1462,11 @@ static inline bool
> > intel_pstate_hwp_boost_down(struct cpudata *cpu)
> >         return false;
> >  }
> > 
> > +static inline void intel_pstate_update_util_hwp(struct
> > update_util_data *data,
> > +                                               u64 time, unsigned
> > int flags)
> > +{
> > +}
> > +
> >  static inline void intel_pstate_calc_avg_perf(struct cpudata *cpu)
> >  {
> >         struct sample *sample = &cpu->sample;
> > @@ -1764,7 +1770,7 @@ static void
> > intel_pstate_set_update_util_hook(unsigned int cpu_num)
> >  {
> >         struct cpudata *cpu = all_cpu_data[cpu_num];
> > 
> > -       if (hwp_active)
> > +       if (hwp_active && !hwp_boost)
> >                 return;
> > 
> >         if (cpu->update_util_set)
> > @@ -1772,8 +1778,12 @@ static void
> > intel_pstate_set_update_util_hook(unsigned int cpu_num)
> > 
> >         /* Prevent intel_pstate_update_util() from using stale
> > data. */
> >         cpu->sample.time = 0;
> > -       cpufreq_add_update_util_hook(cpu_num, &cpu->update_util,
> > -                                    intel_pstate_update_util);
> > +       if (hwp_active)
> > +               cpufreq_add_update_util_hook(cpu_num, &cpu-
> > >update_util,
> > +                                            intel_pstate_update_ut
> > il_hwp);
> > +       else
> > +               cpufreq_add_update_util_hook(cpu_num, &cpu-
> > >update_util,
> > +                                            intel_pstate_update_ut
> > il);
> >         cpu->update_util_set = true;
> >  }
> > 
> > @@ -1885,8 +1895,11 @@ static int intel_pstate_set_policy(struct
> > cpufreq_policy *policy)
> >                 intel_pstate_set_update_util_hook(policy->cpu);
> >         }
> > 
> > -       if (hwp_active)
> > +       if (hwp_active) {
> > +               if (!hwp_boost)
> > +                       intel_pstate_clear_update_util_hook(policy-
> > >cpu);
> >                 intel_pstate_hwp_set(policy->cpu);
> > +       }
> > 
> >         mutex_unlock(&intel_pstate_limits_lock);
> > 
> > --
> > 2.13.6
> > 
