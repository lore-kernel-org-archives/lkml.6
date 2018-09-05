Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E639C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B7B20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xHt77Xw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B7B20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeIFCi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeIFCiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:55 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EBF2083D;
        Wed,  5 Sep 2018 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185204;
        bh=dqlxhShzeAWzs42TAZnALtVFqAe4UslMzH9jtfoHmPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHt77Xw/9xUZCoyA+FMNIObVGPbfRXX0OzmauzcJsiNoiwbt9gp/dZ9f4M5xrm1XQ
         6HI8ur4Knj/N2cSHczTKkJBh6iO6kfR09Wa8d1VL8wCOzup6ymdAKIvwR9SYwd7IiT
         IOpPt1khcuA0tdc3G/xRHl5F8Jwa29r10VNxkZ34=
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
Subject: [PATCH 41/77] perf stat: Move STAT_RECORD out of perf_evlist__print_counters()
Date:   Wed,  5 Sep 2018 19:04:04 -0300
Message-Id: <20180905220440.20256-42-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

It's stat related and should stay in the 'perf stat' command.  The
perf_evlist__print_counters function will be moved out in the following
patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-17-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index db11832bbdbc..4ffbb6594eb6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1701,10 +1701,6 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	struct perf_evsel *counter;
 	char buf[64], *prefix = NULL;
 
-	/* Do not print anything if we record to the pipe. */
-	if (STAT_RECORD && perf_stat.data.is_pipe)
-		return;
-
 	if (interval)
 		print_interval(prefix = buf, ts);
 	else
@@ -1766,6 +1762,10 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
 {
+	/* Do not print anything if we record to the pipe. */
+	if (STAT_RECORD && perf_stat.data.is_pipe)
+		return;
+
 	perf_evlist__print_counters(evsel_list, ts, argc, argv);
 }
 
-- 
2.14.4

