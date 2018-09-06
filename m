Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FCDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F2E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F2E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbeIFSKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:10:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbeIFSKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:10:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DY4gO309142
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:34:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DY40E309139;
        Thu, 6 Sep 2018 06:34:04 -0700
Date:   Thu, 6 Sep 2018 06:34:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bc0bcda201e87d62f0922fa664376355b0fc77ff@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, acme@redhat.com, andi@firstfloor.org,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        dsahern@gmail.com, jolsa@kernel.org, namhyung@kernel.org
Reply-To: jolsa@kernel.org, namhyung@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, dsahern@gmail.com, mingo@kernel.org,
          andi@firstfloor.org, acme@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180830063252.23729-26-jolsa@kernel.org>
References: <20180830063252.23729-26-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Pass 'evlist' argument to print
 functions
Git-Commit-ID: bc0bcda201e87d62f0922fa664376355b0fc77ff
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bc0bcda201e87d62f0922fa664376355b0fc77ff
Gitweb:     https://git.kernel.org/tip/bc0bcda201e87d62f0922fa664376355b0fc77ff
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:34 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:23 -0300

perf stat: Pass 'evlist' argument to print functions

Add 'evlist' argument to print functions to get rid of the global
'evsel_list' variable dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-26-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
