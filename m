Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 48ECD601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeFFIUV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:20:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932369AbeFFIUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:20:20 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf tools: Uniquify the event name if there's no other matched event
Date: Wed,  6 Jun 2018 10:20:16 +0200
Message-Id: <20180606082016.12289-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently by default we try to match the user specified PMU
name to all PMU units available and use them to aggregate
all matched PMUs event counts into one 'pattern' event.

While this is useful for uncore events, it screws up names
for other events, where this is not desirable, like:

Before:
  # perf stat -e cp/cpu-cycles/ kill

   Performance counter stats for 'kill':

           1,573,757      cp/cpu-cycles/

Keeping the pattern matching logic, but making the name unique
in case there's no other match found. That fixes the example
above and hopefully does not screw up anything else.

After:
  # perf stat -e cp/cpu-cycles/ kill

   Performance counter stats for 'kill':

           1,573,757      cpu/cpu-cycles/

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Link: http://lkml.kernel.org/n/tip-lpb7bmaj3szgmemf53yg4nke@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4d24c32e6c38..b32cd8bda0b5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1354,6 +1354,7 @@ static void collect_all_aliases(struct perf_evsel *counter,
 			    void *data)
 {
 	struct perf_evsel *alias;
+	int cnt = 0;
 
 	alias = list_prepare_entry(counter, &(evsel_list->entries), node);
 	list_for_each_entry_continue (alias, &evsel_list->entries, node) {
@@ -1365,7 +1366,15 @@ static void collect_all_aliases(struct perf_evsel *counter,
 			break;
 		alias->merged_stat = true;
 		cb(alias, data, false);
+		cnt++;
 	}
+
+	/*
+	 * There's no matching event to aggregate
+	 * counts with, fix the event name
+	 */
+	if (!cnt)
+		uniquify_event_name(counter);
 }
 
 static bool collect_data(struct perf_evsel *counter,
-- 
2.13.6
