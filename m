Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38126C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F7F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ONpeYoK9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fClClPhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F7F20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbeGaVNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:13:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbeGaVNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:13:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 64F6660AD9; Tue, 31 Jul 2018 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065479;
        bh=uU92Ke4EGYVTiA1iI1e+Lk2GeL79fmKn1gDPf7HHbl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ONpeYoK9oexPBtdnAty1Z9+hhcw7bnrs1eWyf1y4L19tDBhMkhI/j4wVkq7V1Hzqc
         tgnHg+5tdOh59GuuUvqVjXxh8oUJqMGudA9r5TK6CGBpUwCByMIAIB7Lq1EeeFyfp+
         gKHQWYiwyn53XrMhirKGiu4Qikt4SBwOwii8ju2U=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E5EB560376;
        Tue, 31 Jul 2018 19:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533065478;
        bh=uU92Ke4EGYVTiA1iI1e+Lk2GeL79fmKn1gDPf7HHbl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fClClPhE3bj+I8EWhFwAOZ9knNriJ1LcKIf9Cqp8iVglq7CbxjZ0MzvEFwy4otqpR
         ++tzpqZ9pF2ab8IMs4UanFYvBginwlKEte7+O5JRZ28hwIUPK3SP4NNnLMleAnZnFY
         AGK8YNDJVqsVTnOP5ZUMUYYQ0rgc2wpn2CmEM3Co=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 12:31:17 -0700
From:   skannan@codeaurora.org
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
In-Reply-To: <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
Message-ID: <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
X-Sender: skannan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-31 00:59, Quentin Perret wrote:
> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org 
> wrote:
> [...]
>> If it's going to be a different aggregation from what's done for 
>> frequency
>> guidance, I don't see the point of having this inside schedutil. Why 
>> not
>> keep it inside the scheduler files?
> 
> This code basically results from a discussion we had with Peter on v4.
> Keeping everything centralized can make sense from a maintenance
> perspective, I think. That makes it easy to see the impact of any 
> change
> to utilization signals for both EAS and schedutil.

In that case, I'd argue it makes more sense to keep the code centralized 
in the scheduler. The scheduler can let schedutil know about the 
utilization after it aggregates them. There's no need for a cpufreq 
governor to know that there are scheduling classes or how many there 
are. And the scheduler can then choose to aggregate one way for task 
packing and another way for frequency guidance.

It just seems so weird to have logic that's very essential for task 
placement to be inside a cpufreq governor.

>> Also, it seems weird to use a governor's
>> code when it might not actually be in use. What if someone is using
>> ondemand, conservative, performance, etc?
> 
> Yeah I thought about that too ... I would say that even if you don't
> use schedutil, it is probably a fair assumption from the scheduler's
> standpoint to assume that somewhat OPPs follow utilization (in a very
> loose way). So yes, if you use ondemand with EAS you won't have a
> perfectly consistent match between the frequency requests and what EAS
> predicts, and that might result in sub-optimal decisions in some cases,
> but I'm not sure if we can do anything better at this stage.
> 
> Also, if you do use schedutil, EAS will accurately predict what will be
> the frequency _request_, but that gives you no guarantee whatsoever 
> that
> you'll actually get it for real (because you're throttled, or because 
> of
> thermal capping, or simply because the HW refuses it for some reason 
> ...).
> 
> There will be inconsistencies between EAS' predictions and the actual
> frequencies, and we have to live with that. The best we can do is make
> sure we're at least internally consistent from the scheduler's
> standpoint, and that's why I think it can make sense to factorize as
> many things as possible with schedutil where applicable.
> 
>> > +	if (type == frequency_util) {
>> > +		/*
>> > +		 * Bandwidth required by DEADLINE must always be granted
>> > +		 * while, for FAIR and RT, we use blocked utilization of
>> > +		 * IDLE CPUs as a mechanism to gracefully reduce the
>> > +		 * frequency when no tasks show up for longer periods of
>> > +		 * time.
>> > +		 *
>> > +		 * Ideally we would like to set bw_dl as min/guaranteed
>> > +		 * freq and util + bw_dl as requested freq. However,
>> > +		 * cpufreq is not yet ready for such an interface. So,
>> > +		 * we only do the latter for now.
>> > +		 */
>> > +		util += cpu_bw_dl(rq);
>> > +	}
>> 
>> Instead of all this indentation, can't you just return early without 
>> doing
>> the code inside the if?
> 
> But then I'll need to duplicate the 'min' below, so not sure if it's
> worth it ?

I feel like less indentation where reasonably possible leads to more 
readability. But I don't have a strong opinion in this specific case.

>> > +enum schedutil_type {
>> > +	frequency_util,
>> > +	energy_util,
>> > +};
>> 
>> Please don't use lower case for enums. It's extremely confusing.
> 
> Ok, I'll change that in v6.

Thanks.

-Saravana
