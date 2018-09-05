Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742FEC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231FC20857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL6eU8QJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231FC20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeIFCij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeIFCii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:38 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10762083D;
        Wed,  5 Sep 2018 22:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185187;
        bh=TnJCSUE3sWs3tmvkjVTwqa2/DVAK/9inqFKShdBs2Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BL6eU8QJppOxtyb3MkrIOqexcoaidARJVeG21ZDgENYE7xV6mj9KV0P5nMXawnNex
         f5TIm/o7Da0BaXHrzYYR4l0A1rp4yP3/bhGuRh4AT8UkiH78gAMStcYWw73TfjkXas
         fWAwHT8pgpQ9ONbw0RyYiRMGCf9An8+DU8a87MZQ=
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
Subject: [PATCH 35/77] perf stat: Add 'struct perf_stat_config' argument to perf_stat_synthesize_config()
Date:   Wed,  5 Sep 2018 19:03:58 -0300
Message-Id: <20180905220440.20256-36-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a 'struct perf_stat_config' argument to perf_stat_synthesize_config(),
so we could synthesize arbitrary config.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0a358c2e1a93..d0d19a5ffa85 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -402,7 +402,8 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static int perf_stat_synthesize_config(bool attrs)
+static int perf_stat_synthesize_config(struct perf_stat_config *config,
+				       bool attrs)
 {
 	int err;
 
@@ -435,7 +436,7 @@ static int perf_stat_synthesize_config(bool attrs)
 		return err;
 	}
 
-	err = perf_event__synthesize_stat_config(NULL, &stat_config,
+	err = perf_event__synthesize_stat_config(NULL, config,
 						 process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize config.\n");
@@ -606,7 +607,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.4

