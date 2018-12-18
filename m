Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629B1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3949D217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeLROZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:25:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeLROZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:25:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEPHX62857792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:25:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEPHG22857789;
        Tue, 18 Dec 2018 06:25:17 -0800
Date:   Tue, 18 Dec 2018 06:25:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-91b2b97025097ce7ca7536bc87eba2bf14760fb4@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, ak@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          ak@linux.intel.com
In-Reply-To: <20181120050635.4215-1-andi@firstfloor.org>
References: <20181120050635.4215-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Fix
 Load_Miss_Real_Latency on SKL/SKX
Git-Commit-ID: 91b2b97025097ce7ca7536bc87eba2bf14760fb4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  91b2b97025097ce7ca7536bc87eba2bf14760fb4
Gitweb:     https://git.kernel.org/tip/91b2b97025097ce7ca7536bc87eba2bf14760fb4
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 19 Nov 2018 21:06:35 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:32 -0300

perf vendor events intel: Fix Load_Miss_Real_Latency on SKL/SKX

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
