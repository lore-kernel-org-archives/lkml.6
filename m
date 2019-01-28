Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6698AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ED22175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 22:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfA1WDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 17:03:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfA1WDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 17:03:39 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5F5F2A17;
        Mon, 28 Jan 2019 22:03:37 +0000 (UTC)
Date:   Mon, 28 Jan 2019 14:03:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: fix aggregation idle shut-off
Message-Id: <20190128140336.25854cb97c25924f4bfc26c7@linux-foundation.org>
In-Reply-To: <20190116193501.1910-1-hannes@cmpxchg.org>
References: <20190116193501.1910-1-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 14:35:01 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> psi has provisions to shut off the periodic aggregation worker when
> there is a period of no task activity - and thus no data that needs
> aggregating. However, while developing psi monitoring, Suren noticed
> that the aggregation clock currently won't stay shut off for good.
> 
> Debugging this revealed a flaw in the idle design: an aggregation run
> will see no task activity and decide to go to sleep; shortly
> thereafter, the kworker thread that executed the aggregation will go
> idle and cause a scheduling change, during which the psi callback will
> kick the !pending worker again. This will ping-pong forever, and is
> equivalent to having no shut-off logic at all (but with more code!)
> 
> Fix this by exempting aggregation workers from psi's clock waking
> logic when the state change is them going to sleep. To do this, tag
> workers with the last work function they executed, and if in psi we
> see a worker going to sleep after aggregating psi data, we will not
> reschedule the aggregation work item.
> 
> What if the worker is also executing other items before or after?
> 
> Any psi state times that were incurred by work items preceding the
> aggregation work will have been collected from the per-cpu buckets
> during the aggregation itself. If there are work items following the
> aggregation work, the worker's last_func tag will be overwritten and
> the aggregator will be kept alive to process this genuine new activity.
> 
> If the aggregation work is the last thing the worker does, and we
> decide to go idle, the brief period of non-idle time incurred between
> the aggregation run and the kworker's dequeue will be stranded in the
> per-cpu buckets until the clock is woken by later activity. But that
> should not be a problem. The buckets can hold 4s worth of time, and
> future activity will wake the clock with a 2s delay, giving us 2s
> worth of data we can leave behind when disabling aggregation. If it
> takes a worker more than two seconds to go idle after it finishes its
> last work item, we likely have bigger problems in the system, and
> won't notice one sample that was averaged with a bogus per-CPU weight.

Did we ever hear back from Suren about the testing?

Some words here about the new wq_worker_last_func() would be
appropriate.

It's an ugly-looking thing :(  Tejun, did you check this change?


> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -124,6 +124,7 @@
>   * sampling of the aggregate task states would be.
>   */
>  
> +#include "../workqueue_internal.h"

"Only to be included by workqueue and core kernel subsystems"

I'm not sure that psi qualifies.  Perhaps wq_worker_last_func() should
be declared in include/linux/workqueue.h.

And perhaps implemented there as well.  It's similar to
current_wq_worker(), which is inlined and wq_worker_last_func() is
small enough to justify inlining.

> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -909,6 +909,26 @@ struct task_struct *wq_worker_sleeping(struct task_struct *task)
>  	return to_wakeup ? to_wakeup->task : NULL;
>  }
>  
> +/**
> + * wq_worker_last_func - retrieve worker's last work function
> + *
> + * Determine the last function a worker executed. This is called from
> + * the scheduler to get a worker's last known identity.
> + *
> + * CONTEXT:
> + * spin_lock_irq(rq->lock)
> + *
> + * Return:
> + * The last work function %current executed as a worker, NULL if it
> + * hasn't executed any work yet.
> + */
> +work_func_t wq_worker_last_func(struct task_struct *task)
> +{
> +	struct worker *worker = kthread_data(task);
> +
> +	return worker->last_func;
> +}

The semantics are troublesome.  What guarantees that worker->last_func
won't change under the caller's feet?  The caller should hold some lock
(presumably worker->pool->lock) in order to stabilize the
wq_worker_last_func() return value?

Also, the comment isn't really true - this is called from PSI, which is
hardly "the scheduler"?


