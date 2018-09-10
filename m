Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97265C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8A220855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mjKkxC/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8A220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbeIJSuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:50:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIJSuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EUbYCfEDCsJGsk9vZGqMRilQSFrjcI3at2vjd9xn8mM=; b=mjKkxC/APFY0vVUMBI2NZdmdW
        /xGnghsHWPPtiwEz2hxoCZIQP/gnsUtG/FtwvYsACPhQUJ+lSgLNNA17DYxEMCsnW4fIXCJ+7QZEu
        X53vic0H6XaWCEV53HisdDkMgmylymWa3+IZ+kqMxMeXr4fTXWpy6V/JlivJ0UGkZBjXjZL+mm6nP
        NVDcDS0QtXKBSPZF0Zw+8zSa2DdrLm9P8b98cm3VDSe784lYASQVT4ZvIRZJ73fHoX/16ZkQH62cn
        hAaxc5Fj5oQR+up7u1weGGpzL/U0qqmkcKlkjU2kALAe4EsBrYF6Ed7VKHYI5O69/IfZrMqK8QIrW
        RAZc230XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzMg2-0000MD-QP; Mon, 10 Sep 2018 13:56:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3C25202C1A02; Mon, 10 Sep 2018 15:56:27 +0200 (CEST)
Date:   Mon, 10 Sep 2018 15:56:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH V2] kernel: locking: rtmutex: Fix a possible
 sleep-in-atomic-context bug in rt_mutex_handle_deadlock()
Message-ID: <20180910135627.GL24106@hirez.programming.kicks-ass.net>
References: <20180811030037.14885-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180811030037.14885-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 11:00:37AM +0800, Jia-Ju Bai wrote:

You forgot to Cc the person who wrote this code...

>  kernel/locking/rtmutex.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 2823d4163a37..8f25a289abe8 100644
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
> @@ -1218,6 +1218,8 @@ static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
>  	 * Yell lowdly and stop the task right here.
>  	 */
>  	rt_mutex_print_deadlock(w);
> +	/* We're not going anywhere, release the wait_lock */
> +	raw_spin_unlock_irq(&lock->wait_lock);
>  	while (1) {
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		schedule();
> @@ -1269,7 +1271,7 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
>  	if (unlikely(ret)) {
>  		__set_current_state(TASK_RUNNING);
>  		remove_waiter(lock, &waiter);
> -		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
> +		rt_mutex_handle_deadlock(ret, chwalk, &waiter, lock);
>  	}

The patch is correct; but I can't find myself liking it very much. This
dinly little single use function is growing a lot of arguments.

The alternative is something like the below; not sure myself though.
Thomas?


diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 2823d4163a37..a44d4034e232 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1204,18 +1204,10 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	return ret;
 }
 
-static void rt_mutex_handle_deadlock(int res, int detect_deadlock,
-				     struct rt_mutex_waiter *w)
+static void rt_mutex_handle_deadlock(struct rt_mutex_waiter *w)
 {
 	/*
-	 * If the result is not -EDEADLOCK or the caller requested
-	 * deadlock detection, nothing to do here.
-	 */
-	if (res != -EDEADLOCK || detect_deadlock)
-		return;
-
-	/*
-	 * Yell lowdly and stop the task right here.
+	 * Yell loudly and stop the task right here.
 	 */
 	rt_mutex_print_deadlock(w);
 	while (1) {
@@ -1269,7 +1261,10 @@ rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	if (unlikely(ret)) {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		if (chwalk == RT_MUTEX_MIN_CHAINWALK && ret == -EDEADLOCK) {
+			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+			rt_mutex_handle_deadlock(&waiter);
+		}
 	}
 
 	/*
