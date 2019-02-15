Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ECEC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC452070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405312AbfBOJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:49:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbfBOJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:49:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9nlKv1121501
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:49:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9nlX31121498;
        Fri, 15 Feb 2019 01:49:47 -0800
Date:   Fri, 15 Feb 2019 01:49:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-714a92d83fd1e20461f53549cfbee77b20be5032@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com
Reply-To: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, peterz@infradead.org, namhyung@kernel.org,
          jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
          acme@redhat.com
In-Reply-To: <20190213123246.4015-5-jolsa@kernel.org>
References: <20190213123246.4015-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix legacy events symbol separator
 parsing
Git-Commit-ID: 714a92d83fd1e20461f53549cfbee77b20be5032
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

Commit-ID:  714a92d83fd1e20461f53549cfbee77b20be5032
Gitweb:     https://git.kernel.org/tip/714a92d83fd1e20461f53549cfbee77b20be5032
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 13 Feb 2019 13:32:40 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:08 -0300

perf tools: Fix legacy events symbol separator parsing

Fixing legacy symbol events parsing. We can't support single slash
separator, like 'cycles/u', because it conflicts with non empty terms,
like 'cycles/period/u'.

Keeping only '//' and ':' separator for these events:
  cycles//u
  cycles:k

And removing '/' separator support, which is not working
anymore. Also adding automated tests for above events.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 
