Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E4EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5630B20652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="umxaoZkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5630B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeIFCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbeIFCkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:04 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7133E20869;
        Wed,  5 Sep 2018 22:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185272;
        bh=IH3x1VE17h0ZqOQAFJeX89qRMVcxqJzOr7EwsfWtpNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umxaoZkDiMn0rhG59yM0Zadv4b0npi0JSfQB/TPRE1OxsV589Tbdc2U1Ha4Tdv821
         mKrLGlJjvkyQ/2WjL5U5KO71HnCYZMa/dgNVfiiqPAQMk9WsUio1Fo0zww55UyerHB
         7chAt85OBj0mACDmMd9fXYMZjD8yFVIwiGL758cg=
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
Subject: [PATCH 65/77] perf stat: Propagate 'struct target' arg to sort_aggr_thread()
Date:   Wed,  5 Sep 2018 19:04:28 -0300
Message-Id: <20180905220440.20256-66-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

