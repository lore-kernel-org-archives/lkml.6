Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCHTvp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbeCHTvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:51:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C0A2178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/54] perf evlist: Store 'overwrite' in struct perf_mmap
Date: Thu,  8 Mar 2018 16:49:57 -0300
Message-Id: <20180308195029.14991-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

It has been determined that the map is for overwrite mode
(evlist->overwrite_mmap) or non-overwrite mode (evlist->mmap) when
calling perf_evlist__alloc_mmap().

Store the information in struct perf_mmap, which will be used later to
simplify the perf_mmap__read*() interfaces.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1520350567-80082-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 8 +++++---
 tools/perf/util/mmap.h   | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 41a4666f1519..a59281d64368 100644
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
index ec7d3a24e276..71137977af28 100644
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
2.14.3
