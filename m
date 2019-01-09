Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE17C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E67B206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfAIQlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:41:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:57600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbfAIQkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:40:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EEEDAFF4;
        Wed,  9 Jan 2019 16:40:38 +0000 (UTC)
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
Subject: [RFC PATCH 05/15] epoll: introduce user header structure and user index for polling from userspace
Date:   Wed,  9 Jan 2019 17:40:15 +0100
Message-Id: <20190109164025.24554-6-rpenyaev@suse.de>
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

This one introduces main user structures: user header and user index.
Header describes current state of epoll, head and tail of the index
ring, epoll items at the end of the structure.

Index table is a ring, which is controlled by head and tail from the
user header.  Ring consists of u32 indeces, pointing to items in header,
which have been ready for polling.

Userspace has to call epoll_create1(EPOLL_USERPOLL) in order to start
using polling from user side.

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
 fs/eventpoll.c                 | 107 ++++++++++++++++++++++++++++++++-
 include/uapi/linux/eventpoll.h |   3 +-
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2cc183e86a29..9ec682b6488f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -178,6 +178,42 @@ struct epitem {
 	struct epoll_event event;
 };
 
+#define EPOLL_USER_HEADER_SIZE  128
+#define EPOLL_USER_HEADER_MAGIC 0xeb01eb01
+
+enum {
+	EPOLL_USER_POLL_INACTIVE = 0, /* user poll disactivated */
+	EPOLL_USER_POLL_ACTIVE   = 1, /* user can continue busy polling */
+
+	/*
+	 * Always keep some slots ahead to be able to consume new events
+	 * from many threads, i.e. if N threads consume ring from userspace,
+	 * we have to keep N free slots ahead to avoid ring overlap.
+	 *
+	 * Probably this number should be reported to userspace in header.
+	 */
+	EPOLL_USER_EXTRA_INDEX_NR = 16 /* how many extra indeces keep in ring */
+};
+
+struct user_epitem {
+	unsigned int ready_events;
+	struct epoll_event event;
+};
+
+struct user_header {
+	unsigned int magic;          /* epoll user header magic */
+	unsigned int state;          /* epoll ring state */
+	unsigned int header_length;  /* length of the header + items */
+	unsigned int index_length;   /* length of the index ring */
+	unsigned int max_items_nr;   /* max num of items slots */
+	unsigned int max_index_nr;   /* max num of items indeces, always pow2 */
+	unsigned int head;           /* updated by userland */
+	unsigned int tail;           /* updated by kernel */
+	unsigned int padding[24];    /* Header size is 128 bytes */
+
+	struct user_epitem items[];
+};
+
 /*
  * This structure is stored inside the "private_data" member of the file
  * structure and represents the main data structure for the eventpoll
@@ -222,6 +258,36 @@ struct eventpoll {
 
 	struct file *file;
 
+	/* User header with array of items */
+	struct user_header *user_header;
+
+	/* User index, which acts as a ring of coming events */
+	unsigned int *user_index;
+
+	/* Actual length of user header, always aligned on page */
+	unsigned int header_length;
+
+	/* Actual length of user index, always aligned on page */
+	unsigned int index_length;
+
+	/* Number of event items */
+	unsigned int items_nr;
+
+	/* Items bitmap, is used to get a free bit for new registered epi */
+	unsigned long *items_bm;
+
+	/* Removed items bitmap, is used to postpone bit put */
+	unsigned long *removed_items_bm;
+
+	/* Length of both items bitmaps, always aligned on page */
+	unsigned int items_bm_length;
+
+	/*
+	 * Where events are routed: to kernel lists or to user ring.
+	 * Always false for epfd created without EPOLL_USERPOLL.
+	 */
+	bool events_to_uring;
+
 	/* used to optimize loop detection check */
 	int visited;
 	struct list_head visited_list_link;
@@ -876,6 +942,10 @@ static void ep_free(struct eventpoll *ep)
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
+	vfree(ep->user_header);
+	vfree(ep->user_index);
+	vfree(ep->items_bm);
+	vfree(ep->removed_items_bm);
 	kfree(ep);
 }
 
@@ -1028,7 +1098,7 @@ void eventpoll_release_file(struct file *file)
 	mutex_unlock(&epmutex);
 }
 
-static int ep_alloc(struct eventpoll **pep)
+static int ep_alloc(struct eventpoll **pep, int flags)
 {
 	int error;
 	struct user_struct *user;
@@ -1040,6 +1110,31 @@ static int ep_alloc(struct eventpoll **pep)
 	if (unlikely(!ep))
 		goto free_uid;
 
+	if (flags & EPOLL_USERPOLL) {
+		ep->user_header = vmalloc_user(PAGE_SIZE);
+		ep->user_index = vmalloc_user(PAGE_SIZE);
+		ep->items_bm = vzalloc(PAGE_SIZE);
+		ep->removed_items_bm = vzalloc(PAGE_SIZE);
+		ep->events_to_uring = true;
+		if (!ep->user_header || !ep->user_index)
+			goto free_ep;
+		if (!ep->items_bm || !ep->removed_items_bm)
+			goto free_ep;
+
+		ep->header_length   = PAGE_SIZE;
+		ep->index_length    = PAGE_SIZE;
+		ep->items_bm_length = PAGE_SIZE;
+
+		*ep->user_header = (typeof(*ep->user_header)) {
+			.magic         = EPOLL_USER_HEADER_MAGIC,
+			.state         = EPOLL_USER_POLL_ACTIVE,
+			.header_length = ep->header_length,
+			.index_length  = ep->index_length,
+			.max_items_nr  = ep_max_items_nr(ep),
+			.max_index_nr  = ep_max_index_nr(ep),
+		};
+	}
+
 	mutex_init(&ep->mtx);
 	rwlock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
@@ -1053,6 +1148,12 @@ static int ep_alloc(struct eventpoll **pep)
 
 	return 0;
 
+free_ep:
+	vfree(ep->user_header);
+	vfree(ep->user_index);
+	vfree(ep->items_bm);
+	vfree(ep->removed_items_bm);
+	kfree(ep);
 free_uid:
 	free_uid(user);
 	return error;
@@ -2066,12 +2167,12 @@ static int do_epoll_create(int flags)
 	/* Check the EPOLL_* constant for consistency.  */
 	BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
 
-	if (flags & ~EPOLL_CLOEXEC)
+	if (flags & ~(EPOLL_CLOEXEC | EPOLL_USERPOLL))
 		return -EINVAL;
 	/*
 	 * Create the internal data structure ("struct eventpoll").
 	 */
-	error = ep_alloc(&ep);
+	error = ep_alloc(&ep, flags);
 	if (error < 0)
 		return error;
 	/*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 39dfc29f0f52..b0a565f6c6c3 100644
--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -20,7 +20,8 @@
 #include <linux/types.h>
 
 /* Flags for epoll_create1.  */
-#define EPOLL_CLOEXEC O_CLOEXEC
+#define EPOLL_CLOEXEC  O_CLOEXEC
+#define EPOLL_USERPOLL 1
 
 /* Valid opcodes to issue to sys_epoll_ctl() */
 #define EPOLL_CTL_ADD 1
-- 
2.19.1

