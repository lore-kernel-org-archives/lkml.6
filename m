Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id t0azK/xcGFvkJAAAmS7hNA
	; Wed, 06 Jun 2018 22:15:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 89021608B8; Wed,  6 Jun 2018 22:15:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0EAC7605BD;
	Wed,  6 Jun 2018 22:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EAC7605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeFFWPp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:15:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752571AbeFFWPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:15:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F5368151D42;
        Wed,  6 Jun 2018 22:15:37 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B08A72026DEF;
        Wed,  6 Jun 2018 22:15:35 +0000 (UTC)
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
Subject: [PATCH 07/10] perf stat: Add event parsing error handling to add_default_attributes
Date: Thu,  7 Jun 2018 00:15:10 +0200
Message-Id: <20180606221513.11302-8-jolsa@kernel.org>
In-Reply-To: <20180606221513.11302-1-jolsa@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:15:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 06 Jun 2018 22:15:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding missing error handling for parse_events calls
in add_default_attributes functions. The error handler
displays error details, like for transactions (-T):

Before:
  $ perf stat -T
  Cannot set up transaction events

After:
  $ perf stat -T
  Cannot set up transaction events
  event syntax error: '..cycles,cpu/cycles-t/,cpu/tx-start/,cpu/el-start/,cpu/cycles-ct/}'
                                    \___ unknown term

Link: http://lkml.kernel.org/n/tip-hmctifkfiaij47xb9en1hlcf@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a8f93885763a..cc3dd85d5a60 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2451,14 +2451,13 @@ static int add_default_attributes(void)
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
@@ -2469,6 +2468,7 @@ static int add_default_attributes(void)
 					   &errinfo);
 		if (err) {
 			fprintf(stderr, "Cannot set up transaction events\n");
+			parse_events_print_error(&errinfo, transaction_attrs);
 			return -1;
 		}
 		return 0;
@@ -2494,10 +2494,11 @@ static int add_default_attributes(void)
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
@@ -2532,12 +2533,13 @@ static int add_default_attributes(void)
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
2.13.6
