Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4591BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70A208DE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC70A208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbeHPRG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:06:27 -0400
Received: from foss.arm.com ([217.140.101.70]:37144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387730AbeHPRG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:06:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7205F80D;
        Thu, 16 Aug 2018 07:07:36 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0A6C3F5D0;
        Thu, 16 Aug 2018 07:07:33 -0700 (PDT)
Date:   Thu, 16 Aug 2018 15:07:31 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
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
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Message-ID: <20180816140731.GD2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
 <20180816090906.GC2661@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816090906.GC2661@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-Aug 14:39, Pavan Kondeti wrote:
> On Mon, Aug 06, 2018 at 05:39:41PM +0100, Patrick Bellasi wrote:

[...]

> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8f48e64fb8a6..3fac2d098084 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -589,6 +589,11 @@ struct uclamp_se {
> >  	unsigned int value;
> >  	/* Utilization clamp group for this constraint */
> >  	unsigned int group_id;
> > +	/* Effective clamp  for tasks in this group */
> > +	struct {
> > +		unsigned int value;
> > +		unsigned int group_id;
> > +	} effective;
> >  };
> 
> Are these needed when CONFIG_UCLAMP_TASK_GROUP is disabled?

Mmm... not entirely, at least not the value.

While working on v4 I've notice that:

   (1) task_struct::uclamp::effective::group_id

can be used for the back annotation we add in:

   [PATCH v3 11/14] sched/core: uclamp: use TG's clamps to restrict Task's clamps

using the additional field:

   (2) task_struct::uclamp_group_id

So, I'm updating that patch to re-use (1) instead of adding (2).

Regarding:

   (3) task_struct::uclamp::effective::value

it can be used to track the task's effective clamp value once I add
the discretization support discussed with Juri in:

   https://lore.kernel.org/lkml/20180809152313.lewfhufidhxb2qrk@darkstar/


So, I would say that in v4 I can try to see if and how we can guard
(some of) the effective values on !CONFIG_UCLAMP_TASK_GROUP
configurations...

>
> >  union rcu_special {
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2ba55a4afffb..f692df3787bd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1237,6 +1237,8 @@ static inline void init_uclamp_sched_group(void)
> >  		uc_se = &root_task_group.uclamp[clamp_id];
> >  		uc_se->value = uclamp_none(clamp_id);
> >  		uc_se->group_id = group_id;
> > +		uc_se->effective.value = uclamp_none(clamp_id);
> > +		uc_se->effective.group_id = group_id;
> >  
> >  		/* Attach root TG's clamp group */
> >  		uc_map[group_id].se_count = 1;
> >  
> 
> <snip>
> 
> > @@ -7622,11 +7687,19 @@ static struct cftype cpu_legacy_files[] = {
> >  		.read_u64 = cpu_util_min_read_u64,
> >  		.write_u64 = cpu_util_min_write_u64,
> >  	},
> > +	{
> > +		.name = "util.min.effective",
> > +		.read_u64 = cpu_util_min_effective_read_u64,
> > +	},
> >  	{
> >  		.name = "util.max",
> >  		.read_u64 = cpu_util_max_read_u64,
> >  		.write_u64 = cpu_util_max_write_u64,
> >  	},
> > +	{
> > +		.name = "util.max.effective",
> > +		.read_u64 = cpu_util_max_effective_read_u64,
> > +	},
> >  #endif
> >  	{ }	/* Terminate */
> >  };
> 
> Is there any reason why these are not added for the default hierarchy?

Not really, good point!

I think I've just forgot them... which makes me notice that I still
have to improve the coverage for my tests on the default hierarchy.

I don't expect big difference, since the behaviors should be the
same but...

Thanks for pointing this out... will had the attributes in the
upcoming v4.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
