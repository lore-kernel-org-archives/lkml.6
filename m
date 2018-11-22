Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84860C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACAF206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+PMXw16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACAF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404505AbeKVOO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404467AbeKVOO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:57 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A31206BA;
        Thu, 22 Nov 2018 03:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857851;
        bh=+w3AQcVAItC7FcEYpV2oJOgAwQQhF5ZJXg2elDfFP/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+PMXw16/p9bve/a+qwgdkki3d22I0FUqaa74Vl5ankQpNOUAwSyVusRtF/+mujTg
         wPakhU2+g1+KihW8z9XzrKTKyAS9OIxlkRvyZvuDJ8gda4K35J6PJRooVQjZ8jY2as
         CEeI3wN0xeVyh1gT915TbT/iEV9e/G60XrvtrqGM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anton Blanchard <anton@samba.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        yuzhoujian@didichuxing.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/28] perf stat: Use perf_evsel__is_clocki() for clock events
Date:   Thu, 22 Nov 2018 00:36:06 -0300
Message-Id: <20181122033611.15890-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

We already have function to check if a given event is either
SW_CPU_CLOCK or SW_TASK_CLOCK. Utilize it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: yuzhoujian@didichuxing.com
Link: http://lkml.kernel.org/r/20181115095533.16930-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 8ad32763cfff..f0a8cec55c47 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -212,8 +212,7 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 
 	count *= counter->scale;
 
-	if (perf_evsel__match(counter, SOFTWARE, SW_TASK_CLOCK) ||
-	    perf_evsel__match(counter, SOFTWARE, SW_CPU_CLOCK))
+	if (perf_evsel__is_clock(counter))
 		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
-- 
2.14.5

