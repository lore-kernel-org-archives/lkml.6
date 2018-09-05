Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24571C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB72086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FokaRxXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAB72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbeIFCib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeIFCia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:30 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7186B20857;
        Wed,  5 Sep 2018 22:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185178;
        bh=2rxwRhB5DsJgrBadDueLUNTBWxotL6upILTau/cG7FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FokaRxXRr+PX1NkOBML/fv2Mo89M68mD4zj5EL4EaTcpQ8ZV44IY2xQ1ZKLosahTa
         m8z7f6dLBlXBBujGW9QAyzAPvw+5Qq5/ykmr4dtbXrXjg/hjFZ5o2b1+TW09YFa3Ya
         qYo3AUrV1NelJg/pAir7uHR69D13kzX7OstdYHuQ=
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
Subject: [PATCH 32/77] perf evsel: Introduce perf_evsel__store_ids()
Date:   Wed,  5 Sep 2018 19:03:55 -0300
Message-Id: <20180905220440.20256-33-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add perf_evsel__store_ids() from stat's store_counter_ids() code to the
evsel class, so that it can be used globally.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 33 +--------------------------------
 tools/perf/util/evsel.c   | 29 +++++++++++++++++++++++++++++
 tools/perf/util/evsel.h   |  1 +
 3 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8291f503d0cc..45bbd156d496 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -497,37 +497,6 @@ static int perf_stat_synthesize_config(bool is_pipe)
 	return 0;
 }
 
-#define FD(e, x, y) (*(int *)xyarray__entry(e->fd, x, y))
-
-static int __store_counter_ids(struct perf_evsel *counter)
-{
-	int cpu, thread;
-
-	for (cpu = 0; cpu < xyarray__max_x(counter->fd); cpu++) {
-		for (thread = 0; thread < xyarray__max_y(counter->fd);
-		     thread++) {
-			int fd = FD(counter, cpu, thread);
-
-			if (perf_evlist__id_add_fd(evsel_list, counter,
-						   cpu, thread, fd) < 0)
-				return -1;
-		}
-	}
-
-	return 0;
-}
-
-static int store_counter_ids(struct perf_evsel *counter)
-{
-	struct cpu_map *cpus = counter->cpus;
-	struct thread_map *threads = counter->threads;
-
-	if (perf_evsel__alloc_id(counter, cpus->nr, threads->nr))
-		return -ENOMEM;
-
-	return __store_counter_ids(counter);
-}
-
 static bool perf_evsel__should_store_id(struct perf_evsel *counter)
 {
 	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
@@ -658,7 +627,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
-		    store_counter_ids(counter))
+		    perf_evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1a61628a1c12..4ec909d57e9c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2940,3 +2940,32 @@ struct perf_env *perf_evsel__env(struct perf_evsel *evsel)
 		return evsel->evlist->env;
 	return NULL;
 }
+
+static int store_evsel_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+{
+	int cpu, thread;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd);
+		     thread++) {
+			int fd = FD(evsel, cpu, thread);
+
+			if (perf_evlist__id_add_fd(evlist, evsel,
+						   cpu, thread, fd) < 0)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist)
+{
+	struct cpu_map *cpus = evsel->cpus;
+	struct thread_map *threads = evsel->threads;
+
+	if (perf_evsel__alloc_id(evsel, cpus->nr, threads->nr))
+		return -ENOMEM;
+
+	return store_evsel_ids(evsel, evlist);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 163c960614d3..4f8430a85531 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -481,4 +481,5 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 
 struct perf_env *perf_evsel__env(struct perf_evsel *evsel);
 
+int perf_evsel__store_ids(struct perf_evsel *evsel, struct perf_evlist *evlist);
 #endif /* __PERF_EVSEL_H */
-- 
2.14.4

