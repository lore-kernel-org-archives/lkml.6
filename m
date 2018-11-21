Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E0FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D45E2147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D45E2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbeKUUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:50:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKUUuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:50:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49BC23082211;
        Wed, 21 Nov 2018 10:16:15 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40EE517CFF;
        Wed, 21 Nov 2018 10:16:12 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH 1/3] perf/x86/intel: Move branch tracing setup to intel object
Date:   Wed, 21 Nov 2018 11:16:10 +0100
Message-Id: <20181121101612.16272-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 21 Nov 2018 10:16:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving branch tracing setup to Intel core object into separate
intel_pmu_bts_config function, because it's Intel specific.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/core.c       | 20 ------------------
 arch/x86/events/intel/core.c | 41 +++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 106911b603bd..374a19712e20 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -438,26 +438,6 @@ int x86_setup_perfctr(struct perf_event *event)
 	if (config == -1LL)
 		return -EINVAL;
 
-	/*
-	 * Branch tracing:
-	 */
-	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !attr->freq && hwc->sample_period == 1) {
-		/* BTS is not supported by this architecture. */
-		if (!x86_pmu.bts_active)
-			return -EOPNOTSUPP;
-
-		/* BTS is currently only allowed for user-mode. */
-		if (!attr->exclude_kernel)
-			return -EOPNOTSUPP;
-
-		/* disallow bts if conflicting events are present */
-		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
-			return -EBUSY;
-
-		event->destroy = hw_perf_lbr_event_destroy;
-	}
-
 	hwc->config |= config;
 
 	return 0;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 273c62e81546..8c1efb4d8f47 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3098,10 +3098,49 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	return flags;
 }
 
+static int intel_pmu_bts_config(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
+	    !attr->freq && hwc->sample_period == 1) {
+		/* BTS is not supported by this architecture. */
+		if (!x86_pmu.bts_active)
+			return -EOPNOTSUPP;
+
+		/* BTS is currently only allowed for user-mode. */
+		if (!attr->exclude_kernel)
+			return -EOPNOTSUPP;
+
+		/* disallow bts if conflicting events are present */
+		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
+			return -EBUSY;
+
+		event->destroy = hw_perf_lbr_event_destroy;
+	}
+
+	return 0;
+}
+
+static int core_pmu_hw_config(struct perf_event *event)
+{
+	int ret = x86_pmu_hw_config(event);
+
+	if (ret)
+		return ret;
+
+	return intel_pmu_bts_config(event);
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
 
+	if (ret)
+		return ret;
+
+	ret = intel_pmu_bts_config(event);
 	if (ret)
 		return ret;
 
@@ -3596,7 +3635,7 @@ static __initconst const struct x86_pmu core_pmu = {
 	.enable_all		= core_pmu_enable_all,
 	.enable			= core_pmu_enable_event,
 	.disable		= x86_pmu_disable_event,
-	.hw_config		= x86_pmu_hw_config,
+	.hw_config		= core_pmu_hw_config,
 	.schedule_events	= x86_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
-- 
2.17.2

