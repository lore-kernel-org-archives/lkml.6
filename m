Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2009C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6AA2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6AA2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbeIFSEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:04:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbeIFSEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:04:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DSgv2308244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:28:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DSgu3308241;
        Thu, 6 Sep 2018 06:28:42 -0700
Date:   Thu, 6 Sep 2018 06:28:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a5a9eac1a018ad3bfcf9a3ec11eae99fd35f466b@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, namhyung@kernel.org,
        andi@firstfloor.org, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, andi@firstfloor.org,
          namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, alexander.shishkin@linux.intel.com
In-Reply-To: <20180830063252.23729-16-jolsa@kernel.org>
References: <20180830063252.23729-16-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Introduce perf_evlist__print_counters()
Git-Commit-ID: a5a9eac1a018ad3bfcf9a3ec11eae99fd35f466b
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

Commit-ID:  a5a9eac1a018ad3bfcf9a3ec11eae99fd35f466b
Gitweb:     https://git.kernel.org/tip/a5a9eac1a018ad3bfcf9a3ec11eae99fd35f466b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:24 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Introduce perf_evlist__print_counters()

To be in charge of printing out the stat output. It will be moved out of
the 'perf stat' command in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
