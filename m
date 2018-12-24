Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA5AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914BE21848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbeLXM1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:27:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:19491 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbeLXM1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:27:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2018 04:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,392,1539673200"; 
   d="scan'208";a="101087394"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 24 Dec 2018 04:27:21 -0800
Received: from [10.252.4.220] (abudanko-mobl.ccr.corp.intel.com [10.252.4.220])
        by linux.intel.com (Postfix) with ESMTP id 88CA358044E;
        Mon, 24 Dec 2018 04:27:18 -0800 (PST)
Subject: [PATCH v2 3/4] perf record: apply affinity masks when reading mmap
 buffers
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
Message-ID: <4b7b902b-01b7-7a3f-eee2-e7fc8433322c@linux.intel.com>
Date:   Mon, 24 Dec 2018 15:27:17 +0300
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


Build node cpu masks for mmap data buffers. Apply node cpu
masks to tool thread every time it references data buffers
cross node or cross cpu.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- separated AIO buffers binding to patch 2/4
---
 tools/perf/builtin-record.c |  9 +++++++++
 tools/perf/util/evlist.c    |  6 +++++-
 tools/perf/util/mmap.c      | 12 ++++++++++++
 tools/perf/util/mmap.h      |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b26febb54d01..eea96794ee45 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -536,6 +536,9 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
 
+	if (opts->affinity != PERF_AFFINITY_SYS)
+		cpu__setup_cpunode_map();
+
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
@@ -755,6 +758,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
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
index 742fa9a8e498..a2095e4eda4b 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -361,6 +361,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
+	int c, nr_cpus, node;
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
@@ -389,6 +390,17 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
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
