Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB18C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7252520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7252520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeH3Kdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727700AbeH3Kdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA5A77DAC2;
        Thu, 30 Aug 2018 06:33:07 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 873A0B27A5;
        Thu, 30 Aug 2018 06:33:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 08/43] perf stat: Move create_perf_stat_counter into stat.c
Date:   Thu, 30 Aug 2018 08:32:17 +0200
Message-Id: <20180830063252.23729-9-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:33:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving create_perf_stat_counter to stat object,
so we could use it globally.

Link: http://lkml.kernel.org/n/tip-47odtb7otnqlo07h0crk6ftp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 54 +--------------------------------------
 tools/perf/util/stat.c    | 53 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  4 +++
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 45bbd156d496..142cff8eb12b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -234,58 +234,6 @@ static void perf_stat__reset_stats(void)
 		perf_stat__reset_shadow_per_stat(&stat_config.stats[i]);
 }
 
-static int create_perf_stat_counter(struct perf_evsel *evsel,
-				    struct perf_stat_config *config)
-{
-	struct perf_event_attr *attr = &evsel->attr;
-	struct perf_evsel *leader = evsel->leader;
-
-	if (config->scale) {
-		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
-				    PERF_FORMAT_TOTAL_TIME_RUNNING;
-	}
-
-	/*
-	 * The event is part of non trivial group, let's enable
-	 * the group read (for leader) and ID retrieval for all
-	 * members.
-	 */
-	if (leader->nr_members > 1)
-		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
-
-	attr->inherit = !config->no_inherit;
-
-	/*
-	 * Some events get initialized with sample_(period/type) set,
-	 * like tracepoints. Clear it up for counting.
-	 */
-	attr->sample_period = 0;
-
-	if (config->identifier)
-		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
-
-	/*
-	 * Disabling all counters initially, they will be enabled
-	 * either manually by us or by kernel via enable_on_exec
-	 * set later.
-	 */
-	if (perf_evsel__is_group_leader(evsel)) {
-		attr->disabled = 1;
-
-		/*
-		 * In case of initial_delay we enable tracee
-		 * events manually.
-		 */
-		if (target__none(&target) && !config->initial_delay)
-			attr->enable_on_exec = 1;
-	}
-
-	if (target__has_cpu(&target) && !target__has_per_thread(&target))
-		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
-
-	return perf_evsel__open_per_thread(evsel, evsel->threads);
-}
-
 static int process_synthesized_event(struct perf_tool *tool __maybe_unused,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -568,7 +516,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	evlist__for_each_entry(evsel_list, counter) {
 try_again:
-		if (create_perf_stat_counter(counter, &stat_config) < 0) {
+		if (create_perf_stat_counter(counter, &stat_config, &target) < 0) {
 
 			/* Weak group failed. Reset the group. */
 			if ((errno == EINVAL || errno == EBADF) &&
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index a0061e0b0fad..3bd24255376a 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -435,3 +435,56 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
 
 	return ret;
 }
+
+int create_perf_stat_counter(struct perf_evsel *evsel,
+			     struct perf_stat_config *config,
+			     struct target *target)
+{
+	struct perf_event_attr *attr = &evsel->attr;
+	struct perf_evsel *leader = evsel->leader;
+
+	if (config->scale) {
+		attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
+				    PERF_FORMAT_TOTAL_TIME_RUNNING;
+	}
+
+	/*
+	 * The event is part of non trivial group, let's enable
+	 * the group read (for leader) and ID retrieval for all
+	 * members.
+	 */
+	if (leader->nr_members > 1)
+		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
+
+	attr->inherit = !config->no_inherit;
+
+	/*
+	 * Some events get initialized with sample_(period/type) set,
+	 * like tracepoints. Clear it up for counting.
+	 */
+	attr->sample_period = 0;
+
+	if (config->identifier)
+		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
+
+	/*
+	 * Disabling all counters initially, they will be enabled
+	 * either manually by us or by kernel via enable_on_exec
+	 * set later.
+	 */
+	if (perf_evsel__is_group_leader(evsel)) {
+		attr->disabled = 1;
+
+		/*
+		 * In case of initial_delay we enable tracee
+		 * events manually.
+		 */
+		if (target__none(target) && !config->initial_delay)
+			attr->enable_on_exec = 1;
+	}
+
+	if (target__has_cpu(target) && !target__has_per_thread(target))
+		return perf_evsel__open_per_cpu(evsel, perf_evsel__cpus(evsel));
+
+	return perf_evsel__open_per_thread(evsel, evsel->threads);
+}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 918cde064cdc..8fb596641545 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -175,4 +175,8 @@ int perf_event__process_stat_event(struct perf_tool *tool,
 size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
+
+int create_perf_stat_counter(struct perf_evsel *evsel,
+			     struct perf_stat_config *config,
+			     struct target *target);
 #endif
-- 
2.17.1

