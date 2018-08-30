Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437DB2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437DB2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeH3Ke0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728135AbeH3KeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE873807A13F;
        Thu, 30 Aug 2018 06:33:47 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B701A9F09;
        Thu, 30 Aug 2018 06:33:46 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 32/43] perf stat: Move null_run into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:41 +0200
Message-Id: <20180830063252.23729-33-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:47 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move static null_run into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-cclahp2w949g9eg2ryl8ibd4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 7 +++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 381549a989b4..844c755564e3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -148,7 +148,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 #define METRIC_ONLY_LEN 20
 
 static volatile pid_t		child_pid			= -1;
-static bool			null_run			=  false;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -1676,7 +1675,7 @@ static void print_footer(struct perf_stat_config *config)
 	FILE *output = config->output;
 	int n;
 
-	if (!null_run)
+	if (!config->null_run)
 		fprintf(output, "\n");
 
 	if (config->run_count == 1) {
@@ -1894,7 +1893,7 @@ static const struct option stat_options[] = {
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
 	OPT_BOOLEAN(0, "table", &walltime_run_table,
 		    "display details about each run (only with -r option)"),
-	OPT_BOOLEAN('n', "null", &null_run,
+	OPT_BOOLEAN('n', "null", &stat_config.null_run,
 		    "null run - dont start any counters"),
 	OPT_INCR('d', "detailed", &detailed_run,
 		    "detailed run - start a lot of events"),
@@ -2309,7 +2308,7 @@ static int add_default_attributes(void)
 	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
-	if (null_run)
+	if (stat_config.null_run)
 		return 0;
 
 	if (transaction_run) {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 35550e3efd81..c198926c0e27 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -94,6 +94,7 @@ struct perf_stat_config {
 	bool			 csv_output;
 	bool			 interval_clear;
 	bool			 metric_only;
+	bool			 null_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

