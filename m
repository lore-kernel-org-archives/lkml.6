Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB6FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5182148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5182148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403900AbeHPRgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:36:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37350 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeHPRgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:36:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755637A9;
        Thu, 16 Aug 2018 07:37:39 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A78AD3F5D0;
        Thu, 16 Aug 2018 07:37:36 -0700 (PDT)
Date:   Thu, 16 Aug 2018 15:37:34 +0100
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
Subject: Re: [PATCH v3 12/14] sched/core: uclamp: add system default clamps
Message-ID: <20180816143734.GE2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-13-patrick.bellasi@arm.com>
 <20180816091348.GD2661@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816091348.GD2661@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-Aug 14:43, Pavan Kondeti wrote:
> On Mon, Aug 06, 2018 at 05:39:44PM +0100, Patrick Bellasi wrote:
> > Clamp values cannot be tuned at the root cgroup level. Moreover, because
> > of the delegation model requirements and how the parent clamps
> > propagation works, if we want to enable subgroups to set a non null
> > util.min, we need to be able to configure the root group util.min to the
> > allow the maximum utilization (SCHED_CAPACITY_SCALE = 1024).
> > 
> > Unfortunately this setup will also mean that all tasks running in the
> > root group, will always get a maximum util.min clamp, unless they have a
> > lower task specific clamp which is definitively not a desirable default
> > configuration.
> > 
> > Let's fix this by explicitly adding a system default configuration
> > (sysctl_sched_uclamp_util_{min,max}) which works as a restrictive clamp
> > for all tasks running on the root group.
> > 
> > This interface is available independently from cgroups, thus providing a
> > complete solution for system wide utilization clamping configuration.
> > 
> > Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Paul Turner <pjt@google.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Joel Fernandes <joelaf@google.com>
> > Cc: Steve Muckle <smuckle@google.com>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> 
> <snip>
> 
> > +/*
> > + * Minimum utilization for tasks in the root cgroup
> > + * default: 0
> > + */
> > +unsigned int sysctl_sched_uclamp_util_min;
> > +
> > +/*
> > + * Maximum utilization for tasks in the root cgroup
> > + * default: 1024
> > + */
> > +unsigned int sysctl_sched_uclamp_util_max = 1024;
> > +
> > +static struct uclamp_se uclamp_default[UCLAMP_CNT];
> > +
> 
> The default group id for un-clamped root tasks is 0 because of
> this declaration, correct?

Yes, the clamp group 0 is (should be) initialized to track the system
default values:

  util_min = 0 and util_max = SCHED_CAPACITY_SCALE

but...

> >  /**
> >   * uclamp_map: reference counts a utilization "clamp value"
> >   * @value:    the utilization "clamp value" required
> > @@ -957,12 +971,25 @@ static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
> >  	group_id = uc_se->group_id;
> >  
> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
> > +	/*
> > +	 * Tasks in the root group, which do not have a task specific clamp
> > +	 * value, get the system default calmp value.
> > +	 */
> > +	if (group_id == UCLAMP_NOT_VALID &&
> > +	    task_group(p) == &root_task_group) {
> > +		return uclamp_default[clamp_id].group_id;
> > +	}
> > +
> >  	/* Use TG's clamp value to limit task specific values */
> >  	uc_se = &task_group(p)->uclamp[clamp_id];
> >  	if (group_id == UCLAMP_NOT_VALID ||
> >  	    clamp_value > uc_se->effective.value) {
> >  		group_id = uc_se->effective.group_id;
> >  	}
> > +#else
> > +	/* By default, all tasks get the system default clamp value */
> > +	if (group_id == UCLAMP_NOT_VALID)
> > +		return uclamp_default[clamp_id].group_id;
> >  #endif
> >  
> >  	return group_id;
> > @@ -1269,6 +1296,75 @@ static inline void uclamp_group_get(struct task_struct *p,
> >  	uclamp_group_put(clamp_id, prev_group_id);
> >  }
> >  
> > +int sched_uclamp_handler(struct ctl_table *table, int write,
> > +			 void __user *buffer, size_t *lenp,
> > +			 loff_t *ppos)
> > +{
> > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > +	struct uclamp_se *uc_se;
> > +	int old_min, old_max;
> > +	int result;
> > +
> > +	mutex_lock(&uclamp_mutex);
> > +
> > +	old_min = sysctl_sched_uclamp_util_min;
> > +	old_max = sysctl_sched_uclamp_util_max;
> > +
> > +	result = proc_dointvec(table, write, buffer, lenp, ppos);
> > +	if (result)
> > +		goto undo;
> > +	if (!write)
> > +		goto done;
> > +
> > +	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max)
> > +		goto undo;
> > +	if (sysctl_sched_uclamp_util_max > 1024)
> > +		goto undo;
> > +
> > +	/* Find a valid group_id for each required clamp value */
> > +	if (old_min != sysctl_sched_uclamp_util_min) {
> > +		result = uclamp_group_find(UCLAMP_MIN, sysctl_sched_uclamp_util_min);
> > +		if (result == -ENOSPC) {
> > +			pr_err("Cannot allocate more than %d UTIL_MIN clamp groups\n",
> > +			       CONFIG_UCLAMP_GROUPS_COUNT);
> > +			goto undo;
> > +		}
> > +		group_id[UCLAMP_MIN] = result;
> > +	}
> > +	if (old_max != sysctl_sched_uclamp_util_max) {
> > +		result = uclamp_group_find(UCLAMP_MAX, sysctl_sched_uclamp_util_max);
> > +		if (result == -ENOSPC) {
> > +			pr_err("Cannot allocate more than %d UTIL_MAX clamp groups\n",
> > +			       CONFIG_UCLAMP_GROUPS_COUNT);
> > +			goto undo;
> > +		}
> > +		group_id[UCLAMP_MAX] = result;
> > +	}
> > +
> > +	/* Update each required clamp group */
> > +	if (old_min != sysctl_sched_uclamp_util_min) {
> > +		uc_se = &uclamp_default[UCLAMP_MIN];
> > +		uclamp_group_get(NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
> > +				 uc_se, sysctl_sched_uclamp_util_min);
> > +	}
> > +	if (old_max != sysctl_sched_uclamp_util_max) {
> > +		uc_se = &uclamp_default[UCLAMP_MAX];
> > +		uclamp_group_get(NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
> > +				 uc_se, sysctl_sched_uclamp_util_max);
> > +	}
> 

... you are right hereafter: there are still some lose points.

> uclamp_group_get() also drops the reference on the previous group id.
> The initial group id for uclamp_default[] i.e 0 is never claimed by
> us. so we end up releasing it. But root group still points to group#0.
> is this a problem?

No, it's not correct... and it's similar to the issue you already
raised for the refcounting decrement on task exit.

I'm working on v4 to review and fixup all the lose points and missing
initializations (like in this case) related to the clamp groups
mapping refcounting.

Thanks for pointing this out!

Best,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
