Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2686AC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C762220869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OM10jzGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C762220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeIFCiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbeIFCiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:19 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F5120867;
        Wed,  5 Sep 2018 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185167;
        bh=gF03qJxZxKTQgoik2t/Slbi20br5Im0szxW+jkLmvrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OM10jzGJozXTCb/YUhvtfMZo9eetIxij7ulLTdI/YPbdLWwABfmt1aJAuDF6EvrNZ
         dG8vwyj4ugbNeMlyb4r0cx6LvJlsWIgwWqOy5ZcMSOauhlrMGF1fgEASga9mLjYxZm
         6F3ytq9QDebjaF/hu5ap6vk5ZWCFNdB5G1XmSlwo=
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
Subject: [PATCH 28/77] perf stat: Move 'no_inherit' to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:03:51 -0300
Message-Id: <20180905220440.20256-29-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'no_inherit' variable to 'struct perf_stat_config', so
it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 719abdd3b7de..84dbac526925 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -148,7 +148,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 #define METRIC_ONLY_LEN 20
 
 static int			run_count			=  1;
-static bool			no_inherit			= false;
 static volatile pid_t		child_pid			= -1;
 static bool			null_run			=  false;
 static int			detailed_run			=  0;
@@ -254,7 +253,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel,
 	if (leader->nr_members > 1)
 		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
 
-	attr->inherit = !no_inherit;
+	attr->inherit = !config->no_inherit;
 
 	/*
 	 * Some events get initialized with sample_(period/type) set,
@@ -1969,7 +1968,7 @@ static const struct option stat_options[] = {
 		     parse_events_option),
 	OPT_CALLBACK(0, "filter", &evsel_list, "filter",
 		     "event filter", parse_filter),
-	OPT_BOOLEAN('i', "no-inherit", &no_inherit,
+	OPT_BOOLEAN('i', "no-inherit", &stat_config.no_inherit,
 		    "child tasks do not inherit counters"),
 	OPT_STRING('p', "pid", &target.pid, "pid",
 		   "stat events on existing process id"),
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 91e6609fce6e..53b2415ba3f3 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -88,6 +88,7 @@ struct runtime_stat {
 struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
+	bool			 no_inherit;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4

