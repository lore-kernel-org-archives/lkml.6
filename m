Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D006C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE292086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQB8Lfld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE292086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeIFCju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeIFCjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:49 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6AF20869;
        Wed,  5 Sep 2018 22:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185257;
        bh=zHR+oSQvSTNob/LgsxOREkA3+72gC8K3t2mDt+03Rc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQB8LfldUWnQ3gZYyrr+XgFD3kjKZ5sZzyWb3IDIXSIwCF2T7kQun/YZr25UUktPV
         M0jUnAfG+vTo0KfkoxBB1XFDgfFiWvuSwpEyvK2KykTo9law1+DTJo0a7Sb7hEhmO6
         lntYGL7+wuIZmWypHIXyZEb0eHN5X6uBckZ1WEWs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 60/77] perf stat: Move ru_* data to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:23 -0300
Message-Id: <20180905220440.20256-61-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'ru_*' global variables to 'struct perf_stat_config', so that
it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-36-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

