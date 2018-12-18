Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D234C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108121871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLRN4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:56:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeLRN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:56:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDtvcl2851573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:55:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDtvd12851570;
        Tue, 18 Dec 2018 05:55:57 -0800
Date:   Tue, 18 Dec 2018 05:55:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-0b77383134f3dbb461189a9c4f3b46b20152045d@git.kernel.org>
Cc:     ak@linux.intel.com, acme@redhat.com,
        alexey.budankov@linux.intel.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, namhyung@kernel.org,
          acme@redhat.com, alexey.budankov@linux.intel.com,
          ak@linux.intel.com, peterz@infradead.org, jolsa@redhat.com,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com>
References: <5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf mmap: Map data buffer for preserving collected
 data
Git-Commit-ID: 0b77383134f3dbb461189a9c4f3b46b20152045d
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

Commit-ID:  0b77383134f3dbb461189a9c4f3b46b20152045d
Gitweb:     https://git.kernel.org/tip/0b77383134f3dbb461189a9c4f3b46b20152045d
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Tue, 6 Nov 2018 12:03:35 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:01 -0300

perf mmap: Map data buffer for preserving collected data

The map->data buffer is used to preserve map->base profiling data for
writing to disk. AIO map->cblock is used to queue corresponding
map->data buffer for asynchronous writing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5fcda10c-6c63-68df-383a-c6d9e5d1f918@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c |  2 +-
 tools/perf/util/mmap.c   | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/mmap.h   | 11 ++++++++++-
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 36526d229315..6f010b9f0a81 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1028,7 +1028,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp;
+	struct mmap_params mp = { .nr_cblocks = 0 };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index cdb95b3a1213..47cdc3ad6546 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -153,8 +153,55 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 {
 }
 
+#ifdef HAVE_AIO_SUPPORT
+static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
+{
+	int delta_max;
+
+	if (mp->nr_cblocks) {
+		map->aio.data = malloc(perf_mmap__mmap_len(map));
+		if (!map->aio.data) {
+			pr_debug2("failed to allocate data buffer, error %m\n");
+			return -1;
+		}
+		/*
+		 * Use cblock.aio_fildes value different from -1
+		 * to denote started aio write operation on the
+		 * cblock so it requires explicit record__aio_sync()
+		 * call prior the cblock may be reused again.
+		 */
+		map->aio.cblock.aio_fildes = -1;
+		/*
+		 * Allocate cblock with max priority delta to
+		 * have faster aio write system calls.
+		 */
+		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
+		map->aio.cblock.aio_reqprio = delta_max;
+	}
+
+	return 0;
+}
+
+static void perf_mmap__aio_munmap(struct perf_mmap *map)
+{
+	if (map->aio.data)
+		zfree(&map->aio.data);
+}
+#else
+static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
+			       struct mmap_params *mp __maybe_unused)
+{
+	return 0;
+}
+
+static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
+{
+}
+#endif
+
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	perf_mmap__aio_munmap(map);
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -197,7 +244,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
 
-	return 0;
+	return perf_mmap__aio_mmap(map, mp);
 }
 
 static int overwrite_rb_find_range(void *buf, int mask, u64 *start, u64 *end)
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index cc5e2d6d17a9..3f10ad030c5e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 #include <linux/ring_buffer.h>
 #include <stdbool.h>
+#ifdef HAVE_AIO_SUPPORT
+#include <aio.h>
+#endif
 #include "auxtrace.h"
 #include "event.h"
 
@@ -26,6 +29,12 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+#ifdef HAVE_AIO_SUPPORT
+	struct {
+		void 		 *data;
+		struct aiocb	 cblock;
+	} aio;
+#endif
 };
 
 /*
@@ -57,7 +66,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask;
+	int			    prot, mask, nr_cblocks;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
