Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeBFQ4A (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:56:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeBFQyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5874F217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/21] perf mmap: Introduce perf_mmap__read_init()
Date: Tue,  6 Feb 2018 13:53:34 -0300
Message-Id: <20180206165350.2570-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

The new function perf_mmap__read_init() is factored out from
perf_mmap__push().

It is to calculate the 'start' and 'end' of the available data in
ringbuffer.

No functional change.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-5-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 37 +++++++++++++++++++++++++++----------
 tools/perf/util/mmap.h |  2 ++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index fbbbe87f0308..c19a4e640e8e 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -267,24 +267,24 @@ static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u6
 	return -1;
 }
 
-int perf_mmap__push(struct perf_mmap *md, bool overwrite,
-		    void *to, int push(void *to, void *buf, size_t size))
+/*
+ * Report the start and end of the available data in ringbuffer
+ */
+int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
+			 u64 *startp, u64 *endp)
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
-	u64 end, start;
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
-	void *buf;
-	int rc = 0;
 
-	start = overwrite ? head : old;
-	end = overwrite ? old : head;
+	*startp = overwrite ? head : old;
+	*endp = overwrite ? old : head;
 
-	if (start == end)
+	if (*startp == *endp)
 		return 0;
 
-	size = end - start;
+	size = *endp - *startp;
 	if (size > (unsigned long)(md->mask) + 1) {
 		if (!overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
@@ -298,10 +298,27 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->mask, head, &start, &end))
+		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
 			return -1;
 	}
 
+	return 1;
+}
+
+int perf_mmap__push(struct perf_mmap *md, bool overwrite,
+		    void *to, int push(void *to, void *buf, size_t size))
+{
+	u64 head = perf_mmap__read_head(md);
+	u64 end, start;
+	unsigned char *data = md->base + page_size;
+	unsigned long size;
+	void *buf;
+	int rc = 0;
+
+	rc = perf_mmap__read_init(md, overwrite, &start, &end);
+	if (rc < 1)
+		return rc;
+
 	size = end - start;
 
 	if ((start & md->mask) + size != (end & md->mask)) {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e43d7b55a55f..9ab2b48df65b 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -94,4 +94,6 @@ int perf_mmap__push(struct perf_mmap *md, bool backward,
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
+int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
+			 u64 *startp, u64 *endp);
 #endif /*__PERF_MMAP_H */
-- 
2.14.3
