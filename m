Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D27C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6792172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6792172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbeHNThn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732280AbeHNThn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:37:43 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B899C21728;
        Tue, 14 Aug 2018 16:49:46 +0000 (UTC)
Date:   Tue, 14 Aug 2018 12:49:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        peterz@infradead.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] Make call_srcu() available during very early boot
Message-ID: <20180814124945.5cf1753f@gandalf.local.home>
In-Reply-To: <20180814162448.GA20414@linux.vnet.ibm.com>
References: <20180814162448.GA20414@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 09:24:48 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Event tracing is moving to SRCU in order to take advantage of the fact
> that SRCU may be safely used from idle and even offline CPUs.  However,
> event tracing can invoke call_srcu() very early in the boot process,
> even before workqueue_init_early() is invoked (let alone rcu_init()).
> Therefore, call_srcu()'s attempts to queue work fail miserably.
> 
> This commit therefore detects this situation, and refrains from attempting
> to queue work before rcu_init() time, but does everything else that it
> would have done, and in addition, adds the srcu_struct to a global list.
> The rcu_init() function now invokes a new srcu_init() function, which
> is empty if CONFIG_SRCU=n.  Otherwise, srcu_init() queues work for
> each srcu_struct on the list.  This all happens early enough in boot
> that there is but a single CPU with interrupts disabled, which allows
> synchronization to be dispensed with.
> 
> Of course, the queued work won't actually be invoked until after
> workqueue_init() is invoked, which happens shortly after the scheduler
> is up and running.  This means that although call_srcu() may be invoked
> any time after per-CPU variables have been set up, there is still a very
> narrow window when synchronize_srcu() won't work, and this window
> extends from the time that the scheduler starts until the time that
> workqueue_init() returns.  This can be fixed in a manner similar to
> the fix for synchronize_rcu_expedited() and friends, but until someone
> actually needs to use synchronize_srcu() during this window, this fix
> is added churn for no benefit.
> 
> Finally, note that Tree SRCU's new srcu_init() function invokes
> queue_work() rather than the queue_delayed_work() function that is invoked
> post-boot.  The reason is that queue_delayed_work() will (as you would
> expect) post a timer, and timers have not yet been initialized.  So use
> of queue_delayed_work() avoids the complaints about use of uninitialized

You mean "So use of queue_work() avoids .." ?

> spinlocks that would otherwise result.  Besides, delay is in any case
> provide by the aforementioned fact that the queued work won't actually
> be invoked until after the scheduler is up and running.
> 
> Requested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> index f41d2fb09f87..2b5c0822e683 100644
> --- a/include/linux/srcutiny.h
> +++ b/include/linux/srcutiny.h
> @@ -36,6 +36,7 @@ struct srcu_struct {
>  	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
>  	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
>  	struct work_struct srcu_work;	/* For driving grace periods. */
> +	struct list_head srcu_boot_entry; /* Early-boot callbacks. */

I really don't like increasing the size of a structure for a field that
is hardly ever used.

Is there a way we could make a union, or reuse one of the other fields,
as we know that synchronize_srcu() can't be used yet (and if it is,
either warn, or just make it a nop). And when we call srcu_init() and
remove the srcu_struct from the list, we can then initialize whatever
we used as the temporary boot up list field.

srcu_init is called when we are still running only one CPU correct?

>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map dep_map;
>  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> @@ -48,6 +49,7 @@ void srcu_drive_gp(struct work_struct *wp);
>  	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
>  	.srcu_cb_tail = &name.srcu_cb_head,				\
>  	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
> +	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
>  	__SRCU_DEP_MAP_INIT(name)					\
>  }
>  
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index 745d4ca4dd50..86ad97111315 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -94,6 +94,7 @@ struct srcu_struct {
>  						/*  callback for the barrier */
>  						/*  operation. */
>  	struct delayed_work work;
> +	struct list_head srcu_boot_entry;	/* Early-boot callbacks. */
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map dep_map;
>  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> @@ -105,12 +106,13 @@ struct srcu_struct {
>  #define SRCU_STATE_SCAN2	2
>  
>  #define __SRCU_STRUCT_INIT(name, pcpu_name)				\
> -	{								\
> -		.sda = &pcpu_name,					\
> -		.lock = __SPIN_LOCK_UNLOCKED(name.lock),		\
> -		.srcu_gp_seq_needed = 0 - 1,				\
> -		__SRCU_DEP_MAP_INIT(name)				\
> -	}
> +{									\
> +	.sda = &pcpu_name,						\
> +	.lock = __SPIN_LOCK_UNLOCKED(name.lock),			\
> +	.srcu_gp_seq_needed = 0 - 1,					\

Interesting initialization of -1. This was there before, but still
interesting none the less.

> +	.srcu_boot_entry = LIST_HEAD_INIT(name.srcu_boot_entry),	\
> +	__SRCU_DEP_MAP_INIT(name)					\
> +}
>  
>

-- Steve
