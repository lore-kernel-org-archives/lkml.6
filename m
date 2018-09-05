Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D568C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8B12086B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0sxXHO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8B12086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbeIFCjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:43 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAFC220652;
        Wed,  5 Sep 2018 22:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185251;
        bh=yXzM0ZYB/v8n7Zlw57xXXvb63giXgT/LBWfkJlfuRE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0sxXHO86fbYEpxIXsNWNVp+47sqWPvhENu2PMvwyPysn1hi/pzWVmVXuItCHJEBc
         IJj50N7zA2kQ3FcIMZaYqB7Qf4xskeqQ8SrDcXPXNefkjFMAhPxlYKO2i8Tau5CvZF
         H/TajCg9NvocvpEz/YpDSRGjnp2EArFeU//Osltc=
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
Subject: [PATCH 58/77] perf stat: Move 'print_free_counters_hint' to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:04:21 -0300
Message-Id: <20180905220440.20256-59-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'print_free_counters_hint' variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-34-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 844c755564e3..8748bb5e5403 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -170,7 +170,6 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static int			print_free_counters_hint;
 static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
@@ -1051,7 +1050,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			config->csv_sep);
 
 		if (counter->supported) {
-			print_free_counters_hint = 1;
+			config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
 				print_mixed_hw_group_error = 1;
 		}
@@ -1707,7 +1706,7 @@ static void print_footer(struct perf_stat_config *config)
 	}
 	fprintf(output, "\n\n");
 
-	if (print_free_counters_hint &&
+	if (config->print_free_counters_hint &&
 	    sysctl__read_int("kernel/nmi_watchdog", &n) >= 0 &&
 	    n > 0)
 		fprintf(output,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index c198926c0e27..8cad17363e90 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	unsigned int		 metric_only_len;
 	int			 times;
 	int			 run_count;
+	int			 print_free_counters_hint;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
-- 
2.14.4

