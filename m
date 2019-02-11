Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE1EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C4321874
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbfBKUWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:22:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:13689 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfBKUWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:22:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 12:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="145982916"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 12:22:42 -0800
Received: from [10.252.27.66] (abudanko-mobl.ccr.corp.intel.com [10.252.27.66])
        by linux.intel.com (Postfix) with ESMTP id D33315800C6;
        Mon, 11 Feb 2019 12:22:39 -0800 (PST)
Subject: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
Date:   Mon, 11 Feb 2019 23:22:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement -z,--compression_level=<n> and --mmap-flush=<dump_least_size>
options as well as a special PERF_RECORD_COMPRESSED record that contains
compressed parts of kernel data buffer.

Because compression requires auxilary memory to implement encoding of
kernel data record->opts.nr_cblocks == -1 signifies to preallocate single
AIO data buffer aio.data[0] without accompnying AIO control blocks.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- enabled allocation aio data buffers for compression

---
 tools/perf/Documentation/perf-record.txt |   9 ++
 tools/perf/builtin-record.c              | 110 +++++++++++++++++++----
 tools/perf/perf.h                        |   2 +
 tools/perf/util/env.h                    |  10 +++
 tools/perf/util/event.c                  |   1 +
 tools/perf/util/event.h                  |   7 ++
 tools/perf/util/evlist.c                 |   6 +-
 tools/perf/util/evlist.h                 |   3 +-
 tools/perf/util/header.c                 |  45 +++++++++-
 tools/perf/util/header.h                 |   1 +
 tools/perf/util/mmap.c                   |  98 ++++++++++++--------
 tools/perf/util/mmap.h                   |   7 +-
 tools/perf/util/session.h                |   2 +
 13 files changed, 240 insertions(+), 61 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 8f0c2be34848..3682efdf3edd 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -459,6 +459,15 @@ Set affinity mask of trace reading thread according to the policy defined by 'mo
   node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
   cpu  - thread affinity mask is set to cpu of the processed mmap buffer
 
+-z::
+--compression-level=n::
+Produce compressed trace file using specified level n to save storage space (no compression: 0 - default,
+fastest compression: 1, smallest trace file: 22)
+
+--mmap-flush=n::
+Minimal number of bytes accumulated in kernel buffer that is flushed to trace file (default: 1).
+Maximal allowed value is a quater of kernel buffer size.
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6c3719ac901d..227dbbd47d3f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -292,18 +292,20 @@ static int record__aio_parse(const struct option *opt,
 
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
-static int nr_cblocks_max = 0;
-
 static int record__aio_sync(struct perf_mmap *md __maybe_unused, bool sync_all __maybe_unused)
 {
 	return -1;
@@ -334,6 +336,35 @@ static int record__aio_enabled(struct record *rec)
 	return rec->opts.nr_cblocks > 0;
 }
 
+#define MMAP_FLUSH_DEFAULT 1
+
+static int record__comp_enabled(struct record *rec)
+{
+	return rec->opts.comp_level > 0;
+}
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
+	if (opts->mmap_flush > mmap_len / 4)
+		opts->mmap_flush = mmap_len / 4;
+
+	return 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -543,7 +574,8 @@ static int record__mmap_evlist(struct record *rec,
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode,
-				 opts->nr_cblocks, opts->affinity) < 0) {
+				 opts->nr_cblocks, opts->affinity,
+				 opts->mmap_flush) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -734,7 +766,7 @@ static void record__adjust_affinity(struct record *rec, struct perf_mmap *map)
 }
 
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
-				    bool overwrite)
+				    bool overwrite, bool sync)
 {
 	u64 bytes_written = rec->bytes_written;
 	int i;
@@ -757,12 +789,19 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		off = record__aio_get_pos(trace_fd);
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
+		u64 flush = MMAP_FLUSH_DEFAULT;
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
 			record__adjust_affinity(rec, map);
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
@@ -775,10 +814,14 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
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
@@ -804,15 +847,15 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
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
@@ -838,6 +881,9 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	if (!record__comp_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
@@ -1147,6 +1193,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	fd = perf_data__fd(data);
 	rec->session = session;
 
+	rec->opts.comp_level = 0;
+	session->header.env.comp_level = rec->opts.comp_level;
+	session->header.env.comp_type = PERF_COMP_NONE;
+
 	record__init_features(rec);
 
 	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
@@ -1176,6 +1226,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = -1;
 		goto out_child;
 	}
+	session->header.env.comp_mmap_len = session->evlist->mmap_len;
 
 	err = bpf__apply_obj_config();
 	if (err) {
@@ -1311,7 +1362,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (trigger_is_hit(&switch_output_trigger) || done || draining)
 			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
 
-		if (record__mmap_read_all(rec) < 0) {
+		if (record__mmap_read_all(rec, false) < 0) {
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
@@ -1412,8 +1463,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
 
+	if (!quiet && rec->session->bytes_transferred && rec->session->bytes_compressed) {
+		float ratio = (float)rec->session->bytes_transferred/(float)rec->session->bytes_compressed;
+
+		session->header.env.comp_ratio = ratio + 0.5;
+		fprintf(stderr,	"[ perf record: Compressed %.3f MB to %.3f MB, ratio is %.3f ]\n",
+			rec->session->bytes_transferred / 1024.0 / 1024.0, rec->session->bytes_compressed / 1024.0 / 1024.0, ratio);
+	}
+
 	if (forks) {
 		int exit_status;
 
@@ -1814,6 +1874,7 @@ static struct record record = {
 			.uses_mmap   = true,
 			.default_per_cpu = true,
 		},
+		.mmap_flush          = MMAP_FLUSH_DEFAULT,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1982,6 +2043,13 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
+#ifdef HAVE_ZSTD_SUPPORT
+	OPT_UINTEGER('z', "compression-level", &record.opts.comp_level,
+		     "Produce compressed trace file (default: 0, fastest: 1, smallest: 22)"),
+#endif
+	OPT_CALLBACK(0, "mmap-flush", &record.opts, "num",
+		     "Minimal number of bytes in kernel buffer that is flushed to trace file (default: 1)",
+		     record__mmap_flush_parse),
 	OPT_END()
 };
 
@@ -2177,10 +2245,18 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
-	if (rec->opts.nr_cblocks > nr_cblocks_max)
-		rec->opts.nr_cblocks = nr_cblocks_max;
-	if (verbose > 0)
-		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
+	if (rec->opts.comp_level > 22)
+		rec->opts.comp_level = 0;
+	if (record__comp_enabled(rec) && !rec->opts.nr_cblocks) {
+		 /*
+		  * Allocate aio.data[0] buffer for compression.
+		  */
+		rec->opts.nr_cblocks = -1;
+	}
+
+	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
+	pr_debug("comp level: %d\n", rec->opts.comp_level);
+	pr_debug("mmap flush: %d\n", rec->opts.mmap_flush);
 
 	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index b120e547ddc7..e5cf206ab9e0 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -85,6 +85,8 @@ struct record_opts {
 	u64          clockid_res_ns;
 	int	     nr_cblocks;
 	int	     affinity;
+	unsigned int comp_level;
+	int	     mmap_flush;
 };
 
 enum perf_affinity {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d01b8355f4ca..fa5dc9b87029 100644
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
+	PERF_COMP_MAX
 };
 
 extern struct perf_env perf_env;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index ba7be74fad6e..d1ad6c419724 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -68,6 +68,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_EVENT_UPDATE]		= "EVENT_UPDATE",
 	[PERF_RECORD_TIME_CONV]			= "TIME_CONV",
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
+	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 };
 
 static const char *perf_ns__names[] = {
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 36ae7e92dab1..8a13aefe734e 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -254,6 +254,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_EVENT_UPDATE		= 78,
 	PERF_RECORD_TIME_CONV			= 79,
 	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -626,6 +627,11 @@ struct feature_event {
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
@@ -659,6 +665,7 @@ union perf_event {
 	struct feature_event		feat;
 	struct ksymbol_event		ksymbol_event;
 	struct bpf_event		bpf_event;
+	struct compressed_event		pack;
 };
 
 void perf_event__print_totals(void);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 08cedb643ea6..937039faac59 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1022,7 +1022,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity, int flush)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1032,7 +1032,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity, .flush = flush };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1064,7 +1064,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS, 1);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 744906dd4887..edf18811e39f 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -165,7 +165,8 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks, int affinity);
+			 bool auxtrace_overwrite, int nr_cblocks,
+			 int affinity, int flush);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..5ad3a27a042f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1463,6 +1463,21 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	return ret;
 }
 
+static int write_compressed(struct feat_fd *ff __maybe_unused,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	int ret;
+	u64 compression_info = ((u64)ff->ph->env.comp_type  << 32) | ff->ph->env.comp_level;
+
+	ret = do_write(ff, &compression_info, sizeof(compression_info));
+	if (ret)
+		return ret;
+
+	compression_info = ((u64)ff->ph->env.comp_ratio << 32) | ff->ph->env.comp_mmap_len;
+
+	return do_write(ff, &compression_info, sizeof(compression_info));
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1750,6 +1765,13 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
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
@@ -2592,6 +2614,26 @@ static int process_clockid(struct feat_fd *ff,
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
@@ -2651,7 +2693,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
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
index cdc7740fc181..239e9a13c2b7 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -156,8 +156,6 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 {
 }
 
-#ifdef HAVE_AIO_SUPPORT
-
 #ifdef HAVE_LIBNUMA_SUPPORT
 static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
 {
@@ -220,28 +218,24 @@ static int perf_mmap__aio_bind(struct perf_mmap *map __maybe_unused, int idx __m
 }
 #endif
 
+static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map);
+
 static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 {
-	int delta_max, i, prio, ret;
+	int i, ret = 0, init_blocks = 1;
 
 	map->aio.nr_cblocks = mp->nr_cblocks;
+	if (map->aio.nr_cblocks == -1) {
+		map->aio.nr_cblocks = 1;
+		init_blocks = 0;
+	}
+
 	if (map->aio.nr_cblocks) {
-		map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
-		if (!map->aio.aiocb) {
-			pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
-			return -1;
-		}
-		map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
-		if (!map->aio.cblocks) {
-			pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
-			return -1;
-		}
 		map->aio.data = calloc(map->aio.nr_cblocks, sizeof(void *));
 		if (!map->aio.data) {
 			pr_debug2("failed to allocate data buffer, error %m\n");
 			return -1;
 		}
-		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
 		for (i = 0; i < map->aio.nr_cblocks; ++i) {
 			ret = perf_mmap__aio_alloc(map, i);
 			if (ret == -1) {
@@ -251,29 +245,16 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 			ret = perf_mmap__aio_bind(map, i, map->cpu, mp->affinity);
 			if (ret == -1)
 				return -1;
-			/*
-			 * Use cblock.aio_fildes value different from -1
-			 * to denote started aio write operation on the
-			 * cblock so it requires explicit record__aio_sync()
-			 * call prior the cblock may be reused again.
-			 */
-			map->aio.cblocks[i].aio_fildes = -1;
-			/*
-			 * Allocate cblocks with priority delta to have
-			 * faster aio write system calls because queued requests
-			 * are kept in separate per-prio queues and adding
-			 * a new request will iterate thru shorter per-prio
-			 * list. Blocks with numbers higher than
-			 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
-			 */
-			prio = delta_max - i;
-			map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
 		}
+		if (init_blocks)
+			ret = perf_mmap__aio_mmap_blocks(map);
 	}
 
-	return 0;
+	return ret;
 }
 
+static void perf_mmap__aio_munmap_blocks(struct perf_mmap *map);
+
 static void perf_mmap__aio_munmap(struct perf_mmap *map)
 {
 	int i;
@@ -282,6 +263,50 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 		perf_mmap__aio_free(map, i);
 	if (map->aio.data)
 		zfree(&map->aio.data);
+	perf_mmap__aio_munmap_blocks(map);
+}
+
+#ifdef HAVE_AIO_SUPPORT
+static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map)
+{
+	int delta_max, i, prio;
+
+	map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
+	if (!map->aio.aiocb) {
+		pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
+		return -1;
+	}
+	map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
+	if (!map->aio.cblocks) {
+		pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
+		return -1;
+	}
+	delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
+	for (i = 0; i < map->aio.nr_cblocks; ++i) {
+		/*
+		 * Use cblock.aio_fildes value different from -1
+		 * to denote started aio write operation on the
+		 * cblock so it requires explicit record__aio_sync()
+		 * call prior the cblock may be reused again.
+		 */
+		map->aio.cblocks[i].aio_fildes = -1;
+		/*
+		 * Allocate cblocks with priority delta to have
+		 * faster aio write system calls because queued requests
+		 * are kept in separate per-prio queues and adding
+		 * a new request will iterate thru shorter per-prio
+		 * list. Blocks with numbers higher than
+		 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
+		 */
+		prio = delta_max - i;
+		map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
+	}
+
+	return 0;
+}
+
+static void perf_mmap__aio_munmap_blocks(struct perf_mmap *map)
+{
 	zfree(&map->aio.cblocks);
 	zfree(&map->aio.aiocb);
 }
@@ -360,13 +385,12 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 	return rc;
 }
 #else
-static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
-			       struct mmap_params *mp __maybe_unused)
+static int perf_mmap__aio_mmap_blocks(struct perf_mmap *map __maybe_unused)
 {
 	return 0;
 }
 
-static void perf_mmap__aio_munmap(struct perf_mmap *map __maybe_unused)
+static void perf_mmap__aio_munmap_blocks(struct perf_mmap *map __maybe_unused)
 {
 }
 #endif
@@ -444,6 +468,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
 
+	map->flush = mp->flush;
+
 	return perf_mmap__aio_mmap(map, mp);
 }
 
@@ -492,7 +518,7 @@ static int __perf_mmap__read_init(struct perf_mmap *md)
 	md->start = md->overwrite ? head : old;
 	md->end = md->overwrite ? old : head;
 
-	if (md->start == md->end)
+	if ((md->end - md->start) < md->flush)
 		return -EAGAIN;
 
 	size = md->end - md->start;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index e566c19b242b..4fd7d82825b7 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -30,14 +30,15 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
-#ifdef HAVE_AIO_SUPPORT
+	u64		 flush;
 	struct {
 		void		 **data;
+#ifdef HAVE_AIO_SUPPORT
 		struct aiocb	 *cblocks;
 		struct aiocb	 **aiocb;
+#endif
 		int		 nr_cblocks;
 	} aio;
-#endif
 	cpu_set_t	affinity_mask;
 };
 
@@ -70,7 +71,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask, nr_cblocks, affinity;
+	int			    prot, mask, nr_cblocks, affinity, flush;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index d96eccd7d27f..0e14884f28b2 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -35,6 +35,8 @@ struct perf_session {
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
 	struct perf_tool	*tool;
+	u64			bytes_transferred;
+	u64			bytes_compressed;
 };
 
 struct perf_tool;
