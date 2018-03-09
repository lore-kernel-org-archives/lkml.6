Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeCIInw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:43:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeCIInu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:43:50 -0500
Date: Fri, 9 Mar 2018 00:43:42 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-2c5f6d876b4edda8740f5a2826cf9b1a67fa76fb@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, wangnan0@huawei.com, acme@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org
Reply-To: wangnan0@huawei.com, acme@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        kan.liang@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
References: <1520350567-80082-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Store 'overwrite' in struct perf_mmap
Git-Commit-ID: 2c5f6d876b4edda8740f5a2826cf9b1a67fa76fb
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

Commit-ID:  2c5f6d876b4edda8740f5a2826cf9b1a67fa76fb
Gitweb:     https://git.kernel.org/tip/2c5f6d876b4edda8740f5a2826cf9b1a67fa76fb
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 6 Mar 2018 10:36:00 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Mar 2018 10:05:50 -0300

perf evlist: Store 'overwrite' in struct perf_mmap

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
