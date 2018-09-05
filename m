Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99D7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DA220652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ28eVJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DA220652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbeIFCir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeIFCiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:46 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E77D12083E;
        Wed,  5 Sep 2018 22:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185195;
        bh=aYgHTeDSBomLwYEsznrOhN/jS06KPzVDtbyycnfQvTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQ28eVJy57561v0JgH3o2M3OfnWR41o6vO3ITOhsTw4KAvoFlTwCVR+TE9ZLlfjsH
         bxNEQO/L8rh7dA6MoE36DERcWuPvpTpDcCq4sBdAOJRmln+7LW2h3AiaXzxNxDJfql
         gni3h05imT5q2zALfoykKul/e1fi7v5L+68WBo+0=
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
Subject: [PATCH 38/77] perf stat: Add 'perf_event__handler_t' argument to perf_stat_synthesize_config()
Date:   Wed,  5 Sep 2018 19:04:01 -0300
Message-Id: <20180905220440.20256-39-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
@@ -609,7 +606,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return err;
 
 		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
-						  is_pipe);
+						  process_synthesized_event, is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.4

