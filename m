Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2867C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2844222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550061215;
	bh=hgh190qhD1K6DHcTaPWO8Bfz3Y78tiDv4tDRGOVAXYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J8uKwRjycJJLJhZQd5FFYozW7wzYKLlTPCHrKtAPPjB6V9idQaz29KKXkb+LRwByi
	 o1W6+oaaowf/km3qo6ej/wXFG0aLeXWT28XtKG8e13oU3RiEo/edOTQZWtg3fWWkGm
	 G2Iwc3QNB5Ed6mIuJVWRrEh4sgxGqZLg/YjeH0/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392125AbfBMMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392084AbfBMMc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:32:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECC1799DDC;
        Wed, 13 Feb 2019 12:32:55 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71F9C60856;
        Wed, 13 Feb 2019 12:32:54 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 04/10] perf tools: Fix legacy events symbol separator parsing
Date:   Wed, 13 Feb 2019 13:32:40 +0100
Message-Id: <20190213123246.4015-5-jolsa@kernel.org>
In-Reply-To: <20190213123246.4015-1-jolsa@kernel.org>
References: <20190213123246.4015-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 13 Feb 2019 12:32:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing legacy symbol events parsing. We can't support
single slash separator, like 'cycles/u', because it
conflicts with non empty terms, like 'cycles/period/u'.

Keeping only '//' and ':' separator for these events:
  cycles//u
  cycles:k

And removing '/' separator support, which is not working
anymore. Also adding automated tests for above events.

Link: http://lkml.kernel.org/n/tip-f3s9wau935oo3l6d5yk5ohff@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-events.c | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/parse-events.y  |  4 ++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 3b97ac018d5a..4a69c07f4101 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1330,6 +1330,26 @@ static int test__checkevent_complex_name(struct perf_evlist *evlist)
 	return 0;
 }
 
+static int test__sym_event_slash(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->attr.exclude_kernel);
+	return 0;
+}
+
+static int test__sym_event_dc(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong type", evsel->attr.type == PERF_TYPE_HARDWARE);
+	TEST_ASSERT_VAL("wrong config", evsel->attr.config == PERF_COUNT_HW_CPU_CYCLES);
+	TEST_ASSERT_VAL("wrong exclude_user", evsel->attr.exclude_user);
+	return 0;
+}
+
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1670,6 +1690,16 @@ static struct evlist_test test__events[] = {
 		.name  = "cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk",
 		.check = test__checkevent_complex_name,
 		.id    = 53
+	},
+	{
+		.name  = "cycles//u",
+		.check = test__sym_event_slash,
+		.id    = 54,
+	},
+	{
+		.name  = "cycles:k",
+		.check = test__sym_event_dc,
+		.id    = 55,
 	}
 };
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index da8fe57691b8..44819bdb037d 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -311,7 +311,7 @@ value_sym '/' event_config '/'
 	$$ = list;
 }
 |
-value_sym sep_slash_dc
+value_sym sep_slash_slash_dc
 {
 	struct list_head *list;
 	int type = $1 >> 16;
@@ -702,7 +702,7 @@ PE_VALUE PE_ARRAY_RANGE PE_VALUE
 
 sep_dc: ':' |
 
-sep_slash_dc: '/' | ':' |
+sep_slash_slash_dc: '/' '/' | ':' |
 
 %%
 
-- 
2.17.2

