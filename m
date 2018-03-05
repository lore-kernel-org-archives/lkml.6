Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeCETNh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:13:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:47640 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753054AbeCETMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:12:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="23109080"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/7] perf mmap: Using the stored data in perf_mmap__read_event
Date: Mon,  5 Mar 2018 14:10:55 -0500
Message-Id: <1520277059-32749-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
References: <1520277059-32749-1-git-send-email-kan.liang@linux.intel.com>
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
 tools/perf/util/mmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 4cb3614..da9e68b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -76,8 +76,8 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
  * perf_mmap__read_done()
  */
 union perf_event *perf_mmap__read_event(struct perf_mmap *map,
-					bool overwrite,
-					u64 *startp, u64 end)
+					bool overwrite __maybe_unused,
+					u64 *startp, u64 end __maybe_unused)
 {
 	union perf_event *event;
 
@@ -91,13 +91,14 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 		return NULL;
 
 	/* non-overwirte doesn't pause the ringbuffer */
-	if (!overwrite)
-		end = perf_mmap__read_head(map);
+	if (!map->overwrite)
+		map->end = perf_mmap__read_head(map);
 
-	event = perf_mmap__read(map, startp, end);
+	event = perf_mmap__read(map, &map->start, map->end);
+	*startp = map->start;
 
-	if (!overwrite)
-		map->prev = *startp;
+	if (!map->overwrite)
+		map->prev = map->start;
 
 	return event;
 }
-- 
2.4.11
