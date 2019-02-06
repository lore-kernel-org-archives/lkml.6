Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA42C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3BB20823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479223;
	bh=4T+ZlaMmyHGcDhJaWhrATgc3hCtda2Li6t+SFqILZRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v05mOC6edob1URs+iXLtu6DY1LQIThFxvsKcGNUNbx/qAImqw8z20CtTKp3XgG250
	 tKg2/0laXOIlLeUm+j/7+xoFPUlkstPWl8h+6ZOTYys2SKpLVjN2SmOf2010rm3X1J
	 BNT/RKnov5aX/AfVM3VqntDELdhmuTHFkqXGJrZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfBFSuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfBFSus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:50:48 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BADB2186A;
        Wed,  6 Feb 2019 18:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479046;
        bh=4T+ZlaMmyHGcDhJaWhrATgc3hCtda2Li6t+SFqILZRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Shsrm8pmEladllk89FSrymBWrEI667GnULAJluc4cWn/UPDuVqrtfsrk8gYOayk0
         TIv2AVqf+5dZj7MlrFHW2IJEFYoYg4IC0oz0+z5VDYv5edyXfME2BOMVuqWE4kQG6l
         dbHmq3ecczCunuBZMD4vAZZVtQ74EOlavYwym7qo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/53] perf record: Bind the AIO user space buffers to nodes
Date:   Wed,  6 Feb 2019 15:48:38 -0300
Message-Id: <20190206184903.24054-29-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
 tools/perf/util/mmap.c   | 77 +++++++++++++++++++++++++++++++++++++---
 tools/perf/util/setup.py |  5 +++
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
-- 
2.20.1

