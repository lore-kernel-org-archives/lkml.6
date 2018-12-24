Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E736BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A517921850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbeLXNp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:45:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:30075 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbeLXNp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:45:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2018 05:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,392,1539673200"; 
   d="scan'208";a="306329354"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 24 Dec 2018 05:45:25 -0800
Received: from [10.252.4.220] (abudanko-mobl.ccr.corp.intel.com [10.252.4.220])
        by linux.intel.com (Postfix) with ESMTP id D4DDD58048A;
        Mon, 24 Dec 2018 05:45:22 -0800 (PST)
Subject: [PATCH v1 2/4] perf record: introduce z, mmap-flush options and
 PERF_RECORD_COMPRESSED record
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d8b15698-67da-3fea-8bd5-32e18d223e99@linux.intel.com>
Date:   Mon, 24 Dec 2018 16:45:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce --compression_level=n, --mmap-flush options and PERF_RECORD_COMPRESSED 
event record that contains compressed parts of mmap kernel buffer data.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 11 +++
 tools/perf/builtin-record.c              | 97 ++++++++++++++++++++----
 tools/perf/perf.h                        |  2 +
 tools/perf/util/env.h                    | 10 +++
 tools/perf/util/event.c                  |  1 +
 tools/perf/util/event.h                  |  7 ++
 tools/perf/util/evlist.c                 |  6 +-
 tools/perf/util/evlist.h                 |  2 +-
 tools/perf/util/header.c                 | 47 +++++++++++-
 tools/perf/util/header.h                 |  1 +
 tools/perf/util/mmap.c                   |  4 +-
 tools/perf/util/mmap.h                   |  3 +-
 12 files changed, 169 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..b849dfdefefe 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -440,6 +440,17 @@ Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default:
 Asynchronous mode is supported only when linking Perf tool with libc library
 providing implementation for Posix AIO API.
 
+-z::
+--compression-level=n::
+Produce compressed trace file to save storage space using specified level n (default: 0,
+best speed: 1, best compression: 22). Compression can be activated in asynchronous trace
+writing mode (--aio) only.
+
+--mmap-flush=n::
+Minimal number of bytes accumulated in mmap buffer that is flushed to trace file (default: 1).
+When compression mode (-z) is enabled it is recommended to set --mmap-flush to 4096 or more.
+Maximal allowed value is a quater of mmap kernel buffer size.
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..cb0b880281d7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -81,6 +81,8 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
+	u64			bytes_transferred;
+	u64			bytes_compressed;
 };
 
 static volatile int auxtrace_record__snapshot_started;
@@ -286,13 +288,17 @@ static int record__aio_parse(const struct option *opt,
 
 	if (unset) {
 		opts->nr_cblocks = 0;
-	} else {
-		if (str)
-			opts->nr_cblocks = strtol(str, NULL, 0);
-		if (!opts->nr_cblocks)
-			opts->nr_cblocks = nr_cblocks_default;
+		return 0;
 	}
 
+	if (str)
+		opts->nr_cblocks = strtol(str, NULL, 0);
+	if (!opts->nr_cblocks)
+		opts->nr_cblocks = nr_cblocks_default;
+
+	if (opts->nr_cblocks > nr_cblocks_max)
+		opts->nr_cblocks = nr_cblocks_max;
+
 	return 0;
 }
 #else /* HAVE_AIO_SUPPORT */
@@ -328,6 +334,30 @@ static int record__aio_enabled(struct record *rec)
 	return rec->opts.nr_cblocks > 0;
 }
 
+#define MMAP_FLUSH_DEFAULT 1
+
+static int record__mmap_flush_parse(const struct option *opt,
+				    const char *str,
+				    int unset)
+{
+	int mmap_len;
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (unset)
+		return 0;
+
+	if (str)
+		opts->mmap_flush = strtol(str, NULL, 0);
+	if (!opts->mmap_flush)
+		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
+
+	mmap_len = perf_evlist__mmap_size(opts->mmap_pages);
+	if (opts->mmap_flush > mmap_len / 4 )
+		opts->mmap_flush = mmap_len / 4;
+
+	return 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -533,7 +563,8 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks, opts->mmap_flush) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -723,7 +754,7 @@ static struct perf_event_header finished_round_event = {
 };
 
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
-				    bool overwrite)
+				    bool overwrite, bool sync)
 {
 	u64 bytes_written = rec->bytes_written;
 	int i;
@@ -746,11 +777,18 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		off = record__aio_get_pos(trace_fd);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		u64 flush;
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+			if (sync) {
+				flush = map->flush;
+				map->flush = MMAP_FLUSH_DEFAULT;
+			}
 			if (!record__aio_enabled(rec)) {
 				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
+					if (sync)
+						map->flush = flush;
 					rc = -1;
 					goto out;
 				}
@@ -763,10 +801,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				idx = record__aio_sync(map, false);
 				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
 					record__aio_set_pos(trace_fd, off);
+					if (sync)
+						map->flush = flush;
 					rc = -1;
 					goto out;
 				}
 			}
+			if (sync)
+				map->flush = flush;
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
@@ -792,15 +834,15 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	return rc;
 }
 
-static int record__mmap_read_all(struct record *rec)
+static int record__mmap_read_all(struct record *rec, bool sync)
 {
 	int err;
 
-	err = record__mmap_read_evlist(rec, rec->evlist, false);
+	err = record__mmap_read_evlist(rec, rec->evlist, false, sync);
 	if (err)
 		return err;
 
-	return record__mmap_read_evlist(rec, rec->evlist, true);
+	return record__mmap_read_evlist(rec, rec->evlist, true, sync);
 }
 
 static void record__init_features(struct record *rec)
@@ -826,6 +868,9 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	if (!(rec->opts.comp_level && rec->opts.nr_cblocks))
+		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
@@ -1130,6 +1175,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	fd = perf_data__fd(data);
 	rec->session = session;
 
+	session->header.env.comp_type = PERF_COMP_NONE;
+	rec->opts.comp_level = 0;
+	session->header.env.comp_level = rec->opts.comp_level;
+
 	record__init_features(rec);
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
@@ -1159,6 +1208,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = -1;
 		goto out_child;
 	}
+	session->header.env.comp_mmap_len = session->evlist->mmap_len;
 
 	err = bpf__apply_obj_config();
 	if (err) {
@@ -1294,7 +1344,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (trigger_is_hit(&switch_output_trigger) || done || draining)
 			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
 
-		if (record__mmap_read_all(rec) < 0) {
+		if (record__mmap_read_all(rec, false) < 0) {
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
@@ -1395,8 +1445,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
+	if (!quiet && rec->bytes_transferred && rec->bytes_compressed) {
+		float ratio = (float)rec->bytes_transferred/(float)rec->bytes_compressed;
+		session->header.env.comp_ratio = ratio + 0.5;
+		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
+			rec->bytes_transferred / 1024.0 / 1024.0, rec->bytes_compressed / 1024.0 / 1024.0, ratio);
+	}
+
 	if (forks) {
 		int exit_status;
 
@@ -1782,6 +1840,7 @@ static struct record record = {
 			.uses_mmap   = true,
 			.default_per_cpu = true,
 		},
+		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1945,7 +2004,12 @@ static struct option __record_options[] = {
 	OPT_CALLBACK_OPTARG(0, "aio", &record.opts,
 		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
+	OPT_UINTEGER('z', "compression-level", &record.opts.comp_level,
+		     "Produce compressed trace file (default: 0, best speed: 1, best compression: 22)"),
 #endif
+	OPT_CALLBACK(0, "mmap-flush", &record.opts, "num",
+		     "Minimal number of bytes in mmap buffer that is flushed to trace file (default: 1)",
+		     record__mmap_flush_parse),
 	OPT_END()
 };
 
@@ -2138,10 +2202,13 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
-	if (rec->opts.nr_cblocks > nr_cblocks_max)
-		rec->opts.nr_cblocks = nr_cblocks_max;
-	if (verbose > 0)
-		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
+	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
+
+	if (rec->opts.comp_level > 22)
+		rec->opts.comp_level = 0;
+	pr_debug("Compression level: %d\n", rec->opts.comp_level);
+
+	pr_debug("mmap flush (B): %d\n", rec->opts.mmap_flush);
 
 	err = __cmd_record(&record, argc, argv);
 out:
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 388c6dd128b8..0352b5a5b9d5 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -83,6 +83,8 @@ struct record_opts {
 	clockid_t    clockid;
 	u64          clockid_res_ns;
 	int	     nr_cblocks;
+	unsigned int comp_level;
+	int	     mmap_flush;
 };
 
 struct option;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d01b8355f4ca..3d1ab2ccc128 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -64,6 +64,16 @@ struct perf_env {
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
 	u64                     clockid_res_ns;
+	u32			comp_type;
+	u32			comp_level;
+	u32			comp_ratio;
+	u32			comp_mmap_len;
+};
+
+enum perf_compress_type {
+	PERF_COMP_NONE = 0,
+	PERF_COMP_ZSTD,
+	PERF_COMP_EOF
 };
 
 extern struct perf_env perf_env;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 937a5a4f71cc..20730ba2a08b 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -62,6 +62,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_EVENT_UPDATE]		= "EVENT_UPDATE",
 	[PERF_RECORD_TIME_CONV]			= "TIME_CONV",
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
+	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 };
 
 static const char *perf_ns__names[] = {
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index eb95f3384958..03960cfbe8d3 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -249,6 +249,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_EVENT_UPDATE		= 78,
 	PERF_RECORD_TIME_CONV			= 79,
 	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -620,6 +621,11 @@ struct feature_event {
 	char				data[];
 };
 
+struct compressed_event {
+	struct perf_event_header	header;
+	char				data[];
+};
+
 union perf_event {
 	struct perf_event_header	header;
 	struct mmap_event		mmap;
@@ -651,6 +657,7 @@ union perf_event {
 	struct stat_round_event		stat_round;
 	struct time_conv_event		time_conv;
 	struct feature_event		feat;
+	struct compressed_event		pack;
 };
 
 void perf_event__print_totals(void);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8c902276d4b4..c82d4fd32dcf 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1022,7 +1022,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks)
+			 bool auxtrace_overwrite, int nr_cblocks, int flush)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1032,7 +1032,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .flush = flush };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1064,7 +1064,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, 1);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 868294491194..33af704e55a2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -162,7 +162,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks);
+			 bool auxtrace_overwrite, int nr_cblocks, int flush);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..37ab460b6f06 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1463,6 +1463,23 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	return ret;
 }
 
+static int write_compressed(struct feat_fd *ff __maybe_unused,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	int ret;
+	u64 compression_info = ((u64)ff->ph->env.comp_type  << 32) |
+			             ff->ph->env.comp_level;
+
+	ret = do_write(ff, &compression_info, sizeof(compression_info));
+	if (ret)
+		return ret;
+
+	compression_info = ((u64)ff->ph->env.comp_ratio << 32) |
+	                         ff->ph->env.comp_mmap_len;
+
+	return do_write(ff, &compression_info, sizeof(compression_info));
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1750,6 +1767,13 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
 	}
 }
 
+static void print_compressed(struct feat_fd *ff, FILE *fp)
+{
+	fprintf(fp, "# compressed : %s, level = %d, ratio = %d\n",
+		ff->ph->env.comp_type == PERF_COMP_ZSTD ? "Zstd" : "Unknown",
+		ff->ph->env.comp_level, ff->ph->env.comp_ratio);
+}
+
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
 {
 	const char *delimiter = "# pmu mappings: ";
@@ -2592,6 +2616,26 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_compressed(struct feat_fd *ff,
+			      void *data __maybe_unused)
+{
+	u64 compression_info;
+
+	if (do_read_u64(ff, &compression_info))
+		return -1;
+
+	ff->ph->env.comp_type  = (compression_info >> 32) & 0xffffffffULL;
+	ff->ph->env.comp_level = compression_info & 0xffffffffULL;
+
+	if (do_read_u64(ff, &compression_info))
+		return -1;
+
+	ff->ph->env.comp_ratio = (compression_info >> 32) & 0xffffffffULL;
+	ff->ph->env.comp_mmap_len = compression_info & 0xffffffffULL;
+
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2651,7 +2695,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
-	FEAT_OPR(CLOCKID,       clockid,        false)
+	FEAT_OPR(CLOCKID,       clockid,        false),
+	FEAT_OPR(COMPRESSED,	compressed,	false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0d553ddca0a3..ee867075dc64 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -39,6 +39,7 @@ enum {
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
+	HEADER_COMPRESSED,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 8fc39311a30d..5e71b0183e33 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -347,6 +347,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
 
+	map->flush = mp->flush;
+
 	return perf_mmap__aio_mmap(map, mp);
 }
 
@@ -395,7 +397,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
 	md->start = md->overwrite ? head : old;
 	md->end = md->overwrite ? old : head;
 
-	if (md->start == md->end)
+	if ((md->end - md->start) < md->flush)
 		return -EAGAIN;
 
 	size = md->end - md->start;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index aeb6942fdb00..afbfb8b58d45 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -30,6 +30,7 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	u64		 flush;
 #ifdef HAVE_AIO_SUPPORT
 	struct {
 		void		 **data;
@@ -69,7 +70,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask, nr_cblocks;
+	int			    prot, mask, nr_cblocks, flush;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
