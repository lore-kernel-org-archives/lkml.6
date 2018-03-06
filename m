Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeCFGwU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:52:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752800AbeCFGwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:52:18 -0500
Date: Mon, 5 Mar 2018 22:51:08 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-9dfb85dfaffe6bc38f0c9f8a8622e2a7ca333e58@git.kernel.org>
Cc: wangnan0@huawei.com, tglx@linutronix.de, mingo@kernel.org,
        kan.liang@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, jolsa@redhat.com, acme@redhat.com,
        namhyung@kernel.org
Reply-To: wangnan0@huawei.com, kan.liang@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, namhyung@kernel.org, acme@redhat.com, jolsa@redhat.com
In-Reply-To: <1519945751-37786-10-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-10-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Switch to new perf_mmap__read_event()
 interface for time-to-tsc
Git-Commit-ID: 9dfb85dfaffe6bc38f0c9f8a8622e2a7ca333e58
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

Commit-ID:  9dfb85dfaffe6bc38f0c9f8a8622e2a7ca333e58
Gitweb:     https://git.kernel.org/tip/9dfb85dfaffe6bc38f0c9f8a8622e2a7ca333e58
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:07 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:50:23 -0300

perf test: Switch to new perf_mmap__read_event() interface for time-to-tsc

The perf test 'time-to-tsc' still use the legacy interface.

No functional change.

Commiter notes:

Testing it:

  # perf test tsc
  57: Convert perf time to TSC                              : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-10-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 06abe8108b33..7f82d91ef473 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -60,6 +60,8 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	union perf_event *event;
 	u64 test_tsc, comm1_tsc, comm2_tsc;
 	u64 test_time, comm1_time = 0, comm2_time = 0;
+	struct perf_mmap *md;
+	u64 end, start;
 
 	threads = thread_map__new(-1, getpid(), UINT_MAX);
 	CHECK_NOT_NULL__(threads);
@@ -109,7 +111,11 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	perf_evlist__disable(evlist);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+		md = &evlist->mmap[i];
+		if (perf_mmap__read_init(md, false, &start, &end) < 0)
+			continue;
+
+		while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 			struct perf_sample sample;
 
 			if (event->header.type != PERF_RECORD_COMM ||
@@ -128,8 +134,9 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 				comm2_time = sample.time;
 			}
 next_event:
-			perf_evlist__mmap_consume(evlist, i);
+			perf_mmap__consume(md, false);
 		}
+		perf_mmap__read_done(md);
 	}
 
 	if (!comm1_time || !comm2_time)
