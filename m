Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F08C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E578F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E578F206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeIFSTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:19:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56073 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbeIFSTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:19:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DhBu3310499
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:43:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DhBST310496;
        Thu, 6 Sep 2018 06:43:11 -0700
Date:   Thu, 6 Sep 2018 06:43:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-54ac0b1bd25cbdeda226b32a0459e09de46157b3@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        hpa@zytor.com, mingo@kernel.org, acme@redhat.com,
        andi@firstfloor.org, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dsahern@gmail.com,
        peterz@infradead.org
Reply-To: mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          andi@firstfloor.org, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, hpa@zytor.com, peterz@infradead.org,
          dsahern@gmail.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180830063252.23729-42-jolsa@kernel.org>
References: <20180830063252.23729-42-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move 'walltime_*' data to 'struct
 perf_stat_config'
Git-Commit-ID: 54ac0b1bd25cbdeda226b32a0459e09de46157b3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  54ac0b1bd25cbdeda226b32a0459e09de46157b3
Gitweb:     https://git.kernel.org/tip/54ac0b1bd25cbdeda226b32a0459e09de46157b3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:50 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:25 -0300

perf stat: Move 'walltime_*' data to 'struct perf_stat_config'

Move the static variables 'walltime_*' to 'struct perf_stat_config', so
that it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-42-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 22 ++++++++++------------
 tools/perf/util/stat.h    |  2 ++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 486b0cf7818d..8a4979748cbb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -158,13 +158,11 @@ static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
 static bool			forever				= false;
 static bool			force_metric_only		= false;
-static bool			walltime_run_table		= false;
 static struct timespec		ref_time;
 static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static u64			*walltime_run;
 
 struct perf_stat {
 	bool			 record;
@@ -604,8 +602,8 @@ try_again:
 
 	t1 = rdclock();
 
-	if (walltime_run_table)
-		walltime_run[run_idx] = t1 - t0;
+	if (stat_config.walltime_run_table)
+		stat_config.walltime_run[run_idx] = t1 - t0;
 
 	update_stats(&walltime_nsecs_stats, t1 - t0);
 
@@ -1646,7 +1644,7 @@ static void print_table(struct perf_stat_config *config,
 	fprintf(output, "%*s# Table of individual measurements:\n", indent, "");
 
 	for (idx = 0; idx < config->run_count; idx++) {
-		double run = (double) walltime_run[idx] / NSEC_PER_SEC;
+		double run = (double) config->walltime_run[idx] / NSEC_PER_SEC;
 		int h, n = 1 + abs((int) (100.0 * (run - avg)/run) / 5);
 
 		fprintf(output, " %17.*f (%+.*f) ",
@@ -1694,7 +1692,7 @@ static void print_footer(struct perf_stat_config *config)
 		 */
 		int precision = get_precision(sd) + 2;
 
-		if (walltime_run_table)
+		if (config->walltime_run_table)
 			print_table(config, output, precision, avg);
 
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
@@ -1888,7 +1886,7 @@ static const struct option stat_options[] = {
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_INTEGER('r', "repeat", &stat_config.run_count,
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
-	OPT_BOOLEAN(0, "table", &walltime_run_table,
+	OPT_BOOLEAN(0, "table", &stat_config.walltime_run_table,
 		    "display details about each run (only with -r option)"),
 	OPT_BOOLEAN('n', "null", &stat_config.null_run,
 		    "null run - dont start any counters"),
@@ -2802,7 +2800,7 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	if (walltime_run_table && stat_config.run_count <= 1) {
+	if (stat_config.walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
 		parse_options_usage(NULL, stat_options, "table", 0);
@@ -2870,9 +2868,9 @@ int cmd_stat(int argc, const char **argv)
 		stat_config.run_count = 1;
 	}
 
-	if (walltime_run_table) {
-		walltime_run = zalloc(stat_config.run_count * sizeof(walltime_run[0]));
-		if (!walltime_run) {
+	if (stat_config.walltime_run_table) {
+		stat_config.walltime_run = zalloc(stat_config.run_count * sizeof(stat_config.walltime_run[0]));
+		if (!stat_config.walltime_run) {
 			pr_err("failed to setup -r option");
 			goto out;
 		}
@@ -3052,7 +3050,7 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
-	free(walltime_run);
+	free(stat_config.walltime_run);
 
 	if (smi_cost && smi_reset)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 0758107fe56f..5193cbf6e4c6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -105,6 +105,7 @@ struct perf_stat_config {
 	bool			 ru_display;
 	bool			 big_num;
 	bool			 no_merge;
+	bool			 walltime_run_table;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
@@ -123,6 +124,7 @@ struct perf_stat_config {
 	struct cpu_map		*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_map		*cpus_aggr_map;
+	u64			*walltime_run;
 };
 
 void update_stats(struct stats *stats, u64 val);
