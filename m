Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147CCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14C217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfAIK7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:59:08 -0500
Received: from foss.arm.com ([217.140.101.70]:41114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbfAIK7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:59:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 125C7A78;
        Wed,  9 Jan 2019 02:59:08 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8928B3F70D;
        Wed,  9 Jan 2019 02:59:06 -0800 (PST)
Date:   Wed, 9 Jan 2019 10:59:05 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        qais.yousef@arm.com
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Message-ID: <20190109105902.ytnolu2gldhana4c@queper01-lin>
References: <20190109104236.6532-1-quentin.perret@arm.com>
 <20190109104511.mi3gtdcytkky4eyn@vireshk-i7>
 <5435767.4D6MIGYIVi@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5435767.4D6MIGYIVi@aspire.rjw.lan>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 Jan 2019 at 11:56:06 (+0100), Rafael J. Wysocki wrote:
> On Wednesday, January 9, 2019 11:45:11 AM CET Viresh Kumar wrote:
> > On 09-01-19, 10:42, Quentin Perret wrote:
> > > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > > frequency changes to provide scale-invariant load-tracking signals to
> > > the scheduler. However, in the slow path, it does so while specifying
> > > the current and max frequencies in different units, hence resulting in a
> > > broken freq_scale factor.
> > > 
> > > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > > frequency table.
> > > 
> > > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > > message protocol")
> > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > ---
> > >  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > > index 50b1551ba894..3f0693439486 100644
> > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > @@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> > >  	int ret;
> > >  	struct scmi_data *priv = policy->driver_data;
> > >  	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> > > -	u64 freq = policy->freq_table[index].frequency * 1000;
> > > +	u64 freq = policy->freq_table[index].frequency;
> > >  
> > > -	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
> > > +	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
> > >  	if (!ret)
> > >  		arch_set_freq_scale(policy->related_cpus, freq,
> > >  				    policy->cpuinfo.max_freq);
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> This would be stable-candidate I guess?

I think so yes. I was hoping the 'Fixes:' tag would be enough ? Or do I
still need to CC stable too ?

Thanks,
Quentin
