Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1C7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1E2206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfAIQlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfAIQkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2528AF58;
        Wed,  9 Jan 2019 16:40:39 +0000 (UTC)
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
Subject: [RFC PATCH 08/15] epoll: some sanity flags checks for epoll syscalls for polled epfd from userspace
Date:   Wed,  9 Jan 2019 17:40:18 +0100
Message-Id: <20190109164025.24554-9-rpenyaev@suse.de>
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

There are various of limitations if epfd is polled by user:

 1. Expect always EPOLLET flag (Edge Triggered behavior)

 2. No support for EPOLLWAKEUP
       events are consumed from userspace, thus no way to call __pm_relax()

 3. No support for EPOLLEXCLUSIVE
       If device does not pass pollflags to wake_up() there is no way to
       call poll() from the context under spinlock, thus special work is
       scheduled to offload polling.  In this specific case we can't
       support exclusive wakeups, because we do not know actual result
       of scheduled work.

 4. No support for nesting of epoll descriptors polled from userspace:
       no real good reason to scan ready events of user ring from the
       kernel, so just do not do that.

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
 fs/eventpoll.c | 78 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 637b463587c1..bdaec59a847e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -607,13 +607,17 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 #ifdef CONFIG_PM_SLEEP
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+static inline void ep_take_care_of_epollwakeup(struct eventpoll *ep,
+					       struct epoll_event *epev)
 {
-	if ((epev->events & EPOLLWAKEUP) && !capable(CAP_BLOCK_SUSPEND))
-		epev->events &= ~EPOLLWAKEUP;
+	if (epev->events & EPOLLWAKEUP) {
+		if (!capable(CAP_BLOCK_SUSPEND) || ep_polled_by_user(ep))
+			epev->events &= ~EPOLLWAKEUP;
+	}
 }
 #else
-static inline void ep_take_care_of_epollwakeup(struct epoll_event *epev)
+static inline void ep_take_care_of_epollwakeup(struct eventpoll *ep,
+					       struct epoll_event *epev)
 {
 	epev->events &= ~EPOLLWAKEUP;
 }
@@ -1054,6 +1058,7 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 		return vfs_poll(epi->ffd.file, pt) & epi->event.events;
 
 	ep = epi->ffd.file->private_data;
+	WARN_ON(ep_polled_by_user(ep));
 	poll_wait(epi->ffd.file, &ep->poll_wait, pt);
 	locked = pt && (pt->_qproc == ep_ptable_queue_proc);
 
@@ -1094,6 +1099,13 @@ static __poll_t ep_eventpoll_poll(struct file *file, poll_table *wait)
 	struct eventpoll *ep = file->private_data;
 	int depth = 0;
 
+	if (ep_polled_by_user(ep))
+		/*
+		 * We do not support polling of descriptor which is polled
+		 * by user.
+		 */
+		return 0;
+
 	/* Insert inside our poll wait queue */
 	poll_wait(file, &ep->poll_wait, wait);
 
@@ -2324,10 +2336,6 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	if (!file_can_poll(tf.file))
 		goto error_tgt_fput;
 
-	/* Check if EPOLLWAKEUP is allowed */
-	if (ep_op_has_event(op))
-		ep_take_care_of_epollwakeup(&epds);
-
 	/*
 	 * We have to check that the file structure underneath the file descriptor
 	 * the user passed to us _is_ an eventpoll file. And also we do not permit
@@ -2337,10 +2345,25 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	if (f.file == tf.file || !is_file_epoll(f.file))
 		goto error_tgt_fput;
 
+	/*
+	 * Do not support scanning of ready events of epoll, which is pollable
+	 * by userspace.
+	 */
+	if (is_file_epoll(tf.file) && ep_polled_by_user(tf.file->private_data))
+		goto error_tgt_fput;
+
+	/*
+	 * At this point it is safe to assume that the "private_data" contains
+	 * our own data structure.
+	 */
+	ep = f.file->private_data;
+
 	/*
 	 * epoll adds to the wakeup queue at EPOLL_CTL_ADD time only,
 	 * so EPOLLEXCLUSIVE is not allowed for a EPOLL_CTL_MOD operation.
-	 * Also, we do not currently supported nested exclusive wakeups.
+	 * Also, we do not currently supported nested exclusive wakeups
+	 * and EPOLLEXCLUSIVE is not supported for epoll which is polled
+	 * from userspace.
 	 */
 	if (ep_op_has_event(op) && (epds.events & EPOLLEXCLUSIVE)) {
 		if (op == EPOLL_CTL_MOD)
@@ -2348,13 +2371,18 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 		if (op == EPOLL_CTL_ADD && (is_file_epoll(tf.file) ||
 				(epds.events & ~EPOLLEXCLUSIVE_OK_BITS)))
 			goto error_tgt_fput;
+		if (ep_polled_by_user(ep))
+			goto error_tgt_fput;
 	}
 
-	/*
-	 * At this point it is safe to assume that the "private_data" contains
-	 * our own data structure.
-	 */
-	ep = f.file->private_data;
+	if (ep_op_has_event(op)) {
+		if (ep_polled_by_user(ep) && !(epds.events & EPOLLET))
+			/* Polled by user has only edge triggered behaviour */
+			goto error_tgt_fput;
+
+		/* Check if EPOLLWAKEUP is allowed */
+		ep_take_care_of_epollwakeup(ep, &epds);
+	}
 
 	/*
 	 * When we insert an epoll file descriptor, inside another epoll file
@@ -2456,14 +2484,6 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	struct fd f;
 	struct eventpoll *ep;
 
-	/* The maximum number of event must be greater than zero */
-	if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
-		return -EINVAL;
-
-	/* Verify that the area passed by the user is writeable */
-	if (!access_ok(events, maxevents * sizeof(struct epoll_event)))
-		return -EFAULT;
-
 	/* Get the "struct file *" for the eventpoll file */
 	f = fdget(epfd);
 	if (!f.file)
@@ -2482,6 +2502,20 @@ static int do_epoll_wait(int epfd, struct epoll_event __user *events,
 	 * our own data structure.
 	 */
 	ep = f.file->private_data;
+	if (!ep_polled_by_user(ep)) {
+		/* The maximum number of event must be greater than zero */
+		if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
+			goto error_fput;
+
+		/* Verify that the area passed by the user is writeable */
+		error = -EFAULT;
+		if (!access_ok(events, maxevents * sizeof(struct epoll_event)))
+			goto error_fput;
+	} else {
+		/* Use ring instead */
+		if (maxevents != 0 || events != NULL)
+			goto error_fput;
+	}
 
 	/* Time to fish for events ... */
 	error = ep_poll(ep, events, maxevents, timeout);
-- 
2.19.1

