Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7461DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CF82082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CF82082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbeH3Kel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728296AbeH3Kek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E0857788D;
        Thu, 30 Aug 2018 06:34:04 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 163B9A9F09;
        Thu, 30 Aug 2018 06:34:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 42/43] perf stat: Move metric_events into struct perf_stat_config
Date:   Thu, 30 Aug 2018 08:32:51 +0200
Message-Id: <20180830063252.23729-43-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:34:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:34:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving static metric_events into struct perf_stat_config,
so it can be passed around and used outside stat command.

Link: http://lkml.kernel.org/n/tip-3yq5yfji3xlcp2khtioegmpp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 10 ++++------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8a4979748cbb..f4ddedc8619b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -137,8 +137,6 @@ static const char *smi_cost_attrs = {
 
 static struct perf_evlist	*evsel_list;
 
-static struct rblist		 metric_events;
-
 static struct target target = {
 	.uid	= UINT_MAX,
 };
@@ -1082,7 +1080,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 
 	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu(config, counter, id),
-				&out, &metric_events, st);
+				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
@@ -1533,7 +1531,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
-					      &metric_events,
+					      &config->metric_events,
 					      &rt_stat);
 	}
 	fputc('\n', config->output);
@@ -1860,7 +1858,7 @@ static int parse_metric_groups(const struct option *opt,
 			       const char *str,
 			       int unset __maybe_unused)
 {
-	return metricgroup__parse_groups(opt, str, &metric_events);
+	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
 static const struct option stat_options[] = {
@@ -2321,7 +2319,7 @@ static int add_default_attributes(void)
 			struct option opt = { .value = &evsel_list };
 
 			return metricgroup__parse_groups(&opt, "transaction",
-							 &metric_events);
+							 &stat_config.metric_events);
 		}
 
 		if (pmu_have_event("cpu", "cycles-ct") &&
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 5193cbf6e4c6..8d3354e21e19 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -125,6 +125,7 @@ struct perf_stat_config {
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
+	struct rblist		 metric_events;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.17.1

