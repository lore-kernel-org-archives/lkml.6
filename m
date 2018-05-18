Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeERFEX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:04:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:41149 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751898AbeERFD4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:03:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="229565855"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 2/3] perf report: Use perf_evlist_forced_leader to support '--group'
Date: Fri, 18 May 2018 20:57:39 +0800
Message-Id: <1526648260-30540-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526648260-30540-1-git-send-email-yao.jin@linux.intel.com>
References: <1526648260-30540-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have created a new function perf_evlist_forced_leader,
so now remove the old code and use perf_evlist_forced_leader
instead.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4c931af..63fe776 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -202,12 +202,8 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
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
