Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeCGKMj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:12:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeCGKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:12:37 -0500
Date: Wed, 7 Mar 2018 11:12:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v5 3/4] sched/cpufreq_schedutil: use util_est for OPP
 selection
Message-ID: <20180307101214.GI25201@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222170153.673-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 05:01:52PM +0000, Patrick Bellasi wrote:
>  static inline unsigned long cpu_util_cfs(struct rq *rq)
>  {
> +	if (!sched_feat(UTIL_EST))
> +		return READ_ONCE(rq->cfs.avg.util_avg);
> +
> +	return max_t(unsigned long,
> +		     READ_ONCE(rq->cfs.avg.util_avg),
> +		     READ_ONCE(rq->cfs.avg.util_est.enqueued));
>  }

static inline unsigned long cpu_util_cfs(struct rq *rq)
{
	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);

	if (sched_feat(UTIL_EST)) {
		util = max_t(unsigned long, util,
			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
	}

	return util;
}

Seems like a more readable variant.
