Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA44BC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C320C217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfAWOkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:40:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42152 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfAWOkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AB8AA78;
        Wed, 23 Jan 2019 06:40:16 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A659A3F237;
        Wed, 23 Jan 2019 06:40:13 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:40:11 +0000
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH v6 09/16] sched/cpufreq: uclamp: Add utilization clamping
 for RT tasks
Message-ID: <20190123144011.iid3avb63r5v4r2c@e110439-lin>
References: <20190115101513.2822-1-patrick.bellasi@arm.com>
 <20190115101513.2822-10-patrick.bellasi@arm.com>
 <20190123104944.GX27931@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123104944.GX27931@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-Jan 11:49, Peter Zijlstra wrote:
> On Tue, Jan 15, 2019 at 10:15:06AM +0000, Patrick Bellasi wrote:
> > @@ -858,16 +859,23 @@ static inline void
> >  uclamp_effective_get(struct task_struct *p, unsigned int clamp_id,
> >  		     unsigned int *clamp_value, unsigned int *bucket_id)
> >  {
> > +	struct uclamp_se *default_clamp;
> > +
> >  	/* Task specific clamp value */
> >  	*clamp_value = p->uclamp[clamp_id].value;
> >  	*bucket_id = p->uclamp[clamp_id].bucket_id;
> >  
> > +	/* RT tasks have different default values */
> > +	default_clamp = task_has_rt_policy(p)
> > +		? uclamp_default_perf
> > +		: uclamp_default;
> > +
> >  	/* System default restriction */
> > -	if (unlikely(*clamp_value < uclamp_default[UCLAMP_MIN].value ||
> > -		     *clamp_value > uclamp_default[UCLAMP_MAX].value)) {
> > +	if (unlikely(*clamp_value < default_clamp[UCLAMP_MIN].value ||
> > +		     *clamp_value > default_clamp[UCLAMP_MAX].value)) {
> >  		/* Keep it simple: unconditionally enforce system defaults */
> > -		*clamp_value = uclamp_default[clamp_id].value;
> > -		*bucket_id = uclamp_default[clamp_id].bucket_id;
> > +		*clamp_value = default_clamp[clamp_id].value;
> > +		*bucket_id = default_clamp[clamp_id].bucket_id;
> >  	}
> >  }
> 
> So I still don't much like the whole effective thing;

:/

I find back-annotation useful in many cases since we have different
sources for possible clamp values:

 1. task specific
 2. cgroup defined
 3. system defaults
 4. system power default

I don't think we can avoid to somehow back annotate on which bucket a
task has been refcounted... it makes dequeue so much easier, it helps
in ensuring that the refcouning is consistent and enable lazy updates.

> but I think you should use rt_task() instead of
> task_has_rt_policy().

Right... will do.

-- 
#include <best/regards.h>

Patrick Bellasi
