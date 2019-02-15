Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD94222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191730;
	bh=Q2p/EpXoQuwCZdh8Lsq6KDGb/LCEXuB5ZNJY0AAP9u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/bJMvjDV1itZmmAf1J3BieScuQGTaRZlVOFHBgt4UlmxI5/eaV1T2zBRMNtCRVZk
	 uyuD09pkSFKYYi7WnHCcOBXsTWCvMRpdTiiRuSCo26XpDBeAtjAvcVStc0dd5QKNwK
	 YCwi+KhLqBBOEZPOY0W9lxrzHUPxOo4sR3Fnizmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389849AbfBOAss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389722AbfBOAsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:43 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C71222C9;
        Fri, 15 Feb 2019 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191722;
        bh=Q2p/EpXoQuwCZdh8Lsq6KDGb/LCEXuB5ZNJY0AAP9u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y2o3zH6exGbgArltCXpcOBc1ZEPOh+YwNMAqG99EzMEr6S/hTpJx5dwDg2IZ6V9yr
         97W2D8dK2g0mKHAn0ptQWglb+wI6xCny1VmlEdGzll9PRKmCfsPzTL/1lnh53SIUAo
         L1rtofW/tgtNreIlSORHb/6jbj1MQ5ca3Wg+QGv8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/43] perf tools: Fix legacy events symbol separator parsing
Date:   Thu, 14 Feb 2019 21:45:35 -0300
Message-Id: <20190215004539.23571-40-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 
-- 
2.19.1

