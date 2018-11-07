Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D22086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9D22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbeKHAYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:24:42 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52030 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeKHAYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:24:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF72380D;
        Wed,  7 Nov 2018 06:54:00 -0800 (PST)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DDBB3F5BD;
        Wed,  7 Nov 2018 06:53:57 -0800 (PST)
Date:   Wed, 7 Nov 2018 14:53:55 +0000
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
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107145355.GI14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107143713.GS9781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107143713.GS9781@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-Nov 15:37, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> > +static int __setscheduler_uclamp(struct task_struct *p,
> > +				 const struct sched_attr *attr)
> > +{
> > +	unsigned int lower_bound = p->uclamp[UCLAMP_MIN].value;
> > +	unsigned int upper_bound = p->uclamp[UCLAMP_MAX].value;
> > +	int result = 0;
> > +
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> > +		lower_bound = attr->sched_util_min;
> > +
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> > +		upper_bound = attr->sched_util_max;
> > +
> > +	if (lower_bound > upper_bound ||
> > +	    upper_bound > SCHED_CAPACITY_SCALE)
> >  		return -EINVAL;
> >  
> > +	mutex_lock(&uclamp_mutex);
> >  
> > +	/* Update each required clamp group */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +		uclamp_group_get(&p->uclamp[UCLAMP_MIN],
> > +				 UCLAMP_MIN, lower_bound);
> > +	}
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > +		uclamp_group_get(&p->uclamp[UCLAMP_MAX],
> > +				 UCLAMP_MAX, upper_bound);
> > +	}
> > +
> > +	mutex_unlock(&uclamp_mutex);
> > +
> > +	return result;
> > +}
> 
> I'm missing where we error due to lack of groups.

Again, after:

   sched/core: uclamp: add clamp group bucketing support

we should never error.

Perhaps I should really squash the bucketing in these first patches
directly... lemme see what's your take on those bits, if you like them
better not in a separate patch, I'll squash them on v6.

-- 
#include <best/regards.h>

Patrick Bellasi
