Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDB0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0158821738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfAILEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:04:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44880 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730510AbfAILEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:04:36 -0500
Received: from 79.184.254.168.ipv4.supernova.orange.pl (79.184.254.168) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 8d689e21cc018528; Wed, 9 Jan 2019 12:04:34 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        qais.yousef@arm.com
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date:   Wed, 09 Jan 2019 12:03:49 +0100
Message-ID: <1798133.Rn2TxhOzAS@aspire.rjw.lan>
In-Reply-To: <20190109105902.ytnolu2gldhana4c@queper01-lin>
References: <20190109104236.6532-1-quentin.perret@arm.com> <5435767.4D6MIGYIVi@aspire.rjw.lan> <20190109105902.ytnolu2gldhana4c@queper01-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, January 9, 2019 11:59:05 AM CET Quentin Perret wrote:
> On Wednesday 09 Jan 2019 at 11:56:06 (+0100), Rafael J. Wysocki wrote:
> > On Wednesday, January 9, 2019 11:45:11 AM CET Viresh Kumar wrote:
> > > On 09-01-19, 10:42, Quentin Perret wrote:
> > > > The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
> > > > frequency changes to provide scale-invariant load-tracking signals to
> > > > the scheduler. However, in the slow path, it does so while specifying
> > > > the current and max frequencies in different units, hence resulting in a
> > > > broken freq_scale factor.
> > > > 
> > > > Fix this by passing all frequencies in KHz, as stored in the CPUFreq
> > > > frequency table.
> > > > 
> > > > Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
> > > > message protocol")
> > > > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > > > ---
> > > >  drivers/cpufreq/scmi-cpufreq.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > > > index 50b1551ba894..3f0693439486 100644
> > > > --- a/drivers/cpufreq/scmi-cpufreq.c
> > > > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > > > @@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> > > >  	int ret;
> > > >  	struct scmi_data *priv = policy->driver_data;
> > > >  	struct scmi_perf_ops *perf_ops = handle->perf_ops;
> > > > -	u64 freq = policy->freq_table[index].frequency * 1000;
> > > > +	u64 freq = policy->freq_table[index].frequency;
> > > >  
> > > > -	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
> > > > +	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
> > > >  	if (!ret)
> > > >  		arch_set_freq_scale(policy->related_cpus, freq,
> > > >  				    policy->cpuinfo.max_freq);
> > > 
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > This would be stable-candidate I guess?
> 
> I think so yes. I was hoping the 'Fixes:' tag would be enough ?

It doesn't cause -stable to pick up commits automatically if that's
what you're asking about.

> Or do I still need to CC stable too ?

No, you don't need to (and should not) CC -stable yourself.

You can, however, add a Cc: <stable..> tag to the patch which helps
maintainers a bit.

