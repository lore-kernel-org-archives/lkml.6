Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753919AbeCFPjQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:39:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:53171 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeCFPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:37:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="209264473"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 4/8] perf mmap: Using the stored data in perf_mmap__read_event
Date: Tue,  6 Mar 2018 10:36:03 -0500
Message-Id: <1520350567-80082-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Using the 'start', 'end' and 'overwrite' which are stored in
struct perf_mmap to replace the parameters of perf_mmap__read_event().
The parameters will be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
 - Remove old startp/overwrite/end.

 tools/perf/util/mmap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8c1d033..2933942 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -76,8 +76,9 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
  * perf_mmap__read_done()
  */
 union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite,
-					u64 *startp, u64 end)
+					bool overwrite __maybe_unused,
+					u64 *startp __maybe_unused,
+					u64 end __maybe_unused)
 {
 	union perf_event *event;
 
@@ -87,17 +88,14 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 	if (!refcount_read(&map->refcnt))
 		return NULL;
 
-	if (startp == NULL)
-		return NULL;
-
 	/* non-overwirte doesn't pause the ringbuffer */
-	if (!overwrite)
-		end = perf_mmap__read_head(map);
+	if (!map->overwrite)
+		map->end = perf_mmap__read_head(map);
 
-	event = perf_mmap__read(map, startp, end);
+	event = perf_mmap__read(map, &map->start, map->end);
 
-	if (!overwrite)
-		map->prev = *startp;
+	if (!map->overwrite)
+		map->prev = map->start;
 
 	return event;
 }
-- 
2.4.11
