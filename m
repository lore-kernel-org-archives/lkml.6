Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9068AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5140221473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfBHpm8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5140221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLAFhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAFhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:37:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D30C2146D;
        Fri, 30 Nov 2018 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602431;
        bh=R/wsFI8nnpjCw6jZS4Fk//UfEAwnAHHX7I1rv9nCrlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfBHpm8NPAO2ZKpUQ59IhUwuFkALvl0u7IYMF7nRsnKHoIL0LCybyVWA04GM1wTv5
         jAe3SoBJjvjiddNdJnTz6YXKKGeN+onS2SiLFiMz3Gc4JfIbeTb9d2+kqZxrBztVQ9
         1F1/HwZQKudlDJn8XwK5fp25TO5LZxzPOJZXTDl4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        yuzhoujian@didichuxing.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/22] perf stat: Fix shadow stats for clock events
Date:   Fri, 30 Nov 2018 15:26:32 -0300
Message-Id: <20181130182652.23620-3-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Commit 0aa802a79469 ("perf stat: Get rid of extra clock display
function") introduced scale and unit for clock events. Thus,
perf_stat__update_shadow_stats() now saves scaled values of clock events
in msecs, instead of original nsecs. But while calculating values of
shadow stats we still consider clock event values in nsecs. This results
in a wrong shadow stat values. Ex,

  # ./perf stat -e task-clock,cycles ls
    <SNIP>
              2.60 msec task-clock:u    #    0.877 CPUs utilized
         2,430,564      cycles:u        # 1215282.000 GHz

Fix this by saving original nsec values for clock events in
perf_stat__update_shadow_stats(). After patch:

  # ./perf stat -e task-clock,cycles ls
    <SNIP>
              3.14 msec task-clock:u    #    0.839 CPUs utilized
         3,094,528      cycles:u        #    0.985 GHz

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: yuzhoujian@didichuxing.com
Fixes: 0aa802a79469 ("perf stat: Get rid of extra clock display function")
Link: http://lkml.kernel.org/r/20181116042843.24067-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f0a8cec55c47..3c22c58b3e90 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -209,11 +209,12 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st)
 {
 	int ctx = evsel_context(counter);
+	u64 count_ns = count;
 
 	count *= counter->scale;
 
 	if (perf_evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
+		update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-- 
2.19.1

