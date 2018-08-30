Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785820658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A785820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeH3Kdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727597AbeH3Kdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E21380823E3;
        Thu, 30 Aug 2018 06:33:04 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39DCFA9F09;
        Thu, 30 Aug 2018 06:33:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 06/43] perf tools: Switch session argument to evlist in perf_event__synthesize_attrs
Date:   Thu, 30 Aug 2018 08:32:15 +0200
Message-Id: <20180830063252.23729-7-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to pass in other than session's evlist.

Link: http://lkml.kernel.org/n/tip-crsckf9is77d25pwoc3ekmpo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-stat.c   | 2 +-
 tools/perf/util/header.c    | 6 +++---
 tools/perf/util/header.h    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92ac51..9853552bcf16 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -758,7 +758,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		 * We need to synthesize events first, because some
 		 * features works on top of them (on report side).
 		 */
-		err = perf_event__synthesize_attrs(tool, session,
+		err = perf_event__synthesize_attrs(tool, rec->evlist,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 48c88f568fe1..8291f503d0cc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -459,7 +459,7 @@ static int perf_stat_synthesize_config(bool is_pipe)
 	int err;
 
 	if (is_pipe) {
-		err = perf_event__synthesize_attrs(NULL, perf_stat.session,
+		err = perf_event__synthesize_attrs(NULL, evsel_list,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3cadc252dd89..91e6d9cfd906 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3637,13 +3637,13 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 }
 
 int perf_event__synthesize_attrs(struct perf_tool *tool,
-				   struct perf_session *session,
-				   perf_event__handler_t process)
+				 struct perf_evlist *evlist,
+				 perf_event__handler_t process)
 {
 	struct perf_evsel *evsel;
 	int err = 0;
 
-	evlist__for_each_entry(session->evlist, evsel) {
+	evlist__for_each_entry(evlist, evsel) {
 		err = perf_event__synthesize_attr(tool, &evsel->attr, evsel->ids,
 						  evsel->id, process);
 		if (err) {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 6d7fe44aadc0..ff2a1263fb9b 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -124,7 +124,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool,
 				struct perf_event_attr *attr, u32 ids, u64 *id,
 				perf_event__handler_t process);
 int perf_event__synthesize_attrs(struct perf_tool *tool,
-				 struct perf_session *session,
+				 struct perf_evlist *evlist,
 				 perf_event__handler_t process);
 int perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 					     struct perf_evsel *evsel,
-- 
2.17.1

