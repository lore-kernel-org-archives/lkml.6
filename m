Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1987B20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="slljtvGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1987B20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbeIFCj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeIFCj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:58 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1F6F20652;
        Wed,  5 Sep 2018 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185266;
        bh=aOc5mfcmAt7Hf5ZpOiI4YgAp8forDuf5+ZWE6dDsFz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slljtvGYObBYbReSP7lOKEh8V8zFUakYEZyq5BXwsA1/+hhh98WDL8LTFlX/1ELac
         Nht8V8hCWeQq/jPIn3/QsI/Jzk8r7tmlj3p+szt7X5ydPQjsZxEcqXfPIZkz3MbKTY
         NSUbqtwq6fqbDfOA0O+5Vioid/IkKt3RCY3cBmAc=
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
Subject: [PATCH 63/77] perf stat: Move 'big_num' data to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:26 -0300
Message-Id: <20180905220440.20256-64-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static variable 'big_num' to 'struct perf_stat_config', so that
it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-39-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 445673f688de..8ca85017a973 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -151,7 +151,6 @@ static bool			transaction_run;
 static bool			topdown_run			= false;
 static bool			smi_cost			= false;
 static bool			smi_reset			= false;
-static bool			big_num				=  true;
 static int			big_num_opt			=  -1;
 static bool			group				= false;
 static const char		*pre_cmd			= NULL;
@@ -192,6 +191,7 @@ static struct perf_stat_config stat_config = {
 	.run_count		= 1,
 	.metric_only_len	= METRIC_ONLY_LEN,
 	.walltime_nsecs_stats	= &walltime_nsecs_stats,
+	.big_num		= true,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -945,7 +945,7 @@ static void abs_printout(struct perf_stat_config *config,
 	if (config->csv_output) {
 		fmt = floor(sc) != sc ?  "%.2f%s" : "%.0f%s";
 	} else {
-		if (big_num)
+		if (config->big_num)
 			fmt = floor(sc) != sc ? "%'18.2f%s" : "%'18.0f%s";
 		else
 			fmt = floor(sc) != sc ? "%18.2f%s" : "%18.0f%s";
@@ -2847,9 +2847,9 @@ int cmd_stat(int argc, const char **argv)
 			parse_options_usage(NULL, stat_options, "x", 1);
 			goto out;
 		} else /* Nope, so disable big number formatting */
-			big_num = false;
+			stat_config.big_num = false;
 	} else if (big_num_opt == 0) /* User passed --no-big-num */
-		big_num = false;
+		stat_config.big_num = false;
 
 	setup_system_wide(argc);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index be202b066e62..843672214cca 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	bool			 metric_only;
 	bool			 null_run;
 	bool			 ru_display;
+	bool			 big_num;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4

