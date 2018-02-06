Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeBFQ41 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752954AbeBFQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DA821738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/21] perf mmap: Introduce perf_mmap__read_event()
Date: Tue,  6 Feb 2018 13:53:38 -0300
Message-Id: <20180206165350.2570-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Except for 'perf record', the other perf tools read events one by one
from the ring buffer using perf_mmap__read_forward(). But it only
supports non-overwrite mode.

Introduce perf_mmap__read_event() to support both non-overwrite and
overwrite mode.

Usage:
perf_mmap__read_init()
while(event = perf_mmap__read_event()) {
        //process the event
        perf_mmap__consume()
}
perf_mmap__read_done()

It cannot use perf_mmap__read_backward(). Because it always reads the
stale buffer which is already processed. Furthermore, the forward and
backward concepts have been removed. The perf_mmap__read_backward() will
be replaced and discarded later.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-9-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 39 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mmap.h |  4 ++++
 2 files changed, 43 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4f59eaefc706..f804926778b7 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -113,6 +113,45 @@ union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
 	return perf_mmap__read(map, &map->prev, end);
 }
 
+/*
+ * Read event from ring buffer one by one.
+ * Return one event for each call.
+ *
+ * Usage:
+ * perf_mmap__read_init()
+ * while(event = perf_mmap__read_event()) {
+ *	//process the event
+ *	perf_mmap__consume()
+ * }
+ * perf_mmap__read_done()
+ */
+union perf_event *perf_mmap__read_event(struct perf_mmap *map,
+					bool overwrite,
+					u64 *startp, u64 end)
+{
+	union perf_event *event;
+
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return NULL;
+
+	if (startp == NULL)
+		return NULL;
+
+	/* non-overwirte doesn't pause the ringbuffer */
+	if (!overwrite)
+		end = perf_mmap__read_head(map);
+
+	event = perf_mmap__read(map, startp, end);
+
+	if (!overwrite)
+		map->prev = *startp;
+
+	return event;
+}
+
 void perf_mmap__read_catchup(struct perf_mmap *map)
 {
 	u64 head;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 95549d4af943..28718543dd42 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -89,6 +89,10 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 union perf_event *perf_mmap__read_backward(struct perf_mmap *map);
 
+union perf_event *perf_mmap__read_event(struct perf_mmap *map,
+					bool overwrite,
+					u64 *startp, u64 end);
+
 int perf_mmap__push(struct perf_mmap *md, bool backward,
 		    void *to, int push(void *to, void *buf, size_t size));
 
-- 
2.14.3
