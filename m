Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeBPJvd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:51:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932677AbeBPJvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:51:31 -0500
Date: Fri, 16 Feb 2018 01:36:49 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-b4b036b4c76341a5034e872aca3727c4988a7304@git.kernel.org>
Cc: tglx@linutronix.de, hpa@zytor.com, ak@linux.intel.com,
        kan.liang@intel.com, jolsa@kernel.org, mingo@kernel.org,
        acme@redhat.com, wangnan0@huawei.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        yao.jin@linux.intel.com
Reply-To: tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        jolsa@kernel.org, kan.liang@intel.com, ak@linux.intel.com,
        hpa@zytor.com, wangnan0@huawei.com, yao.jin@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org
In-Reply-To: <1516310792-208685-7-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-7-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Discard 'prev' in perf_mmap__read()
Git-Commit-ID: b4b036b4c76341a5034e872aca3727c4988a7304
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

Commit-ID:  b4b036b4c76341a5034e872aca3727c4988a7304
Gitweb:     https://git.kernel.org/tip/b4b036b4c76341a5034e872aca3727c4988a7304
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:21 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:53:06 -0300

perf mmap: Discard 'prev' in perf_mmap__read()

The 'start' and 'prev' variables are duplicates in perf_mmap__read().

Use 'map->prev' to replace 'start' in perf_mmap__read_*().

Suggested-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-7-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 38fa69d..125bfda 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -22,29 +22,27 @@ size_t perf_mmap__mmap_len(struct perf_mmap *map)
 
 /* When check_messup is true, 'end' must points to a good entry */
 static union perf_event *perf_mmap__read(struct perf_mmap *map,
-					 u64 start, u64 end, u64 *prev)
+					 u64 *startp, u64 end)
 {
 	unsigned char *data = map->base + page_size;
 	union perf_event *event = NULL;
-	int diff = end - start;
+	int diff = end - *startp;
 
 	if (diff >= (int)sizeof(event->header)) {
 		size_t size;
 
-		event = (union perf_event *)&data[start & map->mask];
+		event = (union perf_event *)&data[*startp & map->mask];
 		size = event->header.size;
 
-		if (size < sizeof(event->header) || diff < (int)size) {
-			event = NULL;
-			goto broken_event;
-		}
+		if (size < sizeof(event->header) || diff < (int)size)
+			return NULL;
 
 		/*
 		 * Event straddles the mmap boundary -- header should always
 		 * be inside due to u64 alignment of output.
 		 */
-		if ((start & map->mask) + size != ((start + size) & map->mask)) {
-			unsigned int offset = start;
+		if ((*startp & map->mask) + size != ((*startp + size) & map->mask)) {
+			unsigned int offset = *startp;
 			unsigned int len = min(sizeof(*event), size), cpy;
 			void *dst = map->event_copy;
 
@@ -59,20 +57,15 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 			event = (union perf_event *)map->event_copy;
 		}
 
-		start += size;
+		*startp += size;
 	}
 
-broken_event:
-	if (prev)
-		*prev = start;
-
 	return event;
 }
 
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 {
 	u64 head;
-	u64 old = map->prev;
 
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
@@ -82,13 +75,12 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 
 	head = perf_mmap__read_head(map);
 
-	return perf_mmap__read(map, old, head, &map->prev);
+	return perf_mmap__read(map, &map->prev, head);
 }
 
 union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
 {
 	u64 head, end;
-	u64 start = map->prev;
 
 	/*
 	 * Check if event was unmapped due to a POLLHUP/POLLERR.
@@ -118,7 +110,7 @@ union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
 	else
 		end = head + map->mask + 1;
 
-	return perf_mmap__read(map, start, end, &map->prev);
+	return perf_mmap__read(map, &map->prev, end);
 }
 
 void perf_mmap__read_catchup(struct perf_mmap *map)
