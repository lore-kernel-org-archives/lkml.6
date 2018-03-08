Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935031AbeCHJsi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:48:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755155AbeCHJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:48:36 -0500
Date: Thu, 8 Mar 2018 10:48:31 +0100
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
Subject: Re: [PATCH v5 4/4] sched/fair: update util_est only on util_avg
 updates
Message-ID: <20180308094830.GK25201@hirez.programming.kicks-ass.net>
References: <20180222170153.673-1-patrick.bellasi@arm.com>
 <20180222170153.673-5-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222170153.673-5-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 05:01:53PM +0000, Patrick Bellasi wrote:
> +#define UTIL_EST_NEED_UPDATE_FLAG 0x1

> @@ -5321,12 +5345,19 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
>  	if (!task_sleep)
>  		return;
>  
> +	/*
> +	 * Skip update of task's estimated utilization if the PELT signal has
> +	 * never been updated (at least once) since last enqueue time.
> +	 */
> +	ue = READ_ONCE(p->se.avg.util_est);
> +	if (ue.enqueued & UTIL_EST_NEED_UPDATE_FLAG)
> +		return;

The name and function seem inverted, if the flag is set, we do _NOT_
update util_est.

How about something like UTIL_EST_UNCHANGED ? That would give:

	/*
	 * If the PELT values haven't changed since enqueue time,
	 * skip the util_est update.
	 */
	if (enqueue & UTIL_EST_UNCHANGED)
		return;
