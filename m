Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98155C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A6C208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A6C208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755143AbeFNLch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:32:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58498 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754963AbeFNLcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:32:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111531435;
        Thu, 14 Jun 2018 04:32:36 -0700 (PDT)
Received: from e110439-lin (e110439-lin.cambridge.arm.com [10.1.210.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CD0B3F59D;
        Thu, 14 Jun 2018 04:32:34 -0700 (PDT)
Date:   Thu, 14 Jun 2018 12:32:32 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/util_est: fix util_est_dequeue() for throttled cfs
 rq
Message-ID: <20180614113232.GG32302@e110439-lin>
References: <1528972380-16268-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528972380-16268-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-Jun 12:33, Vincent Guittot wrote:
> When a cfs_rq is throttled, parent cfs_rq->nr_running is decreased and
> everything happens at cfs_rq level. Currently util_est stays unchanged
> in such case and it keeps accounting the utilization of throttled tasks.
> This can somewhat make sense as we don't dequeue tasks but only throttled
> cfs_rq.

I think the idea here was that, if tasks are throttled, this should
manifest in a reduction of their utilization... and thus the estimated
utilization should still represent the amount of bandwidth required by
that tasks. Although one could argue that, while a TG is throttled we
would like to be able to drop the frequency if possible.

This has not been implemented that way so far because the
attach/detach of TGs will require to walk them to account for all
child tasks's util_est or, otherwise, to aggregate util_est across TGs.

> If a task of another group is enqueued/dequeued and root cfs_rq becomes
> idle during the dequeue, util_est will be cleared whereas it was
> accounting util_est of throttled tasks before.

Yep :/

> So the behavior of util_est
> is not always the same regarding throttled tasks and depends of side
> activity. Furthermore, util_est will not be updated when the cfs_rq is
> unthrottled

right... that happens because (un)throttling does not involve (en/de)queue.

> as everything happens at cfs rq level. Main results is that
> util_est will stay null whereas we now have running tasks. We have to wait
> for the next dequeue/enqueue of the previously throttled tasks to get an
> up to date util_est.
> 
> Remove the assumption that cfs_rq's estimated utilization of a CPU is 0
> if there is no running task so the util_est of a task remains until the
> latter is dequeued even if its cfs_rq has been throttled.

Right...

> Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e497c05..d3121fc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3982,18 +3982,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
>  	if (!sched_feat(UTIL_EST))
>  		return;
>  
> -	/*
> -	 * Update root cfs_rq's estimated utilization
> -	 *
> -	 * If *p is the last task then the root cfs_rq's estimated utilization
> -	 * of a CPU is 0 by definition.
> -	 */
> -	ue.enqueued = 0;

... AFAIR, this reset what there since one of the first posts as an
"optimization". But actually I was not considering the scenario you
describe.

> -	if (cfs_rq->nr_running) {
> -		ue.enqueued  = cfs_rq->avg.util_est.enqueued;
> -		ue.enqueued -= min_t(unsigned int, ue.enqueued,
> -				     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
> -	}
> +	/* Update root cfs_rq's estimated utilization */
> +	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
> +	ue.enqueued -= min_t(unsigned int, ue.enqueued,
> +			     (_task_util_est(p) | UTIL_AVG_UNCHANGED));

So, this should still be bound-safe thanks to the min() for the
subtraction.


>  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
>  
>  	/*
> -- 
> 2.7.4
> 

LGTM:

Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>

-- 
#include <best/regards.h>

Patrick Bellasi
