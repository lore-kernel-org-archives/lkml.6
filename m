Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeCFGwk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:52:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37855 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbeCFGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:52:38 -0500
Date: Mon, 5 Mar 2018 22:52:29 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-759487307625cd44ac4aa241ee547b52b72bc4ad@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, ak@linux.intel.com, acme@redhat.com,
        mingo@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com
Reply-To: ak@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, jolsa@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, wangnan0@huawei.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <1519945751-37786-13-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-13-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for task-exit
Git-Commit-ID: 759487307625cd44ac4aa241ee547b52b72bc4ad
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

Commit-ID:  759487307625cd44ac4aa241ee547b52b72bc4ad
Gitweb:     https://git.kernel.org/tip/759487307625cd44ac4aa241ee547b52b72bc4ad
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:10 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:51:00 -0300

perf test: Switch to new perf_mmap__read_event() interface for task-exit

The perf test 'task-exit' still use the legacy interface.

No functional change.

Committer notes:

Testing it:

  # perf test exit
  21: Number of exit events of a simple workload            : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-13-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/task-exit.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 01b62b81751b..02b0888b72a3 100644
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
+	if (perf_mmap__read_init(md, false, &start, &end) < 0)
+		goto out_init;
+
+	while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 		if (event->header.type == PERF_RECORD_EXIT)
 			nr_exit++;
 
-		perf_evlist__mmap_consume(evlist, 0);
+		perf_mmap__consume(md, false);
 	}
+	perf_mmap__read_done(md);
 
+out_init:
 	if (!exited || !nr_exit) {
 		perf_evlist__poll(evlist, -1);
 		goto retry;
