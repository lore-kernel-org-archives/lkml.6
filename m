Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042FFC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBBE2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBBE2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeIFSJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:09:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37037 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbeIFSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:09:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DXX5c309109
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:33:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DXXtg309106;
        Thu, 6 Sep 2018 06:33:33 -0700
Date:   Thu, 6 Sep 2018 06:33:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c512e0eae4c63be8c5964c3942b2e9c04dcd459e@git.kernel.org>
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org,
        andi@firstfloor.org, mingo@kernel.org, peterz@infradead.org,
        jolsa@kernel.org
Reply-To: hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          jolsa@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, dsahern@gmail.com,
          mingo@kernel.org, andi@firstfloor.org
In-Reply-To: <20180830063252.23729-25-jolsa@kernel.org>
References: <20180830063252.23729-25-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'target' argument to
 perf_evlist__print_counters()
Git-Commit-ID: c512e0eae4c63be8c5964c3942b2e9c04dcd459e
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

Commit-ID:  c512e0eae4c63be8c5964c3942b2e9c04dcd459e
Gitweb:     https://git.kernel.org/tip/c512e0eae4c63be8c5964c3942b2e9c04dcd459e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:33 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:23 -0300

perf stat: Add 'target' argument to perf_evlist__print_counters()

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
 
