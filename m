Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752323AbeFAO5v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:57:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:44116 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752036AbeFAO5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:57:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="43932700"
Message-ID: <1527865068.3871.3.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH v3 4/4] cpufreq: intel_pstate: enable boost
 for SKX
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: lenb@kernel.org, rjw@rjwysocki.net, peterz@infradead.org,
        mgorman@techsingularity.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org
Date: Fri, 01 Jun 2018 07:57:48 -0700
In-Reply-To: <20180601120103.olsxfhj6b5d5tahz@linux-h043>
References: <20180531225143.34270-1-srinivas.pandruvada@linux.intel.com>
         <20180531225143.34270-5-srinivas.pandruvada@linux.intel.com>
         <20180601120103.olsxfhj6b5d5tahz@linux-h043>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-01 at 14:01 +0200, Giovanni Gherdovich wrote:
> On Thu, May 31, 2018 at 03:51:43PM -0700, Srinivas Pandruvada wrote:
> > Enable HWP boost on Skylake server platform.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 254e30a6c1e0..75c5a95bc0ac 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -1794,6 +1794,11 @@ static const struct x86_cpu_id
> > intel_pstate_cpu_ee_disable_ids[] = {
> >  	{}
> >  };
> >  
> > +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[]
> > __initconst = {
> > +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> > +	{}
> > +};
> > +
> >  static int intel_pstate_init_cpu(unsigned int cpunum)
> >  {
> >  	struct cpudata *cpu;
> > @@ -1824,6 +1829,10 @@ static int intel_pstate_init_cpu(unsigned
> > int cpunum)
> >  			intel_pstate_disable_ee(cpunum);
> >  
> >  		intel_pstate_hwp_enable(cpu);
> > +
> > +		id = x86_match_cpu(intel_pstate_hwp_boost_ids);
> > +		if (id)
> > +			hwp_boost = true;
> >  	}
> >  
> >  	intel_pstate_get_cpu_pstates(cpu);
> > -- 
> > 2.13.6
> > 
> > 
> 
> I have a Skylake server, HWP capable, but it doesn't trigger this
> bit; I had
> to do "echo 1 >
> /sys/devices/system/cpu/intel_pstate/hwp_dynamic_boost".
> 
> Just out of curiosity, do you see reasons for leaving some SKL out of
> the
> default setting? Or maybe I'm missing something.
This is entry level server using SKL desktop CPU model. We will see
some  improvements, but not as big as Xeon E5s. So we can add based on
your test results.

Thanks,
Srinivas

> 
> /proc/cpuinfo says that the model name is "Intel(R) Xeon(R) CPU E3-
> 1240 v5";
> the outputs of `cpuid -1` and `cpuid -1 --raw` are in this pastebin:
> http://paste.opensuse.org/view/raw/34255499


> 
> 
> Giovanni Gherdovich
> SUSE Labs
