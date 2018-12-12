Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA95C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5B520811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5B520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeLLHyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:54:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:43443 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLHyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:54:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 23:54:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="106790869"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 11 Dec 2018 23:54:21 -0800
Received: from [10.125.251.226] (abudanko-mobl.ccr.corp.intel.com [10.125.251.226])
        by linux.intel.com (Postfix) with ESMTP id E27EE58079D;
        Tue, 11 Dec 2018 23:54:18 -0800 (PST)
Subject: [PATCH v1 1/3] perf record: allocate affinity masks
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
Organization: Intel Corp.
Message-ID: <b00e18af-4e77-ddcc-c0d7-cde6e54c0f9b@linux.intel.com>
Date:   Wed, 12 Dec 2018 10:54:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Allocate affinity option and masks for mmap data buffers and
record thread as well as initialize allocated objects.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 11 ++++++++++-
 tools/perf/perf.h           |  5 +++++
 tools/perf/util/evlist.c    |  6 +++---
 tools/perf/util/evlist.h    |  2 +-
 tools/perf/util/mmap.c      |  2 ++
 tools/perf/util/mmap.h      |  3 ++-
 6 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..4979719e54ae 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -81,6 +81,7 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
+	cpu_set_t		affinity_mask;
 };
 
 static volatile int auxtrace_record__snapshot_started;
@@ -533,7 +534,8 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks, opts->affinity) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -1980,6 +1982,9 @@ int cmd_record(int argc, const char **argv)
 # undef REASON
 #endif
 
+	CPU_ZERO(&rec->affinity_mask);
+	rec->opts.affinity = PERF_AFFINITY_SYS;
+
 	rec->evlist = perf_evlist__new();
 	if (rec->evlist == NULL)
 		return -ENOMEM;
@@ -2143,6 +2148,10 @@ int cmd_record(int argc, const char **argv)
 	if (verbose > 0)
 		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
+	pr_debug("affinity (UNSET:%d, NODE:%d, CPU:%d) = %d\n",
+		 PERF_AFFINITY_SYS, PERF_AFFINITY_NODE,
+		 PERF_AFFINITY_CPU, rec->opts.affinity);
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 388c6dd128b8..08e75815de2f 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -83,8 +83,13 @@ struct record_opts {
 	clockid_t    clockid;
 	u64          clockid_res_ns;
 	int	     nr_cblocks;
+	int	     affinity;
 };
 
+#define PERF_AFFINITY_SYS  0
+#define PERF_AFFINITY_NODE 1
+#define PERF_AFFINITY_CPU  2
+
 struct option;
 extern const char * const *record_usage;
 extern struct option *record_options;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e90575192209..60e825be944a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1018,7 +1018,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1028,7 +1028,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1060,7 +1060,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
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
index 8fc39311a30d..e68ba754a8e2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -343,6 +343,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 	map->fd = fd;
 	map->cpu = cpu;
 
+	CPU_ZERO(&map->affinity_mask);
+
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
 				&mp->auxtrace_mp, map->base, fd))
 		return -1;
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index aeb6942fdb00..e566c19b242b 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -38,6 +38,7 @@ struct perf_mmap {
 		int		 nr_cblocks;
 	} aio;
 #endif
+	cpu_set_t	affinity_mask;
 };
 
 /*
@@ -69,7 +70,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask, nr_cblocks;
+	int			    prot, mask, nr_cblocks, affinity;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
