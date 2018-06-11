Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /SI1IRRCHluTdwAAmS7hNA
	; Mon, 11 Jun 2018 09:34:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6E594607A4; Mon, 11 Jun 2018 09:34:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E273C60351;
	Mon, 11 Jun 2018 09:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E273C60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeFKJe2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:34:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932109AbeFKJe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:34:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 051FB7C6C2;
        Mon, 11 Jun 2018 09:34:26 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 949E52144B29;
        Mon, 11 Jun 2018 09:34:23 +0000 (UTC)
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Kim Phillips <kim.phillips@arm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: [PATCH 1/2] perf tests: Add event parsing error handling to parse events test
Date: Mon, 11 Jun 2018 11:34:21 +0200
Message-Id: <20180611093422.1005-1-jolsa@kernel.org>
In-Reply-To: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
References: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 11 Jun 2018 09:34:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 11 Jun 2018 09:34:26 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing error handling for parse_events calls in test_event
function that led to following segfault on s390:

  running test 52 'intel_pt//u'
  perf: Segmentation fault
  ...
  /lib64/libc.so.6(vasprintf+0xe6) [0x3fffca3f106]
  /lib64/libc.so.6(asprintf+0x46) [0x3fffca1aa96]
  ./perf(parse_events_add_pmu+0xb8) [0x80132088]
  ./perf(parse_events_parse+0xc62) [0x8019529a]
  ./perf(parse_events+0x98) [0x801341c0]
  ./perf(test__parse_events+0x48) [0x800cd140]
  ./perf(cmd_test+0x26a) [0x800bd44a]
  test child interrupted

Adding the struct parse_events_error argument to parse_events
call. Also adding parse_events_print_error to get more details
on the parsing failures, like:

  # perf test 6 -v
  running test 52 'intel_pt//u'failed to parse event 'intel_pt//u', err 1, str 'Cannot find PMU `intel_pt'. Missing kernel support?'
  event syntax error: 'intel_pt//u'
                       \___ Cannot find PMU `intel_pt'. Missing kernel support?

Link: http://lkml.kernel.org/n/tip-lmrdeivfr0m34t67c6i98p1f@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7d4077068454..3b0bfdf5a594 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1686,6 +1686,7 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error err = { 0 };
 	struct perf_evlist *evlist;
 	int ret;
 
@@ -1693,10 +1694,11 @@ static int test_event(struct evlist_test *e)
 	if (evlist == NULL)
 		return -ENOMEM;
 
-	ret = parse_events(evlist, e->name, NULL);
+	ret = parse_events(evlist, e->name, &err);
 	if (ret) {
-		pr_debug("failed to parse event '%s', err %d\n",
-			 e->name, ret);
+		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
+			 e->name, ret, err.str);
+		parse_events_print_error(&err, e->name);
 	} else {
 		ret = e->check(evlist);
 	}
-- 
2.13.6
