Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id C4LmOhddGFsRJQAAmS7hNA
	; Wed, 06 Jun 2018 22:16:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C177D60861; Wed,  6 Jun 2018 22:16:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4D1DF605BD;
	Wed,  6 Jun 2018 22:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D1DF605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeFFWPj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:15:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752282AbeFFWPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EC7B8151D42;
        Wed,  6 Jun 2018 22:15:35 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8191E2026DEF;
        Wed,  6 Jun 2018 22:15:33 +0000 (UTC)
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 06/10] perf stat: Allow to specify specific metric column len
Date: Thu,  7 Jun 2018 00:15:09 +0200
Message-Id: <20180606221513.11302-7-jolsa@kernel.org>
In-Reply-To: <20180606221513.11302-1-jolsa@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:15:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:15:35 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following change will introduce new metrics,  that don't need
such wide hard coded spacing. Switching METRIC_ONLY_LEN macro
usage with metric_only_len variable.

Link: http://lkml.kernel.org/n/tip-bh0ke4fh2ygpj3yowna7o1di@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4e7bae4c98d2..a8f93885763a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -145,6 +145,8 @@ static struct target target = {
 
 typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 
+#define METRIC_ONLY_LEN 20
+
 static int			run_count			=  1;
 static bool			no_inherit			= false;
 static volatile pid_t		child_pid			= -1;
@@ -182,6 +184,7 @@ static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
+static unsigned int		metric_only_len			= METRIC_ONLY_LEN;
 
 struct perf_stat {
 	bool			 record;
@@ -969,8 +972,6 @@ static void print_metric_csv(void *ctx,
 	fprintf(out, "%s%s%s%s", csv_sep, vals, csv_sep, unit);
 }
 
-#define METRIC_ONLY_LEN 20
-
 /* Filter out some columns that don't work well in metrics only mode */
 
 static bool valid_only_metric(const char *unit)
@@ -1002,7 +1003,7 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 	char buf[1024], str[1024];
-	unsigned mlen = METRIC_ONLY_LEN;
+	unsigned mlen = metric_only_len;
 
 	if (!valid_only_metric(unit))
 		return;
@@ -1054,7 +1055,7 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 	if (csv_output)
 		fprintf(os->fh, "%s%s", unit, csv_sep);
 	else
-		fprintf(os->fh, "%*s ", METRIC_ONLY_LEN, unit);
+		fprintf(os->fh, "%*s ", metric_only_len, unit);
 }
 
 static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
-- 
2.13.6
