Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA38720879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAVRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:51:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:51486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfAVRvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:51:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 09:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,507,1539673200"; 
   d="scan'208";a="118545623"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 22 Jan 2019 09:51:01 -0800
Received: from [10.252.24.137] (abudanko-mobl.ccr.corp.intel.com [10.252.24.137])
        by linux.intel.com (Postfix) with ESMTP id 2A6DC580434;
        Tue, 22 Jan 2019 09:50:58 -0800 (PST)
Subject: [PATCH v5 3/4] perf record: apply affinity masks when reading mmap
 buffers
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b25e4ebc-078d-2c7b-216c-f0bed108d073@linux.intel.com>
Date:   Tue, 22 Jan 2019 20:50:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <af72a20b-117c-ec65-5fc9-35f4e81b26bd@linux.intel.com>
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
Changes in v5:
- avoided multiple allocations of online cpu maps by 
  implementing it once in cpu_map__online()

Changes in v4:
- corrected mmap_params->cpu_map initialization to be based on /sys/devices/system/cpu/online
- separated node cpu map generation into build_node_mask()

Changes in v3:
- separated mask manipulations into __adjust_affinity() and __setup_affinity_mask()
- implemented mapping of c index into online cpu index

Changes in v2:
- separated AIO buffers binding to patch 2/4
---
 tools/perf/builtin-record.c | 14 ++++++++++++++
 tools/perf/util/cpumap.c    | 10 ++++++++++
 tools/perf/util/cpumap.h    |  1 +
 tools/perf/util/mmap.c      | 28 +++++++++++++++++++++++++++-
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 370a68487532..142d109bc53d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -537,6 +537,9 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
 
+	if (opts->affinity != PERF_AFFINITY_SYS)
+		cpu__setup_cpunode_map();
+
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
@@ -729,6 +732,16 @@ static struct perf_event_header finished_round_event = {
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
@@ -756,6 +769,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+			record__adjust_affinity(rec, map);
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 					rc = -1;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 1ccbd3342069..a5523ba05cf1 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -723,3 +723,13 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
 	buf[size - 1] = '\0';
 	return ptr - buf;
 }
+
+const struct cpu_map *cpu_map__online(void) /* thread unsafe */
+{
+	static const struct cpu_map *online = NULL;
+
+	if (!online)
+		online = cpu_map__new(NULL); /* from /sys/devices/system/cpu/online */
+
+	return online;
+}
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index ed8999d1a640..f00ce624b9f7 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -29,6 +29,7 @@ int cpu_map__get_core_id(int cpu);
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
 int cpu_map__build_core_map(struct cpu_map *cpus, struct cpu_map **corep);
+const struct cpu_map *cpu_map__online(void); /* thread unsafe */
 
 struct cpu_map *cpu_map__get(struct cpu_map *map);
 void cpu_map__put(struct cpu_map *map);
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 34be9f900575..995c282fcd21 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -383,6 +383,32 @@ void perf_mmap__munmap(struct perf_mmap *map)
 	auxtrace_mmap__munmap(&map->auxtrace_mmap);
 }
 
+static void build_node_mask(int node, cpu_set_t *mask)
+{
+	int c, cpu, nr_cpus;
+	const struct cpu_map *cpu_map = NULL;
+
+	cpu_map = cpu_map__online();
+	if (!cpu_map)
+		return;
+
+	nr_cpus = cpu_map__nr(cpu_map);
+	for (c = 0; c < nr_cpus; c++) {
+		cpu = cpu_map->map[c]; /* map c index to online cpu index */
+		if (cpu__get_node(cpu) == node)
+			CPU_SET(cpu, mask);
+	}
+}
+
+static void perf_mmap__setup_affinity_mask(struct perf_mmap *map, struct mmap_params *mp)
+{
+	CPU_ZERO(&map->affinity_mask);
+	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
+		build_node_mask(cpu__get_node(map->cpu), &map->affinity_mask);
+	else if (mp->affinity == PERF_AFFINITY_CPU)
+		CPU_SET(map->cpu, &map->affinity_mask);
+}
+
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 	/*
@@ -412,7 +438,7 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 	map->fd = fd;
 	map->cpu = cpu;
 
-	CPU_ZERO(&map->affinity_mask);
+	perf_mmap__setup_affinity_mask(map, mp);
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
