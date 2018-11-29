Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CBEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA883205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2ynVYbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA883205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeK3ASA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:18:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeK3ASA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JEc+GIgSUtGecaROh0XVEPfKdrqL0WXrBuHmpiPjJHU=; b=L2ynVYbme3Oft90uUbYqCqjTr
        QBj6OWXYG+ufwBiQflqXf4ncSsxanEdK3eXct0+f9l3j/FS3UIdSUUS881/vcw0t3+FtjeZDA8Z3j
        Nw/9bKynZlas7OYUMfG2uLiMd0cYNMowdk7SyK8tlTarbc7IrqirysnM2I2qnCNRDtvOe3dyGvdi2
        cfBtyvgB/IZyUpaZkHSXyCdQEkK9+cp0vpI0T6v66Ys4f2sjGsjP6Mla3LT18AFCjUqixMvIaMJtO
        dauCF1d7IXqN4tTOvVxIQ36Gt33lHEUxucKL+l4432rEql+cJeDHGT1iYDKNUqaz3OYcBffJiKKXg
        UQZO/HXZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSM7O-0007jy-Rk; Thu, 29 Nov 2018 13:12:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 816DF2029F87F; Thu, 29 Nov 2018 14:12:32 +0100 (CET)
Date:   Thu, 29 Nov 2018 14:12:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yongji Xie <elohimes@gmail.com>
Cc:     mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, xieyongji@baidu.com,
        zhangyu31@baidu.com, liuqi16@baidu.com, yuanlinsi01@baidu.com,
        nixun@baidu.com, lilin24@baidu.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129131232.GN2131@hirez.programming.kicks-ass.net>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+Cc davidlohr and waiman

On Thu, Nov 29, 2018 at 08:50:30PM +0800, Yongji Xie wrote:
> From: Xie Yongji <xieyongji@baidu.com>
> 
> Our system encountered a problem recently, the khungtaskd detected
> some process hang on mmap_sem. But the odd thing was that one task which
> is not on mmap_sem.wait_list still sleeps in rwsem_down_read_failed().
> Through code inspection, we found a potential bug can lead to this.
> 
> Imaging this:
> 
> Thread 1                                  Thread 2
>                                           down_write();
> rwsem_down_read_failed()
>  raw_spin_lock_irq(&sem->wait_lock);
>  list_add_tail(&waiter.list, &wait_list);
>  raw_spin_unlock_irq(&sem->wait_lock);
>                                           __up_write();
>                                            rwsem_wake();
>                                             __rwsem_mark_wake();
>                                              wake_q_add();
>                                              list_del(&waiter->list);
>                                              waiter->task = NULL;
>  while (true) {
>   set_current_state(TASK_UNINTERRUPTIBLE);
>   if (!waiter.task) // true
>       break;
>  }
>  __set_current_state(TASK_RUNNING);
> 
> Now Thread 1 is queued in Thread 2's wake_q without sleeping. Then
> Thread 1 call rwsem_down_read_failed() again because Thread 3
> hold the lock, if Thread 3 tries to queue Thread 1 before Thread 2
> do wakeup, it will fail and miss wakeup:
> 
> Thread 1                                  Thread 2      Thread 3
>                                                         down_write();
> rwsem_down_read_failed()
>  raw_spin_lock_irq(&sem->wait_lock);
>  list_add_tail(&waiter.list, &wait_list);
>  raw_spin_unlock_irq(&sem->wait_lock);
>                                                         __rwsem_mark_wake();
>                                                          wake_q_add();
>                                           wake_up_q();
>                                                          waiter->task = NULL;
>  while (true) {
>   set_current_state(TASK_UNINTERRUPTIBLE);
>   if (!waiter.task) // false
>       break;
>   schedule();
>  }
>                                                         wake_up_q(&wake_q);
> 
> In another word, that means we might issue the wakeup before setting the reader
> waiter to nil. If so, the wakeup may do nothing when it was called before reader
> set task state to TASK_UNINTERRUPTIBLE. Then we would have no chance to wake up
> the reader any more, and cause other writers such as "ps" command stuck on it.
> 
> This patch is not verified because we still have no way to reproduce the problem.
> But I'd like to ask for some comments from community firstly.

Urgh; so the case where the cmpxchg() fails because it already has a
wakeup in progress, which then 'violates' our expectation of when the
wakeup happens.

Yes, I think this is real, and worse, I think we need to go audit all
wake_q_add() users and document this behaviour.

In the ideal case we'd delay the actual wakeup to the last wake_up_q(),
but I don't think we can easily fix that.

> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> ---
>  kernel/locking/rwsem-xadd.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index 09b1800..50d9af6 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -198,15 +198,22 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
>  		woken++;
>  		tsk = waiter->task;
>  
> -		wake_q_add(wake_q, tsk);
> +		get_task_struct(tsk);
>  		list_del(&waiter->list);
>  		/*
> -		 * Ensure that the last operation is setting the reader
> +		 * Ensure calling get_task_struct() before setting the reader
>  		 * waiter to nil such that rwsem_down_read_failed() cannot
>  		 * race with do_exit() by always holding a reference count
>  		 * to the task to wakeup.
>  		 */
>  		smp_store_release(&waiter->task, NULL);
> +		/*
> +		 * Ensure issuing the wakeup (either by us or someone else)
> +		 * after setting the reader waiter to nil.
> +		 */
> +		wake_q_add(wake_q, tsk);
> +		/* wake_q_add() already take the task ref */
> +		put_task_struct(tsk);
>  	}
>  
>  	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
> -- 
> 2.2.3
> 
