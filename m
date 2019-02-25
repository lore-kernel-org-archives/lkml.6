Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4199B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfBYI6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:58:52 -0500
Received: from foss.arm.com ([217.140.101.70]:58128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfBYI6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:58:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C0BDA78;
        Mon, 25 Feb 2019 00:58:52 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C649D3F703;
        Mon, 25 Feb 2019 00:58:50 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:58:47 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190225085847.yvrtmxtwvk725b7v@e107158-lin.cambridge.arm.com>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
 <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
 <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/19 10:01, Viresh Kumar wrote:
> On 22-02-19, 11:44, Qais Yousef wrote:
> > Hi Verish
> > 
> > On 02/21/19 16:59, Viresh Kumar wrote:
> > 
> > [...]
> > 
> > > @@ -2239,6 +2314,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > >  			      struct cpufreq_policy *new_policy)
> > >  {
> > >  	struct cpufreq_governor *old_gov;
> > > +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> > > +	unsigned long min, max;
> > >  	int ret;
> > >  
> > >  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> > > @@ -2253,11 +2330,23 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> > >  	if (new_policy->min > new_policy->max)
> > >  		return -EINVAL;
> > >  
> > > +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> > > +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> > > +
> > > +	if (min > new_policy->min)
> > > +		new_policy->min = min;
> > > +	if (max < new_policy->max)
> > > +		new_policy->max = max;
> > > +
> > 
> > Assuming for example min and max range from 1-10, and thermal throttles max to
> > 5 using pm_qos to deal with temporary thermal pressure. But shortly after
> > a driver thinks that max shouldn't be greater than 7 for one reason or another.
> > 
> > What will happen after thermal pressure removes its constraint? Will we still
> > remember the driver's request and apply it so max is set to 7 instead of 10?
> 
> Once everything comes via PM QoS, it will remember all the presently available
> requests and choose a target min/max frequency based on that.

OK I can see the logic now in kernel/power/qos.c now. Sorry I missed it and it
was easier to ask :-)

> 
> But even with this patchset, with half stuff done with PM QoS and half done with
> cpufreq notifiers, it should still work that way only.

And this is why we need to check here if the PM QoS value doesn't conflict with
the current min/max, right? Until the current notifier code is removed they
could trip over each others.

It would be nice to add a comment here about PM QoS managing and remembering
values and that we need to be careful that both mechanisms don't trip over
each others until this transient period is over.

I have a nit too. It would be nice to explicitly state this is
CPU_{MIN,MAX}_FREQUENCY. I can see someone else adding {MIN,MAX}_FREQUENCY for
something elsee (memory maybe?)

Although I looked at the previous series briefly, but this one looks more
compact and easier to follow, so +1 for that.

--
Qais Yousef
