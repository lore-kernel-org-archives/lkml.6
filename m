Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeCETM0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:12:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:29166 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeCETMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:12:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="23109053"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/7] perf mmap: Store mmap scope and type in struct perf_mmap
Date: Mon,  5 Mar 2018 14:10:53 -0500
Message-Id: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There are too many boilerplates for the perf_mmap__read*() interfaces.

Some of the data (e.g. 'start', 'end', 'overwrite') should be stored in
struct perf_mmap at initialization. They will be used later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/mmap.c | 11 ++++++++---
 tools/perf/util/mmap.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4f27c46..642b479 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -250,11 +250,14 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 
 	*startp = overwrite ? head : old;
 	*endp = overwrite ? old : head;
+	md->overwrite = overwrite;
+	md->start = overwrite ? head : old;
+	md->end = overwrite ? old : head;
 
-	if (*startp == *endp)
+	if (md->start == md->end)
 		return -EAGAIN;
 
-	size = *endp - *startp;
+	size = md->end - md->start;
 	if (size > (unsigned long)(md->mask) + 1) {
 		if (!overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
@@ -268,8 +271,10 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (overwrite_rb_find_range(data, md->mask, head, startp, endp))
+		if (overwrite_rb_find_range(data, md->mask, head, &md->start, &md->end))
 			return -EINVAL;
+		*startp = md->start;
+		*endp = md->end;
 	}
 
 	return 0;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index ec7d3a24..9359e93 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -20,6 +20,9 @@ struct perf_mmap {
 	int		 fd;
 	refcount_t	 refcnt;
 	u64		 prev;
+	u64		 start;
+	u64		 end;
+	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
-- 
2.4.11
