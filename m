Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C38EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B8D20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6s9cJOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B8D20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeIFCkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeIFCkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:01 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E1B2077C;
        Wed,  5 Sep 2018 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185269;
        bh=yaxC4x6RDY7RXWwIfY0QEhJTIjvqWLzvcJnunCgqYTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6s9cJOzjmMfalYNaN814AzNnV4vMVhROgoQ6drM4qAPJD5gCe+sRHW/QrksydK/3
         uFaSHqd4XR+00BLpj+wEGbIVIsZtHVRB2xfAu3ssCXfQUefYxkIIzh6wC4gXkdrCU/
         VrzqBde9DKRnl1TpRsz7VQIknbCUE3wX8Cbs0pC0=
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
Subject: [PATCH 64/77] perf stat: Move 'no_merge' data to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:27 -0300
Message-Id: <20180905220440.20256-65-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static variable 'no_merge' to 'struct perf_stat_config', so
that it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-40-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8ca85017a973..c4df076f1e54 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -158,7 +158,6 @@ static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
 static bool			forever				= false;
 static bool			force_metric_only		= false;
-static bool			no_merge			= false;
 static bool			walltime_run_table		= false;
 static struct timespec		ref_time;
 static bool			append_file;
@@ -1173,7 +1172,7 @@ static bool collect_data(struct perf_stat_config *config, struct perf_evsel *cou
 	if (counter->merged_stat)
 		return false;
 	cb(config, counter, data, true);
-	if (no_merge)
+	if (config->no_merge)
 		uniquify_event_name(counter);
 	else if (counter->auto_merge_stats)
 		collect_all_aliases(config, counter, cb, data);
@@ -1902,7 +1901,7 @@ static const struct option stat_options[] = {
 		    "list of cpus to monitor in system-wide"),
 	OPT_SET_UINT('A', "no-aggr", &stat_config.aggr_mode,
 		    "disable CPU count aggregation", AGGR_NONE),
-	OPT_BOOLEAN(0, "no-merge", &no_merge, "Do not merge identical named events"),
+	OPT_BOOLEAN(0, "no-merge", &stat_config.no_merge, "Do not merge identical named events"),
 	OPT_STRING('x', "field-separator", &stat_config.csv_sep, "separator",
 		   "print counts with custom separator"),
 	OPT_CALLBACK('G', "cgroup", &evsel_list, "name",
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 843672214cca..0758107fe56f 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -104,6 +104,7 @@ struct perf_stat_config {
 	bool			 null_run;
 	bool			 ru_display;
 	bool			 big_num;
+	bool			 no_merge;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4

