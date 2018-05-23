Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935047AbeEWUZd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934461AbeEWUVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:21:21 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/18] perf evlist: Introduce force_leader() method
Date: Wed, 23 May 2018 17:20:49 -0300
Message-Id: <20180523202106.17286-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

For non-explicit group (e.g. those created with -e '{eventA,eventB}'),
'perf report' supports a option '--group' which can enable group output.

We also need to support 'perf annotate' with the same '--group'.

Create a new function perf_evlist__force_leader() which contains common
code to force setting the group leader.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1526914666-31839-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 15 +++++++++++++++
 tools/perf/util/evlist.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a59281d64368..e7a4b31a84fb 100644
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
+void perf_evlist__force_leader(struct perf_evlist *evlist)
+{
+	if (!evlist->nr_groups) {
+		struct perf_evsel *leader = perf_evlist__first(evlist);
+
+		perf_evlist__set_leader(evlist);
+		leader->forced_leader = true;
+	}
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 6c41b2f78713..dc66436add98 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -309,4 +309,7 @@ struct perf_evsel *perf_evlist__event2evsel(struct perf_evlist *evlist,
 					    union perf_event *event);
 
 bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
+
+void perf_evlist__force_leader(struct perf_evlist *evlist);
+
 #endif /* __PERF_EVLIST_H */
-- 
2.14.3
