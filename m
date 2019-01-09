Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A568FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76395218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAy676/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfAIK7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:59:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfAIK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:59:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so3144808pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 02:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7HgFKsLiUgBeihUScDY1oQjjwPiunzVz0A+BLsr/TRU=;
        b=QAy676/ObLHJ6NSwOKj7KKzoBlE1mXWIaz56TtLwUFGw8IjgIRxxuSUsxD7rnRyyOP
         +gHiw5Ycvez0pMVeZB/ZJqTwhruP03Plaa7fCsjhnA38JJ2wDYFVyjkzkMKNCm3qFayD
         dHycGTGbSoV7bzQFtKVyPAbw2JZ7w72g8Ml1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7HgFKsLiUgBeihUScDY1oQjjwPiunzVz0A+BLsr/TRU=;
        b=bCuOaWsfFRSl1HyjDMiIlnk79uEeZhDIz3Umj8VPWIYWMqy+CacfDKsr6BuHo/jWXW
         /zhQfIFXQV8xZMiwt2u2HeiCLzuzWN3uty7BgqHV1hLxlksTGV+KfHu+awD5ZlfD+6i6
         QqVsxfV7rfAc7CcVtMIuHhaNBeNlNho3y4AASeJOE7xGraPDe+C/3YDdZDSvCZUJGBaC
         SDgA3LBdMIPGTNB5UTI7To35VC46QNfA0mUR9d3YoWAz+SFHbAmgCVL/oVp0OGvTmGP4
         iQGnjX74OWXGn0MLjU7Vd6+KQcEF15hRa+c2kVhslSLUZLCnLz/vkKDSkcZkvGdGkBO+
         Pvrw==
X-Gm-Message-State: AJcUukcpd1U3nqB872NXX3PRT+kF/pw6o9ly93rCJWtzjvn/MzccY0A1
        yAx6Bo13KIABBCddH71ub+REUQ==
X-Google-Smtp-Source: ALg8bN6VnETbEN5HDDqTt7VdQ5JnvaBwwyjmEXQMe6CnI2pmYLP2gnKknEo4S8CUg0Jxc6MbqCgPlQ==
X-Received: by 2002:a63:8043:: with SMTP id j64mr5022414pgd.405.1547031578087;
        Wed, 09 Jan 2019 02:59:38 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id 196sm282580768pfc.77.2019.01.09.02.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 02:59:37 -0800 (PST)
Date:   Wed, 9 Jan 2019 16:29:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Quentin Perret <quentin.perret@arm.com>, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        qais.yousef@arm.com
Subject: Re: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Message-ID: <20190109105935.i4f7wpedvk5wynwr@vireshk-i7>
References: <20190109104236.6532-1-quentin.perret@arm.com>
 <20190109104511.mi3gtdcytkky4eyn@vireshk-i7>
 <5435767.4D6MIGYIVi@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5435767.4D6MIGYIVi@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 11:56, Rafael J. Wysocki wrote:
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

Cc: 4.17+ <stable@vger.kernel.org> # v4.17+

-- 
viresh
