Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15891C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31E9222DB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404492AbfBMQrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:47:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:59267 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404369AbfBMQrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:47:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 08:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="133319959"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2019 08:47:12 -0800
Date:   Thu, 14 Feb 2019 00:55:38 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast  _PPC to all online CPUs
Message-ID: <20190213165538.GB30385@chenyu-office.sh.intel.com>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
 <20190211103307.rccddkso3f5s3yko@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211103307.rccddkso3f5s3yko@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,
On Mon, Feb 11, 2019 at 04:03:07PM +0530, Viresh Kumar wrote:
> On 09-02-19, 20:02, Chen Yu wrote:
> > On Dell Inc. XPS13 9333, the BIOS changes the value of
> > MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> > the power source changes), the maximum frequency of the
> > CPU is not updated accordingly. This is due to the policy's
> > cpuinfo.max is not updated when _PPC notifier fires.
> > 
> > Fix this problem by updating the policy's cpuinfo.max
> > and broadcast the _PPC notifier to all online CPUs.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> > Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
> >  drivers/cpufreq/cpufreq.c        |  2 ++
> >  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
> >  3 files changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> > index a303fd0e108c..737dbf5aa7f7 100644
> > --- a/drivers/acpi/processor_perflib.c
> > +++ b/drivers/acpi/processor_perflib.c
> > @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
> >  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
> >  		 "limited by BIOS, this should help");
> >  
> > +static int broadcast_ppc;
> > +module_param(broadcast_ppc, int, 0644);
> > +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> > +
> >  #define PPC_REGISTERED   1
> >  #define PPC_IN_USE       2
> >  
> > @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
> >  		else
> >  			acpi_processor_ppc_ost(pr->handle, 0);
> >  	}
> > -	if (ret >= 0)
> > -		cpufreq_update_policy(pr->id);
> > +	if (ret >= 0) {
> > +		if (broadcast_ppc) {
> > +			int cpu;
> > +
> > +			for_each_possible_cpu(cpu)
> > +				cpufreq_update_policy(cpu);
> > +		} else {
> > +			cpufreq_update_policy(pr->id);
> > +		}
> > +	}
> >  }
> >  
> >  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e35a886e00bc..95e08816b512 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  
> >  	policy->min = new_policy->min;
> >  	policy->max = new_policy->max;
> > +	policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> > +	policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
> >  	trace_cpu_frequency_limits(policy);
> >  
> >  	policy->cached_target_freq = UINT_MAX;
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index dd66decf2087..e1881313c396 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
> >  
> >  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
> >  {
> > +	int max_freq;
> >  	struct cpudata *cpu = all_cpu_data[policy->cpu];
> >  
> >  	update_turbo_state();
> > +	max_freq = intel_pstate_get_max_freq(cpu);
> > +
> > +	if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> 
> Why do have this check for policy->max here ?
>
Thanks for looking at this change, I've replied to another email in detail of
the scenario that, this is due to corner case that if the system boots
with battery and plug the AC after boot up, the cpufreq max limit will not
increase even the turbo has been enabled after the AC plugged.

Best,
Yu
