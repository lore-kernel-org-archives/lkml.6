Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD422087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 05:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfBYFwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 00:52:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:8861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfBYFwG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 00:52:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2019 21:52:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,410,1544515200"; 
   d="scan'208";a="149671624"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2019 21:52:04 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 2/3] perf diff: Support --cpu filter option
Date:   Mon, 25 Feb 2019 21:42:43 +0800
Message-Id: <1551102164-3443-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551102164-3443-1-git-send-email-yao.jin@linux.intel.com>
References: <1551102164-3443-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better support for perf diff, it would be useful to add --cpu filter
option.

Multiple CPUs can be provided as a comma-separated list with no space: 0,1.
Ranges of CPUs are specified with -: 0-2. Default is to report samples on
all CPUs.

For example,

perf diff --cpu 0,1

It only diff the samples for CPU0 and CPU1.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-diff.txt |  5 +++++
 tools/perf/builtin-diff.c              | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index 5bfe876..ed13b3f 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -159,6 +159,11 @@ OPTIONS
 	the end of perf.data.old and analyzes the perf.data from the
 	timestamp 3971.150589 to the end of perf.data.
 
+--cpu:: Only diff samples for the list of CPUs provided. Multiple CPUs can
+	be provided as a comma-separated list with no space: 0,1. Ranges of
+	CPUs are specified with -: 0-2. Default is to report samples on all
+	CPUs.
+
 COMPARISON
 ----------
 The comparison is governed by the baseline file. The baseline perf.data
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index ddc41e7..319fbc9 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -83,6 +83,9 @@ static unsigned int sort_compute = 1;
 static s64 compute_wdiff_w1;
 static s64 compute_wdiff_w2;
 
+static const char		*cpu_list;
+static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
+
 enum {
 	COMPUTE_DELTA,
 	COMPUTE_RATIO,
@@ -354,6 +357,11 @@ static int diff__process_sample_event(struct perf_tool *tool,
 		return -1;
 	}
 
+	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap)) {
+		ret = 0;
+		goto out_put;
+	}
+
 	if (!hists__add_entry(hists, &al, NULL, NULL, NULL, sample, true)) {
 		pr_warning("problem incrementing symbol period, skipping event\n");
 		goto out_put;
@@ -905,6 +913,13 @@ static int __cmd_diff(void)
 			pdiff.range_num = 1;
 		}
 
+		if (cpu_list) {
+			ret = perf_session__cpu_bitmap(d->session, cpu_list,
+						       cpu_bitmap);
+			if (ret < 0)
+				goto out_delete;
+		}
+
 		ret = perf_session__process_events(d->session);
 		if (ret) {
 			pr_err("Failed to process %s\n", d->data.file.path);
@@ -977,6 +992,7 @@ static const struct option options[] = {
 		     "How to display percentage of filtered entries", parse_filter_percentage),
 	OPT_STRING(0, "time", &pdiff.time_str, "str",
 		   "Time span (time percent or absolute timestamp)"),
+	OPT_STRING(0, "cpu", &cpu_list, "cpu", "list of cpus to profile"),
 	OPT_END()
 };
 
-- 
2.7.4

