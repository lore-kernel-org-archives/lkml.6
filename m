Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3469FC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AD12171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfA1XGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:06:39 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1XGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:06:39 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E827192D;
        Mon, 28 Jan 2019 23:06:37 +0000 (UTC)
Date:   Mon, 28 Jan 2019 15:06:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: fix aggregation idle shut-off
Message-Id: <20190128150635.c22842034ab7e271c6416d2f@linux-foundation.org>
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
> 
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -480,9 +481,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  			groupc->tasks[t]++;
>  
>  	write_seqcount_end(&groupc->seq);
> -
> -	if (!delayed_work_pending(&group->clock_work))
> -		schedule_delayed_work(&group->clock_work, PSI_FREQ);
>  }
>  
>  static struct psi_group *iterate_groups(struct task_struct *task, void **iter)

This breaks Suren's "psi: introduce psi monitor":

--- kernel/sched/psi.c~psi-introduce-psi-monitor
+++ kernel/sched/psi.c
@@ -752,8 +1012,25 @@ static void psi_group_change(struct psi_
 
 	write_seqcount_end(&groupc->seq);
 
-	if (!delayed_work_pending(&group->clock_work))
-		schedule_delayed_work(&group->clock_work, PSI_FREQ);
+	/*
+	 * Polling flag resets to 0 at the max rate of once per update window
+	 * (at least 500ms interval). smp_wmb is required after group->polling
+	 * 0-to-1 transition to order groupc->times and group->polling writes
+	 * because stall detection logic in the slowpath relies on groupc->times
+	 * changing before group->polling. Explicit smp_wmb is missing because
+	 * cmpxchg() implies smp_mb.
+	 */
+	if ((state_mask & group->trigger_mask) &&
+		atomic_cmpxchg(&group->polling, 0, 1) == 0) {
+		/*
+		 * Start polling immediately even if the work is already
+		 * scheduled
+		 */
+		mod_delayed_work(system_wq, &group->clock_work, 1);
+	} else {
+		if (!delayed_work_pending(&group->clock_work))
+			schedule_delayed_work(&group->clock_work, PSI_FREQ);
+	}
 }
 
and I'm too lazy to go in and figure out how to fix it.

If we're sure about "psi: fix aggregation idle shut-off" (and I am not)
then can I ask for a redo of "psi: introduce psi monitor"?
