Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeEBPU3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:20:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbeEBPUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:20:22 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/52] perf stat: Display time in precision based on std deviation
Date: Wed,  2 May 2018 12:18:55 -0300
Message-Id: <20180502151942.20542-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502151942.20542-1-acme@kernel.org>
References: <20180502151942.20542-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Ingo suggested to display elapsed time for multirun workload (perf stat
-e) with precision based on the precision of the standard deviation.

In his own words:

  > This output is a slightly bit misleading:

  >  Performance counter stats for 'make -j128' (10 runs):
  >      27.988995256 seconds time elapsed                  ( +-  0.39% )

  > The 9 significant digits in the result, while only 1 is valid, suggests accuracy
  > where none exists.

  > It would be better if 'perf stat' would display elapsed time with a precision
  > adjusted to stddev, it should display at most 2 more significant digits than
  > the stddev inaccuracy.

  > I.e. in the above case 0.39% is 0.109, so we only have accuracy for 1 digit, and
  > so we should only display 3:

  >        27.988 seconds time elapsed                       ( +-  0.39% )

Plus a suggestion about the output, which is small enough and connected
with the above change that I merged both changes together.

  > Small output style nit - I think it would be nice if with --repeat the stddev was
  > also displayed in absolute values, besides percentage:
  >
  >       27.988 +- 0.109 seconds time elapsed   ( +- 0.39% )

The output is now:

   Performance counter stats for './perf bench sched pipe' (5 runs):
   SNIP
           13.3667 +- 0.0256 seconds time elapsed  ( +-  0.19% )

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180423090823.32309-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f17dc601b0f3..3a94647ef6bc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1764,19 +1764,37 @@ static void print_header(int argc, const char **argv)
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
2.14.3
