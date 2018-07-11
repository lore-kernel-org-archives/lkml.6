Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41824C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FCB208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FCB208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeGKI4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:56:25 -0400
Received: from mail.santannapisa.it ([193.205.80.99]:50967 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeGKI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:56:25 -0400
Received: from [10.30.3.150] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 131845889; Wed, 11 Jul 2018 10:53:07 +0200
Date:   Wed, 11 Jul 2018 10:53:03 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, bristot@redhat.com
Subject: Re: [PATCH] sched/deadline: Fix switched_from_dl
Message-ID: <20180711105303.05551d59@luca64>
In-Reply-To: <20180711072948.27061-1-juri.lelli@redhat.com>
References: <20180711072948.27061-1-juri.lelli@redhat.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 09:29:48 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Mark noticed that syzkaller is able to reliably trigger the following
> 
>   dl_rq->running_bw > dl_rq->this_bw
>   WARNING: CPU: 1 PID: 153 at kernel/sched/deadline.c:124
> switched_from_dl+0x454/0x608 Kernel panic - not syncing:
> panic_on_warn set ...
> 
>   CPU: 1 PID: 153 Comm: syz-executor253 Not tainted 4.18.0-rc3+ #29
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    dump_backtrace+0x0/0x458
>    show_stack+0x20/0x30
>    dump_stack+0x180/0x250
>    panic+0x2dc/0x4ec
>    __warn_printk+0x0/0x150
>    report_bug+0x228/0x2d8
>    bug_handler+0xa0/0x1a0
>    brk_handler+0x2f0/0x568
>    do_debug_exception+0x1bc/0x5d0
>    el1_dbg+0x18/0x78
>    switched_from_dl+0x454/0x608
>    __sched_setscheduler+0x8cc/0x2018
>    sys_sched_setattr+0x340/0x758
>    el0_svc_naked+0x30/0x34
> 
> syzkaller reproducer runs a bunch of threads that constantly switch
> between DEADLINE and NORMAL classes while interacting through futexes.
> 
> The splat above is caused by the fact that if a DEADLINE task is
> setattr back to NORMAL while in non_contending state (blocked on a
> futex - inactive timer armed), its contribution to running_bw is not
> removed before sub_rq_bw() gets called (!task_on_rq_queued() branch)
> and the latter sees running_bw > this_bw.
> 
> Fix it by removing a task contribution from running_bw if the task is
> not queued and in non_contending state while switched to a different
> class.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/deadline.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Luca Abeni <luca.abeni@santannapisa.it>

And, thanks for taking care of this issue!


			Thanks,
				Luca


> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fbfc3f1d368a..10c7b51c0d1f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2290,8 +2290,17 @@ static void switched_from_dl(struct rq *rq,
> struct task_struct *p) if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(p);
>  
> -	if (!task_on_rq_queued(p))
> +	if (!task_on_rq_queued(p)) {
> +		/*
> +		 * Inactive timer is armed. However, p is leaving
> DEADLINE and
> +		 * might migrate away from this rq while continuing
> to run on
> +		 * some other class. We need to remove its
> contribution from
> +		 * this rq running_bw now, or sub_rq_bw (below) will
> complain.
> +		 */
> +		if (p->dl.dl_non_contending)
> +			sub_running_bw(&p->dl, &rq->dl);
>  		sub_rq_bw(&p->dl, &rq->dl);
> +	}
>  
>  	/*
>  	 * We cannot use inactive_task_timer() to invoke
> sub_running_bw()

