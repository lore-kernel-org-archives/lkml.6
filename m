Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDEBC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679882089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:18:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 679882089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeJBWCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 18:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbeJBWCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 18:02:12 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16167206B2;
        Tue,  2 Oct 2018 15:18:18 +0000 (UTC)
Date:   Tue, 2 Oct 2018 11:18:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2]  sched/rt : return accurate release rq lock info
Message-ID: <20181002111816.0d752a4b@gandalf.local.home>
In-Reply-To: <1538511442-20182-1-git-send-email-peng.hao2@zte.com.cn>
References: <1538511442-20182-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 04:17:22 +0800
Peng Hao <peng.hao2@zte.com.cn> wrote:

> find_lock_lowest_rq may or not releease rq lock, but it is fuzzy.
> If not releasing rq lock, it is unnecessary to re-call
> pick_next_pushable_task.
> When CONFIG_PREEMPT=n, not releasing rq lock frequently happens
> in a simple test case:
> Four different rt priority tasks run on limited two cpus.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  kernel/sched/rt.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a..7c5382a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1718,6 +1718,7 @@ static int find_lowest_rq(struct task_struct *task)
>  static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  {
>  	struct rq *lowest_rq = NULL;
> +	bool release_lock = false;
>  	int tries;
>  	int cpu;
>  
> @@ -1741,6 +1742,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  
>  		/* if the prio of this runqueue changed, try again */
>  		if (double_lock_balance(rq, lowest_rq)) {
> +			release_lock = true;
>  			/*
>  			 * We had to unlock the run queue. In
>  			 * the mean time, task could have
> @@ -1768,6 +1770,8 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  		lowest_rq = NULL;
>  	}
>  
> +	if (!lowest_rq && release_lock)
> +		lowest_rq = RETRY_TASK;
>  	return lowest_rq;
>  }

Instead of adding the above boolean variable, wouldn't this work just
as well?

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..b363ef70412a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1754,7 +1754,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 				     !task_on_rq_queued(task))) {
 
 				double_unlock_balance(rq, lowest_rq);
-				lowest_rq = NULL;
+				lowest_rq = RETRY_TASK;
 				break;
 			}
 		}

>  
> @@ -1830,7 +1834,7 @@ static int push_rt_task(struct rq *rq)
>  
>  	/* find_lock_lowest_rq locks the rq if found */
>  	lowest_rq = find_lock_lowest_rq(next_task, rq);
> -	if (!lowest_rq) {

Not a biggy, but I would add here:

	if (!lowest_rq)
		goto out;

And then add the below. It just flows better.

-- Steve

> +	if (lowest_rq == RETRY_TASK) {
>  		struct task_struct *task;
>  		/*
>  		 * find_lock_lowest_rq releases rq->lock
> @@ -1863,6 +1867,8 @@ static int push_rt_task(struct rq *rq)
>  		goto retry;
>  	}
>  
> +	if (!lowest_rq)
> +		goto out;
>  	deactivate_task(rq, next_task, 0);
>  	set_task_cpu(next_task, lowest_rq->cpu);
>  	activate_task(lowest_rq, next_task, 0);

