Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626A6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1BF20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1BF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeIMSFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 279CA300208D;
        Thu, 13 Sep 2018 12:55:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FFA2600C8;
        Thu, 13 Sep 2018 12:55:38 +0000 (UTC)
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
Subject: [PATCH 21/48] perf tools: Maintain map groups list in a leader thread
Date:   Thu, 13 Sep 2018 14:54:23 +0200
Message-Id: <20180913125450.21342-22-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 13 Sep 2018 12:55:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

To support multi-threaded perf report, we need to maintain time-sorted
map groups.  Add ->mg_list member to struct thread and sort the list
by time.  Now leader threads have one more refcnt for map groups in
the list so also update the thread-mg-share test case.

Currently only add a new map groups when an exec (comm) event is
received.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-xj6w1y6nwhkatvo1dcd5t6sk@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/thread-mg-share.c |   7 +-
 tools/perf/util/event.c            |   2 +
 tools/perf/util/machine.c          |  15 +++-
 tools/perf/util/map.c              |   3 +
 tools/perf/util/map.h              |   2 +
 tools/perf/util/thread.c           | 117 ++++++++++++++++++++++++++++-
 tools/perf/util/thread.h           |   3 +
 7 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/thread-mg-share.c b/tools/perf/tests/thread-mg-share.c
index b1d1bbafe7ae..44a63d7961c8 100644
--- a/tools/perf/tests/thread-mg-share.c
+++ b/tools/perf/tests/thread-mg-share.c
@@ -24,6 +24,9 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	 * with several threads and checks they properly share and
 	 * maintain map groups info (struct map_groups).
 	 *
+	 * Note that a leader thread has one more refcnt for its
+	 * (current) map groups.
+	 *
 	 * thread group (pid: 0, tids: 0, 1, 2, 3)
 	 * other  group (pid: 4, tids: 4, 5)
 	*/
@@ -44,7 +47,7 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 			leader && t1 && t2 && t3 && other);
 
 	mg = leader->mg;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 4);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&mg->refcnt), 5);
 
 	/* test the map groups pointer is shared */
 	TEST_ASSERT_VAL("map groups don't match", mg == t1->mg);
@@ -72,7 +75,7 @@ int test__thread_mg_share(struct test *test __maybe_unused, int subtest __maybe_
 	machine__remove_thread(machine, other_leader);
 
 	other_mg = other->mg;
-	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 2);
+	TEST_ASSERT_EQUAL("wrong refcnt", refcount_read(&other_mg->refcnt), 3);
 
 	TEST_ASSERT_VAL("map groups don't match", other_mg == other_leader->mg);
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 8a19f751d095..29438cda8aa2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1534,6 +1534,8 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 		return NULL;
 	}
 
+	BUG_ON(mg == NULL);
+
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
 		mg = &machine->kmaps;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5ae2baba27ca..e2ebe471cdbc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -404,8 +404,19 @@ static void machine__update_thread_pid(struct machine *machine,
 	if (!leader)
 		goto out_err;
 
-	if (!leader->mg)
-		leader->mg = map_groups__new(machine);
+	if (!leader->mg) {
+		struct map_groups *mg = map_groups__new(machine);
+
+		if (mg == NULL) {
+			pr_err("Not enough memory for map groups\n");
+			return;
+		}
+
+		if (thread__set_map_groups(leader, mg, 0) < 0) {
+			map_groups__put(mg);
+			goto out_err;
+		}
+	}
 
 	if (!leader->mg)
 		goto out_err;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 3f07a587c8e6..6d6a0f65a9a0 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -504,6 +504,8 @@ void map_groups__init(struct map_groups *mg, struct machine *machine)
 	maps__init(&mg->maps);
 	mg->machine = machine;
 	refcount_set(&mg->refcnt, 1);
+	mg->timestamp = 0;
+	INIT_LIST_HEAD(&mg->list);
 }
 
 static void __maps__purge(struct maps *maps)
@@ -550,6 +552,7 @@ struct map_groups *map_groups__new(struct machine *machine)
 void map_groups__delete(struct map_groups *mg)
 {
 	map_groups__exit(mg);
+	list_del(&mg->list);
 	free(mg);
 }
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index e0f327b51e66..fb5f40fea2e3 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -64,6 +64,8 @@ struct map_groups {
 	struct maps	 maps;
 	struct machine	 *machine;
 	refcount_t	 refcnt;
+	u64		 timestamp;
+	struct list_head list;
 };
 
 struct map_groups *map_groups__new(struct machine *machine);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 109fa3bc23c4..fbda4b6d2ec5 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -16,12 +16,78 @@
 
 #include <api/fs/fs.h>
 
+struct map_groups *thread__get_map_groups(struct thread *thread, u64 timestamp)
+{
+	struct map_groups *mg;
+	struct thread *leader = thread;
+
+	BUG_ON(thread->mg == NULL);
+
+	if (thread->tid != thread->pid_) {
+		leader = machine__find_thread_by_time(thread->mg->machine,
+						      thread->pid_, thread->pid_,
+						      timestamp);
+		if (leader == NULL)
+			goto out;
+	}
+
+	list_for_each_entry(mg, &leader->mg_list, list)
+		if (timestamp >= mg->timestamp)
+			return mg;
+
+out:
+	return thread->mg;
+}
+
+int thread__set_map_groups(struct thread *thread, struct map_groups *mg,
+			   u64 timestamp)
+{
+	struct list_head *pos;
+	struct map_groups *old;
+
+	if (mg == NULL)
+		return -ENOMEM;
+
+	/*
+	 * Only a leader thread can have map groups list - others
+	 * reference it through map_groups__get.  This means the
+	 * leader thread will have one more refcnt than others.
+	 */
+	if (thread->tid != thread->pid_)
+		return -EINVAL;
+
+	if (thread->mg) {
+		BUG_ON(refcount_read(&thread->mg->refcnt) <= 1);
+		map_groups__put(thread->mg);
+	}
+
+	/* sort by time */
+	list_for_each(pos, &thread->mg_list) {
+		old = list_entry(pos, struct map_groups, list);
+		if (timestamp > old->timestamp)
+			break;
+	}
+
+	list_add_tail(&mg->list, pos);
+	mg->timestamp = timestamp;
+
+	/* set current ->mg to most recent one */
+	thread->mg = list_first_entry(&thread->mg_list, struct map_groups, list);
+	/* increase one more refcnt for current */
+	map_groups__get(thread->mg);
+
+	return 0;
+}
+
 int thread__init_map_groups(struct thread *thread, struct machine *machine)
 {
 	pid_t pid = thread->pid_;
 
 	if (pid == thread->tid || pid == -1) {
-		thread->mg = map_groups__new(machine);
+		struct map_groups *mg = map_groups__new(machine);
+
+		if (thread__set_map_groups(thread, mg, 0) < 0)
+			map_groups__put(mg);
 	} else {
 		struct thread *leader = __machine__findnew_thread(machine, pid, pid);
 		if (leader) {
@@ -48,6 +114,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		INIT_LIST_HEAD(&thread->comm_list);
 		init_rwsem(&thread->namespaces_lock);
 		init_rwsem(&thread->comm_lock);
+		INIT_LIST_HEAD(&thread->mg_list);
 
 		comm_str = malloc(32);
 		if (!comm_str)
@@ -77,7 +144,8 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 void thread__delete(struct thread *thread)
 {
 	struct namespaces *namespaces, *tmp_namespaces;
-	struct comm *comm, *tmp_comm;
+	struct comm *comm, *tmp;
+	struct map_groups *mg, *tmp_mg;
 
 	BUG_ON(!RB_EMPTY_NODE(&thread->rb_node));
 	BUG_ON(!list_empty(&thread->tid_list));
@@ -89,6 +157,7 @@ void thread__delete(struct thread *thread)
 		thread->mg = NULL;
 	}
 	down_write(&thread->namespaces_lock);
+
 	list_for_each_entry_safe(namespaces, tmp_namespaces,
 				 &thread->namespaces_list, list) {
 		list_del(&namespaces->list);
@@ -97,7 +166,12 @@ void thread__delete(struct thread *thread)
 	up_write(&thread->namespaces_lock);
 
 	down_write(&thread->comm_lock);
-	list_for_each_entry_safe(comm, tmp_comm, &thread->comm_list, list) {
+
+	/* only leader threads have mg list */
+	list_for_each_entry_safe(mg, tmp_mg, &thread->mg_list, list)
+		map_groups__put(mg);
+
+	list_for_each_entry_safe(comm, tmp, &thread->comm_list, list) {
 		list_del(&comm->list);
 		comm__free(comm);
 	}
@@ -217,6 +291,9 @@ struct comm *thread__comm_by_time(const struct thread *thread, u64 timestamp)
 	return list_last_entry(&thread->comm_list, struct comm, list);
 }
 
+static int thread__clone_map_groups(struct thread *thread,
+				    struct thread *parent);
+
 static int ____thread__set_comm(struct thread *thread, const char *str,
 				u64 timestamp, bool exec)
 {
@@ -247,6 +324,40 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 			unwind__flush_access(thread);
 	}
 
+	if (exec) {
+		struct machine *machine;
+
+		BUG_ON(thread->mg == NULL || thread->mg->machine == NULL);
+
+		machine = thread->mg->machine;
+
+		if (thread->tid != thread->pid_) {
+			struct map_groups *old = thread->mg;
+			struct thread *leader;
+
+			leader = machine__findnew_thread(machine, thread->pid_,
+							 thread->pid_);
+
+			/* now it'll be a new leader */
+			thread->pid_ = thread->tid;
+
+			thread->mg = map_groups__new(old->machine);
+			if (thread->mg == NULL)
+				return -ENOMEM;
+
+			/* save current mg in the new leader */
+			thread__clone_map_groups(thread, leader);
+
+			/* current mg of leader thread needs one more refcnt */
+			map_groups__get(thread->mg);
+
+			thread__set_map_groups(thread, thread->mg, old->timestamp);
+		}
+
+		/* create a new mg for newly executed binary */
+		thread__set_map_groups(thread, map_groups__new(machine), timestamp);
+	}
+
 	thread->comm_set = true;
 
 	return 0;
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8a1114c2f43a..e7eaf32a0cf1 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -19,6 +19,7 @@ struct thread {
 	struct rb_node		rb_node;
 	struct list_head	tid_list;
 	struct map_groups	*mg;
+	struct list_head	mg_list;
 	pid_t			pid_; /* Not all tools update this */
 	pid_t			tid;
 	pid_t			ppid;
@@ -89,6 +90,8 @@ struct comm *thread__comm_by_time(const struct thread *thread, u64 timestamp);
 const char *thread__comm_str(const struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
 const char *thread__comm_str_by_time(const struct thread *thread, u64 timestamp);
+struct map_groups *thread__get_map_groups(struct thread *thread, u64 timestamp);
+int thread__set_map_groups(struct thread *thread, struct map_groups *mg, u64 timestamp);
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
 
-- 
2.17.1

