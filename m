Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE5EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AB72082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AB72082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeH3KeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbeH3KeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED5677D84D;
        Thu, 30 Aug 2018 06:33:32 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89C44B27A5;
        Thu, 30 Aug 2018 06:33:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 23/43] perf stat: Move unit_width into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:32 +0200
Message-Id: <20180830063252.23729-24-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:33 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static unit_width into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-wmmgzikkzqx4k5mqz7xld903@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 11 ++++++-----
 tools/perf/util/stat.h    |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 397cb4f28d7f..24171aa6c41f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -161,7 +161,6 @@ static bool			group				= false;
 static const char		*pre_cmd			= NULL;
 static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
-static unsigned int		unit_width			= 4; /* strlen("unit") */
 static bool			forever				= false;
 static bool			force_metric_only		= false;
 static bool			no_merge			= false;
@@ -200,6 +199,7 @@ static volatile int done = 0;
 static struct perf_stat_config stat_config = {
 	.aggr_mode	= AGGR_GLOBAL,
 	.scale		= true,
+	.unit_width	= 4, /* strlen("unit") */
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -524,8 +524,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		counter->supported = true;
 
 		l = strlen(counter->unit);
-		if (l > unit_width)
-			unit_width = l;
+		if (l > stat_config.unit_width)
+			stat_config.unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
 		    perf_evsel__store_ids(counter, evsel_list))
@@ -963,7 +963,7 @@ static void abs_printout(struct perf_stat_config *config,
 
 	if (evsel->unit)
 		fprintf(output, "%-*s%s",
-			config->csv_output ? 0 : unit_width,
+			config->csv_output ? 0 : config->unit_width,
 			evsel->unit, config->csv_sep);
 
 	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
@@ -1056,7 +1056,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		}
 
 		fprintf(config->output, "%-*s%s",
-			config->csv_output ? 0 : unit_width,
+			config->csv_output ? 0 : config->unit_width,
 			counter->unit, config->csv_sep);
 
 		fprintf(config->output, "%*s",
@@ -1542,6 +1542,7 @@ static void print_interval(struct perf_stat_config *config,
 			   char *prefix, struct timespec *ts)
 {
 	bool metric_only = config->metric_only;
+	unsigned int unit_width = config->unit_width;
 	FILE *output = config->output;
 	static int num_print_interval;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index da838182b99c..2dc66e0ba4b8 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -98,6 +98,7 @@ struct perf_stat_config {
 	unsigned int		 interval;
 	unsigned int		 timeout;
 	unsigned int		 initial_delay;
+	unsigned int		 unit_width;
 	int			 times;
 	struct runtime_stat	*stats;
 	int			 stats_num;
-- 
2.17.1

