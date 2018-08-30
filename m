Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B186C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F602082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F602082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeH3Kea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728238AbeH3Ke3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9F2D5A75E;
        Thu, 30 Aug 2018 06:33:52 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75A0FA9F09;
        Thu, 30 Aug 2018 06:33:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 35/43] perf stat: Move ru_* data into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:44 +0200
Message-Id: <20180830063252.23729-36-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:53 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving ru_* data into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-laaz6pbi1x4hicadbvf9ed9s@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 12 +++++-------
 tools/perf/util/stat.h    |  6 ++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f61c2dc8c7e8..942ebfd8ef2e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -171,8 +171,6 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static u64			*walltime_run;
-static bool			ru_display			= false;
-static struct rusage		ru_data;
 
 struct perf_stat {
 	bool			 record;
@@ -583,7 +581,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		wait4(child_pid, &status, 0, &ru_data);
+		wait4(child_pid, &status, 0, &stat_config.ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
@@ -1679,9 +1677,9 @@ static void print_footer(struct perf_stat_config *config)
 	if (config->run_count == 1) {
 		fprintf(output, " %17.9f seconds time elapsed", avg);
 
-		if (ru_display) {
-			double ru_utime = timeval2double(&ru_data.ru_utime);
-			double ru_stime = timeval2double(&ru_data.ru_stime);
+		if (config->ru_display) {
+			double ru_utime = timeval2double(&config->ru_data.ru_utime);
+			double ru_stime = timeval2double(&config->ru_data.ru_stime);
 
 			fprintf(output, "\n\n");
 			fprintf(output, " %17.9f seconds user\n", ru_utime);
@@ -2855,7 +2853,7 @@ int cmd_stat(int argc, const char **argv)
 	 * run and when there's specified tracee.
 	 */
 	if ((stat_config.run_count == 1) && target__none(&target))
-		ru_display = true;
+		stat_config.ru_display = true;
 
 	if (stat_config.run_count < 0) {
 		pr_err("Run count must be a positive number\n");
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 6fb4dac26ccc..1fd0b7e196c6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -4,6 +4,10 @@
 
 #include <linux/types.h>
 #include <stdio.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
 #include "xyarray.h"
 #include "rblist.h"
 #include "perf.h"
@@ -95,6 +99,7 @@ struct perf_stat_config {
 	bool			 interval_clear;
 	bool			 metric_only;
 	bool			 null_run;
+	bool			 ru_display;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
@@ -109,6 +114,7 @@ struct perf_stat_config {
 	int			 stats_num;
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
+	struct rusage		 ru_data;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.17.1

