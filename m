Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753792AbeCFPhc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:37:32 -0500
Received: from mga02.intel.com ([134.134.136.20]:53171 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753590AbeCFPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="209264447"
From: kan.liang@linux.intel.com
To: acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: jolsa@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/8] perf evlist: Store 'overwrite' in struct perf_mmap
Date: Tue,  6 Mar 2018 10:36:00 -0500
Message-Id: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It has been determined that the map is for overwrite mode
(evlist->overwrite_mmap) or non-overwrite mode (evlist->mmap) when
calling perf_evlist__alloc_mmap().
Store the information in struct perf_mmap, which will be used later to
simpler the perf_mmap__read*() interfaces.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
 - New patch to store 'overwrite' in struct perf_mmap at allocation

 tools/perf/util/evlist.c | 8 +++++---
 tools/perf/util/mmap.h   | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 41a4666..a59281d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -722,7 +722,8 @@ void perf_evlist__munmap(struct perf_evlist *evlist)
 	zfree(&evlist->overwrite_mmap);
 }
 
-static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist)
+static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist,
+						 bool overwrite)
 {
 	int i;
 	struct perf_mmap *map;
@@ -736,6 +737,7 @@ static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist)
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		map[i].fd = -1;
+		map[i].overwrite = overwrite;
 		/*
 		 * When the perf_mmap() call is made we grab one refcount, plus
 		 * one extra to let perf_mmap__consume() get the last
@@ -779,7 +781,7 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 			maps = evlist->overwrite_mmap;
 
 			if (!maps) {
-				maps = perf_evlist__alloc_mmap(evlist);
+				maps = perf_evlist__alloc_mmap(evlist, true);
 				if (!maps)
 					return -1;
 				evlist->overwrite_mmap = maps;
@@ -1029,7 +1031,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	struct mmap_params mp;
 
 	if (!evlist->mmap)
-		evlist->mmap = perf_evlist__alloc_mmap(evlist);
+		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
 	if (!evlist->mmap)
 		return -ENOMEM;
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index ec7d3a24..7113797 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -20,6 +20,7 @@ struct perf_mmap {
 	int		 fd;
 	refcount_t	 refcnt;
 	u64		 prev;
+	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 };
-- 
2.4.11
