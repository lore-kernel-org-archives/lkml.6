Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeBQLjr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:39:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbeBQLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:39:46 -0500
Date: Sat, 17 Feb 2018 03:29:26 -0800
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-147c508f3004df6e2958f6c8867909531c2a15e2@git.kernel.org>
Cc: yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com, hpa@zytor.com,
        mathieu.poirier@linaro.org, mingo@kernel.org, tglx@linutronix.de,
        acme@redhat.com, peterz@infradead.org
Reply-To: mingo@kernel.org, peterz@infradead.org, acme@redhat.com,
        tglx@linutronix.de, mathieu.poirier@linaro.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, yao.jin@linux.intel.com
In-Reply-To: <1518467557-18505-3-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use target->per_thread and
 target->system_wide flags
Git-Commit-ID: 147c508f3004df6e2958f6c8867909531c2a15e2
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

Commit-ID:  147c508f3004df6e2958f6c8867909531c2a15e2
Gitweb:     https://git.kernel.org/tip/147c508f3004df6e2958f6c8867909531c2a15e2
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 12 Feb 2018 13:32:36 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 14:55:40 -0300

perf tools: Use target->per_thread and target->system_wide flags

Mathieu Poirier reports issue in commit ("73c0ca1eee3d perf thread_map:
Enumerate all threads from /proc") that it has negative impact on 'perf
record --per-thread'. It has the effect of creating a kernel event for
each thread in the system for 'perf record --per-thread'.

Mathieu Poirier's patch ("perf util: Do not reuse target->per_thread flag")
can fix this issue by creating a new target->all_threads flag.

This patch is based on Mathieu Poirier's patch but it doesn't use a new
target->all_threads flag. This patch just uses 'target->per_thread &&
target->system_wide' as a condition to check for all threads case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: 73c0ca1eee3d ("perf thread_map: Enumerate all threads from /proc")
Link: http://lkml.kernel.org/r/1518467557-18505-3-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
[Fixed checkpatch warning about line over 80 characters]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c     | 21 ++++++++++++++++++++-
 tools/perf/util/thread_map.c |  4 ++--
 tools/perf/util/thread_map.h |  2 +-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e5fc14e..7b7d535 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1086,11 +1086,30 @@ int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
 {
+	bool all_threads = (target->per_thread && target->system_wide);
 	struct cpu_map *cpus;
 	struct thread_map *threads;
 
+	/*
+	 * If specify '-a' and '--per-thread' to perf record, perf record
+	 * will override '--per-thread'. target->per_thread = false and
+	 * target->system_wide = true.
+	 *
+	 * If specify '--per-thread' only to perf record,
+	 * target->per_thread = true and target->system_wide = false.
+	 *
+	 * So target->per_thread && target->system_wide is false.
+	 * For perf record, thread_map__new_str doesn't call
+	 * thread_map__new_all_cpus. That will keep perf record's
+	 * current behavior.
+	 *
+	 * For perf stat, it allows the case that target->per_thread and
+	 * target->system_wide are all true. It means to collect system-wide
+	 * per-thread data. thread_map__new_str will call
+	 * thread_map__new_all_cpus to enumerate all threads.
+	 */
 	threads = thread_map__new_str(target->pid, target->tid, target->uid,
-				      target->per_thread);
+				      all_threads);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 3e1038f..729dad8 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -323,7 +323,7 @@ out_free_threads:
 }
 
 struct thread_map *thread_map__new_str(const char *pid, const char *tid,
-				       uid_t uid, bool per_thread)
+				       uid_t uid, bool all_threads)
 {
 	if (pid)
 		return thread_map__new_by_pid_str(pid);
@@ -331,7 +331,7 @@ struct thread_map *thread_map__new_str(const char *pid, const char *tid,
 	if (!tid && uid != UINT_MAX)
 		return thread_map__new_by_uid(uid);
 
-	if (per_thread)
+	if (all_threads)
 		return thread_map__new_all_cpus();
 
 	return thread_map__new_by_tid_str(tid);
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 0a806b9..5ec91cf 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -31,7 +31,7 @@ struct thread_map *thread_map__get(struct thread_map *map);
 void thread_map__put(struct thread_map *map);
 
 struct thread_map *thread_map__new_str(const char *pid,
-		const char *tid, uid_t uid, bool per_thread);
+		const char *tid, uid_t uid, bool all_threads);
 
 struct thread_map *thread_map__new_by_tid_str(const char *tid_str);
 
