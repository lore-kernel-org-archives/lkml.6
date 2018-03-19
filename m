Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970636AbeCSTEx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 15:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970679AbeCSTCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 15:02:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FCD217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/14] perf mmap: Discard head in overwrite_rb_find_range()
Date: Mon, 19 Mar 2018 16:01:28 -0300
Message-Id: <20180319190136.7441-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180319190136.7441-1-acme@kernel.org>
References: <20180319190136.7441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yisheng Xie <xieyisheng1@huawei.com>

In overwrite mode, start will be set to head in perf_mmap__read_init().
Therefore, there is no need to set the start one more time in
overwrite_rb_find_range() and *start can be used as head instead of
passing head to overwrite_rb_find_range().

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520944274-37001-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 074c4fd3b67e..38ca3ffb9d61 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -199,19 +199,18 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 	return 0;
 }
 
-static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
+static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
 {
 	struct perf_event_header *pheader;
-	u64 evt_head = head;
+	u64 evt_head = *start;
 	int size = mask + 1;
 
-	pr_debug2("overwrite_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
-	pheader = (struct perf_event_header *)(buf + (head & mask));
-	*start = head;
+	pr_debug2("%s: buf=%p, start=%"PRIx64"\n", __func__, buf, *start);
+	pheader = (struct perf_event_header *)(buf + (*start & mask));
 	while (true) {
-		if (evt_head - head >= (unsigned int)size) {
+		if (evt_head - *start >= (unsigned int)size) {
 			pr_debug("Finished reading overwrite ring buffer: rewind\n");
-			if (evt_head - head > (unsigned int)size)
+			if (evt_head - *start > (unsigned int)size)
 				evt_head -= pheader->size;
 			*end = evt_head;
 			return 0;
@@ -262,7 +261,7 @@ int perf_mmap__read_init(struct perf_mmap *md)
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
+		if (overwrite_rb_find_range(data, md->mask, &md->start, &md->end))
 			return -EINVAL;
 	}
 
-- 
2.14.3
