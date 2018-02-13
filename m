Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935236AbeBMMRw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:17:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38923 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934951AbeBMMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:17:50 -0500
Date: Tue, 13 Feb 2018 04:07:27 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-7257bb0efc6ab4b3a16e1c5154f70d30551e3a7b@git.kernel.org>
Cc: hpa@zytor.com, kan.liang@intel.com, tglx@linutronix.de,
        peterz@infradead.org, wangnan0@huawei.com, jolsa@kernel.org,
        acme@redhat.com, yao.jin@linux.intel.com, namhyung@kernel.org,
        mingo@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, kan.liang@intel.com,
        jolsa@kernel.org, acme@redhat.com, wangnan0@huawei.com,
        peterz@infradead.org, yao.jin@linux.intel.com, namhyung@kernel.org,
        ak@linux.intel.com, mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1516310792-208685-9-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-9-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Introduce perf_mmap__read_event()
Git-Commit-ID: 7257bb0efc6ab4b3a16e1c5154f70d30551e3a7b
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

Commit-ID:  7257bb0efc6ab4b3a16e1c5154f70d30551e3a7b
Gitweb:     https://git.kernel.org/tip/7257bb0efc6ab4b3a16e1c5154f70d30551e3a7b
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:23 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:50 -0300

perf mmap: Introduce perf_mmap__read_event()

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
index 4f59eae..f804926 100644
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
index 95549d4..2871854 100644
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
 
