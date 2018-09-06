Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F84C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1773D2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1773D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbeIFSFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:05:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51991 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbeIFSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:05:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DS9Rh308213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:28:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DS9PK308209;
        Thu, 6 Sep 2018 06:28:09 -0700
Date:   Thu, 6 Sep 2018 06:28:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-0a4e64d391a2c771ae33e648cf84d4492369560c@git.kernel.org>
Cc:     mingo@kernel.org, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, acme@redhat.com, andi@firstfloor.org,
        dsahern@gmail.com, namhyung@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: andi@firstfloor.org, dsahern@gmail.com, namhyung@kernel.org,
          peterz@infradead.org, jolsa@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          acme@redhat.com
In-Reply-To: <20180830063252.23729-15-jolsa@kernel.org>
References: <20180830063252.23729-15-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move perf_stat_synthesize_config() to
 stat.c
Git-Commit-ID: 0a4e64d391a2c771ae33e648cf84d4492369560c
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

Commit-ID:  0a4e64d391a2c771ae33e648cf84d4492369560c
Gitweb:     https://git.kernel.org/tip/0a4e64d391a2c771ae33e648cf84d4492369560c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:23 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Move perf_stat_synthesize_config() to stat.c

So that it can be used globally.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-15-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 42 ------------------------------------------
 tools/perf/util/stat.c    | 42 ++++++++++++++++++++++++++++++++++++++++++
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
