Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B93C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB8D206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfAIQlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:57620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfAIQko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53F07B015;
        Wed,  9 Jan 2019 16:40:42 +0000 (UTC)
From:   Roman Penyaev <rpenyaev@suse.de>
Cc:     Roman Penyaev <rpenyaev@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/15] epoll: support polling from userspace for ep_poll()
Date:   Wed,  9 Jan 2019 17:40:24 +0100
Message-Id: <20190109164025.24554-15-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109164025.24554-1-rpenyaev@suse.de>
References: <20190109164025.24554-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When epfd is polled from userspace and user calls epoll_wait():

1. If user ring is not fully consumed (i.e. head != tail) returns
   -ESTALE, indicating that some actions on userside is required.

2. If events were routed to klists probably memory was expanded or
   shrink is still required.  Do shrink if needed and transfer all
   collected events from kernel lists to uring.

3. Ensure with WARN that ep_poll_send_events() can't be called from
   ep_poll() when epfd is pollable from userspace.

4. Wait for events on wait queue, always return -ESTALE if were
   awekened indicating that events have to be consumed from user ring.

Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/eventpoll.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2b38a3d884e8..5de640fcf28b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -523,7 +523,8 @@ static inline bool ep_user_ring_events_available(struct eventpoll *ep)
 static inline int ep_events_available(struct eventpoll *ep)
 {
 	return !list_empty_careful(&ep->rdllist) ||
-		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
+		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR ||
+		ep_user_ring_events_available(ep);
 }
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -2411,6 +2412,8 @@ static int ep_send_events(struct eventpoll *ep,
 {
 	struct ep_send_events_data esed;
 
+	WARN_ON(ep_polled_by_user(ep));
+
 	esed.maxevents = maxevents;
 	esed.events = events;
 
@@ -2607,6 +2610,24 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	lockdep_assert_irqs_enabled();
 
+	if (ep_polled_by_user(ep)) {
+		if (ep_user_ring_events_available(ep))
+			/* Firstly all events from ring have to be consumed */
+			return -ESTALE;
+
+		if (ep_events_routed_to_klists(ep)) {
+			res = ep_transfer_events_and_shrink_uring(ep);
+			if (unlikely(res < 0))
+				return res;
+			if (res)
+				/*
+				 * Events were transferred from klists to
+				 * user ring
+				 */
+				return -ESTALE;
+		}
+	}
+
 	if (timeout > 0) {
 		struct timespec64 end_time = ep_set_mstimeout(timeout);
 
@@ -2695,14 +2716,21 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	__set_current_state(TASK_RUNNING);
 
 send_events:
-	/*
-	 * Try to transfer events to user space. In case we get 0 events and
-	 * there's still timeout left over, we go trying again in search of
-	 * more luck.
-	 */
-	if (!res && eavail &&
-	    !(res = ep_send_events(ep, events, maxevents)) && !timed_out)
-		goto fetch_events;
+	if (!res && eavail) {
+		if (!ep_polled_by_user(ep)) {
+			/*
+			 * Try to transfer events to user space. In case we get
+			 * 0 events and there's still timeout left over, we go
+			 * trying again in search of more luck.
+			 */
+			res = ep_send_events(ep, events, maxevents);
+			if (!res && !timed_out)
+				goto fetch_events;
+		} else {
+			/* User has to deal with the ring himself */
+			res = -ESTALE;
+		}
+	}
 
 	if (waiter) {
 		spin_lock_irq(&ep->wq.lock);
-- 
2.19.1

