Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeCFGxH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:53:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbeCFGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:53:05 -0500
Date: Mon, 5 Mar 2018 22:52:56 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-6afad54d2f0ddebacfcf3b829147d7fed8dab298@git.kernel.org>
Cc: mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
        kan.liang@linux.intel.com, namhyung@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, wangnan0@huawei.com,
        acme@redhat.com, kan.liang@linux.intel.com, ak@linux.intel.com,
        tglx@linutronix.de
In-Reply-To: <1519945751-37786-14-git-send-email-kan.liang@linux.intel.com>
References: <1519945751-37786-14-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Discard legacy interfaces for mmap read
 forward
Git-Commit-ID: 6afad54d2f0ddebacfcf3b829147d7fed8dab298
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

Commit-ID:  6afad54d2f0ddebacfcf3b829147d7fed8dab298
Gitweb:     https://git.kernel.org/tip/6afad54d2f0ddebacfcf3b829147d7fed8dab298
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 18:09:11 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 10:51:10 -0300

perf mmap: Discard legacy interfaces for mmap read forward

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
