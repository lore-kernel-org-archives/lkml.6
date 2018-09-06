Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB76C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EAB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EAB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbeIFOEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:04:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41924 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeIFOEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:04:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F19A80D;
        Thu,  6 Sep 2018 02:30:01 -0700 (PDT)
Received: from queper01-lin (queper01-lin.Emea.Arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99EE73F575;
        Thu,  6 Sep 2018 02:29:57 -0700 (PDT)
Date:   Thu, 6 Sep 2018 10:29:56 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@codeaurora.org,
        skannan@codeaurora.org, pkondeti@codeaurora.org,
        juri.lelli@redhat.com, edubezval@gmail.com,
        srinivas.pandruvada@linux.intel.com, currojerez@riseup.net,
        javi.merino@kernel.org
Subject: Re: [PATCH v6 07/14] sched/topology: Introduce sched_energy_present
 static key
Message-ID: <20180906092955.tq27mhzfkovo2ehn@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-8-quentin.perret@arm.com>
 <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f206f192-1bbf-f868-c8c6-8215334639db@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Wednesday 05 Sep 2018 at 23:06:38 (-0700), Dietmar Eggemann wrote:
> On 08/20/2018 02:44 AM, Quentin Perret wrote:
> > In order to ensure a minimal performance impact on non-energy-aware
> > systems, introduce a static_key guarding the access to Energy-Aware
> > Scheduling (EAS) code.
> > 
> > The static key is set iff all the following conditions are met for at
> > least one root domain:
> >    1. all online CPUs of the root domain are covered by the Energy
> >       Model (EM);
> >    2. the complexity of the root domain's EM is low enough to keep
> >       scheduling overheads low;
> >    3. the root domain has an asymmetric CPU capacity topology (detected
> >       by looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
> >       hierarchy).
> 
> This is pretty much the list (+ is schedutil running) of conditions to set
> rd->pd != NULL in build_perf_domains().

Yes, exactly. I actually loop over the rds to check if one of them has a
pd != NULL in order to enable/disable the static key. So the check for
those conditions is always done at the rd level.

> So when testing 'static_branch_unlikely(&sched_energy_present) &&
> rcu_dereference(rd->pd)' don't you test two times the same thing?

Well, not exactly. You could have two rds in your system, and only one
of the two has an Energy Model. The static key is just a performance
optimization for !EAS systems really. But I must admit it sort of lost a
bit of its interest over the versions. I mean, it's not that clear now
that a static key is a better option than a sched_feat as you suggest
below.

> Also, if let's say somebody wants to run another EM user (e.g. a thermal
> governor, like IPA) but not EAS on a asymmetric CPU capacity system. This
> can't be achieved with the current static branch approach

I assume you're talking about IPA once migrated to using the EM
framework ? In this case, I think you're right, we won't have a single
tunable left to enable/disable EAS. On a big.LITTLE platform, if you
want IPA, EAS will always be enabled by side effect ...

That's a very good point actually. I think some people will not be happy
with that. There are big.LITTLE users (not very many of them, but still)
who don't care that much about energy, but do about performance. And
those guys might want to use IPA without EAS. So I guess we really need
a new knob.

> So what about using a (disabled by default ?) sched_feature + rd->pd != NULL
> instead?

Right, that's an option. I could remove the static key and
sched_energy_start() altogether and replace all the
"if (static_branch_unlikely(&sched_energy_present))" by
"if (sched_feat(ENERGY_AWARE))" for example. That should be equivalent
to what I did with the static key from a performance standpoint. But that
would mean users have to manually flip switches to get EAS up and
running ... I assume it's the price to pay for configurability.

Another option would be a KConfig option + static key. I could keep all
of the ifdefery inside an accessor function like the following:

	static inline bool sched_energy_aware(void)
	{
	#ifdef CONFIG_SCHED_ENERGY
		return static_branch_likely(&sched_energy_present);
	#else
		return false;
	#endif
	}

Now, I understand that scheduler-related KConfig options aren't welcome
in general, so I tend to prefer the sched_feat option.

Thoughts ?

Thanks,
Quentin
