Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD2BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DDD2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRFq5KB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DDD2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeIFCjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:46 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6FF20839;
        Wed,  5 Sep 2018 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185254;
        bh=3TA1yZglQlVBA5cqg9YxCsgr0jP7TqrXf5yqs4fHS30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRFq5KB7kC4JHnDQ5rkZ2trxrlMN0W08tL1etTX5A4wjk9W2kGn/fgpQJ5sRaXPld
         IEdh4ZkQDy2U8e8jlaDfm+LR10fEIBiwocWHY9Z6GDJqpweaQsbsl5q33fu4h9CqYc
         m6Ec1M77pLwnTcRLxB2Xmp0U8kSDGZGWhuKaTvbI=
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
Subject: [PATCH 59/77] perf stat: Move 'print_mixed_hw_group_error' to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:22 -0300
Message-Id: <20180905220440.20256-60-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'print_mixed_hw_group_error' global variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-35-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8748bb5e5403..f61c2dc8c7e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -170,7 +170,6 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
@@ -1052,7 +1051,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		if (counter->supported) {
 			config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
-				print_mixed_hw_group_error = 1;
+				config->print_mixed_hw_group_error = 1;
 		}
 
 		fprintf(config->output, "%-*s%s",
@@ -1715,7 +1714,7 @@ static void print_footer(struct perf_stat_config *config)
 "	perf stat ...\n"
 "	echo 1 > /proc/sys/kernel/nmi_watchdog\n");
 
-	if (print_mixed_hw_group_error)
+	if (config->print_mixed_hw_group_error)
 		fprintf(output,
 			"The events in group usually have to be from "
 			"the same PMU. Try reorganizing the group.\n");
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 8cad17363e90..6fb4dac26ccc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -104,6 +104,7 @@ struct perf_stat_config {
 	int			 times;
 	int			 run_count;
 	int			 print_free_counters_hint;
+	int			 print_mixed_hw_group_error;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
-- 
2.14.4

