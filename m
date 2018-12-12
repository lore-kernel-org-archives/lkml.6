Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADCAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8EA20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8EA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeLLHka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:40:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:32582 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbeLLHk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:40:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 23:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="98102720"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2018 23:40:25 -0800
Received: from [10.125.251.226] (abudanko-mobl.ccr.corp.intel.com [10.125.251.226])
        by linux.intel.com (Postfix) with ESMTP id 00EDA58079D;
        Tue, 11 Dec 2018 23:40:23 -0800 (PST)
Subject: [PATCH v1 2/3] perf record: apply affinity masks when reading mmap
 buffers
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6e5df6f0-5dfa-265e-73cd-803de96ac9b2@linux.intel.com>
Date:   Wed, 12 Dec 2018 10:40:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Build node cpu masks for mmap data buffers. Bind AIO data buffers
to nodes according to kernel data buffers location. Apply node cpu
masks to trace reading thread every time it references memory cross
node or cross cpu.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c |  9 +++++++++
 tools/perf/util/evlist.c    |  6 +++++-
 tools/perf/util/mmap.c      | 38 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/mmap.h      |  1 +
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4979719e54ae..1a1438c73f96 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -532,6 +532,9 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
 
+	if (opts->affinity != PERF_AFFINITY_SYS)
+		cpu__setup_cpunode_map();
+
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
@@ -751,6 +754,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+			if (rec->opts.affinity != PERF_AFFINITY_SYS &&
+			    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
+				CPU_ZERO(&rec->affinity_mask);
+				CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
+				sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
+			}
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 					rc = -1;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 60e825be944a..5ca5bb5ea0db 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1028,7 +1028,11 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
+	struct mmap_params mp = {
+		.nr_cblocks 	= nr_cblocks,
+		.affinity 	= affinity,
+		.cpu_map 	= cpus
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index e68ba754a8e2..0d017ea85dcb 100644
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
@@ -177,11 +180,27 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 		}
 		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
 		for (i = 0; i < map->aio.nr_cblocks; ++i) {
+#ifndef HAVE_LIBNUMA_SUPPORT
 			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
+#else
+			size_t mmap_len = perf_mmap__mmap_len(map);
+			map->aio.data[i] = mmap(NULL, mmap_len,
+				PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+#endif
 			if (!map->aio.data[i]) {
 				pr_debug2("failed to allocate data buffer area, error %m");
 				return -1;
 			}
+#ifdef HAVE_LIBNUMA_SUPPORT
+			if (mp->affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
+				unsigned long node_mask = 1UL << cpu__get_node(map->cpu);
+				if (mbind(map->aio.data[i], mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
+					pr_debug2("failed to bind [%p-%p] to node %d\n",
+						  map->aio.data[i], map->aio.data[i] + mmap_len,
+						  cpu__get_node(map->cpu));
+				}
+			}
+#endif
 			/*
 			 * Use cblock.aio_fildes value different from -1
 			 * to denote started aio write operation on the
@@ -209,8 +228,13 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 {
 	int i;
 
-	for (i = 0; i < map->aio.nr_cblocks; ++i)
+	for (i = 0; i < map->aio.nr_cblocks; ++i) {
+#ifndef HAVE_LIBNUMA_SUPPORT
 		zfree(&map->aio.data[i]);
+#else
+		munmap(map->aio.data[i], perf_mmap__mmap_len(map));
+#endif
+	}
 	if (map->aio.data)
 		zfree(&map->aio.data);
 	zfree(&map->aio.cblocks);
@@ -316,6 +340,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
+	int c, nr_cpus, node;
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
@@ -344,6 +369,17 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 	map->cpu = cpu;
 
 	CPU_ZERO(&map->affinity_mask);
+	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
+		nr_cpus = cpu_map__nr(mp->cpu_map);
+		node = cpu__get_node(map->cpu);
+		for (c = 0; c < nr_cpus; c++) {
+			if (cpu__get_node(c) == node) {
+				CPU_SET(c, &map->affinity_mask);
+			}
+		}
+	} else if (mp->affinity == PERF_AFFINITY_CPU) {
+		CPU_SET(map->cpu, &map->affinity_mask);
+	}
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e566c19b242b..b3f724fad22e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -72,6 +72,7 @@ enum bkw_mmap_state {
 struct mmap_params {
 	int			    prot, mask, nr_cblocks, affinity;
 	struct auxtrace_mmap_params auxtrace_mp;
+	const struct cpu_map	    *cpu_map;
 };
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);
