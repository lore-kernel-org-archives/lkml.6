Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeCETMj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:12:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:47640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932395AbeCETMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:12:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="23109099"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 7/7] perf tools: Refine perf_mmap__read_init
Date: Mon,  5 Mar 2018 14:10:59 -0500
Message-Id: <1520277059-32749-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It doesn't need to pass the 'start' and 'end' boilerplate to
perf_mmap__read_init().
The data will be stored in the struct perf_mmap.

Discard the parameters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
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
index 17cf7fc..a7c9f60 100644
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
+		if (perf_mmap__read_init(md, false) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index e9f69b8..2bcc599 100644
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
+	err = perf_mmap__read_init(md, false);
 	if (err < 0)
 		return (err == -EAGAIN) ? 0 : -1;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index eb19cf9..9fc13c4 100644
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
+	if (perf_mmap__read_init(md, opts->overwrite) < 0)
 		return;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c71ef7ba..86cdc98 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2473,10 +2473,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
 		struct perf_mmap *md;
-		u64 end, start;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md, false) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index e0eae10..15b80b2 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -33,9 +33,8 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct perf_mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
-		u64 start, end;
 
-		perf_mmap__read_init(map, true, &start, &end);
+		perf_mmap__read_init(map, true);
 		while ((event = perf_mmap__read_event(map)) != NULL) {
 			const u32 type = event->header.type;
 
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 384c20f..192c37f 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -177,10 +177,9 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
 		struct perf_mmap *md;
-		u64 end, start;
 
 		md = &evlist->mmap[i];
-		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		if (perf_mmap__read_init(md, false) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index f791966..b494837 100644
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
+		if (perf_mmap__read_init(md, false) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index ad477b7..9ddd914 100644
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
+		if (perf_mmap__read_init(md, false) < 0)
 			continue;
 		while ((event = perf_mmap__read_event(md)) != NULL) {
 			if (event->header.type == PERF_RECORD_COMM &&
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 7790eb3..102a704 100644
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
+	if (perf_mmap__read_init(md, false) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index b0be2da..917f7f5b 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -87,10 +87,9 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
 			struct perf_mmap *md;
-			u64 end, start;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			if (perf_mmap__read_init(md, false) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 59be094..4ff6262 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -165,10 +165,9 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
 			struct perf_mmap *md;
-			u64 end, start;
 
 			md = &evlist->mmap[i];
-			if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			if (perf_mmap__read_init(md, false) < 0)
 				continue;
 
 			while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 403f2d9..9244b74 100644
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
+	if (perf_mmap__read_init(md, false) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 99839de..bdf5d1d 100644
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
+		if (perf_mmap__read_init(md, false) < 0)
 			continue;
 
 		while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 2df0c05..31954a4 100644
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
+	if (perf_mmap__read_init(md, false) < 0)
 		goto out_init;
 
 	while ((event = perf_mmap__read_event(md)) != NULL) {
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index e3921ed..403c5e6 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -235,16 +235,13 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u6
 /*
  * Report the start and end of the available data in ringbuffer
  */
-int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
-			 u64 *startp, u64 *endp)
+int perf_mmap__read_init(struct perf_mmap *md, bool overwrite)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
 
-	*startp = overwrite ? head : old;
-	*endp = overwrite ? old : head;
 	md->overwrite = overwrite;
 	md->start = overwrite ? head : old;
 	md->end = overwrite ? old : head;
@@ -268,8 +265,6 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 		 */
 		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
 			return -EINVAL;
-		*startp = md->start;
-		*endp = md->end;
 	}
 
 	return 0;
@@ -279,13 +274,12 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 		    void *to, int push(void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
-	u64 end, start;
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
 	void *buf;
 	int rc = 0;
 
-	rc = perf_mmap__read_init(md, overwrite, &start, &end);
+	rc = perf_mmap__read_init(md, overwrite);
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 0 : -1;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index c09b4e7..6442025 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -96,7 +96,6 @@ int perf_mmap__push(struct perf_mmap *md, bool backward,
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
-			 u64 *startp, u64 *endp);
+int perf_mmap__read_init(struct perf_mmap *md, bool overwrite);
 void perf_mmap__read_done(struct perf_mmap *map);
 #endif /*__PERF_MMAP_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 4798db9..2055399 100644
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
+	if (perf_mmap__read_init(md, false) < 0)
 		goto end;
 
 	event = perf_mmap__read_event(md);
-- 
2.4.11
