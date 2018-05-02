Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751331AbeEBRmI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:42:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBRmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:42:04 -0400
Date: Wed, 2 May 2018 10:41:43 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bc22de9bcdb2249150fb5b3c48fdc4f6bedd3ad7@git.kernel.org>
Cc: tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, peterz@infradead.org, dsahern@gmail.com,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, hpa@zytor.com, jolsa@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, peterz@infradead.org
In-Reply-To: <20180423090823.32309-7-jolsa@kernel.org>
References: <20180423090823.32309-7-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Display time in precision based on std
 deviation
Git-Commit-ID: bc22de9bcdb2249150fb5b3c48fdc4f6bedd3ad7
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

Commit-ID:  bc22de9bcdb2249150fb5b3c48fdc4f6bedd3ad7
Gitweb:     https://git.kernel.org/tip/bc22de9bcdb2249150fb5b3c48fdc4f6bedd3ad7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 23 Apr 2018 11:08:20 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 09:30:27 -0300

perf stat: Display time in precision based on std deviation

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
 
