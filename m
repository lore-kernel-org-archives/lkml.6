Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeCETNQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:13:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:47640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932314AbeCETMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:12:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="23109094"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/7] perf tools: Refine perf_mmap__consume
Date: Mon,  5 Mar 2018 14:10:57 -0500
Message-Id: <1520277059-32749-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It doesn't need to pass the 'overwrite' to perf_mmap__consume().
Discard the parameter.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
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
index 7f82d91..a9bc77d 100644
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
index d2703d3b..165c0446 100644
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
index bb4f9fa..11b4a41 100644
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
index 1a93deb..abc855d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2492,7 +2492,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 			trace__handle_event(trace, event, &sample);
 next_event:
-			perf_mmap__consume(md, false);
+			perf_mmap__consume(md);
 
 			if (interrupted)
 				goto out_disable;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 03ed8c7..f7c199a 100644
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
index 4590d8f..1f1db59 100644
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
index 44c58d6..f473e10 100644
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
index 620b210..7837ae9 100644
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
index 31f3f70..6ff5f99 100644
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
index e6320e2..b58297b 100644
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
index 10c4dcd..dbf9e20 100644
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
index 02b0888..5aa2e68 100644
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
index c4e41d2..a56c66b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -121,7 +121,7 @@ void perf_mmap__put(struct perf_mmap *map)
 		perf_mmap__munmap(map);
 }
 
-void perf_mmap__consume(struct perf_mmap *map, bool overwrite __maybe_unused)
+void perf_mmap__consume(struct perf_mmap *map)
 {
 	if (!map->overwrite) {
 		u64 old = map->prev;
@@ -264,7 +264,7 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->prev = head;
-			perf_mmap__consume(md, overwrite);
+			perf_mmap__consume(md);
 			return -EAGAIN;
 		}
 
@@ -318,7 +318,7 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 	}
 
 	md->prev = head;
-	perf_mmap__consume(md, overwrite);
+	perf_mmap__consume(md);
 out:
 	return rc;
 }
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9359e93..d098b47 100644
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
index 35fb5ef..ca077f8 100644
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
2.4.11
