Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966623AbeEJSQF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:16:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37169 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966012AbeEJSQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:16:03 -0400
Date: Thu, 10 May 2018 11:15:40 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ye1o2mji7x68xotiot1tn1gp@git.kernel.org>
Cc: ak@linux.intel.com, wangnan0@huawei.com, jolsa@kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        namhyung@kernel.org, acme@redhat.com, kan.liang@linux.intel.com
Reply-To: jolsa@kernel.org, wangnan0@huawei.com, ak@linux.intel.com,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com, hpa@zytor.com,
        acme@redhat.com, kan.liang@linux.intel.com, namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] Revert "perf pmu: Fix pmu events parsing rule"
Git-Commit-ID: 4a35a9027f64d588d2fd9436dda4126e8d5647d7
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

Commit-ID:  4a35a9027f64d588d2fd9436dda4126e8d5647d7
Gitweb:     https://git.kernel.org/tip/4a35a9027f64d588d2fd9436dda4126e8d5647d7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 7 May 2018 15:27:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 7 May 2018 16:28:10 -0300

Revert "perf pmu: Fix pmu events parsing rule"

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
