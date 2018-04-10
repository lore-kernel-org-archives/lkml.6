Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDJKP3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:15:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:27012 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751929AbeDJKP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:15:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="45674737"
From: Yu Chen <yu.c.chen@intel.com>
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] tools/power turbostat: if --max_loop, print for specific time of loops
Date: Tue, 10 Apr 2018 18:18:31 +0800
Message-Id: <20180410101831.28530-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

There's a use case during test to only print specific round of loops
if --interval is specified, for example, with this patch applied:

turbostat -i 5 --max_loops 4
will capture 4 samples with 5 seconds interval.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..a35418a59468 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -48,6 +48,7 @@ char *proc_stat = "/proc/stat";
 FILE *outf;
 int *fd_percpu;
 struct timespec interval_ts = {5, 0};
+unsigned int max_loops;
 unsigned int debug;
 unsigned int quiet;
 unsigned int sums_need_wide_columns;
@@ -470,6 +471,7 @@ void help(void)
 	"		{core | package | j,k,l..m,n-p }\n"
 	"--quiet	skip decoding system configuration header\n"
 	"--interval sec	Override default 5-second measurement interval\n"
+	"--max_loops times	The number of loops if interval is specified\n"
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
@@ -2626,6 +2630,9 @@ void turbostat_loop()
 		compute_average(ODD_COUNTERS);
 		format_all_counters(ODD_COUNTERS);
 		flush_output_stdout();
+
+		if (++loops >= (max_loops/2))
+			break;
 	}
 }
 
@@ -5009,12 +5016,13 @@ void cmdline(int argc, char **argv)
 		{"Summary",	no_argument,		0, 'S'},
 		{"TCC",		required_argument,	0, 'T'},
 		{"version",	no_argument,		0, 'v' },
+		{"max_loops",	required_argument,	0, 'x'},
 		{0,		0,			0,  0 }
 	};
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:v",
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:vx:",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -5076,6 +5084,15 @@ void cmdline(int argc, char **argv)
 			print_version();
 			exit(0);
 			break;
+		case 'x':
+			{
+				unsigned int loops = strtod(optarg, NULL);
+
+				if (loops % 2)
+					loops++;
+				max_loops = loops;
+			}
+			break;
 		}
 	}
 }
-- 
2.13.6
