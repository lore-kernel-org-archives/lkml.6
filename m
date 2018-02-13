Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935172AbeBMMSQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:18:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934947AbeBMMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:18:14 -0500
Date: Tue, 13 Feb 2018 04:07:52 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-fe00d73152ed18080ea895bc84c495d3bca71019@git.kernel.org>
Cc: kan.liang@intel.com, peterz@infradead.org, tglx@linutronix.de,
        jolsa@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        mingo@kernel.org, wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, hpa@zytor.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
        peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
        kan.liang@intel.com, yao.jin@linux.intel.com, ak@linux.intel.com,
        mingo@kernel.org
In-Reply-To: <1516310792-208685-10-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-10-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test: Update mmap read functions for
 backward-ring-buffer test
Git-Commit-ID: fe00d73152ed18080ea895bc84c495d3bca71019
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

Commit-ID:  fe00d73152ed18080ea895bc84c495d3bca71019
Gitweb:     https://git.kernel.org/tip/fe00d73152ed18080ea895bc84c495d3bca71019
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:24 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:50 -0300

perf test: Update mmap read functions for backward-ring-buffer test

Use the new perf_mmap__read_* interfaces for overwrite ringbuffer test.

Commiter notes:

Testing:

  [root@seventh ~]# perf test -v backward
  48: Read backward ring buffer                             :
  --- start ---
  test child forked, pid 8309
  Using CPUID GenuineIntel-6-9E
  mmap size 1052672B
  mmap size 8192B
  Finished reading overwrite ring buffer: rewind
  test child finished with 0
  ---- end ----
  Read backward ring buffer: Ok
  [root@seventh ~]#

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-10-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/backward-ring-buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 4035d43..e0b1b41 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -31,10 +31,12 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 	int i;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &evlist->overwrite_mmap[i];
 		union perf_event *event;
+		u64 start, end;
 
-		perf_mmap__read_catchup(&evlist->overwrite_mmap[i]);
-		while ((event = perf_mmap__read_backward(&evlist->overwrite_mmap[i])) != NULL) {
+		perf_mmap__read_init(map, true, &start, &end);
+		while ((event = perf_mmap__read_event(map, true, &start, end)) != NULL) {
 			const u32 type = event->header.type;
 
 			switch (type) {
@@ -49,6 +51,7 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 				return TEST_FAIL;
 			}
 		}
+		perf_mmap__read_done(map);
 	}
 	return TEST_OK;
 }
