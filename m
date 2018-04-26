Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755611AbeDZLuA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:50:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48088 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755238AbeDZLt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:49:59 -0400
Date: Thu, 26 Apr 2018 13:49:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: use RETRY_TASK in idle_balance
Message-ID: <20180426114956.GJ4064@hirez.programming.kicks-ass.net>
References: <1524739022-7788-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524739022-7788-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:37:02PM +0200, Vincent Guittot wrote:
> Use RETRY_TASK in idle_balance when we want select_task_rq() function to 
> rerun the complete task selection path
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0951d1c..ba49f83 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9862,7 +9862,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	/* Is there a task of a high priority class? */
>  	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
> -		pulled_task = -1;
> +		pulled_task = RETRY_TASK;

This doesn't make sense, pulled_task is an integer, not a task pointer.
Also see how the caller in select_task_rq_fair() converts a negative
into RETRY_TASK.
