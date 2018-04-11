Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDKK2H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:28:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:50895 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeDKK2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:28:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="46969129"
From: Yu Chen <yu.c.chen@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Rafael J Wysocki <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][v3] tools/power turbostat: if --max_loop, print for specific time of loops
Date: Wed, 11 Apr 2018 18:30:38 +0800
Message-Id: <20180411103038.12735-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

There's a use case during test to only print specific round of loops
if --iterations is specified, for example, with this patch applied:

turbostat -i 5 -t 4
will capture 4 samples with 5 seconds interval.

Cc: Len Brown <lenb@kernel.org>
Cc: Rafael J Wysocki <rjw@rjwysocki.net>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..29419b1535bb 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -48,6 +48,7 @@ char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
 struct timespec interval_ts = {5, 0};
+int iterations;
 unsigned int debug;
 unsigned int quiet;
 unsigned int sums_need_wide_columns;
@@ -470,6 +471,7 @@ void help(void)
 	"		{core | package | j,k,l..m,n-p }\n"
 	"--quiet	skip decoding system configuration header\n"
 	"--interval sec	Override default 5-second measurement interval\n"
+	"--iterations loops	The number of loops if interval is specified\n"
 	"--help		print this help message\n"
 	"--list		list column headers only\n"
 	"--out file	create or truncate \"file\" for all output\n"
@@ -2565,6 +2567,7 @@ void turbostat_loop()
 {
 	int retval;
 	int restarted = 0;
+	int loops = 0;
 
 restart:
 	restarted++;
@@ -2583,6 +2586,7 @@ void turbostat_loop()
 	restarted = 0;
 	gettimeofday(&tv_even, (struct timezone *)NULL);
 
+	loops = 0;
 	while (1) {
 		if (for_all_proc_cpus(cpu_is_not_present)) {
 			re_initialize();
@@ -2607,6 +2611,10 @@ void turbostat_loop()
 		compute_average(EVEN_COUNTERS);
 		format_all_counters(EVEN_COUNTERS);
 		flush_output_stdout();
+
+		if (iterations && (++loops >= iterations))
+			break;
+
 		nanosleep(&interval_ts, NULL);
 		if (snapshot_proc_sysfs_files())
 			goto restart;
@@ -2626,6 +2634,9 @@ void turbostat_loop()
 		compute_average(ODD_COUNTERS);
 		format_all_counters(ODD_COUNTERS);
 		flush_output_stdout();
+
+		if (iterations && (++loops >= iterations))
+			break;
 	}
 }
 
@@ -4999,6 +5010,7 @@ void cmdline(int argc, char **argv)
 		{"Dump",	no_argument,		0, 'D'},
 		{"debug",	no_argument,		0, 'd'},	/* internal, not documented */
 		{"interval",	required_argument,	0, 'i'},
+		{"iterations",	required_argument,	0, 't'},
 		{"help",	no_argument,		0, 'h'},
 		{"hide",	required_argument,	0, 'H'},	// meh, -h taken by --help
 		{"Joules",	no_argument,		0, 'J'},
@@ -5014,7 +5026,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:v",
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:vt:",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -5069,6 +5081,15 @@ void cmdline(int argc, char **argv)
 		case 'S':
 			summary_only++;
 			break;
+		case 't':
+			iterations = strtod(optarg, NULL);
+
+			if (iterations <= 0) {
+				fprintf(outf, "loops %d should be positive number\n",
+					iterations);
+				exit(2);
+			}
+			break;
 		case 'T':
 			tcc_activation_temp_override = atoi(optarg);
 			break;
-- 
2.13.6
