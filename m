Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A71C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A6D2064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A6D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbeIFSAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:00:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37683 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFSAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:00:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DP0qh307760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:25:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DOx7f307757;
        Thu, 6 Sep 2018 06:24:59 -0700
Date:   Thu, 6 Sep 2018 06:24:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d09cefd2ef9945b4b767bb67f473a0eb2066374f@git.kernel.org>
Cc:     acme@redhat.com, dsahern@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        namhyung@kernel.org, andi@firstfloor.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
          jolsa@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
          andi@firstfloor.org
In-Reply-To: <20180830063252.23729-9-jolsa@kernel.org>
References: <20180830063252.23729-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Move create_perf_stat_counter() to
 stat.c
Git-Commit-ID: d09cefd2ef9945b4b767bb67f473a0eb2066374f
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

Commit-ID:  d09cefd2ef9945b4b767bb67f473a0eb2066374f
Gitweb:     https://git.kernel.org/tip/d09cefd2ef9945b4b767bb67f473a0eb2066374f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 30 Aug 2018 08:32:17 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:22 -0300

perf stat: Move create_perf_stat_counter() to stat.c

Move create_perf_stat_counter() to the 'stat' class, so that we can use
it globally.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 54 +----------------------------------------------
 tools/perf/util/stat.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat.h    |  4 ++++
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
