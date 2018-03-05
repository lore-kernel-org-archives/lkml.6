Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeCETM5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:12:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:47640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932362AbeCETMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:12:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="23109097"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/7] perf tools: Refine perf_mmap__read_event
Date: Mon,  5 Mar 2018 14:10:58 -0500
Message-Id: <1520277059-32749-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It doesn't need to pass the 'overwrite', 'start' and 'end' to
perf_mmap__read_event.
Discard the parameters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-top.c                     | 2 +-
 tools/perf/builtin-trace.c                   | 2 +-
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 2 +-
 tools/perf/tests/mmap-basic.c                | 2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/perf-record.c               | 2 +-
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 2 +-
 tools/perf/tests/task-exit.c                 | 2 +-
 tools/perf/util/mmap.c                       | 8 +-------
 tools/perf/util/mmap.h                       | 4 +---
 tools/perf/util/python.c                     | 2 +-
 17 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index a9bc77d..17cf7fc 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -115,7 +115,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 		if (perf_mmap__read_init(md, false, &start, &end) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(md)) != NULL) {
 			struct perf_sample sample;
 
 			if (event->header.type != PERF_RECORD_COMM ||
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 165c0446..e9f69b8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -757,7 +757,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 	if (err < 0)
 		return (err == -EAGAIN) ? 0 : -1;
 
-	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+	while ((event = perf_mmap__read_event(md)) != NULL) {
 		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (err) {
 			perf_mmap__consume(md);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 11b4a41..eb19cf9 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -824,7 +824,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 	if (perf_mmap__read_init(md, opts->overwrite, &start, &end) < 0)
 		return;
 
-	while ((event = perf_mmap__read_event(md, opts->overwrite, &start, end)) != NULL) {
+	while ((event = perf_mmap__read_event(md)) != NULL) {
 		ret = perf_evlist__parse_sample(evlist, event, &sample);
 		if (ret) {
 			pr_err("Can't parse sample, err = %d\n", ret);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index abc855d..c71ef7ba 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2479,7 +2479,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (perf_mmap__read_init(md, false, &start, &end) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(md)) != NULL) {
 			struct perf_sample sample;
 
 			++trace->nr_events;
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index e0b1b41..e0eae10 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -36,7 +36,7 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 		u64 start, end;
 
 		perf_mmap__read_init(map, true, &start, &end);
-		while ((event = perf_mmap__read_event(map, true, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(map)) != NULL) {
 			const u32 type = event->header.type;
 
 			switch (type) {
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 09c9c9f..384c20f 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -183,7 +183,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		if (perf_mmap__read_init(md, false, &start, &end) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(md)) != NULL) {
 			const u32 type = event->header.type;
 
 			if (type == PERF_RECORD_SAMPLE)
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index f7c199a..f791966 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -418,7 +418,7 @@ static int process_events(struct machine *machine, struct perf_evlist *evlist,
 		if (perf_mmap__read_init(md, false, &start, &end) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(md)) != NULL) {
 			ret = process_event(machine, evlist, event, state);
 			perf_mmap__consume(md);
 			if (ret < 0)
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 1f1db59..ad477b7 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -36,7 +36,7 @@ static int find_comm(struct perf_evlist *evlist, const char *comm)
 		md = &evlist->mmap[i];
 		if (perf_mmap__read_init(md, false, &start, &end) < 0)
 			continue;
-		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(md)) != NULL) {
 			if (event->header.type == PERF_RECORD_COMM &&
 			    (pid_t)event->comm.pid == getpid() &&
 			    (pid_t)event->comm.tid == getpid() &&
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index f473e10..7790eb3 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -112,7 +112,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	if (perf_mmap__read_init(md, false, &start, &end) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+	while ((event = perf_mmap__read_event(md)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 7837ae9..b0be2da 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -93,7 +93,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 			if (perf_mmap__read_init(md, false, &start, &end) < 0)
 				continue;
 
-			while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+			while ((event = perf_mmap__read_event(md)) != NULL) {
 				const u32 type = event->header.type;
 				int tp_flags;
 				struct perf_sample sample;
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 6ff5f99..59be094 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -171,7 +171,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 			if (perf_mmap__read_init(md, false, &start, &end) < 0)
 				continue;
 
-			while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+			while ((event = perf_mmap__read_event(md)) != NULL) {
 				const u32 type = event->header.type;
 				const char *name = perf_event__name(type);
 
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index b58297b..403f2d9 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -99,7 +99,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	if (perf_mmap__read_init(md, false, &start, &end) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+	while ((event = perf_mmap__read_event(md)) != NULL) {
 		struct perf_sample sample;
 
 		if (event->header.type != PERF_RECORD_SAMPLE)
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index dbf9e20..99839de 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -267,7 +267,7 @@ static int process_events(struct perf_evlist *evlist,
 		if (perf_mmap__read_init(md, false, &start, &end) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(md)) != NULL) {
 			cnt += 1;
 			ret = add_event(evlist, &events, event);
 			 perf_mmap__consume(md);
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 5aa2e68..2df0c05 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -116,7 +116,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	if (perf_mmap__read_init(md, false, &start, &end) < 0)
 		goto out_init;
 
-	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+	while ((event = perf_mmap__read_event(md)) != NULL) {
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index a56c66b..e3921ed 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -75,9 +75,7 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
  * }
  * perf_mmap__read_done()
  */
-union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite __maybe_unused,
-					u64 *startp, u64 end __maybe_unused)
+union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 {
 	union perf_event *event;
 
@@ -87,15 +85,11 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 	if (!refcount_read(&map->refcnt))
 		return NULL;
 
-	if (startp == NULL)
-		return NULL;
-
 	/* non-overwirte doesn't pause the ringbuffer */
 	if (!map->overwrite)
 		map->end = perf_mmap__read_head(map);
 
 	event = perf_mmap__read(map, &map->start, map->end);
-	*startp = map->start;
 
 	if (!map->overwrite)
 		map->prev = map->start;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d098b47..c09b4e7 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -89,9 +89,7 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 
-union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite,
-					u64 *startp, u64 end);
+union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, bool backward,
 		    void *to, int push(void *to, void *buf, size_t size));
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ca077f8..4798db9 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -995,7 +995,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 	if (perf_mmap__read_init(md, false, &start, &end) < 0)
 		goto end;
 
-	event = perf_mmap__read_event(md, false, &start, end);
+	event = perf_mmap__read_event(md);
 	if (event != NULL) {
 		PyObject *pyevent = pyrf_event__new(event);
 		struct pyrf_event *pevent = (struct pyrf_event *)pyevent;
-- 
2.4.11
