Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46967C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1445C20855
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbeLXMYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:24:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:19243 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbeLXMYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:24:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2018 04:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,392,1539673200"; 
   d="scan'208";a="109678537"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 24 Dec 2018 04:24:40 -0800
Received: from [10.252.4.220] (abudanko-mobl.ccr.corp.intel.com [10.252.4.220])
        by linux.intel.com (Postfix) with ESMTP id AD1D158044E;
        Mon, 24 Dec 2018 04:24:37 -0800 (PST)
Subject: [PATCH v2 2/4] perf record: bind the AIO user space buffers to nodes
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <e616e65f-bf53-e87e-b906-4fd9dce86380@linux.intel.com>
Date:   Mon, 24 Dec 2018 15:24:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <e8fccb5e-31b7-b3a0-74bf-490c2d439ab4@linux.intel.com>
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
Changes in v2:
- implemented perf_mmap__aio_alloc, perf_mmap__aio_free, perf_mmap__aio_bind 
  and put HAVE_LIBNUMA_SUPPORT #ifdefs in there
---
 tools/perf/util/mmap.c | 49 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index e68ba754a8e2..742fa9a8e498 100644
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
@@ -154,6 +157,46 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 }
 
 #ifdef HAVE_AIO_SUPPORT
+
+#ifdef HAVE_LIBNUMA_SUPPORT
+static void perf_mmap__aio_alloc(void **data, size_t len)
+{
+	*data = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+}
+
+static void perf_mmap__aio_free(void **data, size_t len)
+{
+	munmap(*data, len);
+	*data = NULL;
+}
+
+static void perf_mmap__aio_bind(void *data, size_t len, int cpu, int affinity)
+{
+	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
+		unsigned long node_mask = 1UL << cpu__get_node(cpu);
+		if (mbind(data, len, MPOL_BIND, &node_mask, 1, 0)) {
+			  pr_debug2("failed to bind [%p-%p] to node %d\n",
+				    data, data + len, cpu__get_node(cpu));
+		}
+	}
+}
+#else
+static void perf_mmap__aio_alloc(void **data, size_t len)
+{
+	*data = malloc(len);
+}
+
+static void perf_mmap__aio_free(void **data, size_t len __maybe_unused)
+{
+	zfree(data);
+}
+
+static void perf_mmap__aio_bind(void *data __maybe_unused, size_t len __maybe_unused,
+                                int cpu __maybe_unused, int affinity __maybe_unused)
+{
+}
+#endif
+
 static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 {
 	int delta_max, i, prio;
@@ -177,11 +220,13 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 		}
 		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
 		for (i = 0; i < map->aio.nr_cblocks; ++i) {
-			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
+			size_t mmap_len = perf_mmap__mmap_len(map);
+			perf_mmap__aio_alloc(&(map->aio.data[i]), mmap_len);
 			if (!map->aio.data[i]) {
 				pr_debug2("failed to allocate data buffer area, error %m");
 				return -1;
 			}
+			perf_mmap__aio_bind(map->aio.data[i], mmap_len, map->cpu, mp->affinity);
 			/*
 			 * Use cblock.aio_fildes value different from -1
 			 * to denote started aio write operation on the
@@ -210,7 +255,7 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 	int i;
 
 	for (i = 0; i < map->aio.nr_cblocks; ++i)
-		zfree(&map->aio.data[i]);
+		perf_mmap__aio_free(&(map->aio.data[i]), perf_mmap__mmap_len(map));
 	if (map->aio.data)
 		zfree(&map->aio.data);
 	zfree(&map->aio.cblocks);
