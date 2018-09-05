Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E074C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB3C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKxiwyRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB3C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeIFCie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbeIFCid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:33 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 442A520652;
        Wed,  5 Sep 2018 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185181;
        bh=tQPXWrNnNFk1KBgdORTIpeVUsxMpyIc5ozEdAMlpeio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKxiwyRPBhZZ2+SnRopc1kMkrgUV7/pTV7s9PUF2SeHeVZq8reeLLpQWIB+koYOqQ
         jooLKZ+alJs7iooTTXoVQQf1PLGyML3reRQ/8qgkxaFj0/4+0IMjWZHyGtuH8K/w5I
         fj5u15ssc3nq6p1W0GYhmBQ/fOOahyOdXSM2kCTg=
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
Subject: [PATCH 33/77] perf stat: Move create_perf_stat_counter() to stat.c
Date:   Wed,  5 Sep 2018 19:03:56 -0300
Message-Id: <20180905220440.20256-34-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

