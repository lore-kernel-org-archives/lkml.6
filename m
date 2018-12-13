Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0A6C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4628C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4628C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeLMHUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:20:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:2715 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbeLMHUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:20:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 23:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="109175450"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2018 23:20:11 -0800
Received: from [10.125.251.221] (abudanko-mobl.ccr.corp.intel.com [10.125.251.221])
        by linux.intel.com (Postfix) with ESMTP id 333AB580380;
        Wed, 12 Dec 2018 23:20:08 -0800 (PST)
Subject: [PATCH v2 3/4] perf record: apply affinity masks when reading mmap,
 buffers
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <26031ab1-f39d-b0c3-8862-c17540f50705@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9fdacffe-051c-1fab-5f45-ecf460c61bef@linux.intel.com>
Date:   Thu, 13 Dec 2018 10:20:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <26031ab1-f39d-b0c3-8862-c17540f50705@linux.intel.com>
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
