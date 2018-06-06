Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IIkMLgZdGFudIwAAmS7hNA
	; Wed, 06 Jun 2018 22:15:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 98E6B607F7; Wed,  6 Jun 2018 22:15:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 21EBE607F7;
	Wed,  6 Jun 2018 22:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21EBE607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752399AbeFFWP0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:15:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752228AbeFFWPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:15:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C5A2859C8;
        Wed,  6 Jun 2018 22:15:22 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB24A2026DEF;
        Wed,  6 Jun 2018 22:15:18 +0000 (UTC)
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Agustin Vega-Frias <agustinv@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Andi Kleen <andi@firstfloor.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 01/10] perf tools: Uniquify the event name if there's no other matched event
Date: Thu,  7 Jun 2018 00:15:04 +0200
Message-Id: <20180606221513.11302-2-jolsa@kernel.org>
In-Reply-To: <20180606221513.11302-1-jolsa@kernel.org>
References: <20180606221513.11302-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 06 Jun 2018 22:15:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 06 Jun 2018 22:15:22 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently by default we try to match the user specified PMU
name to all PMU units available and use them to aggregate
all matched PMUs event counts into one 'pattern' event.

While this is useful for uncore events, it screws up names
for other events, where this is not desirable, like:

Before:
  # perf stat -e cp/cpu-cycles/ kill

   Performance counter stats for 'kill':

           1,573,757      cp/cpu-cycles/

Keeping the pattern matching logic, but making the name unique
in case there's no other match found. That fixes the example
above and hopefully does not screw up anything else.

After:
  # perf stat -e cp/cpu-cycles/ kill

   Performance counter stats for 'kill':

           1,573,757      cpu/cpu-cycles/

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>
Link: http://lkml.kernel.org/n/tip-lpb7bmaj3szgmemf53yg4nke@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 096ccb25c11f..fce46252f89c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1323,6 +1323,7 @@ static void collect_all_aliases(struct perf_evsel *counter,
 			    void *data)
 {
 	struct perf_evsel *alias;
+	int cnt = 0;
 
 	alias = list_prepare_entry(counter, &(evsel_list->entries), node);
 	list_for_each_entry_continue (alias, &evsel_list->entries, node) {
@@ -1334,7 +1335,15 @@ static void collect_all_aliases(struct perf_evsel *counter,
 			break;
 		alias->merged_stat = true;
 		cb(alias, data, false);
+		cnt++;
 	}
+
+	/*
+	 * There's no matching event to aggregate
+	 * counts with, fix the event name
+	 */
+	if (!cnt)
+		uniquify_event_name(counter);
 }
 
 static bool collect_data(struct perf_evsel *counter,
-- 
2.13.6
