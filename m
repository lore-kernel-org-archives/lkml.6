Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeEBPdc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbeEBPU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:28 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/52] perf stat: Display length strings of each run for --table option
Date: Wed,  2 May 2018 12:18:57 -0300
Message-Id: <20180502151942.20542-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding support to display visual aid 'length strings' to easily spot the
biggest difference in time table.

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
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-9-jolsa@kernel.org
[ Updated 'perf stat --table' man page entry ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-stat.txt | 12 ++++++------
 tools/perf/builtin-stat.c              |  8 +++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 72a2414513bd..3a822f308e6d 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -123,14 +123,14 @@ spreadsheets. Columns are separated by the string specified in SEP.
    Performance counter stats for 'perf bench sched pipe' (5 runs):
 
              # Table of individual measurements:
-             5.379 (-0.176)
-             5.243 (-0.311)
-             5.238 (-0.317)
-             5.536 (-0.019)
-             6.377 (+0.823)
+             5.189 (-0.293) #
+             5.189 (-0.294) #
+             5.186 (-0.296) #
+             5.663 (+0.181) ##
+             6.186 (+0.703) ####
 
              # Final result:
-             5.555 +- 0.213 seconds time elapsed  ( +-  3.83% )
+             5.483 +- 0.198 seconds time elapsed  ( +-  3.62% )
 
 -G name::
 --cgroup name::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 72553937c010..a4f662a462c6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1790,9 +1790,15 @@ static void print_table(FILE *output, int precision, double avg)
 
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
2.14.3
