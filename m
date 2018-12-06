Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0548EC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7DA20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131897;
	bh=vX46L8R7a+NtDaBYRnY7AM6Mr/JxMyI03/0OHnel6TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QNuMEykcWw77KEwmAoCVy1UkoDCTAopOtRd8cM1hZZE61WtfOPZMyocTzkpSVClFJ
	 aqXvAK/AGrWA5yacsI6uv4dWss+D939rZwK2d7Ie5xpL4jw6ZmAXND7hK+ygiKUjBw
	 D/6lz/ouJa6/Xm5W44VyF+quiTmvGP0bTCf0UH+s=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7DA20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeLFVbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:31:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbeLFVaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:55 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD91D208E7;
        Thu,  6 Dec 2018 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131854;
        bh=vX46L8R7a+NtDaBYRnY7AM6Mr/JxMyI03/0OHnel6TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BruxMzlZgQz1dNL16KaecdE0m3xKc8JtlXwvrr3LlW97NFs1EuuYmnSIkGsscBRri
         EpvtTf1TVsbJaVWNefhw5xpLGtvCkyOjOxlgnT4fKXogAntDV6pSl+pI5aF1oZhZvv
         8UvhQCbUBxKXG3+ub36wMzInAkkr/LOB197uWwXU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 68/75] perf vendor events intel: Fix Load_Miss_Real_Latency on SKL/SKX
Date:   Thu,  6 Dec 2018 18:25:55 -0300
Message-Id: <20181206212602.20474-69-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Fix incorrect event names for the Load_Miss_Real_Latency metric for
Skylake and Skylake Server.

Fixes https://github.com/andikleen/pmu-tools/issues/158

Before:

  % perf stat -M Load_Miss_Real_Latency true
  event syntax error: '..ss.pending,mem_load_retired.l1_miss_ps,mem_load_retired.fb_hit_ps}:W'
                                    \___ parser error

   Usage: perf stat [<options>] [<command>]

      -M, --metrics <metric/metric group list>
                            monitor specified metrics or metric groups (separated by ,)

After:

  % perf stat -M Load_Miss_Real_Latency true

   Performance counter stats for 'true':

             279,204      l1d_pend_miss.pending     #     14.0 Load_Miss_Real_Latency
               4,784      mem_load_uops_retired.l1_miss
              15,188      mem_load_uops_retired.hit_lfb

         0.000899640 seconds time elapsed

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: http://lkml.kernel.org/r/20181120050635.4215-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json  | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 36c903faed0b..71e9737f4614 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -73,7 +73,7 @@
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 36c903faed0b..71e9737f4614 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -73,7 +73,7 @@
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads",
-        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS_PS + MEM_LOAD_RETIRED.FB_HIT_PS )",
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
         "MetricGroup": "Memory_Bound;Memory_Lat",
         "MetricName": "Load_Miss_Real_Latency"
     },
-- 
2.19.2

