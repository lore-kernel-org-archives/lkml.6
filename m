Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeDLMKo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbeDLMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:10:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA8521785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 12 Apr 2018 08:10:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Bin <huawei.libin@huawei.com>
Cc: <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
Subject: Re: [PATCH 1/2] sched/rt.c: pick and check task if
 double_lock_balance() unlock the rq
Message-ID: <20180412081039.17fcc09c@gandalf.local.home>
In-Reply-To: <1523530735-20011-2-git-send-email-huawei.libin@huawei.com>
References: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
        <1523530735-20011-2-git-send-email-huawei.libin@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 18:58:54 +0800
Li Bin <huawei.libin@huawei.com> wrote:

> @@ -1726,13 +1746,10 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			 * We had to unlock the run queue. In
>  			 * the mean time, task could have
>  			 * migrated already or had its affinity changed.
> -			 * Also make sure that it wasn't scheduled on its rq.
>  			 */
> -			if (unlikely(task_rq(task) != rq ||
> -				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed) ||
> -				     task_running(rq, task) ||
> -				     !rt_task(task) ||
> -				     !task_on_rq_queued(task))) {
> +			struct task_struct *next_task = pick_next_pushable_task(rq);

Could you declare next_task above the comment. It's better styling.

	struct task_struct *next_task;
	/*
	 * Comment
	 */
	next_task = pick_next_pushable_task(rq);


-- Steve

> +			if (unlikely(next_task != task ||
> +				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
>  				lowest_rq = NULL;
> @@ -1752,26 +1769,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
