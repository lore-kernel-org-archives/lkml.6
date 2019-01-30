Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547EA20855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfA3OZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:25:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:27015 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731312AbfA3OZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:25:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 06:24:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="271154317"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga004.jf.intel.com with ESMTP; 30 Jan 2019 06:24:58 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 12/13] perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Wed, 30 Jan 2019 06:23:53 -0800
Message-Id: <1548858234-8872-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
References: <1548858234-8872-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Add a new sort dimension "code_page_size" for common sort.
With this option applied, perf can sort and report by sample's code page
size.

For example,
perf report --stdio --sort=comm,symbol,code_page_size
 # To display the perf.data header info, please use
 # --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 3K of event 'mem-loads:uP'
 # Event count (approx.): 1470769
 #
 # Overhead  Command  Symbol                        Code Page Size IPC
 # [IPC Coverage]
 # ........  .......  ............................  ..............
 # ....................
 #
     69.56%  dtlb     [.] GetTickCount              4K             -

     17.93%  dtlb     [.] Calibrate                 4K             -
 -
     11.40%  dtlb     [.] __gettimeofday            4K             -
 -

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.c                   |  2 ++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 24 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 30 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 2ca0477..b6ecdbc 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -105,6 +105,7 @@ OPTIONS
 	guest machine
 	- sample: Number of sample
 	- period: Raw number of event count of sample
+	- code_page_size: the code page size of sampled code address (ip)
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 253bf3f..e4ab496 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -193,6 +193,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
+	hists__new_col_len(hists, HISTC_CODE_PAGE_SIZE, 6);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
@@ -613,6 +614,7 @@ __hists__add_entry(struct hists *hists,
 		.cpumode = al->cpumode,
 		.ip	 = al->addr,
 		.level	 = al->level,
+		.code_page_size = sample->code_page_size,
 		.stat = {
 			.nr_events = 1,
 			.period	= sample->period,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 2b72d03..76640fc 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -46,6 +46,7 @@ enum hist_column {
 	HISTC_DSO_TO,
 	HISTC_LOCAL_WEIGHT,
 	HISTC_GLOBAL_WEIGHT,
+	HISTC_CODE_PAGE_SIZE,
 	HISTC_MEM_DADDR_SYMBOL,
 	HISTC_MEM_DADDR_DSO,
 	HISTC_MEM_PHYS_DADDR,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 93d1391..0aaf763 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1420,6 +1420,29 @@ struct sort_entry sort_mem_data_page_size = {
 };
 
 static int64_t
+sort__code_page_size_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	uint64_t l = left->code_page_size;
+	uint64_t r = right->code_page_size;
+
+	return (int64_t)(r - l);
+}
+
+static int hist_entry__code_page_size_snprintf(struct hist_entry *he, char *bf,
+					  size_t size, unsigned int width)
+{
+	return repsep_snprintf(bf, size, "%-*s", width,
+			       get_page_size_name(he->code_page_size));
+}
+
+struct sort_entry sort_code_page_size = {
+	.se_header	= "Code Page Size",
+	.se_cmp		= sort__code_page_size_cmp,
+	.se_snprintf	= hist_entry__code_page_size_snprintf,
+	.se_width_idx	= HISTC_CODE_PAGE_SIZE,
+};
+
+static int64_t
 sort__abort_cmp(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info || !right->branch_info)
@@ -1661,6 +1684,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
+	DIM(SORT_CODE_PAGE_SIZE, "code_page_size", sort_code_page_size),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 2e324ae..33e5b46 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -103,6 +103,7 @@ struct hist_entry {
 	u64			transaction;
 	s32			socket;
 	s32			cpu;
+	u64			code_page_size;
 	u8			cpumode;
 	u8			depth;
 
@@ -230,6 +231,7 @@ enum sort_type {
 	SORT_DSO_SIZE,
 	SORT_CGROUP_ID,
 	SORT_SYM_IPC_NULL,
+	SORT_CODE_PAGE_SIZE,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.7.4

