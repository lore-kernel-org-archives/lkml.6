Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF729C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA1320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA1320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbeH3KeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728186AbeH3KeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AD2C7A7EF;
        Thu, 30 Aug 2018 06:33:49 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26FCBA9F09;
        Thu, 30 Aug 2018 06:33:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 33/43] perf stat: Move print_free_counters_hint into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:42 +0200
Message-Id: <20180830063252.23729-34-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving print_free_counters_hint into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-ksfkhgwoquxqrlryz8se3hen@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 844c755564e3..8748bb5e5403 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -170,7 +170,6 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static int			print_free_counters_hint;
 static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
@@ -1051,7 +1050,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			config->csv_sep);
 
 		if (counter->supported) {
-			print_free_counters_hint = 1;
+			config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
 				print_mixed_hw_group_error = 1;
 		}
@@ -1707,7 +1706,7 @@ static void print_footer(struct perf_stat_config *config)
 	}
 	fprintf(output, "\n\n");
 
-	if (print_free_counters_hint &&
+	if (config->print_free_counters_hint &&
 	    sysctl__read_int("kernel/nmi_watchdog", &n) >= 0 &&
 	    n > 0)
 		fprintf(output,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index c198926c0e27..8cad17363e90 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	unsigned int		 metric_only_len;
 	int			 times;
 	int			 run_count;
+	int			 print_free_counters_hint;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
-- 
2.17.1

