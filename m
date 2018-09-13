Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA06C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBC120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBC120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeIMSE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61559 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbeIMSEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5347C997F4;
        Thu, 13 Sep 2018 12:55:34 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CC7F600C6;
        Thu, 13 Sep 2018 12:55:32 +0000 (UTC)
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
Subject: [PATCH 18/48] perf tools: Introduce machine__find*_thread_by_time()
Date:   Thu, 13 Sep 2018 14:54:20 +0200
Message-Id: <20180913125450.21342-19-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 13 Sep 2018 12:55:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

With data file indexing is enabled, it needs to search thread based on
sample time since sample processing is done after other (task, comm and
mmap) events are processed.  This can be a problem if a session is very
long and pid is recycled - in that case it'll only see the last one.

So keep thread start time in it, and search thread based on the time.
This patch introduces machine__find{,new}_thread_by_time() function
for this.  It'll first search current (i.e. recent) thread rbtree and
then dead thread tree (and tid list).  If it couldn't find anyone,
it'll create a new (missing) thread.

The sample timestamp of 0 means that this is called from synthesized
event so just use current rbtree.  The timestamp will be -1 if sample
didn't record the timestamp so will see current threads automatically.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-fxl42zknqoke9d9jix6fvu8w@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/dwarf-unwind.c |   4 +-
 tools/perf/tests/hists_common.c |   2 +-
 tools/perf/tests/hists_link.c   |   2 +-
 tools/perf/util/event.c         |   6 +-
 tools/perf/util/machine.c       | 128 +++++++++++++++++++++++++++++++-
 tools/perf/util/machine.h       |  10 ++-
 tools/perf/util/thread.c        |   5 ++
 tools/perf/util/thread.h        |   1 +
 8 files changed, 148 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 2f008067d989..e55a45c4da5b 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -92,12 +92,10 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 
 noinline int test_dwarf_unwind__thread(struct thread *thread)
 {
-	struct perf_sample sample;
+	struct perf_sample sample = { .time = -1ULL, };
 	unsigned long cnt = 0;
 	int err = -1;
 
-	memset(&sample, 0, sizeof(sample));
-
 	if (test__arch_unwind_sample(&sample, thread)) {
 		pr_debug("failed to get unwind sample\n");
 		goto out;
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index b889a28fd80b..7499ac340883 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -104,7 +104,7 @@ struct machine *setup_fake_machine(struct machines *machines)
 
 	for (i = 0; i < ARRAY_SIZE(fake_mmap_info); i++) {
 		struct perf_sample sample = {
-			.cpumode = PERF_RECORD_MISC_USER,
+			.cpumode = PERF_RECORD_MISC_USER, .time = -1ULL,
 		};
 		union perf_event fake_mmap_event = {
 			.mmap = {
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 9a9d06cb0222..3e07928da53c 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -67,7 +67,7 @@ static int add_hist_entries(struct perf_evlist *evlist, struct machine *machine)
 	struct perf_evsel *evsel;
 	struct addr_location al;
 	struct hist_entry *he;
-	struct perf_sample sample = { .period = 1, .weight = 1, };
+	struct perf_sample sample = { .period = 1, .weight = 1, .time = -1ULL, };
 	size_t i = 0, k;
 
 	/*
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..8a19f751d095 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -21,6 +21,7 @@
 #include "thread.h"
 #include "thread_map.h"
 #include "sane_ctype.h"
+#include "session.h"
 #include "symbol/kallsyms.h"
 #include "asm/bug.h"
 #include "stat.h"
@@ -1608,9 +1609,10 @@ struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
 int machine__resolve(struct machine *machine, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	struct thread *thread = machine__findnew_thread(machine, sample->pid,
-							sample->tid);
+	struct thread *thread;
 
+	thread = machine__findnew_thread_by_time(machine, sample->pid,
+						 sample->tid, sample->time);
 	if (thread == NULL)
 		return -1;
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c36c27429866..999f200f24e7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -578,6 +578,122 @@ struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 	return th;
 }
 
+static struct thread *
+__machine__findnew_thread_by_time(struct machine *machine, struct threads *threads,
+				  pid_t pid, pid_t tid, u64 timestamp, bool create)
+{
+	struct thread *curr, *pos, *new;
+	struct thread *th = NULL;
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+
+	if (!perf_has_index)
+		return ____machine__findnew_thread(machine, threads, pid, tid, create);
+
+	/* lookup current thread first */
+	curr = ____machine__findnew_thread(machine, threads, pid, tid, false);
+	if (curr && timestamp >= curr->start_time)
+		return curr;
+
+	/* and then check dead threads tree & list */
+	p = &threads->dead.rb_node;
+	while (*p != NULL) {
+		parent = *p;
+		th = rb_entry(parent, struct thread, rb_node);
+
+		if (th->tid == tid) {
+			list_for_each_entry(pos, &th->tid_list, tid_list) {
+				if (timestamp >= pos->start_time &&
+				    pos->start_time > th->start_time) {
+					th = pos;
+					break;
+				}
+			}
+
+			if (timestamp >= th->start_time) {
+				machine__update_thread_pid(machine, th, pid);
+				return th;
+			}
+			break;
+		}
+
+		if (tid < th->tid)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	if (!create)
+		return NULL;
+
+	if (!curr && !*p) {
+		/* found no thread.  create one as current thread */
+		return __machine__findnew_thread(machine, pid, tid);
+	}
+
+	new = thread__new(pid, tid);
+	if (new == NULL)
+		return NULL;
+
+	new->dead = true;
+	new->start_time = timestamp;
+
+	if (*p) {
+		list_for_each_entry(pos, &th->tid_list, tid_list) {
+			/* sort by time */
+			if (timestamp >= pos->start_time) {
+				th = pos;
+				break;
+			}
+		}
+		list_add_tail(&new->tid_list, &th->tid_list);
+	} else {
+		rb_link_node(&new->rb_node, parent, p);
+		rb_insert_color(&new->rb_node, &threads->dead);
+	}
+
+	thread__get(new);
+
+	/*
+	 * We have to initialize map_groups separately
+	 * after rb tree is updated.
+	 *
+	 * The reason is that we call machine__findnew_thread
+	 * within thread__init_map_groups to find the thread
+	 * leader and that would screwed the rb tree.
+	 */
+	if (thread__init_map_groups(new, machine))
+		thread__zput(new);
+
+	return new;
+}
+
+struct thread *machine__find_thread_by_time(struct machine *machine, pid_t pid,
+					    pid_t tid, u64 timestamp)
+{
+	struct threads *threads = machine__threads(machine, tid);
+	struct thread *th;
+
+	down_write(&threads->lock);
+	th = thread__get(__machine__findnew_thread_by_time(machine, threads, pid, tid,
+							   timestamp, false));
+	up_write(&threads->lock);
+	return th;
+}
+
+struct thread *machine__findnew_thread_by_time(struct machine *machine, pid_t pid,
+					       pid_t tid, u64 timestamp)
+{
+	struct threads *threads = machine__threads(machine, tid);
+	struct thread *th;
+
+	down_write(&threads->lock);
+	th = thread__get(__machine__findnew_thread_by_time(machine, threads, pid, tid,
+							   timestamp, true));
+	up_write(&threads->lock);
+	return th;
+}
+
 struct comm *machine__thread_exec_comm(struct machine *machine,
 				       struct thread *thread)
 {
@@ -1611,7 +1727,7 @@ int machine__process_mmap2_event(struct machine *machine,
 	}
 
 	thread = machine__findnew_thread(machine, event->mmap2.pid,
-					event->mmap2.tid);
+					 event->mmap2.tid);
 	if (thread == NULL)
 		goto out_problem;
 
@@ -1735,6 +1851,16 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 		pos = rb_entry(parent, struct thread, rb_node);
 
 		if (pos->tid == th->tid) {
+			struct thread *old;
+
+			/* sort by time */
+			list_for_each_entry(old, &pos->tid_list, tid_list) {
+				if (th->start_time >= old->start_time) {
+					pos = old;
+					break;
+				}
+			}
+
 			list_add_tail(&th->tid_list, &pos->tid_list);
 			goto out;
 		}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d91a3567d2cd..9aed55d9facc 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -99,8 +99,6 @@ static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
 	return ip >= kernel_start;
 }
 
-struct thread *machine__find_thread(struct machine *machine, pid_t pid,
-				    pid_t tid);
 struct comm *machine__thread_exec_comm(struct machine *machine,
 				       struct thread *thread);
 
@@ -194,6 +192,14 @@ int machine__nr_cpus_avail(struct machine *machine);
 
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
+struct thread *machine__find_thread(struct machine *machine, pid_t pid,
+				    pid_t tid);
+struct thread *machine__findnew_thread_by_time(struct machine *machine,
+					       pid_t pid, pid_t tid,
+					       u64 timestamp);
+struct thread *machine__find_thread_by_time(struct machine *machine,
+					    pid_t pid, pid_t tid,
+					    u64 timestamp);
 
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename);
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 47c03001d578..109fa3bc23c4 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -225,6 +225,10 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 	/* Override the default :tid entry */
 	if (!thread->comm_set) {
 		int err = comm__override(curr, str, timestamp, exec);
+
+		if (!thread->start_time)
+			thread->start_time = timestamp;
+
 		if (err)
 			return err;
 	} else {
@@ -403,6 +407,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
 	}
 
 	thread->ppid = parent->tid;
+	thread->start_time = timestamp;
 	return thread__clone_map_groups(thread, parent);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index d573f3715fec..e8f779e83347 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -32,6 +32,7 @@ struct thread {
 	struct list_head	comm_list;
 	struct rw_semaphore	comm_lock;
 	u64			db_id;
+	u64			start_time;
 
 	void			*priv;
 	struct thread_stack	*ts;
-- 
2.17.1

