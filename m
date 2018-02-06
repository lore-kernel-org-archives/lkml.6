Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBFREm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbeBFQyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9522179F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/21] perf mmap: Discard 'prev' in perf_mmap__read()
Date: Tue,  6 Feb 2018 13:53:36 -0300
Message-Id: <20180206165350.2570-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

The 'start' and 'prev' variables are duplicates in perf_mmap__read().

Use 'map->prev' to replace 'start' in perf_mmap__read_*().

Suggested-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-7-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 38fa69dc635e..125bfda9d037 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -22,29 +22,27 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map)
 
 /* When check_messup is true, 'end' must points to a good entry */
 static union perf_event *perf_mmap__read(struct perf_mmap *map,
-					 u64 start, u64 end, u64 *prev)
+					 u64 *startp, u64 end)
 {
 	unsigned char *data = map->base + page_size;
 	union perf_event *event = NULL;
-	int diff = end - start;
+	int diff = end - *startp;
 
 	if (diff >= (int)sizeof(event->header)) {
 		size_t size;
 
-		event = (union perf_event *)&data[start & map->mask];
+		event = (union perf_event *)&data[*startp & map->mask];
 		size = event->header.size;
 
-		if (size < sizeof(event->header) || diff < (int)size) {
-			event = NULL;
-			goto broken_event;
-		}
+		if (size < sizeof(event->header) || diff < (int)size)
+			return NULL;
 
 		/*
 		 * Event straddles the mmap boundary -- header should always
 		 * be inside due to u64 alignment of output.
 		 */
-		if ((start & map->mask) + size != ((start + size) & map->mask)) {
-			unsigned int offset = start;
+		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
+			unsigned int offset = *startp;
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
@@ -59,20 +57,15 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 			event = (union perf_event *)map->event_copy;
 		}
 
-		start += size;
+		*startp += size;
 	}
 
-broken_event:
-	if (prev)
-		*prev = start;
-
 	return event;
 }
 
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 {
 	u64 head;
-	u64 old = map->prev;
 
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
@@ -82,13 +75,12 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 
 	head = perf_mmap__read_head(map);
 
-	return perf_mmap__read(map, old, head, &map->prev);
+	return perf_mmap__read(map, &map->prev, head);
 }
 
 union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
 {
 	u64 head, end;
-	u64 start = map->prev;
 
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
@@ -118,7 +110,7 @@ union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
 	else
 		end = head + map->mask + 1;
 
-	return perf_mmap__read(map, start, end, &map->prev);
+	return perf_mmap__read(map, &map->prev, end);
 }
 
 void perf_mmap__read_catchup(struct perf_mmap *map)
-- 
2.14.3
