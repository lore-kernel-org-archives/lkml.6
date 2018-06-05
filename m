Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeFER52 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbeFERwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:33 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/46] perf tools: Fix pmu events parsing rule
Date: Tue,  5 Jun 2018 14:50:22 -0300
Message-Id: <20180605175030.32549-39-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180605121416.31645-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e37608a87dba..155d2570274f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -73,6 +73,7 @@ static void inc_group_count(struct list_head *list,
 %type <num> value_sym
 %type <head> event_config
 %type <head> opt_event_config
+%type <head> opt_pmu_config
 %type <term> event_term
 %type <head> event_pmu
 %type <head> event_legacy_symbol
@@ -224,7 +225,7 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME opt_event_config
+PE_NAME opt_pmu_config
 {
 	struct list_head *list, *orig_terms, *terms;
 
@@ -496,6 +497,17 @@ opt_event_config:
 	$$ = NULL;
 }
 
+opt_pmu_config:
+'/' event_config '/'
+{
+	$$ = $2;
+}
+|
+'/' '/'
+{
+	$$ = NULL;
+}
+
 start_terms: event_config
 {
 	struct parse_events_state *parse_state = _parse_state;
-- 
2.14.3
