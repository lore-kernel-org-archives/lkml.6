Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC529C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A30720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A30720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeH3Kdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727824AbeH3Kdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF289807A13F;
        Thu, 30 Aug 2018 06:33:17 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C030A9F09;
        Thu, 30 Aug 2018 06:33:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 14/43] perf stat: Move perf_stat_synthesize_config into stat.c
Date:   Thu, 30 Aug 2018 08:32:23 +0200
Message-Id: <20180830063252.23729-15-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:17 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So it can be used globaly.

Link: http://lkml.kernel.org/n/tip-6iu57r6ts9f0m92hw7f8in1o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 42 ---------------------------------------
 tools/perf/util/stat.c    | 42 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  6 ++++++
 3 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1171d4e00276..54768ec15dbc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -402,48 +402,6 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static int perf_stat_synthesize_config(struct perf_stat_config *config,
-				       struct perf_tool *tool,
-				       struct perf_evlist *evlist,
-				       perf_event__handler_t process,
-				       bool attrs)
-{
-	int err;
-
-	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evlist, process);
-		if (err < 0) {
-			pr_err("Couldn't synthesize attrs.\n");
-			return err;
-		}
-	}
-
-	err = perf_event__synthesize_extra_attr(tool, evlist, process,
-						attrs);
-
-	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
-						 process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize thread map.\n");
-		return err;
-	}
-
-	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
-					     process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize thread map.\n");
-		return err;
-	}
-
-	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
-	if (err < 0) {
-		pr_err("Couldn't synthesize config.\n");
-		return err;
-	}
-
-	return 0;
-}
-
 static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 {
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 3bd24255376a..5d3172bcc4ae 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -488,3 +488,45 @@ int create_perf_stat_counter(struct perf_evsel *evsel,
 
 	return perf_evsel__open_per_thread(evsel, evsel->threads);
 }
+
+int perf_stat_synthesize_config(struct perf_stat_config *config,
+				struct perf_tool *tool,
+				struct perf_evlist *evlist,
+				perf_event__handler_t process,
+				bool attrs)
+{
+	int err;
+
+	if (attrs) {
+		err = perf_event__synthesize_attrs(tool, evlist, process);
+		if (err < 0) {
+			pr_err("Couldn't synthesize attrs.\n");
+			return err;
+		}
+	}
+
+	err = perf_event__synthesize_extra_attr(tool, evlist, process,
+						attrs);
+
+	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
+						 process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize thread map.\n");
+		return err;
+	}
+
+	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
+					     process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize thread map.\n");
+		return err;
+	}
+
+	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
+	if (err < 0) {
+		pr_err("Couldn't synthesize config.\n");
+		return err;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 8fb596641545..da6a706daecc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -7,6 +7,7 @@
 #include "xyarray.h"
 #include "rblist.h"
 #include "perf.h"
+#include "event.h"
 
 struct stats {
 	double n, mean, M2;
@@ -179,4 +180,9 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
 int create_perf_stat_counter(struct perf_evsel *evsel,
 			     struct perf_stat_config *config,
 			     struct target *target);
+int perf_stat_synthesize_config(struct perf_stat_config *config,
+				struct perf_tool *tool,
+				struct perf_evlist *evlist,
+				perf_event__handler_t process,
+				bool attrs);
 #endif
-- 
2.17.1

