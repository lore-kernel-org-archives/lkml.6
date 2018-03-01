Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162981AbeCAXKW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:10:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162810AbeCAXKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:10:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208165079"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 13/14] perf test: Apply new perf_mmap__read_event() interface for task-exit
Date: Thu,  1 Mar 2018 18:09:10 -0500
Message-Id: <1519945751-37786-13-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'task-exit' still use the legacy interface.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/task-exit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 01b62b8..20884bc 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -47,6 +47,8 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	char sbuf[STRERR_BUFSIZE];
 	struct cpu_map *cpus;
 	struct thread_map *threads;
+	struct perf_mmap *md;
+	u64 end, start;
 
 	signal(SIGCHLD, sig_handler);
 
@@ -110,13 +112,19 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	perf_evlist__start_workload(evlist);
 
 retry:
-	while ((event = perf_evlist__mmap_read(evlist, 0)) != NULL) {
+	md = &evlist->mmap[0];
+	if (perf_mmap__read_init(md, 0, &start, &end) < 0)
+		goto out_init;
+
+	while ((event = perf_mmap__read_event(md, 0, &start, end)) != NULL) {
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
-		perf_evlist__mmap_consume(evlist, 0);
+		perf_mmap__consume(md, 0);
 	}
+	perf_mmap__read_done(md);
 
+out_init:
 	if (!exited || !nr_exit) {
 		perf_evlist__poll(evlist, -1);
 		goto retry;
-- 
2.4.11
