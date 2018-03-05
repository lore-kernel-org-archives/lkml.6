Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbeCEObv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:31:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbeCEObY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:31:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F74521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/28] perf mmap: Discard legacy interfaces for mmap read forward
Date: Mon,  5 Mar 2018 11:29:32 -0300
Message-Id: <20180305142932.16921-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Discards legacy interfaces perf_evlist__mmap_read_forward(),
perf_evlist__mmap_read() and perf_evlist__mmap_consume().

No tools use them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-14-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 25 +------------------------
 tools/perf/util/evlist.h |  4 ----
 tools/perf/util/mmap.c   | 21 +--------------------
 3 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7b7d535396f7..41a4666f1519 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -702,29 +702,6 @@ static int perf_evlist__resume(struct perf_evlist *evlist)
 	return perf_evlist__set_paused(evlist, false);
 }
 
-union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist, int idx)
-{
-	struct perf_mmap *md = &evlist->mmap[idx];
-
-	/*
-	 * Check messup is required for forward overwritable ring buffer:
-	 * memory pointed by md->prev can be overwritten in this case.
-	 * No need for read-write ring buffer: kernel stop outputting when
-	 * it hit md->prev (perf_mmap__consume()).
-	 */
-	return perf_mmap__read_forward(md);
-}
-
-union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx)
-{
-	return perf_evlist__mmap_read_forward(evlist, idx);
-}
-
-void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx)
-{
-	perf_mmap__consume(&evlist->mmap[idx], false);
-}
-
 static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
 {
 	int i;
@@ -761,7 +738,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist)
 		map[i].fd = -1;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
-		 * one extra to let perf_evlist__mmap_consume() get the last
+		 * one extra to let perf_mmap__consume() get the last
 		 * events after all real references (perf_mmap__get()) are
 		 * dropped.
 		 *
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 336b838e6957..6c41b2f78713 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -129,10 +129,6 @@ struct perf_sample_id *perf_evlist__id2sid(struct perf_evlist *evlist, u64 id);
 
 void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist, enum bkw_mmap_state state);
 
-union perf_event *perf_evlist__mmap_read(struct perf_evlist *evlist, int idx);
-
-union perf_event *perf_evlist__mmap_read_forward(struct perf_evlist *evlist,
-						 int idx);
 void perf_evlist__mmap_consume(struct perf_evlist *evlist, int idx);
 
 int perf_evlist__open(struct perf_evlist *evlist);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 91531a7c8fbf..4f27c464ce0b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -63,25 +63,6 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 	return event;
 }
 
-/*
- * legacy interface for mmap read.
- * Don't use it. Use perf_mmap__read_event().
- */
-union perf_event *perf_mmap__read_forward(struct perf_mmap *map)
-{
-	u64 head;
-
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->refcnt))
-		return NULL;
-
-	head = perf_mmap__read_head(map);
-
-	return perf_mmap__read(map, &map->prev, head);
-}
-
 /*
  * Read event from ring buffer one by one.
  * Return one event for each call.
@@ -191,7 +172,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 {
 	/*
-	 * The last one will be done at perf_evlist__mmap_consume(), so that we
+	 * The last one will be done at perf_mmap__consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
 	 * the ring buffer.
 	 *
-- 
2.14.3
