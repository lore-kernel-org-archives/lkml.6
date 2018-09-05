Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99F7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FD12086D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJxsU4oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FD12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbeIFCio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeIFCio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:44 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EBF820652;
        Wed,  5 Sep 2018 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185192;
        bh=ADaxsaST1rSlQYGgMi0FeTbrFD4IynWqaOkNjf91RQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJxsU4oL62g6nKPv0Jbxt5avzihsLF9q51WcV/+XVGRv2SBXft1Ikk6d2SCodKpZC
         6W+j8wVTq+T3QbcdG6Z+aXG9Imvs9AUBAeTUBCqJmh+V//APdwoF7jxPdNpoI/cLOQ
         F0lbfxZgO2mvp5TnEic0dCalb6FXBDn3o9VEr7VM=
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
Subject: [PATCH 37/77] perf stat: Add 'struct perf_evlist' argument to perf_stat_synthesize_config()
Date:   Wed,  5 Sep 2018 19:04:00 -0300
Message-Id: <20180905220440.20256-38-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Get rid of the 'evsel_list' global variable dependency, here in
perf_stat_synthesize_config() we are adding the 'evlist' arg.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ae5029875e87..cb36344c25b7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -404,12 +404,13 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 
 static int perf_stat_synthesize_config(struct perf_stat_config *config,
 				       struct perf_tool *tool,
+				       struct perf_evlist *evlist,
 				       bool attrs)
 {
 	int err;
 
 	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evsel_list,
+		err = perf_event__synthesize_attrs(tool, evlist,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
@@ -417,12 +418,11 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		}
 	}
 
-	err = perf_event__synthesize_extra_attr(tool,
-						evsel_list,
+	err = perf_event__synthesize_extra_attr(tool, evlist,
 						process_synthesized_event,
 						attrs);
 
-	err = perf_event__synthesize_thread_map2(tool, evsel_list->threads,
+	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
 						process_synthesized_event,
 						NULL);
 	if (err < 0) {
@@ -430,7 +430,7 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(tool, evsel_list->cpus,
+	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
 					     process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
@@ -608,7 +608,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(&stat_config, NULL, is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
+						  is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.4

