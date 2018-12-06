Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E250C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2403C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131602;
	bh=BRJGRpTUL+ivylBEKQw3GlXfKCRPjXBn6J1crIhiIkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+Uz14YmFEA7eXHG46+6fCZ1+8dccVbmEIa5qDx3xzuNLzMcYXCJ/goxT6CLoJFNE
	 /+GyNdzEFDmp2gfeCaRSGyHzWQd/Avu0FzMwXmaY6Tog1HRCGEAw11xV6eIv9Axt29
	 QZgM7MPKJtUEOleymUHVfKQtX9FiOYN4AR5U4mYA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2403C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbeLFV0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeLFV0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:26:39 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158DD2146D;
        Thu,  6 Dec 2018 21:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131599;
        bh=BRJGRpTUL+ivylBEKQw3GlXfKCRPjXBn6J1crIhiIkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSGIFEwAoEYvZAXUDtssVzQbtj8cXy6itVZYeaLcB2FTc2gDcYqOuoTccMuRzFV8T
         ACtt4YYANHzoHd987yhDkBjJy9Fph56V9vootvRNjcWgPJsya4D90o5bEYa+BPeM8k
         tBh38Lq2dHatOjzLwDV7vi/Gv64JpW/UhoVOH68Q=
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
Subject: [PATCH 02/75] perf stat: Fix shadow stats for clock events
Date:   Thu,  6 Dec 2018 18:24:49 -0300
Message-Id: <20181206212602.20474-3-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
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
2.19.2

