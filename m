Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbeCIIrK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:47:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeCIIrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:47:08 -0500
Date: Fri, 9 Mar 2018 00:46:55 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-b9bae2c841b73eac6bfed510bc24a3051754ff51@git.kernel.org>
Cc: jolsa@kernel.org, kan.liang@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com, ak@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: wangnan0@huawei.com, namhyung@kernel.org, acme@redhat.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
        jolsa@kernel.org
In-Reply-To: <1520350567-80082-8-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-8-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Simplify perf_mmap__read_init()
Git-Commit-ID: b9bae2c841b73eac6bfed510bc24a3051754ff51
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b9bae2c841b73eac6bfed510bc24a3051754ff51
Gitweb:     https://git.kernel.org/tip/b9bae2c841b73eac6bfed510bc24a3051754ff51
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 6 Mar 2018 10:36:07 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:53 -0300

perf mmap: Simplify perf_mmap__read_init()

It isn't necessary to pass the 'start', 'end' and 'overwrite' arguments
to perf_mmap__read_init().  The data is stored in the struct perf_mmap.

Discard the parameters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-8-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  3 +--
 tools/perf/builtin-kvm.c                     |  3 +--
 tools/perf/builtin-top.c                     |  3 +--
 tools/perf/builtin-trace.c                   |  3 +--
 tools/perf/tests/backward-ring-buffer.c      |  3 +--
 tools/perf/tests/bpf.c                       |  3 +--
 tools/perf/tests/code-reading.c              |  3 +--
 tools/perf/tests/keep-tracking.c             |  3 +--
 tools/perf/tests/mmap-basic.c                |  3 +--
 tools/perf/tests/openat-syscall-tp-fields.c  |  3 +--
 tools/perf/tests/perf-record.c               |  3 +--
 tools/perf/tests/sw-clock.c                  |  3 +--
 tools/perf/tests/switch-tracking.c           |  3 +--
 tools/perf/tests/task-exit.c                 |  3 +--
 tools/perf/util/mmap.c                       | 10 ++--------
 tools/perf/util/mmap.h                       |  3 +--
 tools/perf/util/python.c                     |  3 +--
 17 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 17cf7fc3c7d5..7a7721604b86 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -61,7 +61,6 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	u64 test_tsc, comm1_tsc, comm2_tsc;
 	u64 test_time, comm1_time = 0, comm2_time = 0;
 	struct perf_mmap *md;
-	u64 end, start;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
@@ -112,7 +111,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index e9f69b8f8e25..72e2ca096bf5 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -746,14 +746,13 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 	struct perf_evlist *evlist = kvm->evlist;
 	union perf_event *event;
 	struct perf_mmap *md;
-	u64 end, start;
 	u64 timestamp;
 	s64 n = 0;
 	int err;
 
 	*mmap_time = ULLONG_MAX;
 	md = &evlist->mmap[idx];
-	err = perf_mmap__read_init(md, false, &start, &end);
+	err = perf_mmap__read_init(md);
 	if (err < 0)
 		return (err == -EAGAIN) ? 0 : -1;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index eb19cf92a388..0a26b56afcc5 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -817,11 +817,10 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 	struct perf_session *session = top->session;
 	union perf_event *event;
 	struct machine *machine;
-	u64 end, start;
 	int ret;
 
 	md = opts->overwrite ? &evlist->overwrite_mmap[idx] : &evlist->mmap[idx];
-	if (perf_mmap__read_init(md, opts->overwrite, &start, &end) < 0)
+	if (perf_mmap__read_init(md) < 0)
 		return;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 29fda506ac75..87b95c9410b4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2503,10 +2503,9 @@ again:
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
 		struct perf_mmap *md;
-		u64 end, start;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index e0eae1053ddc..6d598cc071ae 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -33,9 +33,8 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct perf_mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
-		u64 start, end;
 
-		perf_mmap__read_init(map, true, &start, &end);
+		perf_mmap__read_init(map);
 		while ((event = perf_mmap__read_event(map)) != NULL) {
 			const u32 type = event->header.type;
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 384c20f4c902..79b54f8ddebf 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -177,10 +177,9 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
 		struct perf_mmap *md;
-		u64 end, start;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index f7919666bc2c..99936352df4f 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -410,12 +410,11 @@ static int process_events(struct machine *machine, struct perf_evlist *evlist,
 {
 	union perf_event *event;
 	struct perf_mmap *md;
-	u64 end, start;
 	int i, ret;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index ad477b7cf238..17c46f3e6f1e 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -28,13 +28,12 @@ static int find_comm(struct perf_evlist *evlist, const char *comm)
 {
 	union perf_event *event;
 	struct perf_mmap *md;
-	u64 end, start;
 	int i, found;
 
 	found = 0;
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md) < 0)
 			continue;
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			if (event->header.type == PERF_RECORD_COMM &&
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 7790eb3303e6..bb8e6bcb0d96 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -39,7 +39,6 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	struct perf_evsel *evsels[nsyscalls], *evsel;
 	char sbuf[STRERR_BUFSIZE];
 	struct perf_mmap *md;
-	u64 end, start;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	if (threads == NULL) {
@@ -109,7 +108,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		}
 
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+	if (perf_mmap__read_init(md) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index b0be2da65da7..344dc3ac2469 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -87,10 +87,9 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
 			struct perf_mmap *md;
-			u64 end, start;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			if (perf_mmap__read_init(md) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 59be0942b787..34394cc05077 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -165,10 +165,9 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
 			struct perf_mmap *md;
-			u64 end, start;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			if (perf_mmap__read_init(md) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 403f2d9cee96..f9490b237893 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -40,7 +40,6 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	struct cpu_map *cpus;
 	struct thread_map *threads;
 	struct perf_mmap *md;
-	u64 end, start;
 
 	attr.sample_freq = 500;
 
@@ -96,7 +95,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	perf_evlist__disable(evlist);
 
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+	if (perf_mmap__read_init(md) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 99839de3caee..9b5be51e5e7b 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -259,12 +259,11 @@ static int process_events(struct perf_evlist *evlist,
 	LIST_HEAD(events);
 	struct event_node *events_array, *node;
 	struct perf_mmap *md;
-	u64 end, start;
 	int i, ret;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 2df0c0573e2c..e92fa6029ac7 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -48,7 +48,6 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	struct cpu_map *cpus;
 	struct thread_map *threads;
 	struct perf_mmap *md;
-	u64 end, start;
 
 	signal(SIGCHLD, sig_handler);
 
@@ -113,7 +112,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 retry:
 	md = &evlist->mmap[0];
-	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+	if (perf_mmap__read_init(md) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 2fbe4c8a02d2..074c4fd3b67e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -235,16 +235,13 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u6
 /*
  * Report the start and end of the available data in ringbuffer
  */
-int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
-			 u64 *startp, u64 *endp)
+int perf_mmap__read_init(struct perf_mmap *md)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
 
-	*startp = overwrite ? head : old;
-	*endp = overwrite ? old : head;
 	md->start = md->overwrite ? head : old;
 	md->end = md->overwrite ? old : head;
 
@@ -267,8 +264,6 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 		 */
 		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
 			return -EINVAL;
-		*startp = md->start;
-		*endp = md->end;
 	}
 
 	return 0;
@@ -278,13 +273,12 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
-	u64 end, start;
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
 	void *buf;
 	int rc = 0;
 
-	rc = perf_mmap__read_init(md, md->overwrite, &start, &end);
+	rc = perf_mmap__read_init(md);
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 0 : -1;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index ae9499b80110..d82294db1295 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -96,7 +96,6 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
-			 u64 *startp, u64 *endp);
+int perf_mmap__read_init(struct perf_mmap *md);
 void perf_mmap__read_done(struct perf_mmap *map);
 #endif /*__PERF_MMAP_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4798db93e7ee..b956868fd445 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -984,7 +984,6 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	int sample_id_all = 1, cpu;
 	static char *kwlist[] = { "cpu", "sample_id_all", NULL };
 	struct perf_mmap *md;
-	u64 end, start;
 	int err;
 
 	if (!PyArg_ParseTupleAndKeywords(args, kwargs, "i|i", kwlist,
@@ -992,7 +991,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		return NULL;
 
 	md = &evlist->mmap[cpu];
-	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+	if (perf_mmap__read_init(md) < 0)
 		goto end;
 
 	event = perf_mmap__read_event(md);
