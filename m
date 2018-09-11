Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED942086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED942086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIKVqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:46:52 -0400
Received: from foss.arm.com ([217.140.101.70]:46646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeIKVqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:46:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 395737A9;
        Tue, 11 Sep 2018 09:46:43 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AF063F703;
        Tue, 11 Sep 2018 09:46:40 -0700 (PDT)
Date:   Tue, 11 Sep 2018 17:46:37 +0100
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
Subject: Re: [PATCH v4 11/16] sched/core: uclamp: add system default clamps
Message-ID: <20180911164637.GC1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-12-patrick.bellasi@arm.com>
 <CAJuCfpGSUzo9gxWZABUUKaEEEvxdnvny9d1ErnLVLEKrkYf+eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGSUzo9gxWZABUUKaEEEvxdnvny9d1ErnLVLEKrkYf+eQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-Sep 09:20, Suren Baghdasaryan wrote:
> On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > @@ -1509,12 +1633,17 @@ static void __init init_uclamp(void)
> >                 uc_se->group_id = UCLAMP_NOT_VALID;
> >                 uclamp_group_get(NULL, clamp_id, 0, uc_se,
> >                                  uclamp_none(clamp_id));
> > +               /*
> > +                * By default we do not want task-specific clamp values,
> > +                * so that system default values apply.
> > +                */
> > +               uc_se->value = UCLAMP_NOT_VALID;
> >
> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
> >                 /* Init root TG's clamp group */
> >                 uc_se = &root_task_group.uclamp[clamp_id];
> >
> > -               uc_se->effective.value = uclamp_none(clamp_id);
> > +               uc_se->effective.value = uclamp_none(UCLAMP_MAX);
> 
> Both clamps are initialized with 1023 because children can go lower
> but can't go higher? Comment might be helpful.

Yes, that's because with CGroups we set the max allowed value, which
is also the one used for a clamp IFF:
 - the task is not part of a more restrictive group
 - the task has not a more restrictive task specific value

I'll improve this comment on the next respin.

> I saw this pattern of using uclamp_none(UCLAMP_MAX) for both clamps in
> couple places.

The other place is to define / initialize "uclamp_default_perf", which
is the default clamps used for RT tasks, introduce by the last patch:

 https://lore.kernel.org/lkml/20180828135324.21976-17-patrick.bellasi@arm.com/

So, RT tasks and root task group are the only two exceptions for
which, by default, we want a maximum boosting.

> Maybe would be better to have smth like:
> 
> static inline int tg_uclamp_none(int clamp_id) {
>     /* TG's min and max clamps default to SCHED_CAPACITY_SCALE to
> allow children to tighten the restriction */
>     return SCHED_CAPACITY_SCALE;
> }
> 
> and use tg_uclamp_none(clamp_id) instead of uclamp_none(UCLAMP_MAX)?
> Functionally the same but much more readable.

Not entirely convinced, maybe because of the name you suggest: it
cannot contain tg, because it applies also to RT tasks when TG are not
in use.

Maybe something like: uclamp_max_boost(clamp_id) could work instead ?

It will make more explicit that the configuration will maps into a:

     util.min = util.max = SCHED_CAPACITY_SCALE

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
