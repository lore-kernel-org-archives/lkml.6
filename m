Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951AAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D6320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D6320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeH3KeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:34:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbeH3KeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:34:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A97B401DE83;
        Thu, 30 Aug 2018 06:33:34 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 374DAA9F09;
        Thu, 30 Aug 2018 06:33:33 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 24/43] perf stat: Add target argument to perf_evlist__print_counters
Date:   Thu, 30 Aug 2018 08:32:33 +0200
Message-Id: <20180830063252.23729-25-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:33:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:33:34 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding 'struct target' argument to perf_evlist__print_counters,
so the function does not depend on stat command object local
target and can be moved out.

Link: http://lkml.kernel.org/n/tip-fxhirh8l1b9i0ozb6j69umd1@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 24171aa6c41f..528f85146b59 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1590,6 +1590,7 @@ static void print_interval(struct perf_stat_config *config,
 }
 
 static void print_header(struct perf_stat_config *config,
+			 struct target *_target,
 			 int argc, const char **argv)
 {
 	FILE *output = config->output;
@@ -1600,18 +1601,18 @@ static void print_header(struct perf_stat_config *config,
 	if (!config->csv_output) {
 		fprintf(output, "\n");
 		fprintf(output, " Performance counter stats for ");
-		if (target.system_wide)
+		if (_target->system_wide)
 			fprintf(output, "\'system wide");
-		else if (target.cpu_list)
-			fprintf(output, "\'CPU(s) %s", target.cpu_list);
-		else if (!target__has_task(&target)) {
+		else if (_target->cpu_list)
+			fprintf(output, "\'CPU(s) %s", _target->cpu_list);
+		else if (!target__has_task(_target)) {
 			fprintf(output, "\'%s", argv ? argv[0] : "pipe");
 			for (i = 1; argv && (i < argc); i++)
 				fprintf(output, " %s", argv[i]);
-		} else if (target.pid)
-			fprintf(output, "process id \'%s", target.pid);
+		} else if (_target->pid)
+			fprintf(output, "process id \'%s", _target->pid);
 		else
-			fprintf(output, "thread id \'%s", target.tid);
+			fprintf(output, "thread id \'%s", _target->tid);
 
 		fprintf(output, "\'");
 		if (run_count > 1)
@@ -1716,6 +1717,7 @@ static void print_footer(struct perf_stat_config *config)
 static void
 perf_evlist__print_counters(struct perf_evlist *evlist,
 			    struct perf_stat_config *config,
+			    struct target *_target,
 			    struct timespec *ts,
 			    int argc, const char **argv)
 {
@@ -1727,7 +1729,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	if (interval)
 		print_interval(config, prefix = buf, ts);
 	else
-		print_header(config, argc, argv);
+		print_header(config, _target, argc, argv);
 
 	if (metric_only) {
 		static int num_print_iv;
@@ -1789,7 +1791,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	if (STAT_RECORD && perf_stat.data.is_pipe)
 		return;
 
-	perf_evlist__print_counters(evsel_list, &stat_config,
+	perf_evlist__print_counters(evsel_list, &stat_config, &target,
 				    ts, argc, argv);
 }
 
-- 
2.17.1

