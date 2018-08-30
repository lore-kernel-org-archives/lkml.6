Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F94AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2290320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeH3Kdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727597AbeH3Kdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0CCB40200BA;
        Thu, 30 Aug 2018 06:33:02 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E3BFA9F09;
        Thu, 30 Aug 2018 06:33:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 05/43] perf stat: Add identifier flag into struct stat_opts
Date:   Thu, 30 Aug 2018 08:32:14 +0200
Message-Id: <20180830063252.23729-6-jolsa@kernel.org>
In-Reply-To: <20180830063252.23729-1-jolsa@kernel.org>
References: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:33:03 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 30 Aug 2018 06:33:03 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding identifier flag into struct stat_opts to carry the
info whether to use PERF_SAMPLE_IDENTIFIER for events.
It makes the create_perf_stat_counter function independent.

Link: http://lkml.kernel.org/n/tip-s1n7gth2e05oxai3gf2z5p3w@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 22 ++++++++++++----------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 47789558899a..48c88f568fe1 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -261,16 +261,7 @@ static int create_perf_stat_counter(struct perf_evsel *evsel,
 	 */
 	attr->sample_period = 0;
 
-	/*
-	 * But set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
-	 * while avoiding that older tools show confusing messages.
-	 *
-	 * However for pipe sessions we need to keep it zero,
-	 * because script's perf_evsel__check_attr is triggered
-	 * by attr->sample_type != 0, and we can't run it on
-	 * stat sessions.
-	 */
-	if (!(STAT_RECORD && perf_stat.data.is_pipe))
+	if (config->identifier)
 		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
 
 	/*
@@ -3064,6 +3055,17 @@ int cmd_stat(int argc, const char **argv)
 	if (perf_stat_init_aggr_mode())
 		goto out;
 
+	/*
+	 * Set sample_type to PERF_SAMPLE_IDENTIFIER, which should be harmless
+	 * while avoiding that older tools show confusing messages.
+	 *
+	 * However for pipe sessions we need to keep it zero,
+	 * because script's perf_evsel__check_attr is triggered
+	 * by attr->sample_type != 0, and we can't run it on
+	 * stat sessions.
+	 */
+	stat_config.identifier = !(STAT_RECORD && perf_stat.data.is_pipe);
+
 	/*
 	 * We dont want to block the signals - that would cause
 	 * child tasks to inherit that and Ctrl-C would not work.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 53b2415ba3f3..918cde064cdc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -89,6 +89,7 @@ struct perf_stat_config {
 	enum aggr_mode		 aggr_mode;
 	bool			 scale;
 	bool			 no_inherit;
+	bool			 identifier;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.17.1

