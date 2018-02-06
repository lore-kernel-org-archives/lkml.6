Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeBFRFH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbeBFQyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA4721748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/21] perf evlist: Remove stale mmap read for backward
Date: Tue,  6 Feb 2018 13:53:31 -0300
Message-Id: <20180206165350.2570-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

perf_evlist__mmap_read_catchup() and perf_evlist__mmap_read_backward()
are only for overwrite mode.

But they read the evlist->mmap buffer which is for non-overwrite mode.

It did not bring any serious problem yet, because there is no one use
it.

Remove the unused interfaces.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Wang Nan <wangnan0@huawei.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1516310792-208685-2-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 17 -----------------
 tools/perf/util/evlist.h |  4 ----
 2 files changed, 21 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ac35cd214feb..e5fc14e53c05 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -715,28 +715,11 @@ union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist, int
 	return perf_mmap__read_forward(md);
 }
 
-union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist, int idx)
-{
-	struct perf_mmap *md = &evlist->mmap[idx];
-
-	/*
-	 * No need to check messup for backward ring buffer:
-	 * We can always read arbitrary long data from a backward
-	 * ring buffer unless we forget to pause it before reading.
-	 */
-	return perf_mmap__read_backward(md);
-}
-
 union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx)
 {
 	return perf_evlist__mmap_read_forward(evlist, idx);
 }
 
-void perf_evlist__mmap_read_catchup(struct perf_evlist *evlist, int idx)
-{
-	perf_mmap__read_catchup(&evlist->mmap[idx]);
-}
-
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx)
 {
 	perf_mmap__consume(&evlist->mmap[idx], false);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 75f8e0ad5d76..336b838e6957 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -133,10 +133,6 @@ union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx);
 
 union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist,
 						 int idx);
-union perf_event *perf_evlist__mmap_read_backward(struct perf_evlist *evlist,
-						  int idx);
-void perf_evlist__mmap_read_catchup(struct perf_evlist *evlist, int idx);
-
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx);
 
 int perf_evlist__open(struct perf_evlist *evlist);
-- 
2.14.3
