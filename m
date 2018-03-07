Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeCGPuw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:50:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934031AbeCGPup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:45 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 10/19] perf c2c record: Record physical addresses in samples
Date: Wed,  7 Mar 2018 16:50:11 +0100
Message-Id: <20180307155020.32613-11-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to display NUMA node information in following
patches. For this we need to have physical address data in
the sample.

Adding --phys-data as a default option for perf c2c record.

Link: http://lkml.kernel.org/n/tip-4d4lyozdbsknzqeny8kl1jg4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-c2c.txt | 2 +-
 tools/perf/builtin-c2c.c              | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 822414235170..095aebdc5bb7 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -116,7 +116,7 @@ and calls standard perf record command.
 Following perf record options are configured by default:
 (check perf record man page for details)
 
-  -W,-d,--sample-cpu
+  -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
 default:
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 98d243fa0c06..95765a1db903 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2704,7 +2704,7 @@ static int perf_c2c__record(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	rec_argc = argc + 10; /* max number of arguments */
+	rec_argc = argc + 11; /* max number of arguments */
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
 		return -1;
@@ -2720,6 +2720,7 @@ static int perf_c2c__record(int argc, const char **argv)
 		rec_argv[i++] = "-W";
 
 	rec_argv[i++] = "-d";
+	rec_argv[i++] = "--phys-data";
 	rec_argv[i++] = "--sample-cpu";
 
 	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-- 
2.13.6
