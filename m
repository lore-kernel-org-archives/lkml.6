Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25F5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FB9204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FB9204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbeGTQAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:00:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37798 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731763AbeGTQAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:00:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3818380D;
        Fri, 20 Jul 2018 08:12:04 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CDD63F5B3;
        Fri, 20 Jul 2018 08:12:01 -0700 (PDT)
Date:   Fri, 20 Jul 2018 16:11:56 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
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
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v2 02/12] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180720151156.GA31421@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-3-patrick.bellasi@arm.com>
 <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suren,
thanks for the review, all good point... some more comments follow
inline.

On 19-Jul 16:51, Suren Baghdasaryan wrote:
> On Mon, Jul 16, 2018 at 1:28 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:

[...]

> > +/**
> > + * uclamp_group_available: checks if a clamp group is available
> > + * @clamp_id: the utilization clamp index (i.e. min or max clamp)
> > + * @group_id: the group index in the given clamp_id
> > + *
> > + * A clamp group is not free if there is at least one SE which is sing a clamp
> 
> Did you mean to say "single clamp"?

No, it's "...at least one SE which is USING a clamp value..."

> > + * value mapped on the specified clamp_id. These SEs are reference counted by
> > + * the se_count of a uclamp_map entry.
> > + *
> > + * Return: true if there are no SE's mapped on the specified clamp
> > + *         index and group
> > + */
> > +static inline bool uclamp_group_available(int clamp_id, int group_id)
> > +{
> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> > +
> > +       return (uc_map[group_id].value == UCLAMP_NONE);
> 
> The usage of UCLAMP_NONE is very confusing to me. It was not used at
> all in the patch where it was introduced [1/12], here it's used as a
> clamp value and in uclamp_group_find() it's used as group_id. Please
> clarify the usage.

Yes, it's meant to represent a "clamp not valid" condition, whatever
it's a "clamp group" or a "clamp value"... perhaps the name can be
improved.

> I also feel UCLAMP_NONE does not really belong to
> the uclamp_id enum because other elements there are indexes in
> uclamp_maps and this one is a special value.

Right, it looks a bit misplaced, I agree. I think I tried to set it
using a #define but there was some issues I don't remember now...
Anyway, I'll give it another go...


> IMHO if both *group_id*
> and *value* need a special value (-1) to represent
> unused/uninitialized entry it would be better to use different
> constants. Maybe UCLAMP_VAL_NONE and UCLAMP_GROUP_NONE?

Yes, maybe we can use a

   #define UCLAMP_NOT_VALID -1

and get rid the confusing enum entry.

Will update it on v3.

> > +}

[...]

> > +/**
> > + * uclamp_group_find: finds the group index of a utilization clamp group
> > + * @clamp_id: the utilization clamp index (i.e. min or max clamping)
> > + * @clamp_value: the utilization clamping value lookup for
> > + *
> > + * Verify if a group has been assigned to a certain clamp value and return
> > + * its index to be used for accounting.
> > + *
> > + * Since only a limited number of utilization clamp groups are allowed, if no
> > + * groups have been assigned for the specified value, a new group is assigned
> > + * if possible. Otherwise an error is returned, meaning that an additional clamp
> > + * value is not (currently) supported.
> > + */
> > +static int
> > +uclamp_group_find(int clamp_id, unsigned int clamp_value)
> > +{
> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> > +       int free_group_id = UCLAMP_NONE;
> > +       unsigned int group_id = 0;
> > +
> > +       for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
> > +               /* Keep track of first free clamp group */
> > +               if (uclamp_group_available(clamp_id, group_id)) {
> > +                       if (free_group_id == UCLAMP_NONE)
> > +                               free_group_id = group_id;
> > +                       continue;
> > +               }
> > +               /* Return index of first group with same clamp value */
> > +               if (uc_map[group_id].value == clamp_value)
> > +                       return group_id;
> > +       }
> > +       /* Default to first free clamp group */
> > +       if (group_id > CONFIG_UCLAMP_GROUPS_COUNT)
> 
> Is the condition above needed? I think it's always true if you got here.
> Also AFAIKT after the for loop you can just do:
> 
> return (free_group_id != UCLAMP_NONE) ? free_group_id : -ENOSPC;

Yes, you right... the code above can be simplified!

> 
> > +               group_id = free_group_id;
> > +       /* All clamp group already track different clamp values */
> > +       if (group_id == UCLAMP_NONE)
> > +               return -ENOSPC;
> > +       return group_id;
> > +}

[...]

> > +static inline void uclamp_group_put(int clamp_id, int group_id)
> > +{
> > +       struct uclamp_map *uc_map = &uclamp_maps[clamp_id][0];
> > +       unsigned long flags;
> > +
> > +       /* Ignore SE's not yet attached */
> > +       if (group_id == UCLAMP_NONE)
> > +               return;
> > +
> > +       /* Remove SE from this clamp group */
> > +       raw_spin_lock_irqsave(&uc_map[group_id].se_lock, flags);
> > +       uc_map[group_id].se_count -= 1;
> 
> If uc_map[group_id].se_count was 0 before decrement you end up with
> se_count == -1 and no reset for the element.

Well... this should never happen, otherwise the refcounting is not
working as expected.

Maybe we can add (at least) a debug check and warning, something like:

#ifdef SCHED_DEBUG
	if (unlikely(uc_map[group_id].se_count == 0)) {
		WARN(1, "invalid clamp group [%d:%d] refcount\n",
				clamp_id, group_id);
		uc_map[group_id].se_count = 1;
        }
#endif

> > +       if (uc_map[group_id].se_count == 0)
> > +               uclamp_group_reset(clamp_id, group_id);
> > +       raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
> > +}
> > +

[...]

> >  static inline int __setscheduler_uclamp(struct task_struct *p,
> >                                         const struct sched_attr *attr)
> >  {
> > +       struct uclamp_se *uc_se;
> > +       int retval = 0;
> > +
> >         if (attr->sched_util_min > attr->sched_util_max)
> >                 return -EINVAL;
> >         if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> >                 return -EINVAL;
> >
> > -       p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> > -       p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> > +       mutex_lock(&uclamp_mutex);
> > +
> > +       /* Update min utilization clamp */
> > +       uc_se = &p->uclamp[UCLAMP_MIN];
> > +       retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
> > +                                  attr->sched_util_min);
> > +
> > +       /* Update max utilization clamp */
> > +       uc_se = &p->uclamp[UCLAMP_MAX];
> > +       retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
> > +                                  attr->sched_util_max);
> > +
> > +       mutex_unlock(&uclamp_mutex);
> > +
> > +       /*
> > +        * If one of the two clamp values should fail,
> > +        * let the userspace know.
> > +        */
> > +       if (retval)
> > +               return -ENOSPC;
> 
> Maybe a minor issue but this failure is ambiguous. It might mean:
> 1. no clamp value was updated
> 2. UCLAMP_MIN was updated but UCLAMP_MAX was not
> 3. UCLAMP_MAX was updated but UCLAMP_MIN was not

That's right, I put a bit of thought on that me too but at the end
I've been convinced that the possibility to use a single syscall to
set both clamps at the same time has some benefits for user-space.

Maybe the current solution can be improved by supporting an (optional)
strict semantic with an in-kernel roll-back in case one of the two
uclamp_group_get should fail.

The strict semantic with roll-back could be controller via an
additional flag, e.g. SCHED_FLAG_UTIL_CLAMP_STRICT.

When the flag is set, either we are able to set both the attributes or
we roll-back. Otherwise, when the flag is not set, we keep the current
behavior. i.e. we set what we can and report an error to notify
userspace that one constraints was not enforced.

The following snippet should implement this semantics:

---8<---

/* Uclamp flags */
#define SCHED_FLAG_UTIL_CLAMP_STRICT	0x11 /* Roll-back on failure */
#define SCHED_FLAG_UTIL_CLAMP_MIN	0x12 /* Update util_min */
#define SCHED_FLAG_UTIL_CLAMP_MAX	0x14 /* Update util_max */
#define SCHED_FLAG_UTIL_CLAMP		( \
		SCHED_FLAG_UTIL_CLAMP_MIN | SCHED_FLAG_UTIL_CLAMP_MAX)

static inline int __setscheduler_uclamp(struct task_struct *p,
					const struct sched_attr *attr)
{
	unsigned int uclamp_value_old = 0;
	unsigned int uclamp_value;
	struct uclamp_se *uc_se;
	int retval = 0;

	if (attr->sched_util_min > attr->sched_util_max)
		return -EINVAL;
	if (attr->sched_util_max > 100)
		return -EINVAL;

	mutex_lock(&uclamp_mutex);

	if (!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN))
		goto set_util_max;

	uc_se = &p->uclamp[UCLAMP_MIN];
	uclamp_value = scale_from_percent(attr->sched_util_min);
	if (uc_se->value == uclamp_value)
		goto set_util_max;

	/* Update min utilization clamp */
	uclamp_value_old = uc_se->value;
	retval |= uclamp_group_get(p, NULL, UCLAMP_MIN, uc_se, uclamp_value);
	if (retval &&
	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_STRICT)
		goto exit_failure;

set_util_max:

	if (!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX))
		goto exit_done;

	uc_se = &p->uclamp[UCLAMP_MAX];
	uclamp_value = scale_from_percent(attr->sched_util_max);
	if (uc_se->value == uclamp_value)
		goto exit_done;

	/* Update max utilization clamp */
	if (uclamp_group_get(p, NULL, UCLAMP_MAX,
			     uc_se, uclamp_value))
		goto exit_rollback;

exit_done:
	mutex_unlock(&uclamp_mutex);
	return retval;

exit_rollback:
	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
	    attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_STRICT) {
		uclamp_group_get(p, NULL, UCLAMP_MIN,
				 uc_se, uclamp_value_old);
	}
exit_failure:
	mutex_unlock(&uclamp_mutex);

	return -ENOSPC;
}

---8<---


Could that work better?

The code is maybe a bit more convoluted... but perhaps it can be
improved by encoding it in a loop.


-- 
#include <best/regards.h>

Patrick Bellasi
