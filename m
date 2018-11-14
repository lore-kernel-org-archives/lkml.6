Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A558C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF1C2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF1C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeKOI4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:56:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45638 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeKOI4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:56:34 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B13EA5E;
        Wed, 14 Nov 2018 22:51:20 +0000 (UTC)
Date:   Wed, 14 Nov 2018 14:51:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] fs/epoll: deal with wait_queue only once
Message-Id: <20181114145119.2e00ce7530d32fc4958c3707@linux-foundation.org>
In-Reply-To: <20181114182532.27981-2-dave@stgolabs.net>
References: <20181114182532.27981-1-dave@stgolabs.net>
        <20181114182532.27981-2-dave@stgolabs.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 10:25:32 -0800 Davidlohr Bueso <dave@stgolabs.net> wrote:

> There is no reason why we rearm the waitiqueue upon every
> fetch_events retry (for when events are found yet send_events()
> fails). If nothing else, this saves four lock operations per
> retry, and furthermore reduces the scope of the lock even
> further.
> 
> ..
>
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1749,6 +1749,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  {
>  	int res = 0, eavail, timed_out = 0;
>  	u64 slack = 0;
> +	bool waiter = false;
>  	wait_queue_entry_t wait;
>  	ktime_t expires, *to = NULL;
>  
> @@ -1786,6 +1787,15 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  	if (eavail)
>  		goto send_events;
>  
> +	if (!waiter) {
> +		waiter = true;
> +		init_waitqueue_entry(&wait, current);
> +
> +		spin_lock_irq(&ep->wq.lock);
> +		__add_wait_queue_exclusive(&ep->wq, &wait);
> +		spin_unlock_irq(&ep->wq.lock);
> +	}
> +
>  	/*
>  	 * Busy poll timed out.  Drop NAPI ID for now, we can add
>  	 * it back in when we have moved a socket with a valid NAPI
> @@ -1798,10 +1808,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  	 * We need to sleep here, and we will be wake up by
>  	 * ep_poll_callback() when events will become available.
>  	 */
> -	init_waitqueue_entry(&wait, current);
> -	spin_lock_irq(&ep->wq.lock);
> -	__add_wait_queue_exclusive(&ep->wq, &wait);
> -	spin_unlock_irq(&ep->wq.lock);

Why was this moved to before the ep_reset_busy_poll_napi_id() call? 
That movement placed the code ahead of the block comment which serves
to explain its function.


This?  Which also fixes that comment and reflows it to use 80 cols.

--- a/fs/eventpoll.c~fs-epoll-deal-with-wait_queue-only-once-fix
+++ a/fs/eventpoll.c
@@ -1787,15 +1787,6 @@ fetch_events:
 	if (eavail)
 		goto send_events;
 
-	if (!waiter) {
-		waiter = true;
-		init_waitqueue_entry(&wait, current);
-
-		spin_lock_irq(&ep->wq.lock);
-		__add_wait_queue_exclusive(&ep->wq, &wait);
-		spin_unlock_irq(&ep->wq.lock);
-	}
-
 	/*
 	 * Busy poll timed out.  Drop NAPI ID for now, we can add
 	 * it back in when we have moved a socket with a valid NAPI
@@ -1804,10 +1795,18 @@ fetch_events:
 	ep_reset_busy_poll_napi_id(ep);
 
 	/*
-	 * We don't have any available event to return to the caller.
-	 * We need to sleep here, and we will be wake up by
-	 * ep_poll_callback() when events will become available.
+	 * We don't have any available event to return to the caller.  We need
+	 * to sleep here, and we will be woken by ep_poll_callback() when events
+	 * become available.
 	 */
+	if (!waiter) {
+		waiter = true;
+		init_waitqueue_entry(&wait, current);
+
+		spin_lock_irq(&ep->wq.lock);
+		__add_wait_queue_exclusive(&ep->wq, &wait);
+		spin_unlock_irq(&ep->wq.lock);
+	}
 
 	for (;;) {
 		/*
_

