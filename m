Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A88C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B70A2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B70A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbeIFSSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:18:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbeIFSSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:18:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DgY2Y310427
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:42:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DgYAd310424;
        Thu, 6 Sep 2018 06:42:34 -0700
Date:   Thu, 6 Sep 2018 06:42:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-be54d59325314be9d4d53852cbfbeeaebc3b9239@git.kernel.org>
Cc:     dsahern@gmail.com, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        andi@firstfloor.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, acme@redhat.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, andi@firstfloor.org,
          acme@redhat.com, peterz@infradead.org, namhyung@kernel.org,
          tglx@linutronix.de, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          hpa@zytor.com, jolsa@kernel.org
In-Reply-To: <20180830063252.23729-41-jolsa@kernel.org>
References: <20180830063252.23729-41-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Propagate 'struct target' arg to
 sort_aggr_thread()
Git-Commit-ID: be54d59325314be9d4d53852cbfbeeaebc3b9239
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

Commit-ID:  be54d59325314be9d4d53852cbfbeeaebc3b9239
Gitweb:     https://git.kernel.org/tip/be54d59325314be9d4d53852cbfbeeaebc3b9239
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:49 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:25 -0300

perf stat: Propagate 'struct target' arg to sort_aggr_thread()

Propagate the 'struct target' arg to sort_aggr_thread() so that the
function does not depend on the 'perf stat' command object local
variable 'target' and can be moved out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-41-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c4df076f1e54..486b0cf7818d 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1284,7 +1284,8 @@ static int cmp_val(const void *a, const void *b)
 static struct perf_aggr_thread_value *sort_aggr_thread(
 					struct perf_evsel *counter,
 					int nthreads, int ncpus,
-					int *ret)
+					int *ret,
+					struct target *_target)
 {
 	int cpu, thread, i = 0;
 	double uval;
@@ -1309,7 +1310,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 		 * Skip value 0 when enabling --per-thread globally,
 		 * otherwise too many 0 output.
 		 */
-		if (uval == 0.0 && target__has_per_thread(&target))
+		if (uval == 0.0 && target__has_per_thread(_target))
 			continue;
 
 		buf[i].counter = counter;
@@ -1330,6 +1331,7 @@ static struct perf_aggr_thread_value *sort_aggr_thread(
 }
 
 static void print_aggr_thread(struct perf_stat_config *config,
+			      struct target *_target,
 			      struct perf_evsel *counter, char *prefix)
 {
 	FILE *output = config->output;
@@ -1338,7 +1340,7 @@ static void print_aggr_thread(struct perf_stat_config *config,
 	int thread, sorted_threads, id;
 	struct perf_aggr_thread_value *buf;
 
-	buf = sort_aggr_thread(counter, nthreads, ncpus, &sorted_threads);
+	buf = sort_aggr_thread(counter, nthreads, ncpus, &sorted_threads, _target);
 	if (!buf) {
 		perror("cannot sort aggr thread");
 		return;
@@ -1754,7 +1756,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
-			print_aggr_thread(config, counter, prefix);
+			print_aggr_thread(config, _target, counter, prefix);
 		}
 		break;
 	case AGGR_GLOBAL:
