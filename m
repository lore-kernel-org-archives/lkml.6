Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03276C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25172084D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfBIMq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:46:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:46:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CkECY2631955
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:46:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CkDEm2631951;
        Sat, 9 Feb 2019 04:46:13 -0800
Date:   Sat, 9 Feb 2019 04:46:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-c44a8b44ca9f156a5395597109987d1c462ba655@git.kernel.org>
Cc:     peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        alexey.budankov@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          peterz@infradead.org, alexander.shishkin@linux.intel.com,
          ak@linux.intel.com, alexey.budankov@linux.intel.com,
          namhyung@kernel.org
In-Reply-To: <20190205151526.GC10613@kernel.org>
References: <5a5adebc-afe0-4806-81cd-180d49ec043f@linux.intel.com>
        <20190205151526.GC10613@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Bind the AIO user space buffers to
 nodes
Git-Commit-ID: c44a8b44ca9f156a5395597109987d1c462ba655
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c44a8b44ca9f156a5395597109987d1c462ba655
Gitweb:     https://git.kernel.org/tip/c44a8b44ca9f156a5395597109987d1c462ba655
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Tue, 22 Jan 2019 20:48:54 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf record: Bind the AIO user space buffers to nodes

Allocate and bind AIO user space buffers to the memory nodes that mmap
kernel buffers are bound to.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5a5adebc-afe0-4806-81cd-180d49ec043f@linux.intel.com
[ Do not use 'index' as a variable name, it is a define in older glibcs ]
Link: http://lkml.kernel.org/r/20190205151526.GC10613@kernel.org
[ Add -lnuma to the python build when -DHAVE_LIBNUMA_SUPPORT is present, fixing 'perf test python' ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c   | 77 +++++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/setup.py |  5 ++++
 2 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index e68ba754a8e2..d882f43148c3 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -10,6 +10,9 @@
 #include <sys/mman.h>
 #include <inttypes.h>
 #include <asm/bug.h>
+#ifdef HAVE_LIBNUMA_SUPPORT
+#include <numaif.h>
+#endif
 #include "debug.h"
 #include "event.h"
 #include "mmap.h"
@@ -154,9 +157,72 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 }
 
 #ifdef HAVE_AIO_SUPPORT
+
+#ifdef HAVE_LIBNUMA_SUPPORT
+static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
+{
+	map->aio.data[idx] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+				  MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+	if (map->aio.data[idx] == MAP_FAILED) {
+		map->aio.data[idx] = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
+static void perf_mmap__aio_free(struct perf_mmap *map, int idx)
+{
+	if (map->aio.data[idx]) {
+		munmap(map->aio.data[idx], perf_mmap__mmap_len(map));
+		map->aio.data[idx] = NULL;
+	}
+}
+
+static int perf_mmap__aio_bind(struct perf_mmap *map, int idx, int cpu, int affinity)
+{
+	void *data;
+	size_t mmap_len;
+	unsigned long node_mask;
+
+	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
+		data = map->aio.data[idx];
+		mmap_len = perf_mmap__mmap_len(map);
+		node_mask = 1UL << cpu__get_node(cpu);
+		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
+			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
+				data, data + mmap_len, cpu__get_node(cpu));
+			return -1;
+		}
+	}
+
+	return 0;
+}
+#else
+static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
+{
+	map->aio.data[idx] = malloc(perf_mmap__mmap_len(map));
+	if (map->aio.data[idx] == NULL)
+		return -1;
+
+	return 0;
+}
+
+static void perf_mmap__aio_free(struct perf_mmap *map, int idx)
+{
+	zfree(&(map->aio.data[idx]));
+}
+
+static int perf_mmap__aio_bind(struct perf_mmap *map __maybe_unused, int idx __maybe_unused,
+		int cpu __maybe_unused, int affinity __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 {
-	int delta_max, i, prio;
+	int delta_max, i, prio, ret;
 
 	map->aio.nr_cblocks = mp->nr_cblocks;
 	if (map->aio.nr_cblocks) {
@@ -177,11 +243,14 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 		}
 		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
 		for (i = 0; i < map->aio.nr_cblocks; ++i) {
-			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
-			if (!map->aio.data[i]) {
+			ret = perf_mmap__aio_alloc(map, i);
+			if (ret == -1) {
 				pr_debug2("failed to allocate data buffer area, error %m");
 				return -1;
 			}
+			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
+			if (ret == -1)
+				return -1;
 			/*
 			 * Use cblock.aio_fildes value different from -1
 			 * to denote started aio write operation on the
@@ -210,7 +279,7 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 	int i;
 
 	for (i = 0; i < map->aio.nr_cblocks; ++i)
-		zfree(&map->aio.data[i]);
+		perf_mmap__aio_free(map, i);
 	if (map->aio.data)
 		zfree(&map->aio.data);
 	zfree(&map->aio.cblocks);
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index d3ffc18424b5..5b5a167b43ce 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -53,9 +53,14 @@ ext_sources = [f.strip() for f in open('util/python-ext-sources')
 # use full paths with source files
 ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
 
+extra_libraries = []
+if '-DHAVE_LIBNUMA_SUPPORT' in cflags:
+    extra_libraries = [ 'numa' ]
+
 perf = Extension('perf',
 		  sources = ext_sources,
 		  include_dirs = ['util/include'],
+		  libraries = extra_libraries,
 		  extra_compile_args = cflags,
 		  extra_objects = [libtraceevent, libapikfs],
                  )
