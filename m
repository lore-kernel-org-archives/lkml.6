Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B0BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870E6217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfAVRrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:47:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:60786 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfAVRrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:47:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 09:47:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,507,1539673200"; 
   d="scan'208";a="127993530"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2019 09:47:47 -0800
Received: from [10.252.24.137] (abudanko-mobl.ccr.corp.intel.com [10.252.24.137])
        by linux.intel.com (Postfix) with ESMTP id 1E58B58043C;
        Tue, 22 Jan 2019 09:47:44 -0800 (PST)
Subject: [PATCH v5 1/4] perf record: allocate affinity masks
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
Message-ID: <526fa2b0-07de-6dbd-a7e9-26ba875593c9@linux.intel.com>
Date:   Tue, 22 Jan 2019 20:47:43 +0300
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


Allocate affinity option and masks for mmap data buffers and
record thread as well as initialize allocated objects.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v3:
- converted PERF_AFFINITY_EOF to PERF_AFFINITY_MAX

Changes in v2:
- made debug affinity mode message user friendly
- converted affinity mode defines to enum values
---
 tools/perf/builtin-record.c | 13 ++++++++++++-
 tools/perf/perf.h           |  8 ++++++++
 tools/perf/util/evlist.c    |  6 +++---
 tools/perf/util/evlist.h    |  2 +-
 tools/perf/util/mmap.c      |  2 ++
 tools/perf/util/mmap.h      |  3 ++-
 6 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 88ea11d57c6f..370a68487532 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -82,12 +82,17 @@ struct record {
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
@@ -534,7 +539,8 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks, opts->affinity) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -1987,6 +1993,9 @@ int cmd_record(int argc, const char **argv)
 # undef REASON
 #endif
 
+	CPU_ZERO(&rec->affinity_mask);
+	rec->opts.affinity = PERF_AFFINITY_SYS;
+
 	rec->evlist = perf_evlist__new();
 	if (rec->evlist == NULL)
 		return -ENOMEM;
@@ -2150,6 +2159,8 @@ int cmd_record(int argc, const char **argv)
 	if (verbose > 0)
 		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
+	pr_debug("affinity: %s\n", affinity_tags[rec->opts.affinity]);
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 5941fb6eccfc..b120e547ddc7 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -84,6 +84,14 @@ struct record_opts {
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
index 5f01bced3116..6d462ee1b529 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1035,7 +1035,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite, int nr_cblocks)
+			 bool auxtrace_overwrite, int nr_cblocks, int affinity)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1045,7 +1045,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks, .affinity = affinity };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1077,7 +1077,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0, PERF_AFFINITY_SYS);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 18365b1f80b0..bb33872d12fc 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -165,7 +165,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
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
