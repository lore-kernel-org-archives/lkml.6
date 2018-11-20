Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1CAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671AA206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671AA206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKTUaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:30:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45980 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeKTUaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:30:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA3CEBD;
        Tue, 20 Nov 2018 02:01:57 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2357B3F575;
        Tue, 20 Nov 2018 02:01:52 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:01:44 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, tkjos@google.com,
        joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v9 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Message-ID: <20181120100141.ecx57puqurcogn53@queper01-lin>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-16-quentin.perret@arm.com>
 <20181120061925.t6j5jjepziq2gcsh@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120061925.t6j5jjepziq2gcsh@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Tuesday 20 Nov 2018 at 11:49:25 (+0530), Viresh Kumar wrote:
> On 19-11-18, 14:18, Quentin Perret wrote:
> >  static int cpufreq_init(struct cpufreq_policy *policy)
> >  {
> > +	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
> >  	struct cpufreq_frequency_table *freq_table;
> >  	struct opp_table *opp_table = NULL;
> >  	struct private_data *priv;
> > @@ -160,7 +203,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	unsigned int transition_latency;
> >  	bool fallback = false;
> >  	const char *name;
> > -	int ret;
> > +	int ret, nr_opp;
> >  
> >  	cpu_dev = get_cpu_device(policy->cpu);
> >  	if (!cpu_dev) {
> > @@ -237,6 +280,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  		ret = -EPROBE_DEFER;
> >  		goto out_free_opp;
> >  	}
> > +	nr_opp = ret;
> >  
> >  	if (fallback) {
> >  		cpumask_setall(policy->cpus);
> > @@ -280,6 +324,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> >  	policy->cpuinfo.transition_latency = transition_latency;
> >  	policy->dvfs_possible_from_any_cpu = true;
> >  
> > +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> > +
> >  	return 0;
> >  
> >  out_free_cpufreq_table:
> 
> I haven't gone deep into the series, but why don't we need something
> like em_unregister_perf_domain()? That can be used if the cpufreq
> driver goes away. Else loading/unloading/loading the cpufreq driver
> may register the perf-domain callback again.

Right, that's a good point. Registering the perf-domain multiple times
is harmless -- all but the first registration will be ignored. That
_should_ be documented somewhere in patch 03. I'll double check and add
the doc if that's not the case.

The overall idea so far has been to keep the EM framework as simple as
possible. We allocate the EM once and it stays in memory forever. That
makes it really easy for the scheduler (for instance) to manipulate
pointers to perf domains without having to worry about them being
unregistered. We could definitely do something smarter to
register/unregister the PDs dynamically using refcount or something,
but hopefully this is something we can do later, if need be.

Thanks,
Quentin
