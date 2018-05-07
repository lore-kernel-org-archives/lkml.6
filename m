Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeEGUOG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752858AbeEGUOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:14:03 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 6/6] Revert "perf pmu: Fix pmu events parsing rule"
Date: Mon,  7 May 2018 17:13:33 -0300
Message-Id: <20180507201333.26990-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507201333.26990-1-acme@kernel.org>
References: <20180507201333.26990-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As reported by Adrian Hunter, this breaks intel_pt event parsing:

  # perf record -e intel_pt//u uname
  event syntax error: 'intel_pt//u'
                               \___ parser error
  Run 'perf list' for a list of valid events

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -e, --event <event>   event selector. use 'perf list' to list available events
  #

This reverts commit 9a4a931ce847f4aaa12edf11b2e050e18bf45910.

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ye1o2mji7x68xotiot1tn1gp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d14464c42714..7afeb80cc39e 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -224,15 +224,15 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME '/' event_config '/'
+PE_NAME opt_event_config
 {
 	struct list_head *list, *orig_terms, *terms;
 
-	if (parse_events_copy_term_list($3, &orig_terms))
+	if (parse_events_copy_term_list($2, &orig_terms))
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
@@ -262,7 +262,7 @@ PE_NAME '/' event_config '/'
 		if (!ok)
 			YYABORT;
 	}
-	parse_events_terms__delete($3);
+	parse_events_terms__delete($2);
 	parse_events_terms__delete(orig_terms);
 	$$ = list;
 }
-- 
2.14.3
