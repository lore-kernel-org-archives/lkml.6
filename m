Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754979AbeEXFhl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:37:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeEXFhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:37:40 -0400
Date: Wed, 23 May 2018 22:37:20 -0700
From: tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-a26bb0ba706aef4f42cc9377c0d4e849378574a4@git.kernel.org>
Cc: jolsa@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        kan.liang@linux.intel.com, yao.jin@linux.intel.com, acme@redhat.com,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com
Reply-To: yao.jin@linux.intel.com, kan.liang@linux.intel.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1526914666-31839-3-git-send-email-yao.jin@linux.intel.com>
References: <1526914666-31839-3-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf report: Use perf_evlist__force_leader to
 support '--group'
Git-Commit-ID: a26bb0ba706aef4f42cc9377c0d4e849378574a4
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

Commit-ID:  a26bb0ba706aef4f42cc9377c0d4e849378574a4
Gitweb:     https://git.kernel.org/tip/a26bb0ba706aef4f42cc9377c0d4e849378574a4
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 21 May 2018 22:57:45 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 May 2018 14:41:01 -0300

perf report: Use perf_evlist__force_leader to support '--group'

Since we created a new function perf_evlist__force_leader(), remove the
old code and use that new evlist method.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1526914666-31839-3-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4c931afb2e80..ad978e3ee2b8 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -194,20 +194,11 @@ out:
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
