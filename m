Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F548C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DCE223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DCE223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeKOEaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:30:11 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:59757 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOEaL (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 14 Nov 2018 23:30:11 -0500
Received: from localhost.localdomain (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Wed, 14 Nov 2018 11:25:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] fs/epoll: deal with wait_queue only once
Date:   Wed, 14 Nov 2018 10:25:32 -0800
Message-Id: <20181114182532.27981-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181114182532.27981-1-dave@stgolabs.net>
References: <20181114182532.27981-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why we rearm the waitiqueue upon every
fetch_events retry (for when events are found yet send_events()
fails). If nothing else, this saves four lock operations per
retry, and furthermore reduces the scope of the lock even
further.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/eventpoll.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7e2b5f3d6b3e..25b0c94cc091 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1749,6 +1749,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 {
 	int res = 0, eavail, timed_out = 0;
 	u64 slack = 0;
+	bool waiter = false;
 	wait_queue_entry_t wait;
 	ktime_t expires, *to = NULL;
 
@@ -1786,6 +1787,15 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	if (eavail)
 		goto send_events;
 
+	if (!waiter) {
+		waiter = true;
+		init_waitqueue_entry(&wait, current);
+
+		spin_lock_irq(&ep->wq.lock);
+		__add_wait_queue_exclusive(&ep->wq, &wait);
+		spin_unlock_irq(&ep->wq.lock);
+	}
+
 	/*
 	 * Busy poll timed out.  Drop NAPI ID for now, we can add
 	 * it back in when we have moved a socket with a valid NAPI
@@ -1798,10 +1808,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	 * We need to sleep here, and we will be wake up by
 	 * ep_poll_callback() when events will become available.
 	 */
-	init_waitqueue_entry(&wait, current);
-	spin_lock_irq(&ep->wq.lock);
-	__add_wait_queue_exclusive(&ep->wq, &wait);
-	spin_unlock_irq(&ep->wq.lock);
 
 	for (;;) {
 		/*
@@ -1836,10 +1842,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	__set_current_state(TASK_RUNNING);
 
-	spin_lock_irq(&ep->wq.lock);
-	__remove_wait_queue(&ep->wq, &wait);
-	spin_unlock_irq(&ep->wq.lock);
-
 send_events:
 	/*
 	 * Try to transfer events to user space. In case we get 0 events and
@@ -1850,6 +1852,12 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	    !(res = ep_send_events(ep, events, maxevents)) && !timed_out)
 		goto fetch_events;
 
+	if (waiter) {
+		spin_lock_irq(&ep->wq.lock);
+		__remove_wait_queue(&ep->wq, &wait);
+		spin_unlock_irq(&ep->wq.lock);
+	}
+
 	return res;
 }
 
-- 
2.16.4

