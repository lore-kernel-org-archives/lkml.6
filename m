Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B083C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40ECF223FF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 02:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ECF223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeHKFRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 01:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbeHKFRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 01:17:30 -0400
Received: from home.goodmis.org (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3C7223FF;
        Sat, 11 Aug 2018 02:44:58 +0000 (UTC)
Date:   Fri, 10 Aug 2018 22:44:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: locking: rtmutex: Fix a possible
 sleep-in-atomic-context bug in rt_mutex_handle_deadlock()
Message-ID: <20180811024456.ykccnkbdrac4nbem@home.goodmis.org>
References: <20180811023524.13845-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811023524.13845-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 10:35:24AM +0800, Jia-Ju Bai wrote:
> The driver may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] schedule
> kernel/locking/rtmutex.c, 1223: 
> 	schedule in rt_mutex_handle_deadlock
> kernel/locking/rtmutex.c, 1273: 
> 	rt_mutex_handle_deadlock in rt_mutex_slowlock
> kernel/locking/rtmutex.c, 1249: 
> 	_raw_spin_lock_irqsave in rt_mutex_slowlock
> 
> To fix the bug, the spinlock is released before schedule() and then acquired again.
> This is found by my static analysis tool (DSAC).
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  kernel/locking/rtmutex.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 2823d4163a37..af03e162f812 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1205,7 +1205,7 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
>  }
>  
>  static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
> -				     struct rt_mutex_waiter *w)
> +				     struct rt_mutex_waiter *w, struct rt_mutex *lock)
>  {
>  	/*
>  	 * If the result is not -EDEADLOCK or the caller requested
> @@ -1219,8 +1219,10 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
>  	 */
>  	rt_mutex_print_deadlock(w);
>  	while (1) {
> +		raw_spin_unlock_irq(&lock->wait_lock);
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		schedule();
> +		raw_spin_lock_irq(&lock->wait_lock);
>  	}

If you look at the code you will notice that it stops the task and never lets
it continue. Ever.

If we hit this path, it means we are in a deadlock scenario and will not make
any forward progress.

If anything, it should simply be:

	rt_mutex_print_deadlock(w);
+	/* We're not going anywhere, release the wait_lock */
+	raw_spin_unlock_irq(&lock->wait_lock);
	while (1) {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule();
	}

-- Steve


>  }
>  
> @@ -1269,7 +1271,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
>  	if (unlikely(ret)) {
>  		__set_current_state(TASK_RUNNING);
>  		remove_waiter(lock, &waiter);
> -		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
> +		rt_mutex_handle_deadlock(ret, chwalk, &waiter, lock);
>  	}
>  
>  	/*
> -- 
> 2.17.0
