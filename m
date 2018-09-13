Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C0C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE1520854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE1520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeIMSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbeIMSEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 045FA81DE3;
        Thu, 13 Sep 2018 12:55:32 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE004600C6;
        Thu, 13 Sep 2018 12:55:29 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 17/48] perf tools: Convert dead thread list into rbtree
Date:   Thu, 13 Sep 2018 14:54:19 +0200
Message-Id: <20180913125450.21342-18-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 13 Sep 2018 12:55:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf maintains dead threads in a linked list but this can be
a problem if someone needs to search from it especially in a large
session which might have many dead threads.  Convert it to a rbtree
like normal threads and it'll be used later with multi-thread changes.

The list node is now used for chaining dead threads of same tid since
it's easier to handle such threads in time order.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-86w2k0bjyi98p0kvyb6frcu5@git.kernel.org
Original-patch-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/intel-pt.c |  2 +-
 tools/perf/util/machine.c  | 82 ++++++++++++++++++++++++++++++++++----
 tools/perf/util/machine.h  | 10 ++---
 tools/perf/util/thread.c   | 12 +++++-
 tools/perf/util/thread.h   |  6 +--
 5 files changed, 93 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index aec68908d604..8c3537f980ed 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -2517,7 +2517,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	 * current thread lifetime assuption is kept and we don't segfault
 	 * at list_del_init().
 	 */
-	INIT_LIST_HEAD(&pt->unknown_thread->node);
+	INIT_LIST_HEAD(&pt->unknown_thread->tid_list);
 
 	err = thread__set_comm(pt->unknown_thread, "unknown", 0);
 	if (err)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c4acd2001db0..c36c27429866 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -41,10 +41,11 @@ static void machine__threads_init(struct machine *machine)
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
+
 		threads->entries = RB_ROOT;
+		threads->dead    = RB_ROOT;
 		init_rwsem(&threads->lock);
 		threads->nr = 0;
-		INIT_LIST_HEAD(&threads->dead);
 		threads->last_match = NULL;
 	}
 }
@@ -171,6 +172,28 @@ static void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
+static void threads__delete_dead(struct threads *threads)
+{
+	struct rb_node *nd = rb_first(&threads->dead);
+
+	while (nd) {
+		struct thread *t = rb_entry(nd, struct thread, rb_node);
+		struct thread *pos;
+
+		nd = rb_next(nd);
+		rb_erase_init(&t->rb_node, &threads->dead);
+
+		while (!list_empty(&t->tid_list)) {
+			pos = list_first_entry(&t->tid_list,
+					       struct thread, tid_list);
+			list_del_init(&pos->tid_list);
+			thread__delete(pos);
+		}
+
+		thread__delete(t);
+	}
+}
+
 void machine__delete_threads(struct machine *machine)
 {
 	struct rb_node *nd;
@@ -178,6 +201,7 @@ void machine__delete_threads(struct machine *machine)
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
+
 		down_write(&threads->lock);
 		nd = rb_first(&threads->entries);
 		while (nd) {
@@ -186,6 +210,9 @@ void machine__delete_threads(struct machine *machine)
 			nd = rb_next(nd);
 			__machine__remove_thread(machine, t, false);
 		}
+
+		threads__delete_dead(threads);
+
 		up_write(&threads->lock);
 	}
 }
@@ -1673,6 +1700,8 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock)
 {
 	struct threads *threads = machine__threads(machine, th->tid);
+	struct rb_node **p, *parent;
+	struct thread *pos;
 
 	if (threads->last_match == th)
 		threads__set_last_match(threads, NULL);
@@ -1684,14 +1713,44 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	RB_CLEAR_NODE(&th->rb_node);
 	--threads->nr;
 	/*
-	 * Move it first to the dead_threads list, then drop the reference,
-	 * if this is the last reference, then the thread__delete destructor
-	 * will be called and we will remove it from the dead_threads list.
+	 * No need to have an additional reference for non-index file
+	 * as they can be released when reference holders died and
+	 * there will be no more new references.
+	 */
+	if (!perf_has_index) {
+		thread__put(th);
+		goto out;
+	}
+
+	p = &threads->dead.rb_node;
+	parent = NULL;
+
+	/*
+	 * For indexed file, We may have references to this (dead)
+	 * thread, as samples are processed after fork/exit events.
+	 * Just move them to a separate rbtree and keep a reference.
 	 */
-	list_add_tail(&th->node, &threads->dead);
+	while (*p != NULL) {
+		parent = *p;
+		pos = rb_entry(parent, struct thread, rb_node);
+
+		if (pos->tid == th->tid) {
+			list_add_tail(&th->tid_list, &pos->tid_list);
+			goto out;
+		}
+
+		if (th->tid < pos->tid)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	rb_link_node(&th->rb_node, parent, p);
+	rb_insert_color(&th->rb_node, &threads->dead);
+
+out:
 	if (lock)
 		up_write(&threads->lock);
-	thread__put(th);
 }
 
 void machine__remove_thread(struct machine *machine, struct thread *th)
@@ -2395,7 +2454,7 @@ int machine__for_each_thread(struct machine *machine,
 {
 	struct threads *threads;
 	struct rb_node *nd;
-	struct thread *thread;
+	struct thread *thread, *pos;
 	int rc = 0;
 	int i;
 
@@ -2408,10 +2467,17 @@ int machine__for_each_thread(struct machine *machine,
 				return rc;
 		}
 
-		list_for_each_entry(thread, &threads->dead, node) {
+		for (nd = rb_first(&threads->dead); nd; nd = rb_next(nd)) {
+			thread = rb_entry(nd, struct thread, rb_node);
 			rc = fn(thread, priv);
 			if (rc != 0)
 				return rc;
+
+			list_for_each_entry(pos, &thread->tid_list, tid_list) {
+				rc = fn(pos, priv);
+				if (rc != 0)
+					return rc;
+			}
 		}
 	}
 	return rc;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..d91a3567d2cd 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -29,11 +29,11 @@ struct vdso_info;
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads {
-	struct rb_root	  entries;
-	struct rw_semaphore lock;
-	unsigned int	  nr;
-	struct list_head  dead;
-	struct thread	  *last_match;
+	struct rb_root		 entries;
+	struct rb_root		 dead;
+	struct rw_semaphore	 lock;
+	unsigned int		 nr;
+	struct thread		*last_match;
 };
 
 struct machine {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index a61683157760..47c03001d578 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -61,6 +61,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 
 		list_add(&comm->list, &thread->comm_list);
 		refcount_set(&thread->refcnt, 1);
+		INIT_LIST_HEAD(&thread->tid_list);
 		RB_CLEAR_NODE(&thread->rb_node);
 		/* Thread holds first ref to nsdata. */
 		thread->nsinfo = nsinfo__new(pid);
@@ -79,6 +80,7 @@ void thread__delete(struct thread *thread)
 	struct comm *comm, *tmp_comm;
 
 	BUG_ON(!RB_EMPTY_NODE(&thread->rb_node));
+	BUG_ON(!list_empty(&thread->tid_list));
 
 	thread_stack__free(thread);
 
@@ -123,7 +125,15 @@ void thread__put(struct thread *thread)
 		 * Remove it from the dead_threads list, as last reference
 		 * is gone.
 		 */
-		list_del_init(&thread->node);
+		if (!RB_EMPTY_NODE(&thread->rb_node)) {
+			struct machine *machine = thread->mg->machine;
+			struct threads *threads = machine__threads(machine, thread->tid);
+
+			rb_erase(&thread->rb_node, &threads->dead);
+			RB_CLEAR_NODE(&thread->rb_node);
+		}
+
+		list_del_init(&thread->tid_list);
 		thread__delete(thread);
 	}
 }
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 64eaa68bb112..d573f3715fec 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -16,10 +16,8 @@ struct thread_stack;
 struct unwind_libunwind_ops;
 
 struct thread {
-	union {
-		struct rb_node	 rb_node;
-		struct list_head node;
-	};
+	struct rb_node		rb_node;
+	struct list_head	tid_list;
 	struct map_groups	*mg;
 	pid_t			pid_; /* Not all tools update this */
 	pid_t			tid;
-- 
2.17.1

