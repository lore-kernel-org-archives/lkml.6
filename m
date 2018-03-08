Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeCHUCq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeCHTvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E3421795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/54] perf mmap: Use the stored data in perf_mmap__read_event()
Date: Thu,  8 Mar 2018 16:50:00 -0300
Message-Id: <20180308195029.14991-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Using the 'start', 'end' and 'overwrite' which are stored in
struct perf_mmap to replace the parameters of perf_mmap__read_event().
The parameters will be discarded later.

No functional change.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8c1d033638c2..2933942abfe2 100644
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
2.14.3
