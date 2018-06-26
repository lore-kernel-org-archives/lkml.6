Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50991C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133692658A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133692658A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751895AbeFZGyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:54:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44851 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeFZGyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:54:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6rHk11591190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:53:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6rHFq1591187;
        Mon, 25 Jun 2018 23:53:17 -0700
Date:   Mon, 25 Jun 2018 23:53:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-933ccf2002aaef1037cb676622a694f5390c3d59@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, brueckner@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
        dsahern@gmail.com, hpa@zytor.com, kim.phillips@arm.com,
        schwidefsky@de.ibm.com, peterz@infradead.org, acme@redhat.com,
        heiko.carstens@de.ibm.com, alexander.shishkin@linux.intel.com
Reply-To: kim.phillips@arm.com, schwidefsky@de.ibm.com,
          peterz@infradead.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, heiko.carstens@de.ibm.com,
          mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          jolsa@kernel.org, brueckner@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
          dsahern@gmail.com, hpa@zytor.com
In-Reply-To: <20180611093422.1005-1-jolsa@kernel.org>
References: <20180611093422.1005-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests: Add event parsing error handling to
 parse events test
Git-Commit-ID: 933ccf2002aaef1037cb676622a694f5390c3d59
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  933ccf2002aaef1037cb676622a694f5390c3d59
Gitweb:     https://git.kernel.org/tip/933ccf2002aaef1037cb676622a694f5390c3d59
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 11 Jun 2018 11:34:21 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

perf tests: Add event parsing error handling to parse events test

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
