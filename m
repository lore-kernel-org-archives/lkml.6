Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080EDC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA82E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA82E206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbeKTPdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:33:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:33962 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730962AbeKTPdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:33:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 21:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,255,1539673200"; 
   d="scan'208";a="281400892"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2018 21:06:39 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 81E6C3018C4; Mon, 19 Nov 2018 21:06:39 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf vendor events intel: Fix Load_Miss_Real_Latency on SKL/SKX
Date:   Mon, 19 Nov 2018 21:06:35 -0800
Message-Id: <20181120050635.4215-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
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
2.17.2

