Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D671C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECB82083D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoNZSg3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECB82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeIFCjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:40 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2114F2077C;
        Wed,  5 Sep 2018 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185248;
        bh=r7sbqwk/uPZZkUf6y70h2HcZsTPOQxC6uszFFJLHeqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoNZSg3QzKi/IX8/XAbeunussijy5sLkBQKxe8YB9eeaJbfSTKBjoEgjNJ4pHAyZ5
         9HW6QBIgcO7v3q+bj/dMBw8qXVTzjeI+RokBiGLkXPIS2RwC29EuEtanbJMUelZldn
         Ok3+j9ObQlqJRyt3cmGVP+CFBVUlMVoSr8Iulwlo=
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
Subject: [PATCH 57/77] perf stat: Move 'null_run' to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:20 -0300
Message-Id: <20180905220440.20256-58-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'null_run' variable to 'struct perf_stat_config', so
that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-33-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 +++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 381549a989b4..844c755564e3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -148,7 +148,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 #define METRIC_ONLY_LEN 20
 
 static volatile pid_t		child_pid			= -1;
-static bool			null_run			=  false;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -1676,7 +1675,7 @@ static void print_footer(struct perf_stat_config *config)
 	FILE *output = config->output;
 	int n;
 
-	if (!null_run)
+	if (!config->null_run)
 		fprintf(output, "\n");
 
 	if (config->run_count == 1) {
@@ -1894,7 +1893,7 @@ static const struct option stat_options[] = {
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
 	OPT_BOOLEAN(0, "table", &walltime_run_table,
 		    "display details about each run (only with -r option)"),
-	OPT_BOOLEAN('n', "null", &null_run,
+	OPT_BOOLEAN('n', "null", &stat_config.null_run,
 		    "null run - dont start any counters"),
 	OPT_INCR('d', "detailed", &detailed_run,
 		    "detailed run - start a lot of events"),
@@ -2309,7 +2308,7 @@ static int add_default_attributes(void)
 	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
-	if (null_run)
+	if (stat_config.null_run)
 		return 0;
 
 	if (transaction_run) {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 35550e3efd81..c198926c0e27 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -94,6 +94,7 @@ struct perf_stat_config {
 	bool			 csv_output;
 	bool			 interval_clear;
 	bool			 metric_only;
+	bool			 null_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4

