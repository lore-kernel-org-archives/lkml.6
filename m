Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeERIH4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:07:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:54340 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbeERIGs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:06:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,413,1520924400";
   d="scan'208";a="56375270"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 1/3] perf evlist: Create a new function perf_evlist_forced_leader
Date: Sat, 19 May 2018 00:00:32 +0800
Message-Id: <1526659234-1556-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526659234-1556-1-git-send-email-yao.jin@linux.intel.com>
References: <1526659234-1556-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-explicit group, perf report supports a option '--group'
which can enable group output. We also need to support perf annotate
with the same '--group'.

Create a new function perf_evlist_forced_leader which contains
common code to force setting the group leader.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/evlist.c | 15 +++++++++++++++
 tools/perf/util/evlist.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a59281d..6983f6a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1795,3 +1795,18 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist)
 
 	return true;
 }
+
+/*
+ * Events in data file are not collect in groups, but we still want
+ * the group display. Set the artificial group and set the leader's
+ * forced_leader flag to notify the display code.
+ */
+void perf_evlist_forced_leader(struct perf_evlist *evlist)
+{
+	if (!evlist->nr_groups) {
+		struct perf_evsel *leader = perf_evlist__first(evlist);
+
+		perf_evlist__set_leader(evlist);
+		leader->forced_leader = true;
+	}
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 6c41b2f..d77d514 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -309,4 +309,7 @@ struct perf_evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
 					    union perf_event *event);
 
 bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
+
+void perf_evlist_forced_leader(struct perf_evlist *evlist);
+
 #endif /* __PERF_EVLIST_H */
-- 
2.7.4
