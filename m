Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCFC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF17D2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF17D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeH3Kdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727379AbeH3Kdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C8EC87927;
        Thu, 30 Aug 2018 06:33:19 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28D1DA9F09;
        Thu, 30 Aug 2018 06:33:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 15/43] perf stat: Add perf_evlist__print_counters function
Date:   Thu, 30 Aug 2018 08:32:24 +0200
Message-Id: <20180830063252.23729-16-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 30 Aug 2018 06:33:19 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be in charge of printing out the stat output. It will be
moved out of stat command in following patches.

Link: http://lkml.kernel.org/n/tip-girva61h4z5vjn9fclc4d2x9@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 54768ec15dbc..db11832bbdbc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1692,7 +1692,10 @@ static void print_footer(void)
 			"the same PMU. Try reorganizing the group.\n");
 }
 
-static void print_counters(struct timespec *ts, int argc, const char **argv)
+static void
+perf_evlist__print_counters(struct perf_evlist *evlist,
+			    struct timespec *ts,
+			    int argc, const char **argv)
 {
 	int interval = stat_config.interval;
 	struct perf_evsel *counter;
@@ -1724,14 +1727,14 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 		print_aggr(prefix);
 		break;
 	case AGGR_THREAD:
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 			print_aggr_thread(counter, prefix);
 		}
 		break;
 	case AGGR_GLOBAL:
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 			print_counter_aggr(counter, prefix);
@@ -1743,7 +1746,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 		if (metric_only)
 			print_no_aggr_metric(prefix);
 		else {
-			evlist__for_each_entry(evsel_list, counter) {
+			evlist__for_each_entry(evlist, counter) {
 				if (is_duration_time(counter))
 					continue;
 				print_counter(counter, prefix);
@@ -1761,6 +1764,11 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	fflush(stat_config.output);
 }
 
+static void print_counters(struct timespec *ts, int argc, const char **argv)
+{
+	perf_evlist__print_counters(evsel_list, ts, argc, argv);
+}
+
 static volatile int signr = -1;
 
 static void skip_signal(int signo)
-- 
2.17.1

