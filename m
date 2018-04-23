Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeDWJIh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:08:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754492AbeDWJIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:31 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 3/9] perf stat: Keep the / modifier separator in fallback
Date: Mon, 23 Apr 2018 11:08:17 +0200
Message-Id: <20180423090823.32309-4-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf stat fallback for EACCES error sets exclude_kernel
for event and repeats the open. In addition, it also changes
the name of the event to reflect that change by adding the
'u' modifier.

But it does not take into account the '/' separator, so the
event name can end up mangled, like:
(note the '/:' characters)

  $ perf stat -e cpu/cpu-cycles/ kill
  ...
             386,832      cpu/cpu-cycles/:u

Adding the code to check on the '/' separatos and set
following event name:

  $ perf stat -e cpu/cpu-cycles/ kill
  ...
             388,548      cpu/cpu-cycles/u

Link: http://lkml.kernel.org/n/tip-bh7wxrci19km6iwbv4qg555o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1ac8d9236efd..7472f876cd70 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2754,8 +2754,14 @@ bool perf_evsel__fallback(struct perf_evsel *evsel, int err,
 		   (paranoid = perf_event_paranoid()) > 1) {
 		const char *name = perf_evsel__name(evsel);
 		char *new_name;
+		const char *sep = ":";
 
-		if (asprintf(&new_name, "%s%su", name, strchr(name, ':') ? "" : ":") < 0)
+		/* Is there already the separator in the name. */
+		if (strchr(name, '/') ||
+		    strchr(name, ':'))
+			sep = "";
+
+		if (asprintf(&new_name, "%s%su", name, sep) < 0)
 			return false;
 
 		if (evsel->name)
-- 
2.13.6
