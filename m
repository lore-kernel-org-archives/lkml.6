Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72921C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3086C21E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3086C21E5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeHIR77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:59:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55594 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731112AbeHIR77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:59:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D84D77A9;
        Thu,  9 Aug 2018 08:34:33 -0700 (PDT)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF553F5B3;
        Thu,  9 Aug 2018 08:34:27 -0700 (PDT)
Date:   Thu, 9 Aug 2018 16:34:23 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180809153423.nsoepprhut3dv4u2@darkstar>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807132630.GB3062@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807132630.GB3062@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Aug 15:26, Juri Lelli wrote:
> Hi,
> 
> On 06/08/18 17:39, Patrick Bellasi wrote:
> 
> [...]
> 
> > @@ -223,13 +224,25 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> >  	 * utilization (PELT windows are synchronized) we can directly add them
> >  	 * to obtain the CPU's actual utilization.
> >  	 *
> > -	 * CFS utilization can be boosted or capped, depending on utilization
> > -	 * clamp constraints configured for currently RUNNABLE tasks.
> > +	 * CFS and RT utilizations can be boosted or capped, depending on
> > +	 * utilization constraints enforce by currently RUNNABLE tasks.
> > +	 * They are individually clamped to ensure fairness across classes,
> > +	 * meaning that CFS always gets (if possible) the (minimum) required
> > +	 * bandwidth on top of that required by higher priority classes.
> 
> Is this a stale comment written before UCLAMP_SCHED_CLASS was
> introduced? It seems to apply to the below if branch only.

Yes, you right... I'll update the comment.

> >  	 */
> > -	util = cpu_util_cfs(rq);
> > -	if (util)
> > -		util = uclamp_util(cpu_of(rq), util);
> > -	util += cpu_util_rt(rq);
> > +	util_cfs = cpu_util_cfs(rq);
> > +	util_rt  = cpu_util_rt(rq);
> > +	if (sched_feat(UCLAMP_SCHED_CLASS)) {
> > +		util = 0;
> > +		if (util_cfs)
> > +			util += uclamp_util(cpu_of(rq), util_cfs);
> > +		if (util_rt)
> > +			util += uclamp_util(cpu_of(rq), util_rt);
> > +	} else {
> > +		util  = cpu_util_cfs(rq);
> > +		util += cpu_util_rt(rq);
> > +		util  = uclamp_util(cpu_of(rq), util);
> > +	}

Regarding the two policies, do you have any comment?

We had an internal discussion and we found pro/cons for both... but
I'm not sure keeping the sched_feat is a good solution on the long
run, i.e. mainline merge ;)

-- 
#include <best/regards.h>

Patrick Bellasi
