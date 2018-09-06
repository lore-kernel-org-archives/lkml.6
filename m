Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008AC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D46F2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D46F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeIFSDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:03:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbeIFSDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:03:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DRawV308170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:27:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DRaIg308167;
        Thu, 6 Sep 2018 06:27:36 -0700
Date:   Thu, 6 Sep 2018 06:27:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c2c247f2dd87706961fa16d033f9dbf173145e70@git.kernel.org>
Cc:     andi@firstfloor.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, namhyung@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        tglx@linutronix.de, dsahern@gmail.com, jolsa@kernel.org
Reply-To: andi@firstfloor.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@kernel.org, peterz@infradead.org, namhyung@kernel.org,
          tglx@linutronix.de, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          jolsa@kernel.org
In-Reply-To: <20180830063252.23729-14-jolsa@kernel.org>
References: <20180830063252.23729-14-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Add 'perf_event__handler_t' argument to
 perf_stat_synthesize_config()
Git-Commit-ID: c2c247f2dd87706961fa16d033f9dbf173145e70
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

Commit-ID:  c2c247f2dd87706961fa16d033f9dbf173145e70
Gitweb:     https://git.kernel.org/tip/c2c247f2dd87706961fa16d033f9dbf173145e70
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:22 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Add 'perf_event__handler_t' argument to perf_stat_synthesize_config()

So that it's completely independent and can be used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cb36344c25b7..1171d4e00276 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -405,40 +405,37 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 static int perf_stat_synthesize_config(struct perf_stat_config *config,
 				       struct perf_tool *tool,
 				       struct perf_evlist *evlist,
+				       perf_event__handler_t process,
 				       bool attrs)
 {
 	int err;
 
 	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evlist,
-						   process_synthesized_event);
+		err = perf_event__synthesize_attrs(tool, evlist, process);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
 			return err;
 		}
 	}
 
-	err = perf_event__synthesize_extra_attr(tool, evlist,
-						process_synthesized_event,
+	err = perf_event__synthesize_extra_attr(tool, evlist, process,
 						attrs);
 
 	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
-						process_synthesized_event,
-						NULL);
+						 process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
 		return err;
 	}
 
 	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
-					     process_synthesized_event, NULL);
+					     process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
 		return err;
 	}
 
-	err = perf_event__synthesize_stat_config(tool, config,
-						 process_synthesized_event, NULL);
+	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize config.\n");
 		return err;
@@ -609,7 +606,7 @@ try_again:
 			return err;
 
 		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
-						  is_pipe);
+						  process_synthesized_event, is_pipe);
 		if (err < 0)
 			return err;
 	}
