Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeCHTwF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752065AbeCHTwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:01 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAF72177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/54] perf mmap: Simplify perf_mmap__read_event()
Date: Thu,  8 Mar 2018 16:50:03 -0300
Message-Id: <20180308195029.14991-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It isn't necessary to pass the 'overwrite', 'start' and 'end' argument
to perf_mmap__read_event().  Discard them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-7-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 tools/perf/util/mmap.c                       | 5 +----
 tools/perf/util/mmap.h                       | 4 +---
 tools/perf/util/python.c                     | 2 +-
 17 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index a9bc77df6a65..17cf7fc3c7d5 100644
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
index 165c044616b6..e9f69b8f8e25 100644
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
index 11b4a413039f..eb19cf92a388 100644
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
index 27eadf3018c6..29fda506ac75 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2509,7 +2509,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (perf_mmap__read_init(md, false, &start, &end) < 0)
 			continue;
 
-		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
+		while ((event = perf_mmap__read_event(md)) != NULL) {
 			struct perf_sample sample;
 
 			++trace->nr_events;
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index e0b1b414d466..e0eae1053ddc 100644
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
index 09c9c9f9e827..384c20f4c902 100644
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
index f7c199acb7ac..f7919666bc2c 100644
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
index 1f1db5965d05..ad477b7cf238 100644
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
index f473e106aeba..7790eb3303e6 100644
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
index 7837ae936679..b0be2da65da7 100644
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
index 6ff5f99b3e0e..59be0942b787 100644
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
index b58297b9a83d..403f2d9cee96 100644
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
index dbf9e20f7d56..99839de3caee 100644
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
index 5aa2e68e9d05..2df0c0573e2c 100644
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
index 62312e06d75b..2fbe4c8a02d2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -75,10 +75,7 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
  * }
  * perf_mmap__read_done()
  */
-union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite __maybe_unused,
-					u64 *startp __maybe_unused,
-					u64 end __maybe_unused)
+union perf_event *perf_mmap__read_event(struct perf_mmap *map)
 {
 	union perf_event *event;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 043916a20de6..ae9499b80110 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -89,9 +89,7 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 
-union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite,
-					u64 *startp, u64 end);
+union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(void *to, void *buf, size_t size));
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ca077f8be1f0..4798db93e7ee 100644
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
2.14.3
