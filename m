Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366A6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB90208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB90208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbeLFTTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:19:19 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:39897 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLFTSl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 14:18:41 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 12:18:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/7] perf machine: Use cached rbtrees
Date:   Thu,  6 Dec 2018 11:18:14 -0800
Message-Id: <20181206191819.30182-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181206191819.30182-1-dave@stgolabs.net>
References: <20181206191819.30182-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the cost of an extra pointer, we can avoid the O(logN) cost
of finding the first element in the tree (smallest node), which
is something required for nearly every operation dealing with
machine->guests and threads->entries.

The conversion is straightforward, however, it's worth noticing
that the rb_erase_init() calls have been replaced by rb_erase_cached()
which has no _init() flavor, however, the node is explicitly
cleared next anyway, which was redundant until now.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/builtin-report.c |  3 ++-
 tools/perf/util/build-id.c  | 12 ++++++----
 tools/perf/util/machine.c   | 53 ++++++++++++++++++++++++++-------------------
 tools/perf/util/machine.h   | 12 +++++-----
 tools/perf/util/rb_resort.h |  6 ++---
 5 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 257c9c18cb7e..b22fce3d9c95 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -752,7 +752,8 @@ static int tasks_print(struct report *rep, FILE *fp)
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
 
-		for (nd = rb_first(&threads->entries); nd; nd = rb_next(nd)) {
+		for (nd = rb_first_cached(&threads->entries); nd;
+		     nd = rb_next(nd)) {
 			task = tasks + itask++;
 
 			task->thread = rb_entry(nd, struct thread, rb_node);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 04b1d53e4bf9..a3796455898e 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -363,7 +363,8 @@ int perf_session__write_buildid_table(struct perf_session *session,
 	if (err)
 		return err;
 
-	for (nd = rb_first(&session->machines.guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&session->machines.guests); nd;
+	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		err = machine__write_buildid_table(pos, fd);
 		if (err)
@@ -396,7 +397,8 @@ int dsos__hit_all(struct perf_session *session)
 	if (err)
 		return err;
 
-	for (nd = rb_first(&session->machines.guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&session->machines.guests); nd;
+	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 
 		err = machine__hit_all_dsos(pos);
@@ -849,7 +851,8 @@ int perf_session__cache_build_ids(struct perf_session *session)
 
 	ret = machine__cache_build_ids(&session->machines.host);
 
-	for (nd = rb_first(&session->machines.guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&session->machines.guests); nd;
+	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		ret |= machine__cache_build_ids(pos);
 	}
@@ -866,7 +869,8 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
 	struct rb_node *nd;
 	bool ret = machine__read_build_ids(&session->machines.host, with_hits);
 
-	for (nd = rb_first(&session->machines.guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&session->machines.guests); nd;
+	     nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		ret |= machine__read_build_ids(pos, with_hits);
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8f36ce813bc5..1fbdc745a57e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -41,7 +41,7 @@ static void machine__threads_init(struct machine *machine)
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
-		threads->entries = RB_ROOT;
+		threads->entries = RB_ROOT_CACHED;
 		init_rwsem(&threads->lock);
 		threads->nr = 0;
 		INIT_LIST_HEAD(&threads->dead);
@@ -179,7 +179,7 @@ void machine__delete_threads(struct machine *machine)
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads *threads = &machine->threads[i];
 		down_write(&threads->lock);
-		nd = rb_first(&threads->entries);
+		nd = rb_first_cached(&threads->entries);
 		while (nd) {
 			struct thread *t = rb_entry(nd, struct thread, rb_node);
 
@@ -222,7 +222,7 @@ void machine__delete(struct machine *machine)
 void machines__init(struct machines *machines)
 {
 	machine__init(&machines->host, "", HOST_KERNEL_ID);
-	machines->guests = RB_ROOT;
+	machines->guests = RB_ROOT_CACHED;
 }
 
 void machines__exit(struct machines *machines)
@@ -234,9 +234,10 @@ void machines__exit(struct machines *machines)
 struct machine *machines__add(struct machines *machines, pid_t pid,
 			      const char *root_dir)
 {
-	struct rb_node **p = &machines->guests.rb_node;
+	struct rb_node **p = &machines->guests.rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct machine *pos, *machine = malloc(sizeof(*machine));
+	bool leftmost = true;
 
 	if (machine == NULL)
 		return NULL;
@@ -251,12 +252,14 @@ struct machine *machines__add(struct machines *machines, pid_t pid,
 		pos = rb_entry(parent, struct machine, rb_node);
 		if (pid < pos->pid)
 			p = &(*p)->rb_left;
-		else
+		else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 
 	rb_link_node(&machine->rb_node, parent, p);
-	rb_insert_color(&machine->rb_node, &machines->guests);
+	rb_insert_color_cached(&machine->rb_node, &machines->guests, leftmost);
 
 	return machine;
 }
@@ -267,7 +270,7 @@ void machines__set_comm_exec(struct machines *machines, bool comm_exec)
 
 	machines->host.comm_exec = comm_exec;
 
-	for (nd = rb_first(&machines->guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *machine = rb_entry(nd, struct machine, rb_node);
 
 		machine->comm_exec = comm_exec;
@@ -276,7 +279,7 @@ void machines__set_comm_exec(struct machines *machines, bool comm_exec)
 
 struct machine *machines__find(struct machines *machines, pid_t pid)
 {
-	struct rb_node **p = &machines->guests.rb_node;
+	struct rb_node **p = &machines->guests.rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct machine *machine;
 	struct machine *default_machine = NULL;
@@ -339,7 +342,7 @@ void machines__process_guests(struct machines *machines,
 {
 	struct rb_node *nd;
 
-	for (nd = rb_first(&machines->guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		process(pos, data);
 	}
@@ -352,7 +355,8 @@ void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size)
 
 	machines->host.id_hdr_size = id_hdr_size;
 
-	for (node = rb_first(&machines->guests); node; node = rb_next(node)) {
+	for (node = rb_first_cached(&machines->guests); node;
+	     node = rb_next(node)) {
 		machine = rb_entry(node, struct machine, rb_node);
 		machine->id_hdr_size = id_hdr_size;
 	}
@@ -465,9 +469,10 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 						  pid_t pid, pid_t tid,
 						  bool create)
 {
-	struct rb_node **p = &threads->entries.rb_node;
+	struct rb_node **p = &threads->entries.rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct thread *th;
+	bool leftmost = true;
 
 	th = threads__get_last_match(threads, machine, pid, tid);
 	if (th)
@@ -485,8 +490,10 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 
 		if (tid < th->tid)
 			p = &(*p)->rb_left;
-		else
+		else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 
 	if (!create)
@@ -495,7 +502,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 	th = thread__new(pid, tid);
 	if (th != NULL) {
 		rb_link_node(&th->rb_node, parent, p);
-		rb_insert_color(&th->rb_node, &threads->entries);
+		rb_insert_color_cached(&th->rb_node, &threads->entries, leftmost);
 
 		/*
 		 * We have to initialize map_groups separately
@@ -506,7 +513,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		 * leader and that would screwed the rb tree.
 		 */
 		if (thread__init_map_groups(th, machine)) {
-			rb_erase_init(&th->rb_node, &threads->entries);
+			rb_erase_cached(&th->rb_node, &threads->entries);
 			RB_CLEAR_NODE(&th->rb_node);
 			thread__put(th);
 			return NULL;
@@ -744,7 +751,7 @@ size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 	struct rb_node *nd;
 	size_t ret = __dsos__fprintf(&machines->host.dsos.head, fp);
 
-	for (nd = rb_first(&machines->guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		ret += __dsos__fprintf(&pos->dsos.head, fp);
 	}
@@ -764,7 +771,7 @@ size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
 	struct rb_node *nd;
 	size_t ret = machine__fprintf_dsos_buildid(&machines->host, fp, skip, parm);
 
-	for (nd = rb_first(&machines->guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
 		ret += machine__fprintf_dsos_buildid(pos, fp, skip, parm);
 	}
@@ -804,7 +811,8 @@ size_t machine__fprintf(struct machine *machine, FILE *fp)
 
 		ret = fprintf(fp, "Threads: %u\n", threads->nr);
 
-		for (nd = rb_first(&threads->entries); nd; nd = rb_next(nd)) {
+		for (nd = rb_first_cached(&threads->entries); nd;
+		     nd = rb_next(nd)) {
 			struct thread *pos = rb_entry(nd, struct thread, rb_node);
 
 			ret += thread__fprintf(pos, fp);
@@ -1107,7 +1115,7 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 
 void machines__destroy_kernel_maps(struct machines *machines)
 {
-	struct rb_node *next = rb_first(&machines->guests);
+	struct rb_node *next = rb_first_cached(&machines->guests);
 
 	machine__destroy_kernel_maps(&machines->host);
 
@@ -1115,7 +1123,7 @@ void machines__destroy_kernel_maps(struct machines *machines)
 		struct machine *pos = rb_entry(next, struct machine, rb_node);
 
 		next = rb_next(&pos->rb_node);
-		rb_erase(&pos->rb_node, &machines->guests);
+		rb_erase_cached(&pos->rb_node, &machines->guests);
 		machine__delete(pos);
 	}
 }
@@ -1680,7 +1688,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	BUG_ON(refcount_read(&th->refcnt) == 0);
 	if (lock)
 		down_write(&threads->lock);
-	rb_erase_init(&th->rb_node, &threads->entries);
+	rb_erase_cached(&th->rb_node, &threads->entries);
 	RB_CLEAR_NODE(&th->rb_node);
 	--threads->nr;
 	/*
@@ -2453,7 +2461,8 @@ int machine__for_each_thread(struct machine *machine,
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
 		threads = &machine->threads[i];
-		for (nd = rb_first(&threads->entries); nd; nd = rb_next(nd)) {
+		for (nd = rb_first_cached(&threads->entries); nd;
+		     nd = rb_next(nd)) {
 			thread = rb_entry(nd, struct thread, rb_node);
 			rc = fn(thread, priv);
 			if (rc != 0)
@@ -2480,7 +2489,7 @@ int machines__for_each_thread(struct machines *machines,
 	if (rc != 0)
 		return rc;
 
-	for (nd = rb_first(&machines->guests); nd; nd = rb_next(nd)) {
+	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *machine = rb_entry(nd, struct machine, rb_node);
 
 		rc = machine__for_each_thread(machine, fn, priv);
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..a4cc5a1cb1f8 100644
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
+	struct rb_root_cached  entries;
+	struct rw_semaphore    lock;
+	unsigned int	       nr;
+	struct list_head       dead;
+	struct thread	       *last_match;
 };
 
 struct machine {
@@ -134,7 +134,7 @@ typedef void (*machine__process_t)(struct machine *machine, void *data);
 
 struct machines {
 	struct machine host;
-	struct rb_root guests;
+	struct rb_root_cached guests;
 };
 
 void machines__init(struct machines *machines);
diff --git a/tools/perf/util/rb_resort.h b/tools/perf/util/rb_resort.h
index a920f702a74d..f272e181d3d6 100644
--- a/tools/perf/util/rb_resort.h
+++ b/tools/perf/util/rb_resort.h
@@ -144,8 +144,8 @@ struct __name##_sorted *__name = __name##_sorted__new
 				  __ilist->rblist.nr_entries)
 
 /* For 'struct machine->threads' */
-#define DECLARE_RESORT_RB_MACHINE_THREADS(__name, __machine, hash_bucket)	\
-	DECLARE_RESORT_RB(__name)(&__machine->threads[hash_bucket].entries,	\
-				  __machine->threads[hash_bucket].nr)
+#define DECLARE_RESORT_RB_MACHINE_THREADS(__name, __machine, hash_bucket)    \
+ DECLARE_RESORT_RB(__name)(&__machine->threads[hash_bucket].entries.rb_root, \
+			   __machine->threads[hash_bucket].nr)
 
 #endif /* _PERF_RESORT_RB_H_ */
-- 
2.16.4

