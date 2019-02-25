Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720DB21734
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfBYMPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:15:03 -0500
Received: from foss.arm.com ([217.140.101.70]:59930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfBYMPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:15:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708D41596;
        Mon, 25 Feb 2019 04:15:02 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C703F575;
        Mon, 25 Feb 2019 04:15:00 -0800 (PST)
Date:   Mon, 25 Feb 2019 12:14:58 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190225121458.fvdiiumgyhhdardw@e107158-lin.cambridge.arm.com>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
 <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
 <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
 <20190225085847.yvrtmxtwvk725b7v@e107158-lin.cambridge.arm.com>
 <20190225090955.suq4jw26d2brkjha@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225090955.suq4jw26d2brkjha@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/19 14:39, Viresh Kumar wrote:
> On 25-02-19, 08:58, Qais Yousef wrote:
> > On 02/25/19 10:01, Viresh Kumar wrote:
> > > > > +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> > > > > +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> > > > > +
> > > > > +	if (min > new_policy->min)
> > > > > +		new_policy->min = min;
> > > > > +	if (max < new_policy->max)
> > > > > +		new_policy->max = max;
> 
> > And this is why we need to check here if the PM QoS value doesn't conflict with
> > the current min/max, right? Until the current notifier code is removed they
> > could trip over each others.
> 
> No. The above if/else block is already removed as part of patch 5/5. It was
> required because of conflict between userspace specific min/max and qos min/max,
> which are migrated to use qos by patc 5/5.
> 
> The cpufreq notifier mechanism already lets users play with min/max and that is
> already safe from conflicts.
> 
> 
> > It would be nice to add a comment here about PM QoS managing and remembering
> > values
> 
> I am not sure if that would add any value. Some documentation update may be
> useful for people looking for details though, that I shall do after all the
> changes get in and things become a bit stable.
> 

Up to you. But not everyone is familiar with the code and a one line comment
that points to where aggregation is happening would be helpful for someone
scanning this code IMHO.

> > and that we need to be careful that both mechanisms don't trip over
> > each others until this transient period is over.
> 
> The second mechanism will die very very soon once this is merged, migrating them
> shouldn't be a big challenge AFAICT. I didn't attempt that because I didn't
> wanted to waste time updating things in case this version also doesn't make
> sense to others.
> 
> > I have a nit too. It would be nice to explicitly state this is
> > CPU_{MIN,MAX}_FREQUENCY. I can see someone else adding {MIN,MAX}_FREQUENCY for
> > something elsee (memory maybe?)
> 
> This is not CPU specific, but any device. The same interface shall be used by
> devfreq as well, who wanted to use freq-constraints initially.
> 

I don't get that to be honest. I probably have to read more.

Is what you're saying that when applying a MIN_FREQUENCY constraint the same
value will be applied to both cpufreq and devfreq? Isn't this too coarse?

> > Although I looked at the previous series briefly, but this one looks more
> > compact and easier to follow, so +1 for that.
> 
> Thanks for looking into this Qais.
> 
> -- 
> viresh

Thanks

--
Qais Yousef
