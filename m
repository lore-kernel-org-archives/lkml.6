Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754576AbeDWKRw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:17:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeDWKRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:17:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCDA96032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date: Mon, 23 Apr 2018 15:47:40 +0530
From: Pavan Kondeti <pkondeti@codeaurora.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] kernel/sched/core: busy wait before going idle
Message-ID: <20180423101740.GA28936@codeaurora.org>
References: <20180415133149.24112-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415133149.24112-1-npiggin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Sun, Apr 15, 2018 at 11:31:49PM +1000, Nicholas Piggin wrote:
> This is a quick hack for comments, but I've always wondered --
> if we have a short term polling idle states in cpuidle for performance
> -- why not skip the context switch and entry into all the idle states,
> and just wait for a bit to see if something wakes up again.
> 
> It's not uncommon to see various going-to-idle work in kernel profiles.
> This might be a way to reduce that (and just the cost of switching
> registers and kernel stack to idle thread). This can be an important
> path for single thread request-response throughput.
> 
> tbench bandwidth seems to be improved (the numbers aren't too stable
> but they pretty consistently show some gain). 10-20% would be a pretty
> nice gain for such workloads
> 
> clients     1     2     4     8    16   128
> vanilla   232   467   823  1819  3218  9065
> patched   310   503   962  2465  3743  9820
> 

<snip>

> +idle_spin_end:
>  	/* Promote REQ to ACT */
>  	rq->clock_update_flags <<= 1;
>  	update_rq_clock(rq);
> @@ -3437,6 +3439,32 @@ static void __sched notrace __schedule(bool preempt)
>  		if (unlikely(signal_pending_state(prev->state, prev))) {
>  			prev->state = TASK_RUNNING;
>  		} else {
> +			/*
> +			 * Busy wait before switching to idle thread. This
> +			 * is marked unlikely because we're idle so jumping
> +			 * out of line doesn't matter too much.
> +			 */
> +			if (unlikely(do_idle_spin && rq->nr_running == 1)) {
> +				u64 start;
> +
> +				do_idle_spin = false;
> +
> +				rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> +				rq_unlock_irq(rq, &rf);
> +
> +				spin_begin();
> +				start = local_clock();
> +				while (!need_resched() && prev->state &&
> +					!signal_pending_state(prev->state, prev)) {
> +					spin_cpu_relax();
> +					if (local_clock() - start > 1000000)
> +						break;
> +				}

Couple of comments/questions.

When a RT task is doing this busy loop, 

(1) need_resched() may not be set even if a fair/normal task is enqueued on
this CPU.

(2) Any lower prio RT task waking up on this CPU may migrate to another CPU
thinking this CPU is busy with higher prio RT task.

> +				spin_end();
> +
> +				rq_lock_irq(rq, &rf);
> +				goto idle_spin_end;
> +			}
>  			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
>  			prev->on_rq = 0;
>  
> -- 
> 2.17.0
> 

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
