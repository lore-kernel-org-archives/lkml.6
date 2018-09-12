Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF869C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9087820866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9087820866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeILPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:36:02 -0400
Received: from foss.arm.com ([217.140.101.70]:57264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeILPgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:36:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC6C7A9;
        Wed, 12 Sep 2018 03:32:06 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197BF3F614;
        Wed, 12 Sep 2018 03:32:03 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:32:01 +0100
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
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180912103201.GD1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <CAJuCfpF36-VZm0JVVNnOnGm-ukVejzxbPhH33X3z9gAQ06t9gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF36-VZm0JVVNnOnGm-ukVejzxbPhH33X3z9gAQ06t9gQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suren,

On 08-Sep 16:47, Suren Baghdasaryan wrote:

[...]

> > + * A clamp group is not free if there is at least one SE which is sing a clamp
> 
> typo in the sentence

Right, s/is sing/is using/

+1

[...]

> > +static int
> > +uclamp_group_find(int clamp_id, unsigned int clamp_value)
> > +{
> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> > +       int free_group_id = UCLAMP_NOT_VALID;
> > +       unsigned int group_id = 0;
> > +
> > +       for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> > +               /* Keep track of first free clamp group */
> > +               if (uclamp_group_available(clamp_id, group_id)) {
> > +                       if (free_group_id == UCLAMP_NOT_VALID)
> > +                               free_group_id = group_id;
> > +                       continue;
> > +               }
> 
> Not a big improvement but reordering the two conditions in this loop
> would avoid finding and recording free_group_id if the very first
> group is the one we are looking for.

Right, indeed with:

   uclamp_group_put()
       uclamp_group_reset()
           uclamp_group_init()

we always ensure that:

   uc_map[group_id].value == UCLAMP_NOT_VALID

for free groups. Thus, it should be safe to swap this two checks and
we likely save few instructions for a likely common case of non
clamped tasks.

+1

I'll also get the chance to remove the two simple comments. ;)

> > +               /* Return index of first group with same clamp value */
> > +               if (uc_map[group_id].value == clamp_value)
> > +                       return group_id;
> > +       }
> > +
> > +       if (likely(free_group_id != UCLAMP_NOT_VALID))
> > +               return free_group_id;
> > +
> > +       return -ENOSPC;
> > +}

[...]

> > +static inline void uclamp_group_put(int clamp_id, int group_id)

> Is the size and the number of invocations of this function small
> enough for inlining? Same goes for uclamp_group_get() and especially
> for __setscheduler_uclamp().

Right... yes, we could let the scheduler do its job and remove inline
from these functions... at least for those not in the critical path.

+1

[...]

> > +       if (likely(uc_map[group_id].se_count))
> > +               uc_map[group_id].se_count -= 1;
> > +#ifdef SCHED_DEBUG
> > +       else {
> 
> nit: no need for braces
> 
> > +               WARN(1, "invalid SE clamp group [%d:%d] refcount\n",
> > +                    clamp_id, group_id);

Since the above statement is multi-line, we actually need it for code
code-style requirements.

> > +       }
> > +#endif

[...]

> > +static void uclamp_fork(struct task_struct *p, bool reset)
> > +{
> > +       int clamp_id;
> > +
> > +       if (unlikely(!p->sched_class->uclamp_enabled))
> > +               return;
> > +
> > +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> > +               int next_group_id = p->uclamp[clamp_id].group_id;
> > +               struct uclamp_se *uc_se = &p->uclamp[clamp_id];
> 
> Might be easier to read if after the above assignment you use
> uc_se->xxx instead of p->uclamp[clamp_id].xxx in the code below.

Yes, that's actually the intent of the above assigmenet... but I've
forgot a couple of usages! +1

> > +
> > +               if (unlikely(reset)) {
> > +                       next_group_id = 0;
> > +                       p->uclamp[clamp_id].value = uclamp_none(clamp_id);
> > +               }
> > +
> > +               p->uclamp[clamp_id].group_id = UCLAMP_NOT_VALID;
> > +               uclamp_group_get(clamp_id, next_group_id, uc_se,
> > +                                p->uclamp[clamp_id].value);
> > +       }
> > +}

[...]

> Thanks,
> Suren.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
