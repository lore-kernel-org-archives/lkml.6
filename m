Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71331C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCF125C71
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCTQtV7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCF125C71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964892AbeFYRlS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964864AbeFYRlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:14 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD4625F72;
        Mon, 25 Jun 2018 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948473;
        bh=h2z7PRKV7SScB7DzjwA2LqRDYCdBpyOx5JeNFIzyOR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCTQtV7hfHFglL7k/xxkWx9bMbSsOInZ+sjFwSrFlaIOEiN/njuVHxDN4QGwayTQO
         NMAoZKiYCx3MoecZmJ39NnK9gZCikUtT0CyjUj1Xh8TktoJ9L2dTrzGQk1dMyLg8GZ
         Ic7uG8M0eEpOB/f6lwXk5kVePbWsj76N90zKs0nY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/19] perf tests: Add event parsing error handling to parse events test
Date:   Mon, 25 Jun 2018 14:40:30 -0300
Message-Id: <20180625174045.25765-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add missing error handling for parse_events calls in test_event function
that led to following segfault on s390:

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

Adding the struct parse_events_error argument to parse_events call. Also
adding parse_events_print_error to get more details on the parsing
failures, like:

  # perf test 6 -v
  running test 52 'intel_pt//u'failed to parse event 'intel_pt//u', err 1, str 'Cannot find PMU `intel_pt'. Missing kernel support?'
  event syntax error: 'intel_pt//u'
                       \___ Cannot find PMU `intel_pt'. Missing kernel support?

Committer note:

Use named initializers in the struct parse_events_error variable to
avoid breaking the build on centos5, 6 and others with a similar gcc:

  cc1: warnings being treated as errors
  tests/parse-events.c: In function 'test_event':
  tests/parse-events.c:1696: error: missing initializer
  tests/parse-events.c:1696: error: (near initialization for 'err.str')

Reported-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20180611093422.1005-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 7d4077068454..9751e7563a45 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1686,6 +1686,7 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error err = { .idx = 0, };
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
2.14.3

