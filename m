Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31038C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E831620880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E831620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeILWrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:47:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36640 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeILWrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:47:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABD937A9;
        Wed, 12 Sep 2018 10:42:14 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD15F3F557;
        Wed, 12 Sep 2018 10:42:11 -0700 (PDT)
Date:   Wed, 12 Sep 2018 18:42:09 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
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
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180912174209.GI1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912162427.GA24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912162427.GA24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-Sep 18:24, Peter Zijlstra wrote:
> On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
> >  static inline int __setscheduler_uclamp(struct task_struct *p,
> >  					const struct sched_attr *attr)
> 
> But large for inline now.

Yes, Suren also already pointed that out... already gone in my v5 ;)

> >  {
> > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > +	int lower_bound, upper_bound;
> > +	struct uclamp_se *uc_se;
> > +	int result = 0;
> 
> I think the thing would become much more readable if you set
> lower/upper_bound right here.

Do you mean the bits I've ---8<---ed below ?

> >
> > +	mutex_lock(&uclamp_mutex);
> >
> > +	/* Find a valid group_id for each required clamp value */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {

---8<---
> > +		upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> > +			? attr->sched_util_max
> > +			: p->uclamp[UCLAMP_MAX].value;
> > +
> > +		if (upper_bound == UCLAMP_NOT_VALID)
> > +			upper_bound = SCHED_CAPACITY_SCALE;
> > +		if (attr->sched_util_min > upper_bound) {
> > +			result = -EINVAL;
> > +			goto done;
> > +		}
---8<---

Actually it could also make sense to have them before the mutex ;)

> > +
> > +		result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> > +		if (result == -ENOSPC) {
> > +			pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> 
> AFAICT this is an unpriv part of the syscall; and you can spam the log
> without limits. Not good.

Good point, will better check this.

[...]

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
