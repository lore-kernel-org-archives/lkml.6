Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD2C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9868920989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfAUUQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:16:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:55626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728272AbfAUUPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 511A7AFF9;
        Mon, 21 Jan 2019 20:15:15 +0000 (UTC)
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
Subject: [RFC PATCH v2 07/13] epoll: call ep_add_event_to_uring() from ep_poll_callback()
Date:   Mon, 21 Jan 2019 21:14:50 +0100
Message-Id: <20190121201456.28338-8-rpenyaev@suse.de>
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

Each ep_poll_callback() is called when fd calls wakeup() on epfd.
So account new event in user ring.

The tricky part here is EPOLLONESHOT.  Since we are lockless we
have to be deal with ep_poll_callbacks() called in parallel, thus
use cmpxchg to clear public event bits and filter out concurrent
call from another cpu.

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
 fs/eventpoll.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 26d837252ba4..1d0039b334b8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1406,6 +1406,29 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd,
 }
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 
+/**
+ * Atomically clear public event bits and return %true if the old value has
+ * public event bits set.
+ */
+static inline bool ep_clear_public_event_bits(struct epitem *epi)
+{
+	__poll_t old, flags;
+
+	/*
+	 * Here we race with ourselves and with ep_modify(), which can
+	 * change the event bits.  In order not to override events updated
+	 * by ep_modify() we have to do cmpxchg.
+	 */
+
+	old = epi->event.events;
+	do {
+		flags = old;
+	} while ((old = cmpxchg(&epi->event.events, flags,
+				flags & EP_PRIVATE_BITS)) != flags);
+
+	return flags & ~EP_PRIVATE_BITS;
+}
+
 /**
  * Adds a new entry to the tail of the list in a lockless way, i.e.
  * multiple CPUs are allowed to call this function concurrently.
@@ -1525,6 +1548,20 @@ static int ep_poll_callback(struct epitem *epi, __poll_t pollflags)
 	if (pollflags && !(pollflags & epi->event.events))
 		goto out_unlock;
 
+	if (ep_polled_by_user(ep)) {
+		/*
+		 * For polled descriptor from user we have to disable events on
+		 * callback path in case of one-shot.
+		 */
+		if ((epi->event.events & EPOLLONESHOT) &&
+		    !ep_clear_public_event_bits(epi))
+			/* Race is lost, another callback has cleared events */
+			goto out_unlock;
+
+		ep_add_event_to_uring(epi, pollflags);
+		goto wakeup;
+	}
+
 	/*
 	 * If we are transferring events to userspace, we can hold no locks
 	 * (because we're accessing user memory, and because of linux f_op->poll()
@@ -1544,6 +1581,7 @@ static int ep_poll_callback(struct epitem *epi, __poll_t pollflags)
 		ep_pm_stay_awake_rcu(epi);
 	}
 
+wakeup:
 	/*
 	 * Wake up ( if active ) both the eventpoll wait list and the ->poll()
 	 * wait list.
-- 
2.19.1

