Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162996AbeCAXKu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:10:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:30247 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162854AbeCAXKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:10:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208165087"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 14/14] perf tools: Discard legacy interfaces for mmap read forward
Date: Thu,  1 Mar 2018 18:09:11 -0500
Message-Id: <1519945751-37786-14-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Discards legacy interfaces perf_evlist__mmap_read_forward(),
perf_evlist__mmap_read() and perf_evlist__mmap_consume().

No tools use them.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 25 +------------------------
 tools/perf/util/evlist.h |  4 ----
 tools/perf/util/mmap.c   | 21 +--------------------
 3 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7b7d535..41a4666 100644
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
index 336b838..6c41b2f 100644
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
index 91531a7..4f27c46 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -64,25 +64,6 @@ static union perf_event *perf_mmap__read(struct perf_mmap *map,
 }
 
 /*
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
-/*
  * Read event from ring buffer one by one.
  * Return one event for each call.
  *
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
2.4.11
