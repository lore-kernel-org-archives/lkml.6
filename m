Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A2DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D012086D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D012086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbeHWMSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:18:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732488AbeHWMSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:18:11 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 166D0C74;
        Thu, 23 Aug 2018 08:49:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 116/324] perf tests: Add event parsing error handling to parse events test
Date:   Thu, 23 Aug 2018 09:53:02 +0200
Message-Id: <20180823075001.710148493@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 933ccf2002aaef1037cb676622a694f5390c3d59 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/parse-events.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1672,6 +1672,7 @@ static struct terms_test test__terms[] =
 
 static int test_event(struct evlist_test *e)
 {
+	struct parse_events_error err = { .idx = 0, };
 	struct perf_evlist *evlist;
 	int ret;
 
@@ -1679,10 +1680,11 @@ static int test_event(struct evlist_test
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


