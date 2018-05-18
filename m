Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeERIGx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:06:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:54340 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERIGu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:06:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="56375283"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 2/3] perf report: Use perf_evlist_forced_leader to support '--group'
Date: Sat, 19 May 2018 00:00:33 +0800
Message-Id: <1526659234-1556-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526659234-1556-1-git-send-email-yao.jin@linux.intel.com>
References: <1526659234-1556-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have created a new function perf_evlist_forced_leader,
so now remove the old code and use perf_evlist_forced_leader
instead.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4c931af..d41b208 100644
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
+		perf_evlist_forced_leader(evlist);
 }
 
 static int process_feature_event(struct perf_tool *tool,
-- 
2.7.4
