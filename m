Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD6BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E054D21D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E054D21D68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeHISHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:07:35 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55744 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbeHISHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:07:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F83C7A9;
        Thu,  9 Aug 2018 08:42:07 -0700 (PDT)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B5353F5B3;
        Thu,  9 Aug 2018 08:42:00 -0700 (PDT)
Date:   Thu, 9 Aug 2018 16:41:56 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
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
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 06/14] sched/cpufreq: uclamp: add utilization clamping
 for RT tasks
Message-ID: <20180809154156.gdsx2vacjmp6p6dp@darkstar>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-7-patrick.bellasi@arm.com>
 <20180807135403.s7jktvxmhycujeht@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807135403.s7jktvxmhycujeht@queper01-lin>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Aug 14:54, Quentin Perret wrote:
> Hi Patrick,

Hi Quentin!

> On Monday 06 Aug 2018 at 17:39:38 (+0100), Patrick Bellasi wrote:
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index a7affc729c25..bb25ef66c2d3 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -200,6 +200,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> >  {
> >  	struct rq *rq = cpu_rq(sg_cpu->cpu);
> > +	unsigned long util_cfs, util_rt;
> >  	unsigned long util, irq, max;
> >  
> >  	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> 
> IIUC, not far below this you should still have something like:
> 
> 	if (rt_rq_is_runnable(&rq->rt))
> 		return max;

Do you mean that when RT tasks are RUNNABLE we still want to got to
MAX? Not sure to understand... since this patch is actually to clamp
the RT class...

> So you won't reach the actual clamping code at the end of the function
> when a RT task is runnable no?

... mmm... no... this patch is to clamp RT tasks... Am I missing
something?

> Also, I always had the feeling that the default for RT should be
> util_min == 1024, and then users could decide to lower the bar if they
> want to.

Mmm... good point! This would keep the policy unaltered for RT tasks.

I want to keep sched class specific code in uclamp at minimum, but
likely this should be achievable by just properly initializing the
task-specific util_min for RT tasks, if the original task has
UCLAM_NOT_VALID.

> For the specific case of RT, that feels more natural than
> applying a max util clamp IMO. What do you think ?

I'll look better into this for the next posting!

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
