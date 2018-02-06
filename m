Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeBFQ4w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeBFQyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44ADE21788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/21] perf mmap: Discard legacy interface for mmap read
Date: Tue,  6 Feb 2018 13:53:40 -0300
Message-Id: <20180206165350.2570-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Discards perf_mmap__read_backward() and perf_mmap__read_catchup(). No
tools use them.

There are tools still use perf_mmap__read_forward(). Keep it, but add
comments to point to the new interface for future use.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-11-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 50 ++++----------------------------------------------
 tools/perf/util/mmap.h |  3 ---
 2 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index f804926778b7..91531a7c8fbf 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -63,6 +63,10 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 	return event;
 }
 
+/*
+ * legacy interface for mmap read.
+ * Don't use it. Use perf_mmap__read_event().
+ */
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 {
 	u64 head;
@@ -78,41 +82,6 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 	return perf_mmap__read(map, &map->prev, head);
 }
 
-union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
-{
-	u64 head, end;
-
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->refcnt))
-		return NULL;
-
-	head = perf_mmap__read_head(map);
-	if (!head)
-		return NULL;
-
-	/*
-	 * 'head' pointer starts from 0. Kernel minus sizeof(record) form
-	 * it each time when kernel writes to it, so in fact 'head' is
-	 * negative. 'end' pointer is made manually by adding the size of
-	 * the ring buffer to 'head' pointer, means the validate data can
-	 * read is the whole ring buffer. If 'end' is positive, the ring
-	 * buffer has not fully filled, so we must adjust 'end' to 0.
-	 *
-	 * However, since both 'head' and 'end' is unsigned, we can't
-	 * simply compare 'end' against 0. Here we compare '-head' and
-	 * the size of the ring buffer, where -head is the number of bytes
-	 * kernel write to the ring buffer.
-	 */
-	if (-head < (u64)(map->mask + 1))
-		end = 0;
-	else
-		end = head + map->mask + 1;
-
-	return perf_mmap__read(map, &map->prev, end);
-}
-
 /*
  * Read event from ring buffer one by one.
  * Return one event for each call.
@@ -152,17 +121,6 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 	return event;
 }
 
-void perf_mmap__read_catchup(struct perf_mmap *map)
-{
-	u64 head;
-
-	if (!refcount_read(&map->refcnt))
-		return;
-
-	head = perf_mmap__read_head(map);
-	map->prev = head;
-}
-
 static bool perf_mmap__empty(struct perf_mmap *map)
 {
 	return perf_mmap__read_head(map) == map->prev && !map->auxtrace_mmap.base;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 28718543dd42..ec7d3a24e276 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -65,8 +65,6 @@ void perf_mmap__put(struct perf_mmap *map);
 
 void perf_mmap__consume(struct perf_mmap *map, bool overwrite);
 
-void perf_mmap__read_catchup(struct perf_mmap *md);
-
 static inline u64 perf_mmap__read_head(struct perf_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->base;
@@ -87,7 +85,6 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 }
 
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
-union perf_event *perf_mmap__read_backward(struct perf_mmap *map);
 
 union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 					bool overwrite,
-- 
2.14.3
