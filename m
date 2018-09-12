Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD25C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D608320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 14:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D608320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeILTYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 15:24:12 -0400
Received: from foss.arm.com ([217.140.101.70]:60766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726932AbeILTYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 15:24:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD1380D;
        Wed, 12 Sep 2018 07:19:29 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E1F53F5C0;
        Wed, 12 Sep 2018 07:19:26 -0700 (PDT)
Date:   Wed, 12 Sep 2018 15:19:23 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v4 09/16] sched/core: uclamp: map TG's clamp values into
 CPU's clamp groups
Message-ID: <20180912141923.GF1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-10-patrick.bellasi@arm.com>
 <CAJuCfpEbmW0Gr26FSDmtLB5C1gk0M83AYQihLr_Dz=gXY_-+qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEbmW0Gr26FSDmtLB5C1gk0M83AYQihLr_Dz=gXY_-+qA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-Sep 11:52, Suren Baghdasaryan wrote:
> On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > +/**
> > + * release_uclamp_sched_group: release utilization clamp references of a TG
> 
> free_uclamp_sched_group

+1

> > + * @tg: the task group being removed
> > + *
> > + * An empty task group can be removed only when it has no more tasks or child
> > + * groups. This means that we can also safely release all the reference
> > + * counting to clamp groups.
> > + */
> > +static inline void free_uclamp_sched_group(struct task_group *tg)
> > +{

[...]

> > @@ -1417,9 +1444,18 @@ static void __init init_uclamp(void)
> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
> >                 /* Init root TG's clamp group */
> >                 uc_se = &root_task_group.uclamp[clamp_id];
> > +
> >                 uc_se->effective.value = uclamp_none(clamp_id);
> > -               uc_se->value = uclamp_none(clamp_id);
> > -               uc_se->group_id = 0;
> > +               uc_se->effective.group_id = 0;
> > +
> > +               /*
> > +                * The max utilization is always allowed for both clamps.
> > +                * This is required to not force a null minimum utiliation on
> > +                * all child groups.
> > +                */
> > +               uc_se->group_id = UCLAMP_NOT_VALID;
> > +               uclamp_group_get(NULL, clamp_id, 0, uc_se,
> > +                                uclamp_none(UCLAMP_MAX));
> 
> I don't quite get why you are using uclamp_none(UCLAMP_MAX) for both
> UCLAMP_MIN and UCLAMP_MAX clamps. I assume the comment above is to
> explain this but I'm still unclear why this is done.

That's maybe a bit tricky to get but, this will not happen since for
root group tasks we apply the system default values... which however
are introduced by one of the following patches 11/16.

So, my understanding of the "delegation model" is that for cgroups we
have to ensure each TG is a "restriction" of its parent. Thus:

     tg::util_min <= tg_parent::util_min

This is required to ensure that a tg_parent can always restrict
resources on its descendants. I guess that's required to have a sane
usage of CGroups for VMs where the Host can transparently control its
Guests.

According to the above rule, and considering that root task group
cannot be modified, to allow boosting on TG we are forced to set the
root group with util_min = SCHED_CAPACITY_SCALE.

Moreover, Tejun pointed out that if we need tuning at root TG level,
it means that we need system wide tunable, which should be available
also when CGroups are not in use.

That's why on patch:

   [PATCH v4 11/16] sched/core: uclamp: add system default clamps
   https://lore.kernel.org/lkml/20180828135324.21976-12-patrick.bellasi@arm.com/

we add the concept of system default clamps which are actually
initialized with util_min=0, i.e. 0% boost by default.

These system default clamp values applies to tasks which are running
either in the root task group on in an autogroup, which also cannot be
tuned at run-time, whenever the task has not a task specific clamp
value specified.

All that considered, the code above is still confusing and I should
consider moving to patch 11/16 the initialization to UCLAMP_MAX for
util_min...

> Maybe expand the comment to explain the intention?

... and add there something like:

        /*
         * The max utilization is always allowed for both clamps.
         * This satisfies the "delegation model" required by CGroups
         * v2, where a child task group cannot have more resources then
         * its father, thus allowing the creation of child groups with
         * a non null util_min.
         * For tasks within the root_task_group we will use the system
         * default clamp values anyway, thus they will not be boosted
         * to the max utilization by default.
         */

It this more clear ?


> With this I think all TGs will get boosted by default, won't they?

You right, at cgroup creation time we clone parent's clamps... thus,
all root_task_group's children group will get max boosting at creation
time. However, since we don't have task within a newly created task
group, the system management software can still refine the clamps
before staring to move tasks in there.

Do you think we should initialize root task group childrens
differently ? I would prefer to avoid special cases if not strictly
required...

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
