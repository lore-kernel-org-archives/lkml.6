Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F03D2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F03D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeH3KeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728062AbeH3KeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48CD47DAC2;
        Thu, 30 Aug 2018 06:33:36 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8AAEA9F09;
        Thu, 30 Aug 2018 06:33:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 25/43] perf stat: Pass evlist argument to print functions
Date:   Thu, 30 Aug 2018 08:32:34 +0200
Message-Id: <20180830063252.23729-26-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:36 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding evlist argument to print functions to get
rid of the evsel_list dependency.

Link: http://lkml.kernel.org/n/tip-wema3fc7ibju89vom0p4pc4a@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 528f85146b59..46181ac492c5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1222,6 +1222,7 @@ static void aggr_cb(struct perf_evsel *counter, void *data, bool first)
 }
 
 static void print_aggr(struct perf_stat_config *config,
+		       struct perf_evlist *evlist,
 		       char *prefix)
 {
 	bool metric_only = config->metric_only;
@@ -1248,7 +1249,7 @@ static void print_aggr(struct perf_stat_config *config,
 
 		ad.id = id = aggr_map->map[s];
 		first = true;
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 
@@ -1449,6 +1450,7 @@ static void print_counter(struct perf_stat_config *config,
 }
 
 static void print_no_aggr_metric(struct perf_stat_config *config,
+				 struct perf_evlist *evlist,
 				 char *prefix)
 {
 	int cpu;
@@ -1457,13 +1459,13 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 	u64 ena, run, val;
 	double uval;
 
-	nrcpus = evsel_list->cpus->nr;
+	nrcpus = evlist->cpus->nr;
 	for (cpu = 0; cpu < nrcpus; cpu++) {
 		bool first = true;
 
 		if (prefix)
 			fputs(prefix, config->output);
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 			if (first) {
@@ -1499,6 +1501,7 @@ static const char *aggr_header_csv[] = {
 };
 
 static void print_metric_headers(struct perf_stat_config *config,
+				 struct perf_evlist *evlist,
 				 const char *prefix, bool no_indent)
 {
 	struct perf_stat_output_ctx out;
@@ -1520,7 +1523,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 	}
 
 	/* Print metrics headers only */
-	evlist__for_each_entry(evsel_list, counter) {
+	evlist__for_each_entry(evlist, counter) {
 		if (is_duration_time(counter))
 			continue;
 		os.evsel = counter;
@@ -1539,6 +1542,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 }
 
 static void print_interval(struct perf_stat_config *config,
+			   struct perf_evlist *evlist,
 			   char *prefix, struct timespec *ts)
 {
 	bool metric_only = config->metric_only;
@@ -1584,7 +1588,7 @@ static void print_interval(struct perf_stat_config *config,
 	}
 
 	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
-		print_metric_headers(config, " ", true);
+		print_metric_headers(config, evlist, " ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
 }
@@ -1727,7 +1731,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	char buf[64], *prefix = NULL;
 
 	if (interval)
-		print_interval(config, prefix = buf, ts);
+		print_interval(config, evlist, prefix = buf, ts);
 	else
 		print_header(config, _target, argc, argv);
 
@@ -1735,7 +1739,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		static int num_print_iv;
 
 		if (num_print_iv == 0 && !interval)
-			print_metric_headers(config, prefix, false);
+			print_metric_headers(config, evlist, prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
 		if (config->aggr_mode == AGGR_GLOBAL && prefix)
@@ -1745,7 +1749,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	switch (config->aggr_mode) {
 	case AGGR_CORE:
 	case AGGR_SOCKET:
-		print_aggr(config, prefix);
+		print_aggr(config, evlist, prefix);
 		break;
 	case AGGR_THREAD:
 		evlist__for_each_entry(evlist, counter) {
@@ -1765,7 +1769,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		break;
 	case AGGR_NONE:
 		if (metric_only)
-			print_no_aggr_metric(config, prefix);
+			print_no_aggr_metric(config, evlist, prefix);
 		else {
 			evlist__for_each_entry(evlist, counter) {
 				if (is_duration_time(counter))
-- 
2.17.1

