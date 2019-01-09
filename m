Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A9E20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfAIJi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:38:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:7988 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbfAIJi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:38:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="134316832"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2019 01:38:27 -0800
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id 94955580490;
        Wed,  9 Jan 2019 01:38:24 -0800 (PST)
Subject: [PATCH v3 3/4] perf record: apply affinity masks when reading mmap
 buffers
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
Message-ID: <a5081531-f89b-9d5a-df16-76a1de3c0d82@linux.intel.com>
Date:   Wed, 9 Jan 2019 12:38:23 +0300
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


Build node cpu masks for mmap data buffers. Apply node cpu
masks to tool thread every time it references data buffers
cross node or cross cpu.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v3:
- separated mask manipulations into __adjust_affinity() and __setup_affinity_mask()
- implemented mapping of c index into online cpu index
Changes in v2:
- separated AIO buffers binding to patch 2/4
---
 tools/perf/builtin-record.c | 14 ++++++++++++++
 tools/perf/util/evlist.c    |  6 +++++-
 tools/perf/util/mmap.c      | 20 +++++++++++++++++++-
 tools/perf/util/mmap.h      |  1 +
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e5a108b11d46..553c2fabf3c1 100644
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
@@ -728,6 +731,16 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
+{
+	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
+	    !CPU_EQUAL(&rec->affinity_mask, &map->affinity_mask)) {
+		CPU_ZERO(&rec->affinity_mask);
+		CPU_OR(&rec->affinity_mask, &rec->affinity_mask, &map->affinity_mask);
+		sched_setaffinity(0, sizeof(rec->affinity_mask), &rec->affinity_mask);
+	}
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite)
 {
@@ -755,6 +768,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+			record__adjust_affinity(rec, map);
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 					rc = -1;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 08cedb643ea6..b6680f65ccc4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1032,7 +1032,11 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
+	struct mmap_params mp = {
+		.nr_cblocks	= nr_cblocks,
+		.affinity	= affinity,
+		.cpu_map	= cpus
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index e5220790f1fb..ee0230eed635 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -377,6 +377,24 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
+static void perf_mmap__setup_affinity_mask(struct perf_mmap *map, struct mmap_params *mp)
+{
+	int c, cpu, nr_cpus, node;
+
+	CPU_ZERO(&map->affinity_mask);
+	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1) {
+		nr_cpus = cpu_map__nr(mp->cpu_map);
+		node = cpu__get_node(map->cpu);
+		for (c = 0; c < nr_cpus; c++) {
+			cpu = mp->cpu_map->map[c]; /* map c index to online cpu index */
+			if (cpu__get_node(cpu) == node)
+				CPU_SET(cpu, &map->affinity_mask);
+		}
+	} else if (mp->affinity == PERF_AFFINITY_CPU) {
+		CPU_SET(map->cpu, &map->affinity_mask);
+	}
+}
+
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
@@ -406,7 +424,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 	map->fd = fd;
 	map->cpu = cpu;
 
-	CPU_ZERO(&map->affinity_mask);
+	perf_mmap__setup_affinity_mask(map, mp);
 
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
