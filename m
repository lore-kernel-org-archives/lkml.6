Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeEBRnH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:43:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36485 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeEBRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:43:01 -0400
Date: Wed, 2 May 2018 10:42:41 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-abc60bad0030193ffb55e438664bc09ac53939cf@git.kernel.org>
Cc: dsahern@gmail.com, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, hpa@zytor.com
Reply-To: dsahern@gmail.com, mingo@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        acme@redhat.com, hpa@zytor.com
In-Reply-To: <20180423090823.32309-9-jolsa@kernel.org>
References: <20180423090823.32309-9-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Display length strings of each run for
 --table option
Git-Commit-ID: abc60bad0030193ffb55e438664bc09ac53939cf
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

Commit-ID:  abc60bad0030193ffb55e438664bc09ac53939cf
Gitweb:     https://git.kernel.org/tip/abc60bad0030193ffb55e438664bc09ac53939cf
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 23 Apr 2018 11:08:22 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 09:30:27 -0300

perf stat: Display length strings of each run for --table option

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
