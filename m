Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C79C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C91208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C91208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKOLKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:10:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:48722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbeKOLKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:10:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE687ACB5;
        Thu, 15 Nov 2018 01:04:21 +0000 (UTC)
Date:   Wed, 14 Nov 2018 17:04:15 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/2] fs/epoll: deal with wait_queue only once
Message-ID: <20181115010415.2hgkc6w35m6jvh4g@linux-r8p5>
References: <20181114182532.27981-1-dave@stgolabs.net>
 <20181114182532.27981-2-dave@stgolabs.net>
 <20181114145119.2e00ce7530d32fc4958c3707@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181114145119.2e00ce7530d32fc4958c3707@linux-foundation.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Andrew Morton wrote:

>Why was this moved to before the ep_reset_busy_poll_napi_id() call?
>That movement placed the code ahead of the block comment which serves
>to explain its function.

Yikes, that was a brain fart.

>
>
>This?  Which also fixes that comment and reflows it to use 80 cols.

Looks good, thanks.

>
>--- a/fs/eventpoll.c~fs-epoll-deal-with-wait_queue-only-once-fix
>+++ a/fs/eventpoll.c
>@@ -1787,15 +1787,6 @@ fetch_events:
> 	if (eavail)
> 		goto send_events;
>
>-	if (!waiter) {
>-		waiter = true;
>-		init_waitqueue_entry(&wait, current);
>-
>-		spin_lock_irq(&ep->wq.lock);
>-		__add_wait_queue_exclusive(&ep->wq, &wait);
>-		spin_unlock_irq(&ep->wq.lock);
>-	}
>-
> 	/*
> 	 * Busy poll timed out.  Drop NAPI ID for now, we can add
> 	 * it back in when we have moved a socket with a valid NAPI
>@@ -1804,10 +1795,18 @@ fetch_events:
> 	ep_reset_busy_poll_napi_id(ep);
>
> 	/*
>-	 * We don't have any available event to return to the caller.
>-	 * We need to sleep here, and we will be wake up by
>-	 * ep_poll_callback() when events will become available.
>+	 * We don't have any available event to return to the caller.  We need
>+	 * to sleep here, and we will be woken by ep_poll_callback() when events
>+	 * become available.
> 	 */
>+	if (!waiter) {
>+		waiter = true;
>+		init_waitqueue_entry(&wait, current);
>+
>+		spin_lock_irq(&ep->wq.lock);
>+		__add_wait_queue_exclusive(&ep->wq, &wait);
>+		spin_unlock_irq(&ep->wq.lock);
>+	}
>
> 	for (;;) {
> 		/*
>_
>
