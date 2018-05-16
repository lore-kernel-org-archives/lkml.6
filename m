Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeEPP6Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:58:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:42691 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbeEPP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:58:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="41443907"
Message-ID: <1526486302.61700.23.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net,
        x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org
Date: Wed, 16 May 2018 08:58:22 -0700
In-Reply-To: <20180516151925.GO28366@localhost.localdomain>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
         <20180516151925.GO28366@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 17:19 +0200, Juri Lelli wrote:
> On 15/05/18 21:49, Srinivas Pandruvada wrote:
> > intel_pstate has two operating modes: active and passive. In
> > "active"
> > mode, the in-built scaling governor is used and in "passive" mode,
> > the driver can be used with any governor like "schedutil". In
> > "active"
> > mode the utilization values from schedutil is not used and there is
> > a requirement from high performance computing use cases, not to
> > read
> > any APERF/MPERF MSRs. In this case no need to use CPU cycles for
> > frequency invariant accounting by reading APERF/MPERF MSRs.
> > With this change frequency invariant account is only enabled in
> > "passive" mode.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> > [Note: The tick will be enabled later in the series when hwp
> > dynamic
> > boost is enabled]
> > 
> >  drivers/cpufreq/intel_pstate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 17e566af..f686bbe 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2040,6 +2040,8 @@ static int
> > intel_pstate_register_driver(struct cpufreq_driver *driver)
> >  {
> >  	int ret;
> >  
> > +	x86_arch_scale_freq_tick_disable();
> > +
> >  	memset(&global, 0, sizeof(global));
> >  	global.max_perf_pct = 100;
> >  
> > @@ -2052,6 +2054,9 @@ static int
> > intel_pstate_register_driver(struct cpufreq_driver *driver)
> >  
> >  	global.min_perf_pct = min_perf_pct_min();
> >  
> > +	if (driver == &intel_cpufreq)
> > +		x86_arch_scale_freq_tick_enable();
> 
> This will unconditionally trigger the reading/calculation at each
> tick
> even though information is not actually consumed (e.g., running
> performance or any other governor), right? Do we want that?
Good point. I should call x86_arch_scale_freq_tick_disable() in
performance mode switch for active mode.

Thanks,
Srinivas

> 
> Anyway, FWIW I started testing this on a E5-2609 v3 and I'm not
> seeing
> hackbench regressions so far (running with schedutil governor).
> 
> Best,
> 
> - Juri
