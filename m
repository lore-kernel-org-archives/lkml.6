Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeDWJJj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:09:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754529AbeDWJIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:08:36 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 6/9] perf stat: Display time in precision based on std deviation
Date: Mon, 23 Apr 2018 11:08:20 +0200
Message-Id: <20180423090823.32309-7-jolsa@kernel.org>
In-Reply-To: <20180423090823.32309-1-jolsa@kernel.org>
References: <20180423090823.32309-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo suggested to display elapsed time for multirun
workload (perf stat -e) with precision based on the
precision of the standard deviation.

In his own words:

  > It would be better if perf stat would display elapsed time with a precision
  > adjusted to stddev, it should display at most 2 more significant digits than
  > the stddev inaccuracy.
  >
  > I.e. in the above case 0.39% is 0.109, so we only have accuracy for 1 digit, and
  > so we should only display 3:
  >
  >        27.988 seconds time elapsed                                ( +-  0.39% )

Plus suggestion about the output, which is small enough and
connected with above change that I merged both changes together.

  > Small output style nit - I think it would be nice if with --repeat the stddev was
  > also displayed in absolute values, besides percentage:
  >
  >       27.988 +- 0.109 seconds time elapsed   ( +- 0.39% )

The output is now:

   Performance counter stats for './perf bench sched pipe' (5 runs):
   SNIP
           13.3667 +- 0.0256 seconds time elapsed  ( +-  0.19% )

Suggested-by: Ingo Molnar <mingo@kernel.org>
Link: http://lkml.kernel.org/n/tip-q10lhnqju8rdpiha542mvied@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 147a27e8c937..6b4f3d359cb3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1733,19 +1733,37 @@ static void print_header(int argc, const char **argv)
 	}
 }
 
+static int get_precision(double num)
+{
+	if (num > 1)
+		return 0;
+
+	return lround(ceil(-log10(num)));
+}
+
 static void print_footer(void)
 {
+	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = stat_config.output;
 	int n;
 
 	if (!null_run)
 		fprintf(output, "\n");
-	fprintf(output, " %17.9f seconds time elapsed",
-			avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC);
-	if (run_count > 1) {
-		fprintf(output, "                                        ");
-		print_noise_pct(stddev_stats(&walltime_nsecs_stats),
-				avg_stats(&walltime_nsecs_stats));
+
+	if (run_count == 1) {
+		fprintf(output, " %17.9f seconds time elapsed", avg);
+	} else {
+		double sd = stddev_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
+		/*
+		 * Display at most 2 more significant
+		 * digits than the stddev inaccuracy.
+		 */
+		int precision = get_precision(sd) + 2;
+
+		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
+			precision, avg, precision, sd);
+
+		print_noise_pct(sd, avg);
 	}
 	fprintf(output, "\n\n");
 
-- 
2.13.6
