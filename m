Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80005C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5144A2251B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5144A2251B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbeKNBNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:13:00 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58026 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732000AbeKNBNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:13:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C361A78;
        Tue, 13 Nov 2018 07:14:26 -0800 (PST)
Received: from darkstar (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 764DF3F5BD;
        Tue, 13 Nov 2018 07:14:25 -0800 (PST)
Date:   Tue, 13 Nov 2018 07:14:24 -0800
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 06/15] sched/core: uclamp: enforce last task UCLAMP_MAX
Message-ID: <20181113151424.GB7681@darkstar>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-8-patrick.bellasi@arm.com>
 <20181111170848.GB3038@worktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111170848.GB3038@worktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-Nov 18:08, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:33:01PM +0000, Patrick Bellasi wrote:
> > When a util_max clamped task sleeps, its clamp constraints are removed
> > from the CPU. However, the blocked utilization on that CPU can still be
> > higher than the max clamp value enforced while that task was running.
> > 
> > The release of a util_max clamp when a CPU is going to be idle could
> > thus allow unwanted CPU frequency increases while tasks are not
> > running. This can happen, for example, when a frequency update is
> > triggered from another CPU of the same frequency domain.
> > In this case, when we aggregate the utilization of all the CPUs in a
> > shared frequency domain, schedutil can still see the full not clamped
> > blocked utilization of all the CPUs and thus, eventually, increase the
> > frequency.
> 
> > @@ -810,6 +811,28 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
> >  		if (max_value >= SCHED_CAPACITY_SCALE)
> >  			break;
> >  	}
> > +
> > +	/*
> > +	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
> > +	 * task, we want to keep the CPU clamped to the last task's clamp
> > +	 * value. This is to avoid frequency spikes to MAX when one CPU, with
> > +	 * an high blocked utilization, sleeps and another CPU, in the same
> > +	 * frequency domain, do not see anymore the clamp on the first CPU.
> > +	 *
> > +	 * The UCLAMP_FLAG_IDLE is set whenever we detect, from the above
> > +	 * loop, that there are no more RUNNABLE taks on that CPU.
> > +	 * In this case we enforce the CPU util_max to that of the last
> > +	 * dequeued task.
> > +	 */
> > +	if (max_value < 0) {
> > +		if (clamp_id == UCLAMP_MAX) {
> > +			rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
> > +			max_value = last_clamp_value;
> > +		} else {
> > +			max_value = uclamp_none(UCLAMP_MIN);
> > +		}
> > +	}
> > +
> >  	rq->uclamp.value[clamp_id] = max_value;
> >  }
> 
> *groan*, so it could be jet-lag, but I find the comment really hard to
> understand.
> 
> Would not something like:
> 
> 	/*
> 	 * Avoid blocked utilization pushing up the frequency when we go
> 	 * idle (which drops the max-clamp) by retaining the last known
> 	 * max-clamp.
> 	 */
> 
> Be more clear?

It works: short and effective... will update in v6.

Thanks.

-- 
#include <best/regards.h>

Patrick Bellasi
