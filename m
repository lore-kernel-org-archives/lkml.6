Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85F38C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C71B208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5yoyEgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C71B208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933899AbeFKRtJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933838AbeFKRtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:49:04 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0002208B1;
        Mon, 11 Jun 2018 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739343;
        bh=UZLtMa7RoVM2uMCfqp4/M062UyzyzOn6O/Wg67ViOaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5yoyEgMN6Ni0YqX8a64h5WcPdqVMOnC3qazsjPiU/cahNGlkrywJojpOEJnGBbZK
         qW8LXl1oJjdqJapNW5vHxZPssSNevbGAPOUEI7hquXRAOtFzkGz4+LA1oMoAw1h84e
         miZaNlEqB1ZQwnkYMEo1PYvvW2Vkbs8h1N/m48b4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/12] perf stat: Add event parsing error handling to add_default_attributes
Date:   Mon, 11 Jun 2018 14:48:08 -0300
Message-Id: <20180611174810.14815-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add missing error handling for parse_events calls in add_default_attributes
functions. The error handler displays error details, like for transactions (-T):

Before:
  $ perf stat -T
  Cannot set up transaction events

After:
  $ perf stat -T
  Cannot set up transaction events
  event syntax error: '..cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}'
                                    \___ unknown term

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3fc1f5286d50..22547a490e1f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2442,14 +2442,13 @@ static int add_default_attributes(void)
 	(PERF_COUNT_HW_CACHE_OP_PREFETCH	<<  8) |
 	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
 };
+	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
 	if (null_run)
 		return 0;
 
 	if (transaction_run) {
-		struct parse_events_error errinfo;
-
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
@@ -2460,6 +2459,7 @@ static int add_default_attributes(void)
 					   &errinfo);
 		if (err) {
 			fprintf(stderr, "Cannot set up transaction events\n");
+			parse_events_print_error(&errinfo, transaction_attrs);
 			return -1;
 		}
 		return 0;
@@ -2485,10 +2485,11 @@ static int add_default_attributes(void)
 		    pmu_have_event("msr", "smi")) {
 			if (!force_metric_only)
 				metric_only = true;
-			err = parse_events(evsel_list, smi_cost_attrs, NULL);
+			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
 		} else {
 			fprintf(stderr, "To measure SMI cost, it needs "
 				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
+			parse_events_print_error(&errinfo, smi_cost_attrs);
 			return -1;
 		}
 		if (err) {
@@ -2523,12 +2524,13 @@ static int add_default_attributes(void)
 		if (topdown_attrs[0] && str) {
 			if (warn)
 				arch_topdown_group_warn();
-			err = parse_events(evsel_list, str, NULL);
+			err = parse_events(evsel_list, str, &errinfo);
 			if (err) {
 				fprintf(stderr,
 					"Cannot set up top down events %s: %d\n",
 					str, err);
 				free(str);
+				parse_events_print_error(&errinfo, str);
 				return -1;
 			}
 		} else {
-- 
2.14.3

