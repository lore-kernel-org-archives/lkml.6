Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DC7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E6D2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk3qKBhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E6D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeIFCiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbeIFCiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:50 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEAE20861;
        Wed,  5 Sep 2018 22:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185198;
        bh=hNDmhERvz/8+Q2ADUB8HU7s29rCUaWvFhg5Dl5aF64o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hk3qKBhyIWPJZ3eVhdODwjWHcpr244Vq1hbvclIdCD44jzRTT5vjC71jvz/OFPkrx
         NrxobDVVAxZ10VAFyReu2iodmz/zaV+Yr7+7s592xBYQ5/jerXysNpdfwW9AmzQUNF
         No1wfUDwQQXpg+SZx3PwczNhaRxI3I/EqR3o3g7k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/77] perf stat: Move perf_stat_synthesize_config() to stat.c
Date:   Wed,  5 Sep 2018 19:04:02 -0300
Message-Id: <20180905220440.20256-40-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

