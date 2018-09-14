Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F7C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303AF20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303AF20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeINOAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:00:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58306 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeINOAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:00:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31A4D18A;
        Fri, 14 Sep 2018 01:47:10 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629B33F703;
        Fri, 14 Sep 2018 01:47:07 -0700 (PDT)
Date:   Fri, 14 Sep 2018 09:47:04 +0100
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
Message-ID: <20180914084704.GL1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912162427.GA24106@hirez.programming.kicks-ass.net>
 <20180912174209.GI1413@e110439-lin>
 <20180913192034.GA24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913192034.GA24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-Sep 21:20, Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 06:42:09PM +0100, Patrick Bellasi wrote:
> > On 12-Sep 18:24, Peter Zijlstra wrote:
> > > On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
> 
> > > >  {
> > > > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > > > +	int lower_bound, upper_bound;
> > > > +	struct uclamp_se *uc_se;
> > > > +	int result = 0;
> > > 
> > > I think the thing would become much more readable if you set
> > > lower/upper_bound right here.
> 
> > Actually it could also make sense to have them before the mutex ;)
> 
> Indeed.
> 
> +               upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> +                       ? attr->sched_util_max
> +                       : p->uclamp[UCLAMP_MAX].value;
> +
> +               if (upper_bound == UCLAMP_NOT_VALID)
> +                       upper_bound = SCHED_CAPACITY_SCALE;
> +               if (attr->sched_util_min > upper_bound) {
> +                       result = -EINVAL;
> +                       goto done;
> +               }
> +
> +               result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> +               if (result == -ENOSPC) {
> +                       pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> +                       goto done;
> +               }
> +               group_id[UCLAMP_MIN] = result;
> +       }
> +       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +               lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> +                       ? attr->sched_util_min
> +                       : p->uclamp[UCLAMP_MIN].value;
> +
> +               if (lower_bound == UCLAMP_NOT_VALID)
> +                       lower_bound = 0;
> +               if (attr->sched_util_max < lower_bound ||
> +                   attr->sched_util_max > SCHED_CAPACITY_SCALE) {
> +                       result = -EINVAL;
> +                       goto done;
> +               }
> 
> That would end up soething like:
> 
> 	unsigned int lower_bound = p->uclamp[UCLAMP_MIN].value;
> 	unsigned int upper_bound = p->uclamp[UCLAMP_MAX].value;
> 
> 	if (sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> 		lower_bound = attr->sched_util_min;
> 
> 	if (sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> 		upper_bound = attr->sched_util_max;
> 
> 	if (lower_bound > upper_bound ||
> 	    upper_bound > SCHED_CAPACITY_MAX)
> 		return -EINVAL;
> 
> 	mutex_lock(...);

Yes... much cleaner, thanks.

-- 
#include <best/regards.h>

Patrick Bellasi
