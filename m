Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801F820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801F820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeH3Keh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44142 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728296AbeH3Keg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D7BA40201BC;
        Thu, 30 Aug 2018 06:34:01 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEF52B27A5;
        Thu, 30 Aug 2018 06:33:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 40/43] perf stat: Propagate struct target arg to sort_aggr_thread
Date:   Thu, 30 Aug 2018 08:32:49 +0200
Message-Id: <20180830063252.23729-41-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:34:01 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:34:01 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate struct target arg to sort_aggr_thread
so the function does not depend on stat command object
local target and can be moved out.

Link: http://lkml.kernel.org/n/tip-1q2zv8p9pwa3vddh2js3s9fo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.1

