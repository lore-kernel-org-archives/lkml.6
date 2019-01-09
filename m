Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31344C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E067F2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfAIQL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:11:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:32771 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbfAIQLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:11:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 08:11:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="113408853"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jan 2019 08:11:24 -0800
Received: from [10.252.18.78] (abudanko-mobl.ccr.corp.intel.com [10.252.18.78])
        by linux.intel.com (Postfix) with ESMTP id ACEA05802E1;
        Wed,  9 Jan 2019 08:11:21 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Reduce NUMA related overhead in perf record
 profiling on large server systems
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
 <20190109144125.GA2515@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <de0a2949-6b3c-0aa8-087d-9d81f3b3b450@linux.intel.com>
Date:   Wed, 9 Jan 2019 19:11:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190109144125.GA2515@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09.01.2019 17:41, Jiri Olsa wrote:
> On Wed, Jan 09, 2019 at 12:19:20PM +0300, Alexey Budankov wrote:
>>
<SNIP>
>> It has been observed that trace reading thread run>> The patch set is generated for acme perf/core repository.
>>
>> ---
>> Alexey Budankov (4):
>>   perf record: allocate affinity masks
>>   perf record: bind the AIO user space buffers to nodes
>>   perf record: apply affinity masks when reading mmap buffers
>>   perf record: implement --affinity=node|cpu option
> 
> 
> hi,
> can't apply your code on latest Arnaldo's perf/core:
> 
> Applying: perf record: allocate affinity masks
> Applying: perf record: bind the AIO user space buffers to nodes
> Applying: perf record: apply affinity masks when reading mmap buffers
> Applying: perf record: implement --affinity=node|cpu option
> error: corrupt patch at line 62
> Patch failed at 0004 perf record: implement --affinity=node|cpu option
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

Sorry about that.
Patch set update and resend is in progress.
The whole change on top of Arnaldo's perf/core tip follows for your convenience.

Thanks!
Alexey

---
 tools/perf/Documentation/perf-record.txt |  5 ++
 tools/perf/builtin-record.c              | 47 ++++++++++++++++-
 tools/perf/perf.h                        |  8 +++
 tools/perf/util/evlist.c                 | 10 ++--
 tools/perf/util/evlist.h                 |  2 +-
 tools/perf/util/mmap.c                   | 91 ++++++++++++++++++++++++++++++--
 tools/perf/util/mmap.h                   |  4 +-
 7 files changed, 157 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..efb839784f32 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -440,6 +440,11 @@ Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default:
 Asynchronous mode is supported only when linking Perf tool with libc library
 providing implementation for Posix AIO API.
 
+--affinity=mode::
+Set affinity mask of trace reading thread according to the policy defined by 'mode' value:
+  node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
+  cpu  - thread affinity mask is set to cpu of the processed mmap buffer
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..94a966ba9a6f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -81,12 +81,17 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
+	cpu_set_t		affinity_mask;
 };
 
 static volatile int auxtrace_record__snapshot_started;
 static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
 static DEFINE_TRIGGER(switch_output_trigger);
 
+static const char *affinity_tags[PERF_AFFINITY_MAX] = {
+	"SYS", "NODE", "CPU"
+};
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -531,9 +536,13 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
 
+	if (opts->affinity != PERF_AFFINITY_SYS)
+		cpu__setup_cpunode_map();
+
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks, opts->affinity) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -722,6 +731,16 @@ static struct perf_event_header finished_round_event = {
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
@@ -749,6 +768,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+			record__adjust_affinity(rec, map);
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 					rc = -1;
@@ -1639,6 +1659,23 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
 	return -1;
 }
 
+static int record__parse_affinity(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (unset)
+		return 0;
+
+	if (str) {
+		if (!strcasecmp(str, "node"))
+			opts->affinity = PERF_AFFINITY_NODE;
+		else if (!strcasecmp(str, "cpu"))
+			opts->affinity = PERF_AFFINITY_CPU;
+	}
+
+	return 0;
+}
+
 static int record__parse_mmap_pages(const struct option *opt,
 				    const char *str,
 				    int unset __maybe_unused)
@@ -1946,6 +1983,9 @@ static struct option __record_options[] = {
 		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
 #endif
+	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
+		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
+		     record__parse_affinity),
 	OPT_END()
 };
 
@@ -1980,6 +2020,9 @@ int cmd_record(int argc, const char **argv)
 # undef REASON
 #endif
 
+	CPU_ZERO(&rec->affinity_mask);
+	rec->opts.affinity = PERF_AFFINITY_SYS;
+
 	rec->evlist = perf_evlist__new();
 	if (rec->evlist == NULL)
 		return -ENOMEM;
@@ -2143,6 +2186,8 @@ int cmd_record(int argc, const char **argv)
 	if (verbose > 0)
 		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
+	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 388c6dd128b8..36d5cfe6362f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -83,6 +83,14 @@ struct record_opts {
 	clockid_t    clockid;
 	u64          clockid_res_ns;
 	int	     nr_cblocks;
+	int	     affinity;
+};
+
+enum perf_affinity {
+	PERF_AFFINITY_SYS = 0,
+	PERF_AFFINITY_NODE,
+	PERF_AFFINITY_CPU,
+	PERF_AFFINITY_MAX
 };
 
 struct option;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8c902276d4b4..b6680f65ccc4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1022,7 +1022,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1032,7 +1032,11 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
+	struct mmap_params mp = {
+		.nr_cblocks	= nr_cblocks,
+		.affinity	= affinity,
+		.cpu_map	= cpus
+	};
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1064,7 +1068,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 868294491194..72728d7f4432 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -162,7 +162,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks);
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8fc39311a30d..ee0230eed635 100644
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
@@ -154,9 +157,68 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 }
 
 #ifdef HAVE_AIO_SUPPORT
+
+#ifdef HAVE_LIBNUMA_SUPPORT
+static int perf_mmap__aio_alloc(struct perf_mmap *map, int index)
+{
+	map->aio.data[index] = mmap(NULL, perf_mmap__mmap_len(map), PROT_READ|PROT_WRITE,
+				    MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+	if (map->aio.data[index] == MAP_FAILED) {
+		map->aio.data[index] = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
+static void perf_mmap__aio_free(struct perf_mmap *map, int index)
+{
+	if (map->aio.data[index]) {
+		munmap(map->aio.data[index], perf_mmap__mmap_len(map));
+		map->aio.data[index] = NULL;
+	}
+}
+
+static void perf_mmap__aio_bind(struct perf_mmap *map, int index, int cpu, int affinity)
+{
+	void *data;
+	size_t mmap_len;
+	unsigned long node_mask;
+
+	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
+		data = map->aio.data[index];
+		mmap_len = perf_mmap__mmap_len(map);
+		node_mask = 1UL << cpu__get_node(cpu);
+		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
+			pr_warn("failed to bind [%p-%p] to node %d\n",
+				data, data + mmap_len, cpu__get_node(cpu));
+		}
+	}
+}
+#else
+static int perf_mmap__aio_alloc(struct perf_mmap *map, int index)
+{
+	map->aio.data[index] = malloc(perf_mmap__mmap_len(map));
+	if (map->aio.data[index] == NULL)
+		return -1;
+
+	return 0;
+}
+
+static void perf_mmap__aio_free(struct perf_mmap *map, int index)
+{
+	zfree(&(map->aio.data[index]));
+}
+
+static void perf_mmap__aio_bind(struct perf_mmap *map __maybe_unused, int index __maybe_unused,
+		int cpu __maybe_unused, int affinity __maybe_unused)
+{
+}
+#endif
+
 static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 {
-	int delta_max, i, prio;
+	int delta_max, i, prio, ret;
 
 	map->aio.nr_cblocks = mp->nr_cblocks;
 	if (map->aio.nr_cblocks) {
@@ -177,11 +239,12 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 		}
 		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
 		for (i = 0; i < map->aio.nr_cblocks; ++i) {
-			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
-			if (!map->aio.data[i]) {
+			ret = perf_mmap__aio_alloc(map, i);
+			if (ret == -1) {
 				pr_debug2("failed to allocate data buffer area, error %m");
 				return -1;
 			}
+			perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
 			/*
 			 * Use cblock.aio_fildes value different from -1
 			 * to denote started aio write operation on the
@@ -210,7 +273,7 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 	int i;
 
 	for (i = 0; i < map->aio.nr_cblocks; ++i)
-		zfree(&map->aio.data[i]);
+		perf_mmap__aio_free(map, i);
 	if (map->aio.data)
 		zfree(&map->aio.data);
 	zfree(&map->aio.cblocks);
@@ -314,6 +377,24 @@ void perf_mmap__munmap(struct perf_mmap *map)
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
@@ -343,6 +424,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 	map->fd = fd;
 	map->cpu = cpu;
 
+	perf_mmap__setup_affinity_mask(map, mp);
+
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index aeb6942fdb00..b3f724fad22e 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -38,6 +38,7 @@ struct perf_mmap {
 		int		 nr_cblocks;
 	} aio;
 #endif
+	cpu_set_t	affinity_mask;
 };
 
 /*
@@ -69,8 +70,9 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask, nr_cblocks;
+	int			    prot, mask, nr_cblocks, affinity;
 	struct auxtrace_mmap_params auxtrace_mp;
+	const struct cpu_map	    *cpu_map;
 };
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu);

> 
> jirka
> 
