Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753854AbeCFPhg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:37:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:53171 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753802AbeCFPhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:37:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="209264470"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/8] perf mmap: Using the stored scope data in perf_mmap__push
Date: Tue,  6 Mar 2018 10:36:02 -0500
Message-Id: <1520350567-80082-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Using the 'start' and 'end' which are stored in struct perf_mmap to
replace the temporary 'start' and 'end'.
The temporary variables will be discarded later.

It doesn't need to pass 'overwrite' to perf_mmap__push(). It's stored in
struct perf_mmap.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
 - Remove the 'overwrite' parameter from perf_mmap__push(). 

 tools/perf/builtin-record.c |  2 +-
 tools/perf/util/mmap.c      | 24 ++++++++++++------------
 tools/perf/util/mmap.h      |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 12230dd..9290742 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -510,7 +510,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], overwrite, rec, record__pushfn) != 0) {
+			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 09acaf7..8c1d033 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -279,8 +279,8 @@ int perf_mmap__read_init(struct perf_mmap *md, bool overwrite,
 	return 0;
 }
 
-int perf_mmap__push(struct perf_mmap *md, bool overwrite,
-		    void *to, int push(void *to, void *buf, size_t size))
+int perf_mmap__push(struct perf_mmap *md, void *to,
+		    int push(void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 end, start;
@@ -289,16 +289,16 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 	void *buf;
 	int rc = 0;
 
-	rc = perf_mmap__read_init(md, overwrite, &start, &end);
+	rc = perf_mmap__read_init(md, md->overwrite, &start, &end);
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 0 : -1;
 
-	size = end - start;
+	size = md->end - md->start;
 
-	if ((start & md->mask) + size != (end & md->mask)) {
-		buf = &data[start & md->mask];
-		size = md->mask + 1 - (start & md->mask);
-		start += size;
+	if ((md->start & md->mask) + size != (md->end & md->mask)) {
+		buf = &data[md->start & md->mask];
+		size = md->mask + 1 - (md->start & md->mask);
+		md->start += size;
 
 		if (push(to, buf, size) < 0) {
 			rc = -1;
@@ -306,9 +306,9 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 		}
 	}
 
-	buf = &data[start & md->mask];
-	size = end - start;
-	start += size;
+	buf = &data[md->start & md->mask];
+	size = md->end - md->start;
+	md->start += size;
 
 	if (push(to, buf, size) < 0) {
 		rc = -1;
@@ -316,7 +316,7 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 	}
 
 	md->prev = head;
-	perf_mmap__consume(md, overwrite);
+	perf_mmap__consume(md, md->overwrite);
 out:
 	return rc;
 }
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9359e93..65f5b26 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -93,8 +93,8 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 					bool overwrite,
 					u64 *startp, u64 end);
 
-int perf_mmap__push(struct perf_mmap *md, bool backward,
-		    void *to, int push(void *to, void *buf, size_t size));
+int perf_mmap__push(struct perf_mmap *md, void *to,
+		    int push(void *to, void *buf, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
-- 
2.4.11
