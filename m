Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeCFPhi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:37:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:53171 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753800AbeCFPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:37:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="209264467"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/8] perf mmap: Store mmap scope in struct perf_mmap
Date: Tue,  6 Mar 2018 10:36:01 -0500
Message-Id: <1520350567-80082-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There are too many boilerplates for the perf_mmap__read*() interfaces.

The 'start' and 'end' should be stored in struct perf_mmap at
initialization. They will be used later.

The old 'startp' and 'endp' are used by perf_mmap__read_event() now.
They cannot be removed. So the old 'startp/endp' and new
'md->start/md->end' will exist simultaneously now.
The old one will be removed later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
 - Using the 'overwrite' which set in previous patch
 - Add the reason of keeping old starp/end in the change log

 tools/perf/util/mmap.c | 12 ++++++++----
 tools/perf/util/mmap.h |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4f27c46..09acaf7 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -250,13 +250,15 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 
 	*startp = overwrite ? head : old;
 	*endp = overwrite ? old : head;
+	md->start = md->overwrite ? head : old;
+	md->end = md->overwrite ? old : head;
 
-	if (*startp == *endp)
+	if (md->start == md->end)
 		return -EAGAIN;
 
-	size = *endp - *startp;
+	size = md->end - md->start;
 	if (size > (unsigned long)(md->mask) + 1) {
-		if (!overwrite) {
+		if (!md->overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->prev = head;
@@ -268,8 +270,10 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
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
index 7113797..9359e93 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -20,6 +20,8 @@ struct perf_mmap {
 	int		 fd;
 	refcount_t	 refcnt;
 	u64		 prev;
+	u64		 start;
+	u64		 end;
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
-- 
2.4.11
