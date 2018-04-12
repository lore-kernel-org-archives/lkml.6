Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbeDLMMk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 08:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbeDLMMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 08:12:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C769921785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 12 Apr 2018 08:12:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Bin <huawei.libin@huawei.com>
Cc: <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
Subject: Re: [PATCH 2/2] sched/deadline.c: pick and check task if
 double_lock_balance() unlock the rq
Message-ID: <20180412081237.2a212c95@gandalf.local.home>
In-Reply-To: <1523530735-20011-3-git-send-email-huawei.libin@huawei.com>
References: <1523530735-20011-1-git-send-email-huawei.libin@huawei.com>
        <1523530735-20011-3-git-send-email-huawei.libin@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2018 18:58:55 +0800
Li Bin <huawei.libin@huawei.com> wrote:

> @@ -1965,11 +1985,9 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
>  
>  		/* Retry if something changed. */
>  		if (double_lock_balance(rq, later_rq)) {
> -			if (unlikely(task_rq(task) != rq ||
> -				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_allowed) ||
> -				     task_running(rq, task) ||
> -				     !dl_task(task) ||
> -				     !task_on_rq_queued(task))) {
> +			struct task_struct *next_task = pick_next_pushable_dl_task(rq);

I would do the same thing here, and add the comment from rt.c as it
is the same reason.

-- Steve

> +			if (unlikely(next_task != task ||
> +						!cpumask_test_cpu(later_rq->cpu, &task->cpus_allowed))) {
>  				double_unlock_balance(rq, later_rq);
>  				later_rq = NULL;
