Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCADC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A28206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfBXPif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:38:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:4458 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbfBXPhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2019 07:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="120396830"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2019 07:37:30 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A1AE0301377; Sun, 24 Feb 2019 07:37:30 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 05/11] perf tools report: Support time sort key
Date:   Sun, 24 Feb 2019 07:37:16 -0800
Message-Id: <20190224153722.27020-6-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190224153722.27020-1-andi@firstfloor.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a time sort key to perf report to display samples for
different time quantums separately. This allows easier
analysis of workloads that change over time, and also
will allow looking at the context of samples.

% perf record ...
% perf report --sort time,overhead,symbol --time-quantum 1ms --stdio
...
     0.67%  277061.87300  [.] _dl_start
     0.50%  277061.87300  [.] f1
     0.50%  277061.87300  [.] f2
     0.33%  277061.87300  [.] main
     0.29%  277061.87300  [.] _dl_lookup_symbol_x
     0.29%  277061.87300  [.] dl_main
     0.29%  277061.87300  [.] do_lookup_x
     0.17%  277061.87300  [.] _dl_debug_initialize
     0.17%  277061.87300  [.] _dl_init_paths
     0.08%  277061.87300  [.] check_match
     0.04%  277061.87300  [.] _dl_count_modids
     1.33%  277061.87400  [.] f1
     1.33%  277061.87400  [.] f2
     1.33%  277061.87400  [.] main
     1.17%  277061.87500  [.] main
     1.08%  277061.87500  [.] f1
     1.08%  277061.87500  [.] f2
     1.00%  277061.87600  [.] main
     0.83%  277061.87600  [.] f1
     0.83%  277061.87600  [.] f2
     1.00%  277061.87700  [.] main

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-report.txt |  2 ++
 tools/perf/util/hist.c                   |  9 ++++++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 38 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 52 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 9ec1702bccdd..546d87221ad8 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -105,6 +105,8 @@ OPTIONS
 	guest machine
 	- sample: Number of sample
 	- period: Raw number of event count of sample
+	- time: Separate the samples by time stamp with the resolution specified by
+	--time-quantum (default 100ms). Specify with overhead and before it.
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index d25ca5bb91e6..7bf4d85a3021 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -194,6 +194,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
+	hists__new_col_len(hists, HISTC_TIME, 12);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
@@ -248,6 +249,13 @@ static void he_stat__add_cpumode_period(struct he_stat *he_stat,
 	}
 }
 
+static long hist_time(unsigned long time)
+{
+	if (time_quantum)
+		return (time / time_quantum) * time_quantum;
+	return (time / 1000000) * 1000000;
+}
+
 static void he_stat__add_period(struct he_stat *he_stat, u64 period,
 				u64 weight)
 {
@@ -628,6 +636,7 @@ __hists__add_entry(struct hists *hists,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
 		.ops = ops,
+		.time = hist_time(sample->time),
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 8e602b486c5c..8b21b6d006be 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -31,6 +31,7 @@ enum hist_filter {
 
 enum hist_column {
 	HISTC_SYMBOL,
+	HISTC_TIME,
 	HISTC_DSO,
 	HISTC_THREAD,
 	HISTC_COMM,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d1010a966f9b..974a4c553f82 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -15,6 +15,7 @@
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
 #include "annotate.h"
+#include "time-utils.h"
 #include <linux/kernel.h>
 
 regex_t		parent_regex;
@@ -649,6 +650,42 @@ struct sort_entry sort_socket = {
 	.se_width_idx	= HISTC_SOCKET,
 };
 
+/* --sort time */
+
+static int64_t
+sort__time_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return right->time - left->time;
+}
+
+static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
+				    size_t size, unsigned int width)
+{
+	unsigned long secs;
+	unsigned long long nsecs;
+	char he_time[32];
+
+	nsecs = he->time;
+	secs = nsecs / 1000000000;
+	nsecs -= secs * 1000000000;
+
+	if (nanosecs)
+		snprintf(he_time, sizeof he_time, "%5lu.%09llu: ",
+			 secs, nsecs);
+	else
+		timestamp__scnprintf_usec(he->time, he_time,
+					  sizeof(he_time));
+
+	return repsep_snprintf(bf, size, "%-.*s", width, he_time);
+}
+
+struct sort_entry sort_time = {
+	.se_header      = "Time",
+	.se_cmp	        = sort__time_cmp,
+	.se_snprintf    = hist_entry__time_snprintf,
+	.se_width_idx	= HISTC_TIME,
+};
+
 /* --sort trace */
 
 static char *get_trace_output(struct hist_entry *he)
@@ -1629,6 +1666,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
+	DIM(SORT_TIME, "time", sort_time),
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 98223d952404..fc323f10f474 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -135,6 +135,7 @@ struct hist_entry {
 	char			*srcfile;
 	struct symbol		*parent;
 	struct branch_info	*branch_info;
+	long			time;
 	struct hists		*hists;
 	struct mem_info		*mem_info;
 	void			*raw_data;
@@ -231,6 +232,7 @@ enum sort_type {
 	SORT_DSO_SIZE,
 	SORT_CGROUP_ID,
 	SORT_SYM_IPC_NULL,
+	SORT_TIME,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.17.2

