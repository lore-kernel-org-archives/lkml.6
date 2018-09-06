Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63DFC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF6220645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF6220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeIFSgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:36:13 -0400
Received: from foss.arm.com ([217.140.101.70]:46292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729534AbeIFSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:36:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E510180D;
        Thu,  6 Sep 2018 07:00:31 -0700 (PDT)
Received: from e110439-lin (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 228963F614;
        Thu,  6 Sep 2018 07:00:28 -0700 (PDT)
Date:   Thu, 6 Sep 2018 15:00:26 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
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
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180906140026.GC25636@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180906081728.GB27626@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906081728.GB27626@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Sep 10:17, Juri Lelli wrote:
> On 28/08/18 14:53, Patrick Bellasi wrote:
> 
> [...]
> 
> >  static inline int __setscheduler_uclamp(struct task_struct *p,
> >  					const struct sched_attr *attr)
> >  {
> > -	if (attr->sched_util_min > attr->sched_util_max)
> > -		return -EINVAL;
> > -	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> > -		return -EINVAL;
> > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > +	int lower_bound, upper_bound;
> > +	struct uclamp_se *uc_se;
> > +	int result = 0;
> >  
> > -	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> > -	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> > +	mutex_lock(&uclamp_mutex);
> >  
> > -	return 0;
> > +	/* Find a valid group_id for each required clamp value */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
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
> > +
> > +		result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> > +		if (result == -ENOSPC) {
> > +			pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> > +			goto done;
> > +		}
> > +		group_id[UCLAMP_MIN] = result;
> > +	}
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > +		lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> > +			? attr->sched_util_min
> > +			: p->uclamp[UCLAMP_MIN].value;
> > +
> > +		if (lower_bound == UCLAMP_NOT_VALID)
> > +			lower_bound = 0;
> > +		if (attr->sched_util_max < lower_bound ||
> > +		    attr->sched_util_max > SCHED_CAPACITY_SCALE) {
> > +			result = -EINVAL;
> > +			goto done;
> > +		}
> > +
> > +		result = uclamp_group_find(UCLAMP_MAX, attr->sched_util_max);
> > +		if (result == -ENOSPC) {
> > +			pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> > +			goto done;
> > +		}
> > +		group_id[UCLAMP_MAX] = result;
> > +	}
> 
> Don't you have to reset result to 0 here (it seems what follows cannot
> fail anymore)? Otherwise this function will return latest
> uclamp_group_find return value, which will be interpreted as error if
> not 0.

Yes, wired.. it uses to work on my tests just because I return from
the caller on !0 and:
 - that's just good enough to set by uclamps
 - my current rt-app integration does not check the sycall return value
 - my tests never request the clamp_group mapped on group_id=0

:(

Will fix both this and the rt-app integration and the tests !

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
