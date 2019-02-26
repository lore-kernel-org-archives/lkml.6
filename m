Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC24C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68F6217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfBZF7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:59:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:64140 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfBZF7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:59:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 21:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="277884776"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2019 21:59:48 -0800
Received: from [10.251.90.22] (abudanko-mobl.ccr.corp.intel.com [10.251.90.22])
        by linux.intel.com (Postfix) with ESMTP id 98B00580261;
        Mon, 25 Feb 2019 21:59:45 -0800 (PST)
Subject: [PATCH v3 4/9] perf record: implement COMPRESSED event record and its
 attributes
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
Organization: Intel Corp.
Message-ID: <bc601e5f-564f-7999-8849-cc293b43dee6@linux.intel.com>
Date:   Tue, 26 Feb 2019 08:59:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <10824243-040d-4b44-65c0-2c63870e9bb6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implemented PERF_RECORD_COMPRESSED event, related data types, header
feature and functions to write, read and print feature attributes
from the trace header section.

comp_mmap_len preserves the size of mmaped kernel buffer that was used
during collection. comp_mmap_len size is used on loading stage as the
size of decomp buffer for decompression of COMPRESSED events content.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c |  9 ++++++
 tools/perf/perf.h           |  1 +
 tools/perf/util/env.h       | 10 +++++++
 tools/perf/util/event.c     |  1 +
 tools/perf/util/event.h     |  7 +++++
 tools/perf/util/header.c    | 55 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h    |  1 +
 7 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 299f484f3e30..61017fa0ee1c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -357,6 +357,11 @@ static int record__mmap_flush_parse(const struct option *opt,
 	return 0;
 }
 
+static int record__comp_enabled(struct record *rec)
+{
+	return rec->opts.comp_level > 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -873,6 +878,9 @@ static void record__init_features(struct record *rec)
 	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
 		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
 
+	if (!record__comp_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
@@ -1211,6 +1219,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = -1;
 		goto out_child;
 	}
+	session->header.env.comp_mmap_len = session->evlist->mmap_len;
 
 	err = bpf__apply_obj_config();
 	if (err) {
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 7886cc9771cf..2c6caad45b10 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -86,6 +86,7 @@ struct record_opts {
 	int	     nr_cblocks;
 	int	     affinity;
 	int	     mmap_flush;
+	unsigned int comp_level;
 };
 
 enum perf_affinity {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index fb39e9af128f..7990d63ab764 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -65,6 +65,16 @@ struct perf_env {
 	unsigned long long	 memory_bsize;
 	u64                     clockid_res_ns;
 	u32                     comp_ratio;
+	u32			comp_ver;
+	u32			comp_type;
+	u32			comp_level;
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
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a2323d777dae..011b464fdad7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1250,6 +1250,30 @@ static int write_mem_topology(struct feat_fd *ff __maybe_unused,
 	return ret;
 }
 
+static int write_compressed(struct feat_fd *ff __maybe_unused,
+			    struct perf_evlist *evlist __maybe_unused)
+{
+	int ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_ver), sizeof(ff->ph->env.comp_ver));
+	if (ret)
+		return ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_type), sizeof(ff->ph->env.comp_type));
+	if (ret)
+		return ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_level), sizeof(ff->ph->env.comp_level));
+	if (ret)
+		return ret;
+
+	ret = do_write(ff, &(ff->ph->env.comp_ratio), sizeof(ff->ph->env.comp_ratio));
+	if (ret)
+		return ret;
+
+	return do_write(ff, &(ff->ph->env.comp_mmap_len), sizeof(ff->ph->env.comp_mmap_len));
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1537,6 +1561,13 @@ static void print_cache(struct feat_fd *ff, FILE *fp __maybe_unused)
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
@@ -2379,6 +2410,27 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_compressed(struct feat_fd *ff,
+			      void *data __maybe_unused)
+{
+	if (do_read_u32(ff, &(ff->ph->env.comp_ver)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_type)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_level)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_ratio)))
+		return -1;
+
+	if (do_read_u32(ff, &(ff->ph->env.comp_mmap_len)))
+		return -1;
+
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2438,7 +2490,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
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
