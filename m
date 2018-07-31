Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7ABC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C0120870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C0120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeGaJjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:39:04 -0400
Received: from foss.arm.com ([217.140.101.70]:49738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbeGaJjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:39:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFC7C80D;
        Tue, 31 Jul 2018 00:59:58 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48DE3F5BA;
        Tue, 31 Jul 2018 00:59:54 -0700 (PDT)
Date:   Tue, 31 Jul 2018 08:59:53 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     skannan@codeaurora.org
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
Message-ID: <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <331552975e858911db66bc78c2c8e720@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org wrote:
[...]
> If it's going to be a different aggregation from what's done for frequency
> guidance, I don't see the point of having this inside schedutil. Why not
> keep it inside the scheduler files?

This code basically results from a discussion we had with Peter on v4.
Keeping everything centralized can make sense from a maintenance
perspective, I think. That makes it easy to see the impact of any change
to utilization signals for both EAS and schedutil.


> Also, it seems weird to use a governor's
> code when it might not actually be in use. What if someone is using
> ondemand, conservative, performance, etc?

Yeah I thought about that too ... I would say that even if you don't
use schedutil, it is probably a fair assumption from the scheduler's
standpoint to assume that somewhat OPPs follow utilization (in a very
loose way). So yes, if you use ondemand with EAS you won't have a
perfectly consistent match between the frequency requests and what EAS
predicts, and that might result in sub-optimal decisions in some cases,
but I'm not sure if we can do anything better at this stage.

Also, if you do use schedutil, EAS will accurately predict what will be
the frequency _request_, but that gives you no guarantee whatsoever that
you'll actually get it for real (because you're throttled, or because of
thermal capping, or simply because the HW refuses it for some reason ...).

There will be inconsistencies between EAS' predictions and the actual
frequencies, and we have to live with that. The best we can do is make
sure we're at least internally consistent from the scheduler's
standpoint, and that's why I think it can make sense to factorize as
many things as possible with schedutil where applicable.

> > +	if (type == frequency_util) {
> > +		/*
> > +		 * Bandwidth required by DEADLINE must always be granted
> > +		 * while, for FAIR and RT, we use blocked utilization of
> > +		 * IDLE CPUs as a mechanism to gracefully reduce the
> > +		 * frequency when no tasks show up for longer periods of
> > +		 * time.
> > +		 *
> > +		 * Ideally we would like to set bw_dl as min/guaranteed
> > +		 * freq and util + bw_dl as requested freq. However,
> > +		 * cpufreq is not yet ready for such an interface. So,
> > +		 * we only do the latter for now.
> > +		 */
> > +		util += cpu_bw_dl(rq);
> > +	}
> 
> Instead of all this indentation, can't you just return early without doing
> the code inside the if?

But then I'll need to duplicate the 'min' below, so not sure if it's
worth it ?

> > +enum schedutil_type {
> > +	frequency_util,
> > +	energy_util,
> > +};
> 
> Please don't use lower case for enums. It's extremely confusing.

Ok, I'll change that in v6.

Thanks !
Quentin
