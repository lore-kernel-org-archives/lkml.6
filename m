Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A24DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1482087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1482087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJHNYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:24:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:52092 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbeJHNYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:24:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2018 23:14:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,355,1534834800"; 
   d="scan'208";a="76212362"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2018 23:14:32 -0700
Received: from [10.125.251.251] (abudanko-mobl.ccr.corp.intel.com [10.125.251.251])
        by linux.intel.com (Postfix) with ESMTP id 25BF55801E6;
        Sun,  7 Oct 2018 23:14:29 -0700 (PDT)
Subject: [PATCH v11 1/3]: perf util: map data buffer for preserving collected
 data
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
Date:   Mon, 8 Oct 2018 09:14:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The map->data buffer is used to preserve map->base profiling data 
for writing to disk. AIO map->cblock is used to queue corresponding 
map->data buffer for asynchronous writing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v10:
 - moved specific code to perf_mmap__aio_mmap(), perf_mmap__aio_munmap()
 - adjusted error reporting by using %m
Changes in v9:
  - implemented NO_AIO and HAVE_AIO_SUPPORT defines to cover cases of 
    libc implementations without Posix AIO API support
Changes in v7:
  - implemented handling record.aio setting from perfconfig file
 Changes in v6:
  - adjusted setting of priorities for cblocks;
 Changes in v5:
  - reshaped layout of data structures;
  - implemented --aio option;
 Changes in v4:
  - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management 
 Changes in v2:
  - converted zalloc() to calloc() for allocation of mmap_aio array,
  - cleared typo and adjusted fallback branch code;
---
 tools/perf/Makefile.config |  5 +++++
 tools/perf/Makefile.perf   |  7 ++++++-
 tools/perf/util/evlist.c   |  4 +++-
 tools/perf/util/mmap.c     | 48 +++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/mmap.h     | 11 +++++++++++
 5 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f6d1a03c7523..2e90f4ce9214 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -355,6 +355,11 @@ endif # NO_LIBELF
 
 ifeq ($(feature-glibc), 1)
   CFLAGS += -DHAVE_GLIBC_SUPPORT
+  ifndef NO_AIO
+    ifndef BIONIC
+        CFLAGS += -DHAVE_AIO_SUPPORT
+    endif
+  endif
 endif
 
 ifdef NO_DWARF
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 92514fb3689f..7becc6a72cf2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -97,8 +97,13 @@ include ../scripts/utilities.mak
 # Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
 # When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
 # llvm-config is not in $PATH.
-
+#
 # Define NO_CORESIGHT if you do not want support for CoreSight trace decoding.
+#
+# Define NO_AIO if you do not want support of Posix AIO based trace
+# streaming for record mode. Currently Posix AIO trace streaming is
+# supported only when linking with glibc.
+#
 
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index be440df29615..af2f8c965d7a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1029,7 +1029,9 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * So &mp should not be passed through const pointer.
 	 */
 	struct mmap_params mp;
-
+#ifdef HAVE_AIO_SUPPORT
+	mp.nr_cblocks = 0;
+#endif
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
 	if (!evlist->mmap)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index cdb95b3a1213..db8f16f8a363 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -153,8 +153,19 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 {
 }
 
+#ifdef HAVE_AIO_SUPPORT
+static void perf_mmap__aio_munmap(struct perf_mmap *map)
+{
+	if (map->data)
+		zfree(&map->data);
+}
+#endif
+
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+#ifdef HAVE_AIO_SUPPORT
+	perf_mmap__aio_munmap(map);
+#endif
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -164,8 +175,40 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
+#ifdef HAVE_AIO_SUPPORT
+static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
+{
+	int delta_max;
+
+	map->nr_cblocks = mp->nr_cblocks;
+	if (map->nr_cblocks) {
+		map->data = malloc(perf_mmap__mmap_len(map));
+		if (!map->data) {
+			pr_debug2("failed to allocate data buffer, error %m\n");
+			return -1;
+		}
+		/*
+		 * Use cblock.aio_fildes value different from -1
+		 * to denote started aio write operation on the
+		 * cblock so it requires explicit record__aio_sync()
+		 * call prior the cblock may be reused again.
+		 */
+		map->cblock.aio_fildes = -1;
+		/*
+		 * Allocate cblock with max priority delta to
+		 * have faster aio write system calls.
+		 */
+		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
+		map->cblock.aio_reqprio = delta_max;
+	}
+
+	return 0;
+}
+#endif
+
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
+	int rc = 0;
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
@@ -197,7 +240,10 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
 
-	return 0;
+#ifdef HAVE_AIO_SUPPORT
+	rc = perf_mmap__aio_mmap(map, mp);
+#endif
+	return rc;
 }
 
 static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e603314dc792..1b63b6cc7cf9 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <stdbool.h>
+#ifdef HAVE_AIO_SUPPORT
+#include <aio.h>
+#endif
 #include "auxtrace.h"
 #include "event.h"
 
@@ -26,6 +29,11 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+#ifdef HAVE_AIO_SUPPORT
+	void 		 *data;
+	struct aiocb	 cblock;
+	int		 nr_cblocks;
+#endif
 };
 
 /*
@@ -59,6 +67,9 @@ enum bkw_mmap_state {
 struct mmap_params {
 	int			    prot, mask;
 	struct auxtrace_mmap_params auxtrace_mp;
+#ifdef HAVE_AIO_SUPPORT
+	int			    nr_cblocks;
+#endif
 };
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
