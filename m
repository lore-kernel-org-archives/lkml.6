Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7CDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F69E20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F69E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeH3Kee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbeH3Ked (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D525C5A75E;
        Thu, 30 Aug 2018 06:33:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 727DDA9F09;
        Thu, 30 Aug 2018 06:33:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 38/43] perf stat: Move big_num data into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:47 +0200
Message-Id: <20180830063252.23729-39-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static big_num into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-3z70bag45oyahf06loz984uo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 8 ++++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 445673f688de..8ca85017a973 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -151,7 +151,6 @@ static bool			transaction_run;
 static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
-static bool			big_num				=  true;
 static int			big_num_opt			=  -1;
 static bool			group				= false;
 static const char		*pre_cmd			= NULL;
@@ -192,6 +191,7 @@ static struct perf_stat_config stat_config = {
 	.run_count		= 1,
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
+	.big_num		= true,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -945,7 +945,7 @@ static void abs_printout(struct perf_stat_config *config,
 	if (config->csv_output) {
 		fmt = floor(sc) != sc ?  "%.2f%s" : "%.0f%s";
 	} else {
-		if (big_num)
+		if (config->big_num)
 			fmt = floor(sc) != sc ? "%'18.2f%s" : "%'18.0f%s";
 		else
 			fmt = floor(sc) != sc ? "%18.2f%s" : "%18.0f%s";
@@ -2847,9 +2847,9 @@ int cmd_stat(int argc, const char **argv)
 			parse_options_usage(NULL, stat_options, "x", 1);
 			goto out;
 		} else /* Nope, so disable big number formatting */
-			big_num = false;
+			stat_config.big_num = false;
 	} else if (big_num_opt == 0) /* User passed --no-big-num */
-		big_num = false;
+		stat_config.big_num = false;
 
 	setup_system_wide(argc);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index be202b066e62..843672214cca 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	bool			 metric_only;
 	bool			 null_run;
 	bool			 ru_display;
+	bool			 big_num;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

