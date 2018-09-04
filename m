Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45697C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58D92086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58D92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeIDLdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:33:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:56366 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeIDLdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:33:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 00:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="71408817"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2018 00:09:37 -0700
Received: from [10.125.251.238] (abudanko-mobl.ccr.corp.intel.com [10.125.251.238])
        by linux.intel.com (Postfix) with ESMTP id 654FF5803E2;
        Tue,  4 Sep 2018 00:09:35 -0700 (PDT)
Subject: [PATCH v5 1/2]: perf util: map data buffer for preserving collected
 data
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7b3a635a-1789-65b9-31f4-fef5406bc3d5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d8649338-b157-0a36-e68d-674f33a545eb@linux.intel.com>
Date:   Tue, 4 Sep 2018 10:09:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7b3a635a-1789-65b9-31f4-fef5406bc3d5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The map->data buffers are used to preserve map->base profiling data 
for writing to disk. AIO map->cblocks are used to queue corresponding 
map->data buffers for asynchronous writing. map->cblocks objects are 
located in the last page of every map->data buffer.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 Changes in v5:
  - reshaped layout of data structures;
  - implemented --aio option;
 Changes in v4:
  - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management 
 Changes in v2:
  - converted zalloc() to calloc() for allocation of mmap_aio array,
  - cleared typo and adjusted fallback branch code;
--- 
 tools/perf/builtin-record.c | 12 +++++++++++-
 tools/perf/perf.h           |  1 +
 tools/perf/util/evlist.c    |  7 ++++---
 tools/perf/util/evlist.h    |  3 ++-
 tools/perf/util/mmap.c      | 48 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mmap.h      |  6 +++++-
 6 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92ac51..8eb093f8d4d5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -326,7 +326,8 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -1519,6 +1520,7 @@ static struct record record = {
 			.default_per_cpu = true,
 		},
 		.proc_map_timeout     = 500,
+		.nr_cblocks	      = 2
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1678,6 +1680,8 @@ static struct option __record_options[] = {
 			  "signal"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
+	OPT_INTEGER(0, "aio", &record.opts.nr_cblocks,
+		    "asynchronous trace write operations (min: 1, max: 32, default: 2)"),
 	OPT_END()
 };
 
@@ -1870,6 +1874,12 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (!(1 <= rec->opts.nr_cblocks && rec->opts.nr_cblocks <= 32)) {
+		if (verbose > 0)
+			pr_warning("Asynchronous trace writes reset to default.\n");
+		rec->opts.nr_cblocks = 2;
+	}
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5a3cf5..0a1ae2ae567a 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -82,6 +82,7 @@ struct record_opts {
 	bool         use_clockid;
 	clockid_t    clockid;
 	unsigned int proc_map_timeout;
+	int	     nr_cblocks;
 };
 
 struct option;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..08be79650a85 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1018,7 +1018,8 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite)
+			 bool auxtrace_overwrite,
+			 int nr_cblocks)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1028,7 +1029,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp;
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1060,7 +1061,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 2);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..a94d3c613254 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -162,7 +162,8 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite);
+			 bool auxtrace_overwrite,
+			 int nr_cblocks);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index fc832676a798..ea728db8f460 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -155,6 +155,14 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
+	int i;
+	if (map->data) {
+		for (i = 0; i < map->nr_cblocks; ++i)
+			zfree(&(map->data[i]));
+		zfree(&(map->data));
+	}
+	if (map->cblocks)
+		zfree(&(map->cblocks));
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -166,6 +174,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 {
+	int i;
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
@@ -190,6 +199,45 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 		map->base = NULL;
 		return -1;
 	}
+	map->nr_cblocks = mp->nr_cblocks;
+	map->cblocks = calloc(map->nr_cblocks, sizeof(struct aiocb*));
+	if (!map->cblocks) {
+		pr_debug2("failed to allocate perf event data buffers, error %d\n",
+				errno);
+		return -1;
+	}
+	map->data = calloc(map->nr_cblocks, sizeof(void*));
+	if (map->data) {
+		for (i = 0; i < map->nr_cblocks; ++i) {
+			map->data[i] = malloc(perf_mmap__mmap_len(map));
+			if (map->data[i]) {
+				unsigned char *data = map->data[i];
+				map->cblocks[i] = (struct aiocb *)&data[map->mask + 1];
+				memset(map->cblocks[i], 0, sizeof(struct aiocb));
+				/* Use cblock.aio_fildes value different from -1
+				 * to denote started aio write operation on the
+				 * cblock so it requires explicit record__aio_sync()
+				 * call prior the cblock may be reused again.
+				 */
+				map->cblocks[i]->aio_fildes = -1;
+				/* Allocate cblocks with decreasing priority to
+				 * have faster aio_write() calls because queued
+				 * requests are kept in separate per-prio queues
+				 * and adding a new request iterates thru shorter
+				 * per-prio list.
+				 */
+				map->cblocks[i]->aio_reqprio = map->nr_cblocks - i;
+			} else {
+				pr_debug2("failed to allocate perf event data buffer, error %d\n",
+						errno);
+				return -1;
+			}
+		}
+	} else {
+		pr_debug2("failed to alloc perf event data buffers, error %d\n",
+				errno);
+		return -1;
+	}
 	map->fd = fd;
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index d82294db1295..4a9bb0ecae4f 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <stdbool.h>
+#include <aio.h>
 #include "auxtrace.h"
 #include "event.h"
 
@@ -25,6 +26,9 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void 		 **data;
+	struct aiocb	 **cblocks;
+	int 		 nr_cblocks;
 };
 
 /*
@@ -56,7 +60,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask;
+	int			    prot, mask, nr_cblocks;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
