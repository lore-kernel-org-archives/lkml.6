Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D724C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DB52084A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfA2JKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:10:51 -0500
Received: from foss.arm.com ([217.140.101.70]:60562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfA2JKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:10:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9986980D;
        Tue, 29 Jan 2019 01:10:47 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B9EF3F7A6;
        Tue, 29 Jan 2019 01:10:44 -0800 (PST)
Date:   Tue, 29 Jan 2019 09:10:43 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org
Subject: Re: [PATCH 2/7] cpufreq: dt: Register an Energy Model
Message-ID: <20190129091041.et46clxo3lci34xf@queper01-lin>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-3-quentin.perret@arm.com>
 <20190129053041.ymyhfusj6eimpxfu@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129053041.ymyhfusj6eimpxfu@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 Jan 2019 at 11:00:41 (+0530), Viresh Kumar wrote:
> On 28-01-19, 16:55, Quentin Perret wrote:
> > Now that PM_OPP provides a helper function to estimate the power
> > consumed by CPUs, make sure to try and register an Energy Model (EM)
> > from cpufreq-dt, hence ensuring interested subsystems (the task
> > scheduler, for example) can make use of that information when available.
> > 
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> > index e58bfcb1169e..7556e07e7a9f 100644
> > --- a/drivers/cpufreq/cpufreq-dt.c
> > +++ b/drivers/cpufreq/cpufreq-dt.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/cpu_cooling.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/energy_model.h>
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -152,6 +153,7 @@ static int resources_available(void)
> >  
> >  static int cpufreq_init(struct cpufreq_policy *policy)
> >  {
> > +	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
> 
> Hmm, so all the earlier comments regarding prototype of this routine are invalid
> because of this.

Right.

> 
> >  	struct cpufreq_frequency_table *freq_table;
> >  	struct opp_table *opp_table = NULL;
> >  	struct private_data *priv;
> > @@ -160,7 +162,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	unsigned int transition_latency;
> >  	bool fallback = false;
> >  	const char *name;
> > -	int ret;
> > +	int ret, nr_opp;
> >  
> >  	cpu_dev = get_cpu_device(policy->cpu);
> >  	if (!cpu_dev) {
> > @@ -237,6 +239,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  		ret = -EPROBE_DEFER;
> >  		goto out_free_opp;
> >  	}
> > +	nr_opp = ret;
> 
> Instead use nr_opp instead of ret while calling dev_pm_opp_get_opp_count().

Will do.

> 
> >  
> >  	if (fallback) {
> >  		cpumask_setall(policy->cpus);
> > @@ -280,6 +283,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	policy->cpuinfo.transition_latency = transition_latency;
> >  	policy->dvfs_possible_from_any_cpu = true;
> >  
> > +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> > +
> >  	return 0;
> >  
> >  out_free_cpufreq_table:
> > -- 
> > 2.20.1
> 
> -- 
> viresh

Thanks,
Quentin
