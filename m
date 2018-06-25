Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF78C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAC425F7E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+gEHfqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CAC425F7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964915AbeFYRlX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964891AbeFYRlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:18 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CC825F73;
        Mon, 25 Jun 2018 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948477;
        bh=GgUivGhCan4UxqV/jQDewKvwfq09OK7PvmvIw8KAX6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+gEHfqojTglaPo8i1PWRcxDUFD0qQNKWjklC0i0R+97oyFvM4vHqS5nVle7l6Z3+
         a0WJYHDniYs7Czu7fEFqaNHYGcVeYGmre44Nove9VFQD5UJnzDH2P5twLXzW1pTjff
         5QkXGRRf3mibzdo4YSAuU9mqlXR/xzG2O0d926BU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/19] perf tests: Add valid callback for parse-events test
Date:   Mon, 25 Jun 2018 14:40:31 -0300
Message-Id: <20180625174045.25765-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding optional 'valid' callback for events tests in parse-events
object, so we don't try to parse PMUs, which are not supported.

Following line is displayed for skipped test:

  running test 52 'intel_pt//u'... SKIP

Committer note:

Use named initializers in the struct evlist_test variable to avoid
breaking the build on centos:5, 6 and others with a similar gcc:

  cc1: warnings being treated as errors
  tests/parse-events.c: In function 'test_pmu_events':
  tests/parse-events.c:1817: error: missing initializer
  tests/parse-events.c:1817: error: (near initialization for 'e.type')

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20180611093422.1005-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 9751e7563a45..61211918bfba 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1309,6 +1309,11 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
 	return 0;
 }
 
+static bool test__intel_pt_valid(void)
+{
+	return !!perf_pmu__find("intel_pt");
+}
+
 static int test__intel_pt(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = perf_evlist__first(evlist);
@@ -1375,6 +1380,7 @@ struct evlist_test {
 	const char *name;
 	__u32 type;
 	const int id;
+	bool (*valid)(void);
 	int (*check)(struct perf_evlist *evlist);
 };
 
@@ -1648,6 +1654,7 @@ static struct evlist_test test__events[] = {
 	},
 	{
 		.name  = "intel_pt//u",
+		.valid = test__intel_pt_valid,
 		.check = test__intel_pt,
 		.id    = 52,
 	},
@@ -1690,6 +1697,11 @@ static int test_event(struct evlist_test *e)
 	struct perf_evlist *evlist;
 	int ret;
 
+	if (e->valid && !e->valid()) {
+		pr_debug("... SKIP");
+		return 0;
+	}
+
 	evlist = perf_evlist__new();
 	if (evlist == NULL)
 		return -ENOMEM;
@@ -1716,10 +1728,11 @@ static int test_events(struct evlist_test *events, unsigned cnt)
 	for (i = 0; i < cnt; i++) {
 		struct evlist_test *e = &events[i];
 
-		pr_debug("running test %d '%s'\n", e->id, e->name);
+		pr_debug("running test %d '%s'", e->id, e->name);
 		ret1 = test_event(e);
 		if (ret1)
 			ret2 = ret1;
+		pr_debug("\n");
 	}
 
 	return ret2;
@@ -1801,7 +1814,7 @@ static int test_pmu_events(void)
 	}
 
 	while (!ret && (ent = readdir(dir))) {
-		struct evlist_test e;
+		struct evlist_test e = { .id = 0, };
 		char name[2 * NAME_MAX + 1 + 12 + 3];
 
 		/* Names containing . are special and cannot be used directly */
-- 
2.14.3

