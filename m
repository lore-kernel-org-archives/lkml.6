Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeDWJKK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:10:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754499AbeDWJIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:32 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 4/9] perf tools: Fix pmu events parsing rule
Date: Mon, 23 Apr 2018 11:08:18 +0200
Message-Id: <20180423090823.32309-5-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all the event parsing fails end up
in the event_pmu rule, and display misleading
help like:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ Cannot find PMU `inst'. Missing kernel support?
  ...

The reason is that the event_pmu is too strong
and match also single string. Changing it to
force the '/' separators to be part of the rule,
and getting the proper error now:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ parser error
  Run 'perf list' for a list of valid events
  ...

Link: http://lkml.kernel.org/n/tip-vgf5a8wk0eyayo7omvutwhqo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/parse-events.y | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7afeb80cc39e..d14464c42714 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -224,15 +224,15 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME opt_event_config
+PE_NAME '/' event_config '/'
 {
 	struct list_head *list, *orig_terms, *terms;
 
-	if (parse_events_copy_term_list($2, &orig_terms))
+	if (parse_events_copy_term_list($3, &orig_terms))
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
@@ -262,7 +262,7 @@ PE_NAME opt_event_config
 		if (!ok)
 			YYABORT;
 	}
-	parse_events_terms__delete($2);
+	parse_events_terms__delete($3);
 	parse_events_terms__delete(orig_terms);
 	$$ = list;
 }
-- 
2.13.6
