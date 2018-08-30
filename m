Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA26C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28D120658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D28D120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeH3Kej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728296AbeH3Kei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCAC326352;
        Thu, 30 Aug 2018 06:34:02 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A0F4A9F09;
        Thu, 30 Aug 2018 06:34:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 41/43] perf stat: Move walltime_* data into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:50 +0200
Message-Id: <20180830063252.23729-42-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:34:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:34:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static walltime_* data into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-ymexory86fsla7n1yvy8tqfa@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
@@ -604,8 +602,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
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
-- 
2.17.1

