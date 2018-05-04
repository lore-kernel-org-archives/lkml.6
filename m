Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeEDQCe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:02:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751196AbeEDQCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:02:33 -0400
Date: Fri, 4 May 2018 18:02:28 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, kan.liang@linux.intel.com
Subject: Re: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
Message-ID: <20180504160228.GA25229@krava>
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
 <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
 <20180503103717.GA14776@krava>
 <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 02:38:15PM +0300, Adrian Hunter wrote:

SNIP

> >>> index 7afeb80cc39e..d14464c42714 100644
> >>> --- a/tools/perf/util/parse-events.y
> >>> +++ b/tools/perf/util/parse-events.y
> >>> @@ -224,15 +224,15 @@ event_def: event_pmu |
> >>>  	   event_bpf_file
> >>>  
> >>>  event_pmu:
> >>> -PE_NAME opt_event_config
> >>> +PE_NAME '/' event_config '/'
> >>
> >> These are not equivalent because opt_event_config allows '//'
> >> but event_config cannot be an empty string.
> > 
> > yep, overlooked this one, how about patch below
> 
> Seems to work but gives build warnings:
> 
> util/parse-events.y: warning: 1 shift/reduce conflict [-Wconflicts-sr]
> util/parse-events.y: warning: 1 reduce/reduce conflict [-Wconflicts-rr]

I had to make an explicit rule, so I moved the original rule code
into separate function.. hence the patch is little bigger ;-)

cc-ing Kan Liang, who recently changed this code,

I'll still have to rebase this one his recent change,
once it gets in, but should be easy

jirka


---
 tools/perf/util/parse-events.c | 43 +++++++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.h |  3 +++
 tools/perf/util/parse-events.y | 51 +++++++++++++-----------------------------
 3 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2fb0272146d8..33e3fc147f35 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -8,6 +8,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <sys/param.h>
+#include <fnmatch.h>
 #include "term.h"
 #include "../perf.h"
 #include "evlist.h"
@@ -1287,6 +1288,48 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	return evsel ? 0 : -ENOMEM;
 }
 
+int parse_events_pmu(struct parse_events_state *parse_state,
+		     struct list_head *list, char *name,
+		     struct list_head *head_config)
+{
+	struct list_head *orig_terms;
+	struct perf_pmu *pmu = NULL;
+	char *pattern = NULL;
+	int ok = 0;
+
+	if (!parse_events_add_pmu(parse_state, list, name, head_config, false))
+		return 0;
+
+	if (parse_events_copy_term_list(head_config, &orig_terms))
+		return -1;
+
+	if (asprintf(&pattern, "%s*", name) < 0)
+		goto out;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		struct list_head *terms;
+		char *tmp = pmu->name;
+
+		if (!strncmp(tmp, "uncore_", 7) &&
+		    strncmp(tmp, "uncore_", 7))
+			tmp += 7;
+		if (!fnmatch(pattern, tmp, 0)) {
+			if (parse_events_copy_term_list(orig_terms, &terms)) {
+				ok = 0;
+				goto out;
+			}
+			if (!parse_events_add_pmu(parse_state, list, pmu->name, terms, true))
+				ok++;
+			parse_events_terms__delete(terms);
+		}
+	}
+
+out:
+	parse_events_terms__delete(orig_terms);
+	free(pattern);
+	return ok ? 0 : -1;
+}
+
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head **listp)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5015cfd58277..743586213ee4 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -168,6 +168,9 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config, bool auto_merge_stats);
+int parse_events_pmu(struct parse_events_state *parse_state,
+		     struct list_head *list, char *name,
+		     struct list_head *head_config);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index d14464c42714..a93f8c660395 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -8,7 +8,6 @@
 
 #define YYDEBUG 1
 
-#include <fnmatch.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/types.h>
@@ -226,44 +225,26 @@ event_def: event_pmu |
 event_pmu:
 PE_NAME '/' event_config '/'
 {
-	struct list_head *list, *orig_terms, *terms;
+	struct list_head *list;
+
+	ALLOC_LIST(list);
 
-	if (parse_events_copy_term_list($3, &orig_terms))
+	if (parse_events_pmu(_parse_state, list, $1, $3))
 		YYABORT;
 
-	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
-		struct perf_pmu *pmu = NULL;
-		int ok = 0;
-		char *pattern;
-
-		if (asprintf(&pattern, "%s*", $1) < 0)
-			YYABORT;
-
-		while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-			char *name = pmu->name;
-
-			if (!strncmp(name, "uncore_", 7) &&
-			    strncmp($1, "uncore_", 7))
-				name += 7;
-			if (!fnmatch(pattern, name, 0)) {
-				if (parse_events_copy_term_list(orig_terms, &terms)) {
-					free(pattern);
-					YYABORT;
-				}
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true))
-					ok++;
-				parse_events_terms__delete(terms);
-			}
-		}
-
-		free(pattern);
-
-		if (!ok)
-			YYABORT;
-	}
 	parse_events_terms__delete($3);
-	parse_events_terms__delete(orig_terms);
+	$$ = list;
+}
+|
+PE_NAME '/' '/'
+{
+	struct list_head *list;
+
+	ALLOC_LIST(list);
+
+	if (parse_events_pmu(_parse_state, list, $1, NULL))
+		YYABORT;
+
 	$$ = list;
 }
 |
-- 
2.13.6
