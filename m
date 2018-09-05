Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A10AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77C020867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB8rRRq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77C020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeIFCjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:15 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A8B020869;
        Wed,  5 Sep 2018 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185223;
        bh=RZo0ALqNRCBkTQGQx+I9kN8uKtoweeuqexuSr3CQtFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AB8rRRq/SPZlKeKT6ZnA+5OVm5x4hwkfJ877szbr/xRB6Ol8zzhlpR929X1e60OHh
         EFaerJ+Oi3ricJ8YVyq77/jA2bhJzZB9q8o1Qsj3QGaV/8V5BDpv3Ww8CoxelbE89C
         J/zhR+tihdsvhioCc7ltK/cVU7Pe3FvQEHch0UV4=
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
Subject: [PATCH 48/77] perf stat: Move 'unit_width' to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:11 -0300
Message-Id: <20180905220440.20256-49-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'unit_width' variable to 'struct perf_stat_config',
so it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-24-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

