Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCBEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D9120658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D9120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeH3Kdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727597AbeH3Kdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 490E280C3C16;
        Thu, 30 Aug 2018 06:33:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA5C5A9F09;
        Thu, 30 Aug 2018 06:33:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 07/43] perf tools: Add perf_evsel__store_ids function
Date:   Thu, 30 Aug 2018 08:32:16 +0200
Message-Id: <20180830063252.23729-8-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 06:33:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evsel__store_ids function from stat's
store_counter_ids code into evsel object, so it
could be used globaly.

Link: http://lkml.kernel.org/n/tip-epqr71x8ufexd3or67kjqp9v@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.1

