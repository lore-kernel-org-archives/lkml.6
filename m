Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443AC37130
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E031A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfAUUPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:15:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:55672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbfAUUPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA8EFAFFD;
        Mon, 21 Jan 2019 20:15:16 +0000 (UTC)
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
Subject: [RFC PATCH v2 11/13] epoll: support polling from userspace for ep_poll()
Date:   Mon, 21 Jan 2019 21:14:54 +0100
Message-Id: <20190121201456.28338-12-rpenyaev@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121201456.28338-1-rpenyaev@suse.de>
References: <20190121201456.28338-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rule of thumb for epfd polled from userspace is simple: epfd has
events if ->head != ->tail, no traversing of each item is performed.

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
 fs/eventpoll.c | 68 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3c3721c315a7..e70d1ab64ec1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -440,6 +440,12 @@ static inline bool ep_polled_by_user(struct eventpoll *ep)
 	return !!ep->user_header;
 }
 
+static inline bool ep_uring_events_available(struct eventpoll *ep)
+{
+	return ep_polled_by_user(ep) &&
+		ep->user_header->head != ep->user_header->tail;
+}
+
 /**
  * ep_events_available - Checks if ready events might be available.
  *
@@ -451,7 +457,8 @@ static inline bool ep_polled_by_user(struct eventpoll *ep)
 static inline int ep_events_available(struct eventpoll *ep)
 {
 	return !list_empty_careful(&ep->rdllist) ||
-		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
+		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR ||
+		ep_uring_events_available(ep);
 }
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -1160,7 +1167,7 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 				 int depth)
 {
-	struct eventpoll *ep;
+	struct eventpoll *ep, *tep;
 	bool locked;
 
 	pt->_key = epi->event.events;
@@ -1169,6 +1176,26 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 
 	ep = epi->ffd.file->private_data;
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
+
+	tep = epi->ffd.file->private_data;
+	if (ep_polled_by_user(tep)) {
+		/*
+		 * The behaviour differs comparing to full scan of ready
+		 * list for original epoll.  If descriptor is pollable
+		 * from userspace we don't do scan of all ready user items:
+		 * firstly because we can't do reverse search of epi by
+		 * uitem bit, secondly this is simply waste of time for
+		 * edge triggered descriptors (user code should be prepared
+		 * to deal with EAGAIN returned from read() or write() on
+		 * inserted file descriptor) and thirdly once event is put
+		 * into user index ring do not touch it from kernel, what
+		 * we do is mark it as EPOLLREMOVED on ep_remove() and
+		 * that's it.
+		 */
+		return ep_uring_events_available(tep) ?
+			EPOLLIN | EPOLLRDNORM : 0;
+	}
+
 	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
 
 	return ep_scan_ready_list(epi->ffd.file->private_data,
@@ -1211,6 +1238,12 @@ static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 	/* Insert inside our poll wait queue */
 	poll_wait(file, &ep->poll_wait, wait);
 
+	if (ep_polled_by_user(ep)) {
+		/* Please read detailed comments inside ep_item_poll() */
+		return ep_uring_events_available(ep) ?
+			EPOLLIN | EPOLLRDNORM : 0;
+	}
+
 	/*
 	 * Proceed to find out if wanted events are really available inside
 	 * the ready list.
@@ -2232,6 +2265,8 @@ static int ep_send_events(struct eventpoll *ep,
 {
 	struct ep_send_events_data esed;
 
+	WARN_ON(ep_polled_by_user(ep));
+
 	esed.maxevents = maxevents;
 	esed.events = events;
 
@@ -2278,6 +2313,12 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 
 	lockdep_assert_irqs_enabled();
 
+	if (ep_polled_by_user(ep)) {
+		if (ep_uring_events_available(ep))
+			/* Firstly all events from ring have to be consumed */
+			return -ESTALE;
+	}
+
 	if (timeout > 0) {
 		struct timespec64 end_time = ep_set_mstimeout(timeout);
 
@@ -2366,14 +2407,21 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
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

