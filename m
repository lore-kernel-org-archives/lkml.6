Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbeBLUcr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 15:32:47 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37790 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753871AbeBLUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 15:32:43 -0500
X-Google-Smtp-Source: AH8x2260Lj93zJdwhcj7ktSs1SeotSX4Mdjlw+7EY0EM3KMTwLqyVQpz35uMHdSVyWVpyEJ3aDpjyg==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        yao.jin@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf util: Use target->per_thread and target->system_wide flags
Date: Mon, 12 Feb 2018 13:32:36 -0700
Message-Id: <1518467557-18505-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Mathieu Poirier reports issue in commit ("73c0ca1eee3d perf thread_map:
Enumerate all threads from /proc") that it has negative impact on
'perf record --per-thread'. It has the effect of creating a kernel event
for each thread in the system for 'perf record --per-thread'.

Mathieu Poirier's patch ("perf util: Do not reuse target->per_thread flag")
can fix this issue by creating a new target->all_threads flag.

This patch is based on Mathieu Poirier's patch but it doesn't use a new
target->all_threads flag. This patch just uses 'target->per_thread &&
target->system_wide' as a condition to check for all threads case.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
[Fixed checkpatch warning about line over 80 characters]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/evlist.c     | 21 ++++++++++++++++++++-
 tools/perf/util/thread_map.c |  4 ++--
 tools/perf/util/thread_map.h |  2 +-
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e5fc14e53c05..7b7d535396f7 100644
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
index 3e1038f6491c..729dad8f412d 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -323,7 +323,7 @@ struct thread_map *thread_map__new_by_tid_str(const char *tid_str)
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
index 0a806b99e73c..5ec91cfd1869 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -31,7 +31,7 @@ struct thread_map *thread_map__get(struct thread_map *map);
 void thread_map__put(struct thread_map *map);
 
 struct thread_map *thread_map__new_str(const char *pid,
-		const char *tid, uid_t uid, bool per_thread);
+		const char *tid, uid_t uid, bool all_threads);
 
 struct thread_map *thread_map__new_by_tid_str(const char *tid_str);
 
-- 
2.7.4
