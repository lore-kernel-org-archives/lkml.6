Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935170AbeBMMQJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:16:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934898AbeBMMQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:16:07 -0500
Date: Tue, 13 Feb 2018 04:05:40 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-701b3ef37c0a4a5168bc07cfd48b35727b5a922c@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org,
        jolsa@kernel.org, ak@linux.intel.com, wangnan0@huawei.com,
        kan.liang@intel.com, peterz@infradead.org, acme@redhat.com,
        yao.jin@linux.intel.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        yao.jin@linux.intel.com, acme@redhat.com, wangnan0@huawei.com,
        kan.liang@intel.com, namhyung@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, jolsa@kernel.org
In-Reply-To: <1516310792-208685-5-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-5-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Introduce perf_mmap__read_init()
Git-Commit-ID: 701b3ef37c0a4a5168bc07cfd48b35727b5a922c
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

Commit-ID:  701b3ef37c0a4a5168bc07cfd48b35727b5a922c
Gitweb:     https://git.kernel.org/tip/701b3ef37c0a4a5168bc07cfd48b35727b5a922c
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:19 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:49 -0300

perf mmap: Introduce perf_mmap__read_init()

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
index fbbbe87..c19a4e6 100644
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
index e43d7b5..9ab2b48 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -94,4 +94,6 @@ int perf_mmap__push(struct perf_mmap *md, bool backward,
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
+int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
+			 u64 *startp, u64 *endp);
 #endif /*__PERF_MMAP_H */
