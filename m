Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935252AbeBMMSp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:18:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934918AbeBMMSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:18:41 -0500
Date: Tue, 13 Feb 2018 04:08:18 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-b47160428c794efb32aa6ad6aac323ad79b1e834@git.kernel.org>
Cc: jolsa@kernel.org, wangnan0@huawei.com, namhyung@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, kan.liang@intel.com,
        acme@redhat.com, peterz@infradead.org, mingo@kernel.org, hpa@zytor.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, yao.jin@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, acme@redhat.com,
        kan.liang@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org, wangnan0@huawei.com
In-Reply-To: <1516310792-208685-11-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-11-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Discard legacy interface for mmap read
Git-Commit-ID: b47160428c794efb32aa6ad6aac323ad79b1e834
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

Commit-ID:  b47160428c794efb32aa6ad6aac323ad79b1e834
Gitweb:     https://git.kernel.org/tip/b47160428c794efb32aa6ad6aac323ad79b1e834
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:25 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:50 -0300

perf mmap: Discard legacy interface for mmap read

Discards perf_mmap__read_backward() and perf_mmap__read_catchup(). No
tools use them.

There are tools still use perf_mmap__read_forward(). Keep it, but add
comments to point to the new interface for future use.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-11-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 50 ++++----------------------------------------------
 tools/perf/util/mmap.h |  3 ---
 2 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index f804926..91531a7 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -63,6 +63,10 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 	return event;
 }
 
+/*
+ * legacy interface for mmap read.
+ * Don't use it. Use perf_mmap__read_event().
+ */
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 {
 	u64 head;
@@ -78,41 +82,6 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
 	return perf_mmap__read(map, &map->prev, head);
 }
 
-union perf_event *perf_mmap__read_backward(struct perf_mmap *map)
-{
-	u64 head, end;
-
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->refcnt))
-		return NULL;
-
-	head = perf_mmap__read_head(map);
-	if (!head)
-		return NULL;
-
-	/*
-	 * 'head' pointer starts from 0. Kernel minus sizeof(record) form
-	 * it each time when kernel writes to it, so in fact 'head' is
-	 * negative. 'end' pointer is made manually by adding the size of
-	 * the ring buffer to 'head' pointer, means the validate data can
-	 * read is the whole ring buffer. If 'end' is positive, the ring
-	 * buffer has not fully filled, so we must adjust 'end' to 0.
-	 *
-	 * However, since both 'head' and 'end' is unsigned, we can't
-	 * simply compare 'end' against 0. Here we compare '-head' and
-	 * the size of the ring buffer, where -head is the number of bytes
-	 * kernel write to the ring buffer.
-	 */
-	if (-head < (u64)(map->mask + 1))
-		end = 0;
-	else
-		end = head + map->mask + 1;
-
-	return perf_mmap__read(map, &map->prev, end);
-}
-
 /*
  * Read event from ring buffer one by one.
  * Return one event for each call.
@@ -152,17 +121,6 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 	return event;
 }
 
-void perf_mmap__read_catchup(struct perf_mmap *map)
-{
-	u64 head;
-
-	if (!refcount_read(&map->refcnt))
-		return;
-
-	head = perf_mmap__read_head(map);
-	map->prev = head;
-}
-
 static bool perf_mmap__empty(struct perf_mmap *map)
 {
 	return perf_mmap__read_head(map) == map->prev && !map->auxtrace_mmap.base;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 2871854..ec7d3a24 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -65,8 +65,6 @@ void perf_mmap__put(struct perf_mmap *map);
 
 void perf_mmap__consume(struct perf_mmap *map, bool overwrite);
 
-void perf_mmap__read_catchup(struct perf_mmap *md);
-
 static inline u64 perf_mmap__read_head(struct perf_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->base;
@@ -87,7 +85,6 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 }
 
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
-union perf_event *perf_mmap__read_backward(struct perf_mmap *map);
 
 union perf_event *perf_mmap__read_event(struct perf_mmap *map,
 					bool overwrite,
