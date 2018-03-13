Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932741AbeCMUKv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:10:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58900 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCMUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:10:48 -0400
Date: Tue, 13 Mar 2018 21:10:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [RT PATCH 2/2] block: blk-mq: move
 blk_queue_usage_counter_release() into process context
Message-ID: <20180313201039.GB4082@hirez.programming.kicks-ass.net>
References: <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
 <20180309222643.GC5926@hirez.programming.kicks-ass.net>
 <20180312105113.p7jifhwdwbhpvxds@linutronix.de>
 <20180312132729.GI4064@hirez.programming.kicks-ass.net>
 <20180312141107.roveviectc6a75s7@linutronix.de>
 <20180312142933.GF4043@hirez.programming.kicks-ass.net>
 <20180312195118.rye5lg2pb26kmavn@linutronix.de>
 <20180313184039.begptzircgb5ketk@linutronix.de>
 <20180313184240.ndq2pw2fmvhkwidc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313184240.ndq2pw2fmvhkwidc@linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 07:42:41PM +0100, Sebastian Andrzej Siewior wrote:
> +static void blk_queue_usage_counter_release_swork(struct swork_event *sev)
> +{
> +	struct request_queue *q =
> +		container_of(sev, struct request_queue, mq_pcpu_wake);
> +
> +	wake_up_all(&q->mq_freeze_wq);
> +}
> +
>  static void blk_queue_usage_counter_release(struct percpu_ref *ref)
>  {
>  	struct request_queue *q =
>  		container_of(ref, struct request_queue, q_usage_counter);
>  
> -	wake_up_all(&q->mq_freeze_wq);
> +	swork_queue(&q->mq_pcpu_wake);
>  }

Depending on if we expect there to actually be wakeups, you could do
something like:

	if (wq_has_sleepers(&q->mq_freeze_wq))
		swork_queue(&q->mq_pcpu_wake));

avoiding the whole workqueue thing in the case there wasn't anybody
waiting for it. But since I don't know this code, I can't say if it
makes sense or not. Tejun?
