Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeCHTwB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752007AbeCHTv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550BA205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/54] perf mmap: Simplify perf_mmap__consume()
Date: Thu,  8 Mar 2018 16:50:02 -0300
Message-Id: <20180308195029.14991-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It isn't necessary to pass the 'overwrite' argument to
perf_mmap__consume().  Discard it.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-6-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 4 ++--
 tools/perf/builtin-top.c                     | 2 +-
 tools/perf/builtin-trace.c                   | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 2 +-
 tools/perf/tests/mmap-basic.c                | 2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/perf-record.c               | 2 +-
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 2 +-
 tools/perf/tests/task-exit.c                 | 2 +-
 tools/perf/util/mmap.c                       | 6 +++---
 tools/perf/util/mmap.h                       | 2 +-
 tools/perf/util/python.c                     | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 7f82d91ef473..a9bc77df6a65 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -134,7 +134,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 				comm2_time = sample.time;
 			}
 next_event:
-			perf_mmap__consume(md, false);
+			perf_mmap__consume(md);
 		}
 		perf_mmap__read_done(md);
 	}
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index d2703d3b8366..165c044616b6 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -760,7 +760,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 		err = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
 		if (err) {
-			perf_mmap__consume(md, false);
+			perf_mmap__consume(md);
 			pr_err("Failed to parse sample\n");
 			return -1;
 		}
@@ -770,7 +770,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 		 * FIXME: Here we can't consume the event, as perf_session__queue_event will
 		 *        point to it, and it'll get possibly overwritten by the kernel.
 		 */
-		perf_mmap__consume(md, false);
+		perf_mmap__consume(md);
 
 		if (err) {
 			pr_err("Failed to enqueue sample: %d\n", err);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index bb4f9fafd11d..11b4a413039f 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -879,7 +879,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		} else
 			++session->evlist->stats.nr_unknown_events;
 next_event:
-		perf_mmap__consume(md, opts->overwrite);
+		perf_mmap__consume(md);
 	}
 
 	perf_mmap__read_done(md);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5b81060a8117..27eadf3018c6 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2522,7 +2522,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 			trace__handle_event(trace, event, &sample);
 next_event:
-			perf_mmap__consume(md, false);
+			perf_mmap__consume(md);
 
 			if (interrupted)
 				goto out_disable;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 03ed8c77b1bb..f7c199acb7ac 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -420,7 +420,7 @@ static int process_events(struct machine *machine, struct perf_evlist *evlist,
 
 		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			ret = process_event(machine, evlist, event, state);
-			perf_mmap__consume(md, false);
+			perf_mmap__consume(md);
 			if (ret < 0)
 				return ret;
 		}
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 4590d8fb91ab..1f1db5965d05 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -42,7 +42,7 @@ static int find_comm(struct perf_evlist *evlist, const char *comm)
 			    (pid_t)event->comm.tid == getpid() &&
 			    strcmp(event->comm.comm, comm) == 0)
 				found += 1;
-			perf_mmap__consume(md, false);
+			perf_mmap__consume(md);
 		}
 		perf_mmap__read_done(md);
 	}
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 44c58d69cd87..f473e106aeba 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -135,7 +135,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 			goto out_delete_evlist;
 		}
 		nr_events[evsel->idx]++;
-		perf_mmap__consume(md, false);
+		perf_mmap__consume(md);
 	}
 	perf_mmap__read_done(md);
 
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 620b21023f72..7837ae936679 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -101,7 +101,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 				++nr_events;
 
 				if (type != PERF_RECORD_SAMPLE) {
-					perf_mmap__consume(md, false);
+					perf_mmap__consume(md);
 					continue;
 				}
 
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 31f3f70adca6..6ff5f99b3e0e 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -272,7 +272,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 					++errs;
 				}
 
-				perf_mmap__consume(md, false);
+				perf_mmap__consume(md);
 			}
 			perf_mmap__read_done(md);
 		}
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index e6320e267ba5..b58297b9a83d 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -114,7 +114,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		total_periods += sample.period;
 		nr_samples++;
 next_event:
-		perf_mmap__consume(md, false);
+		perf_mmap__consume(md);
 	}
 	perf_mmap__read_done(md);
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 10c4dcdc2324..dbf9e20f7d56 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -270,7 +270,7 @@ static int process_events(struct perf_evlist *evlist,
 		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			cnt += 1;
 			ret = add_event(evlist, &events, event);
-			 perf_mmap__consume(md, false);
+			 perf_mmap__consume(md);
 			if (ret < 0)
 				goto out_free_nodes;
 		}
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 02b0888b72a3..5aa2e68e9d05 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -120,7 +120,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
-		perf_mmap__consume(md, false);
+		perf_mmap__consume(md);
 	}
 	perf_mmap__read_done(md);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8a2dac90056c..62312e06d75b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -118,7 +118,7 @@ void perf_mmap__put(struct perf_mmap *map)
 		perf_mmap__munmap(map);
 }
 
-void perf_mmap__consume(struct perf_mmap *map, bool overwrite __maybe_unused)
+void perf_mmap__consume(struct perf_mmap *map)
 {
 	if (!map->overwrite) {
 		u64 old = map->prev;
@@ -260,7 +260,7 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->prev = head;
-			perf_mmap__consume(md, overwrite);
+			perf_mmap__consume(md);
 			return -EAGAIN;
 		}
 
@@ -314,7 +314,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	}
 
 	md->prev = head;
-	perf_mmap__consume(md, md->overwrite);
+	perf_mmap__consume(md);
 out:
 	return rc;
 }
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 65f5b26d8668..043916a20de6 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -66,7 +66,7 @@ void perf_mmap__munmap(struct perf_mmap *map);
 void perf_mmap__get(struct perf_mmap *map);
 void perf_mmap__put(struct perf_mmap *map);
 
-void perf_mmap__consume(struct perf_mmap *map, bool overwrite);
+void perf_mmap__consume(struct perf_mmap *map);
 
 static inline u64 perf_mmap__read_head(struct perf_mmap *mm)
 {
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 35fb5ef7d290..ca077f8be1f0 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1013,7 +1013,7 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
 		err = perf_evsel__parse_sample(evsel, event, &pevent->sample);
 
 		/* Consume the even only after we parsed it out. */
-		perf_mmap__consume(md, false);
+		perf_mmap__consume(md);
 
 		if (err)
 			return PyErr_Format(PyExc_OSError,
-- 
2.14.3
