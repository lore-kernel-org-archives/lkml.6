Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeBFREU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:04:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752932AbeBFQy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89904217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/21] perf test: Update mmap read functions for backward-ring-buffer test
Date: Tue,  6 Feb 2018 13:53:39 -0300
Message-Id: <20180206165350.2570-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

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
index 4035d43523c3..e0b1b414d466 100644
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
-- 
2.14.3
