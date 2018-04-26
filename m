Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeDZFy3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 01:54:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeDZFy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 01:54:26 -0400
Date: Wed, 25 Apr 2018 22:54:06 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-9a4a931ce847f4aaa12edf11b2e050e18bf45910@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, peterz@infradead.org, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com
Reply-To: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, peterz@infradead.org, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, dsahern@gmail.com
In-Reply-To: <20180423090823.32309-5-jolsa@kernel.org>
References: <20180423090823.32309-5-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf pmu: Fix pmu events parsing rule
Git-Commit-ID: 9a4a931ce847f4aaa12edf11b2e050e18bf45910
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

Commit-ID:  9a4a931ce847f4aaa12edf11b2e050e18bf45910
Gitweb:     https://git.kernel.org/tip/9a4a931ce847f4aaa12edf11b2e050e18bf45910
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 23 Apr 2018 11:08:18 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 23 Apr 2018 11:17:27 -0300

perf pmu: Fix pmu events parsing rule

Currently all the event parsing fails end up in the event_pmu rule, and
display misleading help like:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ Cannot find PMU `inst'. Missing kernel support?
  ...

The reason is that the event_pmu is too strong and match also single
string. Changing it to force the '/' separators to be part of the rule,
and getting the proper error now:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ parser error
  Run 'perf list' for a list of valid events
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
