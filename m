Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754944AbeEXFha (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:37:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41771 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754806AbeEXFh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:37:27 -0400
Date: Wed, 23 May 2018 22:36:51 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-e2bdbe80a0b7dea9ba73582701b8a67c01e1da4f@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, yao.jin@linux.intel.com, jolsa@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, acme@redhat.com
Reply-To: peterz@infradead.org, acme@redhat.com, tglx@linutronix.de,
        jolsa@kernel.org, kan.liang@linux.intel.com, yao.jin@linux.intel.com,
        hpa@zytor.com, ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1526914666-31839-2-git-send-email-yao.jin@linux.intel.com>
References: <1526914666-31839-2-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Introduce force_leader() method
Git-Commit-ID: e2bdbe80a0b7dea9ba73582701b8a67c01e1da4f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e2bdbe80a0b7dea9ba73582701b8a67c01e1da4f
Gitweb:     https://git.kernel.org/tip/e2bdbe80a0b7dea9ba73582701b8a67c01e1da4f
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 21 May 2018 22:57:44 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 May 2018 14:40:54 -0300

perf evlist: Introduce force_leader() method

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
