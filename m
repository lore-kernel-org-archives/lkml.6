Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D160AC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A1D2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBIMru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:47:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfBIMru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:47:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19Clbjf2632059
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:47:37 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19Clbkg2632056;
        Sat, 9 Feb 2019 04:47:37 -0800
Date:   Sat, 9 Feb 2019 04:47:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-f13de6609a9a25ce4d6dc37c4427f5bc90072fb0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, peterz@infradead.org,
          mingo@kernel.org, tglx@linutronix.de,
          alexey.budankov@linux.intel.com, acme@redhat.com,
          namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <b25e4ebc-078d-2c7b-216c-f0bed108d073@linux.intel.com>
References: <b25e4ebc-078d-2c7b-216c-f0bed108d073@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Apply affinity masks when reading mmap
 buffers
Git-Commit-ID: f13de6609a9a25ce4d6dc37c4427f5bc90072fb0
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

Commit-ID:  f13de6609a9a25ce4d6dc37c4427f5bc90072fb0
Gitweb:     https://git.kernel.org/tip/f13de6609a9a25ce4d6dc37c4427f5bc90072fb0
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Tue, 22 Jan 2019 20:50:57 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:39 -0300

perf record: Apply affinity masks when reading mmap buffers

Build node cpu masks for mmap data buffers. Apply node cpu masks to tool
thread every time it references data buffers cross node or cross cpu.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/b25e4ebc-078d-2c7b-216c-f0bed108d073@linux.intel.com
[ Use cpu-set-sched.h to get the CPU_{EQUAL,OR}() fallbacks for older systems ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 15 +++++++++++++++
 tools/perf/util/cpumap.c    | 10 ++++++++++
 tools/perf/util/cpumap.h    |  1 +
 tools/perf/util/mmap.c      | 28 +++++++++++++++++++++++++++-
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7ced5f3e8100..3fdfbaebd95e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -38,6 +38,7 @@
 #include "util/bpf-loader.h"
 #include "util/trigger.h"
 #include "util/perf-hooks.h"
+#include "util/cpu-set-sched.h"
 #include "util/time-utils.h"
 #include "util/units.h"
 #include "util/bpf-event.h"
@@ -536,6 +537,9 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
 
+	if (opts->affinity != PERF_AFFINITY_SYS)
+		cpu__setup_cpunode_map();
+
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
@@ -719,6 +723,16 @@ static struct perf_event_header finished_round_event = {
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
@@ -746,6 +760,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+			record__adjust_affinity(rec, map);
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 					rc = -1;
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 383674f448fc..0bbc3feb0894 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -730,3 +730,13 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
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
index d882f43148c3..cdc7740fc181 100644
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
