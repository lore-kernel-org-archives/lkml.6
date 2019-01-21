Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87736C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4020861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfAUUPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:15:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:55558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbfAUUPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:15:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 404F1AE60;
        Mon, 21 Jan 2019 20:15:13 +0000 (UTC)
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
Subject: [RFC PATCH v2 03/13] epoll: allocate user header and user events ring for polling from userspace
Date:   Mon, 21 Jan 2019 21:14:46 +0100
Message-Id: <20190121201456.28338-4-rpenyaev@suse.de>
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

This one allocates user header and user events ring according to max items
number, passed as a parameter.  User events (index) ring is in a pow2.
Pages, which will be shared between kernel and userspace, are accounted
through user->locked_vm counter.

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
 fs/eventpoll.c                 | 130 +++++++++++++++++++++++++++++++--
 include/uapi/linux/eventpoll.h |   3 +-
 2 files changed, 125 insertions(+), 8 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f598442512f3..a73c077a552c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -231,6 +231,27 @@ struct eventpoll {
 
 	struct file *file;
 
+	/* User header with array of items */
+	struct epoll_uheader *user_header;
+
+	/* User index, which acts as a ring of coming events */
+	unsigned int *user_index;
+
+	/* Actual length of user header, always aligned on page */
+	unsigned int header_length;
+
+	/* Actual length of user index, always pow2 */
+	unsigned int index_length;
+
+	/* Maximum possible event items */
+	unsigned int max_items_nr;
+
+	/* Items bitmap, is used to get a free bit for new registered epi */
+	unsigned long *items_bm;
+
+	/* Length of both items bitmaps, always aligned on page */
+	unsigned int items_bm_length;
+
 	/* used to optimize loop detection check */
 	int visited;
 	struct list_head visited_list_link;
@@ -381,6 +402,27 @@ static void ep_nested_calls_init(struct nested_calls *ncalls)
 	spin_lock_init(&ncalls->lock);
 }
 
+static inline unsigned int ep_to_items_length(unsigned int nr)
+{
+	struct epoll_uheader *user_header;
+
+	return PAGE_ALIGN(struct_size(user_header, items, nr));
+}
+
+static inline unsigned int ep_to_index_length(unsigned int nr)
+{
+	struct eventpoll *ep;
+	unsigned int size;
+
+	size = roundup_pow_of_two(nr << ilog2(sizeof(*ep->user_index)));
+	return max_t(typeof(size), size, PAGE_SIZE);
+}
+
+static inline unsigned int ep_to_items_bm_length(unsigned int nr)
+{
+	return PAGE_ALIGN(ALIGN(nr, 8) >> 3);
+}
+
 /**
  * ep_events_available - Checks if ready events might be available.
  *
@@ -836,6 +878,38 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	return 0;
 }
 
+static int ep_account_mem(struct eventpoll *ep, struct user_struct *user)
+{
+	unsigned long nr_pages, page_limit, cur_pages, new_pages;
+
+	nr_pages  = ep->header_length >> PAGE_SHIFT;
+	nr_pages += ep->index_length >> PAGE_SHIFT;
+
+	/* Don't allow more pages than we can safely lock */
+	page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+	do {
+		cur_pages = atomic_long_read(&user->locked_vm);
+		new_pages = cur_pages + nr_pages;
+		if (new_pages > page_limit && !capable(CAP_IPC_LOCK))
+			return -ENOMEM;
+	} while (atomic_long_cmpxchg(&user->locked_vm, cur_pages,
+				     new_pages) != cur_pages);
+
+	return 0;
+}
+
+static void ep_unaccount_mem(struct eventpoll *ep, struct user_struct *user)
+{
+	unsigned long nr_pages;
+
+	nr_pages  = ep->header_length >> PAGE_SHIFT;
+	nr_pages += ep->index_length >> PAGE_SHIFT;
+	if (nr_pages)
+		/* When polled by user */
+		atomic_long_sub(nr_pages, &user->locked_vm);
+}
+
 static void ep_free(struct eventpoll *ep)
 {
 	struct rb_node *rbp;
@@ -883,8 +957,12 @@ static void ep_free(struct eventpoll *ep)
 
 	mutex_unlock(&epmutex);
 	mutex_destroy(&ep->mtx);
-	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
+	vfree(ep->user_header);
+	vfree(ep->user_index);
+	vfree(ep->items_bm);
+	ep_unaccount_mem(ep, ep->user);
+	free_uid(ep->user);
 	kfree(ep);
 }
 
@@ -1037,7 +1115,7 @@ void eventpoll_release_file(struct file *file)
 	mutex_unlock(&epmutex);
 }
 
-static int ep_alloc(struct eventpoll **pep)
+static int ep_alloc(struct eventpoll **pep, int flags, size_t max_items)
 {
 	int error;
 	struct user_struct *user;
@@ -1049,6 +1127,37 @@ static int ep_alloc(struct eventpoll **pep)
 	if (unlikely(!ep))
 		goto free_uid;
 
+	if (flags & EPOLL_USERPOLL) {
+		BUILD_BUG_ON(sizeof(*ep->user_header) !=
+			     EPOLL_USERPOLL_HEADER_SIZE);
+
+		if (!max_items || max_items > EP_USERPOLL_MAX_ITEMS_NR) {
+			error = -EINVAL;
+			goto free_ep;
+		}
+		ep->max_items_nr = max_items;
+		ep->header_length = ep_to_items_length(max_items);
+		ep->index_length = ep_to_index_length(max_items);
+		ep->items_bm_length = ep_to_items_bm_length(max_items);
+
+		error = ep_account_mem(ep, user);
+		if (error)
+			goto free_ep;
+
+		ep->user_header = vmalloc_user(ep->header_length);
+		ep->user_index = vmalloc_user(ep->index_length);
+		ep->items_bm = vzalloc(ep->items_bm_length);
+		if (!ep->user_header || !ep->user_index || !ep->items_bm)
+			goto unaccount_mem;
+
+		*ep->user_header = (typeof(*ep->user_header)) {
+			.magic         = EPOLL_USERPOLL_HEADER_MAGIC,
+			.header_length = ep->header_length,
+			.index_length  = ep->index_length,
+			.max_items_nr  = ep->max_items_nr,
+		};
+	}
+
 	mutex_init(&ep->mtx);
 	rwlock_init(&ep->lock);
 	init_waitqueue_head(&ep->wq);
@@ -1062,6 +1171,13 @@ static int ep_alloc(struct eventpoll **pep)
 
 	return 0;
 
+unaccount_mem:
+	ep_unaccount_mem(ep, user);
+free_ep:
+	vfree(ep->user_header);
+	vfree(ep->user_index);
+	vfree(ep->items_bm);
+	kfree(ep);
 free_uid:
 	free_uid(user);
 	return error;
@@ -2066,7 +2182,7 @@ static void clear_tfile_check_list(void)
 /*
  * Open an eventpoll file descriptor.
  */
-static int do_epoll_create(int flags)
+static int do_epoll_create(int flags, size_t size)
 {
 	int error, fd;
 	struct eventpoll *ep = NULL;
@@ -2075,12 +2191,12 @@ static int do_epoll_create(int flags)
 	/* Check the EPOLL_* constant for consistency.  */
 	BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
 
-	if (flags & ~EPOLL_CLOEXEC)
+	if (flags & ~(EPOLL_CLOEXEC | EPOLL_USERPOLL))
 		return -EINVAL;
 	/*
 	 * Create the internal data structure ("struct eventpoll").
 	 */
-	error = ep_alloc(&ep);
+	error = ep_alloc(&ep, flags, size);
 	if (error < 0)
 		return error;
 	/*
@@ -2111,7 +2227,7 @@ static int do_epoll_create(int flags)
 
 SYSCALL_DEFINE1(epoll_create1, int, flags)
 {
-	return do_epoll_create(flags);
+	return do_epoll_create(flags, 0);
 }
 
 SYSCALL_DEFINE1(epoll_create, int, size)
@@ -2119,7 +2235,7 @@ SYSCALL_DEFINE1(epoll_create, int, size)
 	if (size <= 0)
 		return -EINVAL;
 
-	return do_epoll_create(0);
+	return do_epoll_create(0, 0);
 }
 
 /*
diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
index 690a625ddeb2..fd06efe5d07e 100644
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

