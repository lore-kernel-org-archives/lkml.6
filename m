Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeBPJtj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:49:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeBPJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:49:38 -0500
Date: Fri, 16 Feb 2018 01:38:15 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-600a7cfe88de2c6e44e23d61dd721b996b790eb2@git.kernel.org>
Cc: namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        ak@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        yao.jin@linux.intel.com, kan.liang@intel.com, wangnan0@huawei.com
Reply-To: tglx@linutronix.de, yao.jin@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com, kan.liang@intel.com,
        mingo@kernel.org, namhyung@kernel.org, acme@redhat.com,
        ak@linux.intel.com, peterz@infradead.org, hpa@zytor.com
In-Reply-To: <1516310792-208685-10-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-10-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test: Update mmap read functions for
 backward-ring-buffer test
Git-Commit-ID: 600a7cfe88de2c6e44e23d61dd721b996b790eb2
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

Commit-ID:  600a7cfe88de2c6e44e23d61dd721b996b790eb2
Gitweb:     https://git.kernel.org/tip/600a7cfe88de2c6e44e23d61dd721b996b790eb2
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:24 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:54:08 -0300

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
