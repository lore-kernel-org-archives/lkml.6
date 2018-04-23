Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeDWJJD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:09:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754431AbeDWJIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:38 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 8/9] perf stat: Display length strings of each run for --table option
Date: Mon, 23 Apr 2018 11:08:22 +0200
Message-Id: <20180423090823.32309-9-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to display visual aid 'length strings' to
easily spot the biggest difference in time table.

  $ perf stat -r 10 --table perf bench sched pipe
  ...

   Performance counter stats for './perf bench sched pipe' (5 runs):

             # Table of individual measurements:
             5.189 (-0.293) #
             5.189 (-0.294) #
             5.186 (-0.296) #
             5.663 (+0.181) ##
             6.186 (+0.703) ####

             # Final result:
             5.483 +- 0.198 seconds time elapsed  ( +-  3.62% )

Suggested-by: Ingo Molnar <mingo@kernel.org>
Link: http://lkml.kernel.org/n/tip-hb3t43jryqr4d911yu1ap918@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 345687b0eb10..2137c7d11767 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1759,9 +1759,15 @@ static void print_table(FILE *output, int precision, double avg)
 
 	for (idx = 0; idx < run_count; idx++) {
 		double run = (double) walltime_run[idx] / NSEC_PER_SEC;
+		int h, n = 1 + abs((int) (100.0 * (run - avg)/run) / 5);
 
-		fprintf(output, " %17.*f (%+.*f)\n",
+		fprintf(output, " %17.*f (%+.*f) ",
 			precision, run, precision, run - avg);
+
+		for (h = 0; h < n; h++)
+			fprintf(output, "#");
+
+		fprintf(output, "\n");
 	}
 
 	fprintf(output, "\n%*s# Final result:\n", indent, "");
-- 
2.13.6
