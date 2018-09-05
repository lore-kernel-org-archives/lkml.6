Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EEBC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCADC20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKsoTzFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCADC20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeIFCjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:18 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A5420652;
        Wed,  5 Sep 2018 22:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185226;
        bh=aJgB5wzlD+4Gdk07kfNrtv4L0hOZBbHI0+6YVTOd0DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKsoTzFqfMhP07N/EE5wF47g9qmAGP3bYtp4K3xS/DQxRtr7JxOopXBP5iwVYZ/EK
         59HT/iMObG+5EQxkkWnqLtsCWf6RB3rfyEAEEjf7kL4Cc0iCVRMTqXMSDMJgpZtSRZ
         3Gdcjqd3uCSldnf+4gAdG+IAbiy7qsuckgJfYQfQ=
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
Subject: [PATCH 49/77] perf stat: Add 'target' argument to perf_evlist__print_counters()
Date:   Wed,  5 Sep 2018 19:04:12 -0300
Message-Id: <20180905220440.20256-50-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'struct target' argument to perf_evlist__print_counters(), so the
function does not depend on the 'perf stat' command object local target
and can be moved out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

