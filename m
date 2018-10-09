Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4F4C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBA7214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBA7214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeJIVxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:53:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:26134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbeJIVxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:53:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2018 07:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,360,1534834800"; 
   d="scan'208";a="93617370"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2018 07:36:27 -0700
Received: from [10.125.251.255] (abudanko-mobl.ccr.corp.intel.com [10.125.251.255])
        by linux.intel.com (Postfix) with ESMTP id 3BB67580409;
        Tue,  9 Oct 2018 07:36:25 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v5] perf record: encode -k clockid frequency into Perf trace
Organization: Intel Corp.
Message-ID: <23a4a1dc-b160-85a0-347d-40a2ed6d007b@linux.intel.com>
Date:   Tue, 9 Oct 2018 17:36:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Store -k clockid frequency into Perf trace to enable timestamps 
derived metrics conversion into wall clock time on reporting stage.

Below is the example of perf report output:

  tools/perf/perf record -k raw -- ../../matrix/linux/matrix.gcc
  ...
  [ perf record: Captured and wrote 31.222 MB perf.data (818054 samples) ]
  
  tools/perf/perf report --header
  # ========
  ...
  # event : name = cycles:ppp, , size = 112, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, disabled = 1, inherit = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, use_clockid = 1, clockid = 4
  ...
  # clockid frequency: 1000 MHz
  ...
  # ========

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v5:
 - use u64 for clockid_res_ns values to simplify operations with trace header
Changes in v4:
 - addressed compilation issues on 32bit platforms
Changes in v3:
 - moved header's clockid_res_ns initialization out of record__init_features()
 - added explicit warning for case of failed clock_getres() call
Changes in v2:
 - renamed clockid_freq to clockid_res_ns and get_clockid_freq() to get_clockid_res()
 - avoided redundant define of NSEC_IN_SEC, reused linux/time64.h:NSEC_PER_SEC
 - moved MHz conversion into print_clockid() and shortened write_clockid()
---
 tools/perf/builtin-record.c | 24 ++++++++++++++++++++++--
 tools/perf/perf.h           |  1 +
 tools/perf/util/env.h       |  1 +
 tools/perf/util/header.c    | 23 +++++++++++++++++++++++
 tools/perf/util/header.h    |  1 +
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0980dfe3396b..10cf889c6d75 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -592,6 +592,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.full_auxtrace)
 		perf_header__clear_feat(&session->header, HEADER_AUXTRACE);
 
+	if (!(rec->opts.use_clockid && rec->opts.clockid_res_ns))
+		perf_header__clear_feat(&session->header, HEADER_CLOCKID);
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
@@ -897,6 +900,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	record__init_features(rec);
 
+	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
+		session->header.env.clockid_res_ns = rec->opts.clockid_res_ns;
+
 	if (forks) {
 		err = perf_evlist__prepare_workload(rec->evlist, &opts->target,
 						    argv, data->is_pipe,
@@ -1337,6 +1343,19 @@ static const struct clockid_map clockids[] = {
 	CLOCKID_END,
 };
 
+static int get_clockid_res(clockid_t clk_id, u64 *res_ns)
+{
+	struct timespec res;
+
+	*res_ns = 0;
+	if (!clock_getres(clk_id, &res))
+		*res_ns = res.tv_nsec + res.tv_sec * NSEC_PER_SEC;
+	else
+		pr_warning("WARNING: Failed to determine specified clock resolution.\n");
+
+	return 0;
+}
+
 static int parse_clockid(const struct option *opt, const char *str, int unset)
 {
 	struct record_opts *opts = (struct record_opts *)opt->value;
@@ -1360,7 +1379,7 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
 
 	/* if its a number, we're done */
 	if (sscanf(str, "%d", &opts->clockid) == 1)
-		return 0;
+		return get_clockid_res(opts->clockid, &opts->clockid_res_ns);
 
 	/* allow a "CLOCK_" prefix to the name */
 	if (!strncasecmp(str, "CLOCK_", 6))
@@ -1369,7 +1388,8 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
 	for (cm = clockids; cm->name; cm++) {
 		if (!strcasecmp(str, cm->name)) {
 			opts->clockid = cm->clockid;
-			return 0;
+			return get_clockid_res(opts->clockid,
+					       &opts->clockid_res_ns);
 		}
 	}
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5a3cf5..0ed4a34c74c4 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -81,6 +81,7 @@ struct record_opts {
 	unsigned     initial_delay;
 	bool         use_clockid;
 	clockid_t    clockid;
+	u64          clockid_res_ns;
 	unsigned int proc_map_timeout;
 };
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 1f3ccc368530..d01b8355f4ca 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -63,6 +63,7 @@ struct perf_env {
 	struct numa_node	*numa_nodes;
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
+	u64                     clockid_res_ns;
 };
 
 extern struct perf_env perf_env;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1ec1d9bc2d63..4fd45be95a43 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1034,6 +1034,13 @@ static int write_auxtrace(struct feat_fd *ff,
 	return err;
 }
 
+static int write_clockid(struct feat_fd *ff,
+			 struct perf_evlist *evlist __maybe_unused)
+{
+	return do_write(ff, &ff->ph->env.clockid_res_ns,
+			sizeof(ff->ph->env.clockid_res_ns));
+}
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1508,6 +1515,12 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 		fprintf(fp, "# Core ID and Socket ID information is not available\n");
 }
 
+static void print_clockid(struct feat_fd *ff, FILE *fp)
+{
+	fprintf(fp, "# clockid frequency: %"PRIu64" MHz\n",
+		ff->ph->env.clockid_res_ns * 1000);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2531,6 +2544,15 @@ static int process_mem_topology(struct feat_fd *ff,
 	return ret;
 }
 
+static int process_clockid(struct feat_fd *ff,
+			   void *data __maybe_unused)
+{
+	if (do_read_u64(ff, &ff->ph->env.clockid_res_ns))
+		return -1;
+
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2590,6 +2612,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
+	FEAT_OPR(CLOCKID,       clockid,        false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index e17903caa71d..0d553ddca0a3 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -38,6 +38,7 @@ enum {
 	HEADER_CACHE,
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
+	HEADER_CLOCKID,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
