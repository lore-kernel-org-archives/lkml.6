Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC999C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B87214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbfAIJhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:37:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:15811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfAIJhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:37:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="106833754"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 09 Jan 2019 01:37:21 -0800
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id B951358056F;
        Wed,  9 Jan 2019 01:37:18 -0800 (PST)
Subject: [PATCH v3 2/4] perf record: bind the AIO user space buffers to nodes
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
Organization: Intel Corp.
Message-ID: <848d3b31-7efb-880b-3e82-87ba6748104c@linux.intel.com>
Date:   Wed, 9 Jan 2019 12:37:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Allocate and bind AIO user space buffers to the memory nodes
that mmap kernel buffers are bound to.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v3:
- corrected code style issues
- adjusted __aio_alloc,__aio_bind,__aio_free() implementation
Changes in v2:
- implemented perf_mmap__aio_alloc, perf_mmap__aio_free, perf_mmap__aio_bind 
  and put HAVE_LIBNUMA_SUPPORT #ifdefs in there
---
 tools/perf/util/mmap.c | 71 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index e68ba754a8e2..e5220790f1fb 100644
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
@@ -154,9 +157,68 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 }
 
 #ifdef HAVE_AIO_SUPPORT
+
+#ifdef HAVE_LIBNUMA_SUPPORT
+static int perf_mmap__aio_alloc(struct perf_mmap *map, int index)
+{
+	map->aio.data[index] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+				    MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+	if (map->aio.data[index] == MAP_FAILED) {
+		map->aio.data[index] = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
+static void perf_mmap__aio_free(struct perf_mmap *map, int index)
+{
+	if (map->aio.data[index]) {
+		munmap(map->aio.data[index], perf_mmap__mmap_len(map));
+		map->aio.data[index] = NULL;
+	}
+}
+
+static void perf_mmap__aio_bind(struct perf_mmap *map, int index, int cpu, int affinity)
+{
+	void *data;
+	size_t mmap_len;
+	unsigned long node_mask;
+
+	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
+		data = map->aio.data[index];
+		mmap_len = perf_mmap__mmap_len(map);
+		node_mask = 1UL << cpu__get_node(cpu);
+		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
+			pr_warn("failed to bind [%p-%p] to node %d\n",
+				data, data + mmap_len, cpu__get_node(cpu));
+		}
+	}
+}
+#else
+static int perf_mmap__aio_alloc(struct perf_mmap *map, int index)
+{
+	map->aio.data[index] = malloc(perf_mmap__mmap_len(map));
+	if (map->aio.data[index] == NULL)
+		return -1;
+
+	return 0;
+}
+
+static void perf_mmap__aio_free(struct perf_mmap *map, int index)
+{
+	zfree(&(map->aio.data[index]));
+}
+
+static void perf_mmap__aio_bind(struct perf_mmap *map __maybe_unused, int index __maybe_unused,
+		int cpu __maybe_unused, int affinity __maybe_unused)
+{
+}
+#endif
+
 static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 {
-	int delta_max, i, prio;
+	int delta_max, i, prio, ret;
 
 	map->aio.nr_cblocks = mp->nr_cblocks;
 	if (map->aio.nr_cblocks) {
@@ -177,11 +239,12 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
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
+			perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
 			/*
 			 * Use cblock.aio_fildes value different from -1
 			 * to denote started aio write operation on the
@@ -210,7 +273,7 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 	int i;
 
 	for (i = 0; i < map->aio.nr_cblocks; ++i)
-		zfree(&map->aio.data[i]);
+		perf_mmap__aio_free(map, i);
 	if (map->aio.data)
 		zfree(&map->aio.data);
 	zfree(&map->aio.cblocks);
