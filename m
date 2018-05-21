Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeEUHE3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 03:04:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:53610 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbeEUHEE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 03:04:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,426,1520924400";
   d="scan'208";a="57007333"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 2/3] perf report: Use perf_evlist__force_leader to support '--group'
Date: Mon, 21 May 2018 22:57:45 +0800
Message-Id: <1526914666-31839-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526914666-31839-1-git-send-email-yao.jin@linux.intel.com>
References: <1526914666-31839-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have created a new function perf_evlist__force_leader,
so now remove the old code and use perf_evlist__force_leader
instead.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4c931af..ad978e3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -194,20 +194,11 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	return err;
 }
 
-/*
- * Events in data file are not collect in groups, but we still want
- * the group display. Set the artificial group and set the leader's
- * forced_leader flag to notify the display code.
- */
 static void setup_forced_leader(struct report *report,
 				struct perf_evlist *evlist)
 {
-	if (report->group_set && !evlist->nr_groups) {
-		struct perf_evsel *leader = perf_evlist__first(evlist);
-
-		perf_evlist__set_leader(evlist);
-		leader->forced_leader = true;
-	}
+	if (report->group_set)
+		perf_evlist__force_leader(evlist);
 }
 
 static int process_feature_event(struct perf_tool *tool,
-- 
2.7.4
