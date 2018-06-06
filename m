Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id npsZGRhdGFsKJQAAmS7hNA
	; Wed, 06 Jun 2018 22:16:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1312160861; Wed,  6 Jun 2018 22:16:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89766605BD;
	Wed,  6 Jun 2018 22:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89766605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeFFWPl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:15:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752552AbeFFWPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:15:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4150ACB9CF;
        Wed,  6 Jun 2018 22:15:33 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7E842026DEF;
        Wed,  6 Jun 2018 22:15:30 +0000 (UTC)
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
Subject: [PATCH 05/10] perf stat: Fix metric column display
Date: Thu,  7 Jun 2018 00:15:08 +0200
Message-Id: <20180606221513.11302-6-jolsa@kernel.org>
In-Reply-To: <20180606221513.11302-1-jolsa@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 06 Jun 2018 22:15:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 06 Jun 2018 22:15:33 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the metric only display aligned.

Before:
  # perf stat --topdown -I 1000
  #           time core         cpus retiring             bad speculation      frontend bound       backend bound
       1.000394323 S0-C0           2     37.4%               12.0%               31.4%               19.2%
       1.000394323 S0-C1           2     25.1%                9.2%               43.8%               21.9%
       2.001521204 S0-C0           2     36.4%               11.4%               32.4%               19.8%
       2.001521204 S0-C1           2     26.2%                9.4%               43.1%               21.3%
       3.001930208 S0-C0           2     35.1%               10.7%               33.6%               20.6%
       3.001930208 S0-C1           2     28.9%               10.0%               40.0%               21.1%

After:
  # perf stat --topdown -I 1000
  #           time core         cpus             retiring      bad speculation       frontend bound        backend bound
       1.000303722 S0-C0           2                34.2%                 7.6%                34.2%                24.0%
       1.000303722 S0-C1           2                33.1%                 6.4%                36.9%                23.6%
       2.001281055 S0-C0           2                34.6%                 6.7%                36.8%                21.8%
       2.001281055 S0-C1           2                32.8%                 7.1%                38.1%                22.0%
       3.001546080 S0-C0           2                39.3%                 5.5%                32.7%                22.5%
       3.001546080 S0-C1           2                37.8%                 6.0%                33.1%                23.1%

Link: http://lkml.kernel.org/n/tip-w26176oxgjojrub2z3hytkqp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0b1ddd5ef05d..4e7bae4c98d2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1001,19 +1001,20 @@ static void print_metric_only(void *ctx, const char *color, const char *fmt,
 {
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
-	int n;
-	char buf[1024];
+	char buf[1024], str[1024];
 	unsigned mlen = METRIC_ONLY_LEN;
 
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(buf, os->evsel, unit);
-	n = color_fprintf(out, color ?: "", fmt, val);
-	if (n > METRIC_ONLY_LEN)
-		n = METRIC_ONLY_LEN;
 	if (mlen < strlen(unit))
 		mlen = strlen(unit) + 1;
-	fprintf(out, "%*s", mlen - n, "");
+
+	if (color)
+		mlen += strlen(color) + sizeof(PERF_COLOR_RESET) - 1;
+
+	color_snprintf(str, sizeof(str), color ?: "", fmt, val);
+	fprintf(out, "%*s ", mlen, str);
 }
 
 static void print_metric_only_csv(void *ctx, const char *color __maybe_unused,
@@ -1053,7 +1054,7 @@ static void print_metric_header(void *ctx, const char *color __maybe_unused,
 	if (csv_output)
 		fprintf(os->fh, "%s%s", unit, csv_sep);
 	else
-		fprintf(os->fh, "%-*s ", METRIC_ONLY_LEN, unit);
+		fprintf(os->fh, "%*s ", METRIC_ONLY_LEN, unit);
 }
 
 static void nsec_printout(int id, int nr, struct perf_evsel *evsel, double avg)
@@ -1730,7 +1731,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 				fprintf(output, "             counts %*s events\n", unit_width, "unit");
 			break;
 		case AGGR_NONE:
-			fprintf(output, "#           time CPU");
+			fprintf(output, "#           time CPU    ");
 			if (!metric_only)
 				fprintf(output, "                counts %*s events\n", unit_width, "unit");
 			break;
-- 
2.13.6
