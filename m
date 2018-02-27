Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeB0WfT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:35:19 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751947AbeB0WfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:35:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C868F60F91
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC 3/3] perf pmu: Restore auto-merging of PMU events created by prefix match
Date: Tue, 27 Feb 2018 17:34:08 -0500
Message-Id: <1519770848-26738-4-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519770848-26738-1-git-send-email-agustinv@codeaurora.org>
References: <1519770848-26738-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was disabled when auto-merging of non-alias events was disabled in
commit 63ce844 (perf stat: Only auto-merge events that are PMU aliases).

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 tools/perf/util/parse-events.c | 13 +++----------
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.y |  4 ++--
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index bafc91e..4e80ca3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1217,7 +1217,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			 get_config_name(head_config), &config_terms);
 }

-static int __parse_events_add_pmu(struct parse_events_state *parse_state,
+int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
 			 struct list_head *head_config, bool auto_merge_stats)
 {
@@ -1287,13 +1287,6 @@ static int __parse_events_add_pmu(struct parse_events_state *parse_state,
 	return evsel ? 0 : -ENOMEM;
 }

-int parse_events_add_pmu(struct parse_events_state *parse_state,
-			 struct list_head *list, char *name,
-			 struct list_head *head_config)
-{
-	return __parse_events_add_pmu(parse_state, list, name, head_config, false);
-}
-
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str, struct list_head **listp)
 {
@@ -1323,8 +1316,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 					return -1;
 				list_add_tail(&term->list, head);

-				if (!__parse_events_add_pmu(parse_state, list,
-							    pmu->name, head, true)) {
+				if (!parse_events_add_pmu(parse_state, list,
+							  pmu->name, head, true)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 88108cd..5015cfd 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -167,7 +167,7 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 				void *ptr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
-			 struct list_head *head_config);
+			 struct list_head *head_config, bool auto_merge_stats);

 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index c528469..b51278f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -232,7 +232,7 @@ PE_NAME opt_event_config
 		YYABORT;

 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;

@@ -245,7 +245,7 @@ PE_NAME opt_event_config
 			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					YYABORT;
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms))
+				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true))
 					ok++;
 				parse_events_terms__delete(terms);
 			}
--
2.7.4
