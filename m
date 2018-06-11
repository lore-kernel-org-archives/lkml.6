Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ofjFOilCHlt9dwAAmS7hNA
	; Mon, 11 Jun 2018 09:34:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D9D0560792; Mon, 11 Jun 2018 09:34:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6312460351;
	Mon, 11 Jun 2018 09:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6312460351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeFKJeb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:34:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932745AbeFKJe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:34:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35E92818BAF9;
        Mon, 11 Jun 2018 09:34:28 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E6132144B29;
        Mon, 11 Jun 2018 09:34:26 +0000 (UTC)
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
Subject: [PATCH 2/2] perf tests: Add valid callback for parse-events test
Date: Mon, 11 Jun 2018 11:34:22 +0200
Message-Id: <20180611093422.1005-2-jolsa@kernel.org>
In-Reply-To: <20180611093422.1005-1-jolsa@kernel.org>
References: <0d25bc25-ed0b-81bb-c516-12fd25442427@linux.ibm.com>
 <20180611093422.1005-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 11 Jun 2018 09:34:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 11 Jun 2018 09:34:28 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding optional 'valid' callback for events tests in
parse-events object, so we don't try to parse PMUs,
which are not supported.

Following line is displayed for skipped test:

  running test 52 'intel_pt//u'... SKIP

Link: http://lkml.kernel.org/n/tip-to9naisphr61z23b0br10xhh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/parse-events.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 3b0bfdf5a594..347378ddaa8b 100644
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
+		struct evlist_test e = { 0 };
 		char name[2 * NAME_MAX + 1 + 12 + 3];
 
 		/* Names containing . are special and cannot be used directly */
-- 
2.13.6
