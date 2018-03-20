Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeCTGSV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:18:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeCTGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:18:15 -0400
Date: Mon, 19 Mar 2018 23:17:53 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8fab7843a15078814764e01c303d175c92b500c1@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
        namhyung@kernel.org, jmario@redhat.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org
Reply-To: peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, jmario@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com
In-Reply-To: <20180309101442.9224-5-jolsa@kernel.org>
References: <20180309101442.9224-5-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c record: Record physical addresses in
 samples
Git-Commit-ID: 8fab7843a15078814764e01c303d175c92b500c1
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

Commit-ID:  8fab7843a15078814764e01c303d175c92b500c1
Gitweb:     https://git.kernel.org/tip/8fab7843a15078814764e01c303d175c92b500c1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:37 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:52:57 -0300

perf c2c record: Record physical addresses in samples

We are going to display NUMA node information in following patches. For
this we need to have physical address data in the sample.

Adding --phys-data as a default option for perf c2c record.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
