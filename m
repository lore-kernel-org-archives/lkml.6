Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB2A2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB2A2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeH3Kdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727379AbeH3Kdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3EB9B26356;
        Thu, 30 Aug 2018 06:33:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0065A9F09;
        Thu, 30 Aug 2018 06:33:14 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 13/43] perf stat: Add perf_event__handler_t argument to perf_stat_synthesize_config
Date:   Thu, 30 Aug 2018 08:32:22 +0200
Message-Id: <20180830063252.23729-14-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:16 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it's completely independent and can be
used outside stat command.

Link: http://lkml.kernel.org/n/tip-eehdn85xqcqf7jrafoqu2lfv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
@@ -609,7 +606,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return err;
 
 		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
-						  is_pipe);
+						  process_synthesized_event, is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.17.1

