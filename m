Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB433C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F28B20869
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRg9OeFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F28B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeIFCiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbeIFCiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:24 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8EEA20861;
        Wed,  5 Sep 2018 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185173;
        bh=iJ05fZE+s6mehW9T9GjpgNHPfod+bowqvzBQBatxTyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRg9OeFEzkTaChDJdtPuAPfJTefnscnnljo+G5GKn+NAdbaMC/7BA7Y1jmwE9EutE
         NdlOjnqHcHPtPZ0SbG/UvEbagxj6OAsc+Cf3msXp9CGM3ay82D9LfeOtdb/qtcTwCq
         CyYgurWEW4If/VBSAsVMehQ2/1gdVWx3rHvBtXw0=
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
Subject: [PATCH 30/77] perf stat: Add 'identifier' flag to 'struct perf_stat_config'
Date:   Wed,  5 Sep 2018 19:03:53 -0300
Message-Id: <20180905220440.20256-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'identifier' flag to 'struct perf_stat_config' to carry the info
whether to use PERF_SAMPLE_IDENTIFIER for events.

This makes create_perf_stat_counter() independent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

