Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB53DC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643152077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSqJGYJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643152077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeIFCix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbeIFCix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:53 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE2C20652;
        Wed,  5 Sep 2018 22:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185201;
        bh=yeuYOY0BqagfsntxNlrduM5Nk+4G/Ht03Z7EAla7ayk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSqJGYJGOX2rT5jO6po9pkypBf2qaXWg93NbYQBmdftB2YRvCS32JNbOpsh0RT83p
         CqHW/33/jsiD+WXpl/SC/ewKTYX9/kVr2uUdSzovLmlx6prLT3ijUL/E7p8XG0pDfz
         pboqMc7suWuhbjgtqdaSBxGAcTyHU5DXiYQ86sZk=
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
Subject: [PATCH 40/77] perf stat: Introduce perf_evlist__print_counters()
Date:   Wed,  5 Sep 2018 19:04:03 -0300
Message-Id: <20180905220440.20256-41-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

