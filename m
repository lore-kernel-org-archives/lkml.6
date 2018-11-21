Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833A0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5708120989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5708120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeKUUuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:50:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKUUuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:50:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 76370308A941;
        Wed, 21 Nov 2018 10:16:17 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8A4317C25;
        Wed, 21 Nov 2018 10:16:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH 2/3] perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts
Date:   Wed, 21 Nov 2018 11:16:11 +0100
Message-Id: <20181121101612.16272-2-jolsa@kernel.org>
In-Reply-To: <20181121101612.16272-1-jolsa@kernel.org>
References: <20181121101612.16272-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 21 Nov 2018 10:16:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we check the branch tracing only by checking for the
PERF_COUNT_HW_BRANCH_INSTRUCTIONS event of PERF_TYPE_HARDWARE
type. But we can define the same event with the PERF_TYPE_RAW
type.

Changing the intel_pmu_has_bts code to check on event's final
hw config value, so both HW types are covered.

Adding unlikely to intel_pmu_has_bts condition calls, because
it was used in the original code in intel_bts_constraints.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/events/intel/core.c | 17 +++--------------
 arch/x86/events/perf_event.h | 13 +++++++++----
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8c1efb4d8f47..3fd3842571e8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2470,16 +2470,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 static struct event_constraint *
 intel_bts_constraints(struct perf_event *event)
 {
-	struct hw_perf_event *hwc = &event->hw;
-	unsigned int hw_event, bts_event;
-
-	if (event->attr.freq)
-		return NULL;
-
-	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
-	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
-
-	if (unlikely(hw_event == bts_event && hwc->sample_period == 1))
+	if (unlikely(intel_pmu_has_bts(event)))
 		return &bts_constraint;
 
 	return NULL;
@@ -3101,10 +3092,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 static int intel_pmu_bts_config(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
-	struct hw_perf_event *hwc = &event->hw;
 
-	if (attr->config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !attr->freq && hwc->sample_period == 1) {
+	if (unlikely(intel_pmu_has_bts(event))) {
 		/* BTS is not supported by this architecture. */
 		if (!x86_pmu.bts_active)
 			return -EOPNOTSUPP;
@@ -3166,7 +3155,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		/*
 		 * BTS is set up earlier in this path, so don't account twice
 		 */
-		if (!intel_pmu_has_bts(event)) {
+		if (!unlikely(intel_pmu_has_bts(event))) {
 			/* disallow lbr if conflicting events are present */
 			if (x86_add_exclusive(x86_lbr_exclusive_lbr))
 				return -EBUSY;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index adae087cecdd..78d7b7031bfc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -859,11 +859,16 @@ static inline int amd_pmu_init(void)
 
 static inline bool intel_pmu_has_bts(struct perf_event *event)
 {
-	if (event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !event->attr.freq && event->hw.sample_period == 1)
-		return true;
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int hw_event, bts_event;
+
+	if (event->attr.freq)
+		return false;
+
+	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
+	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
 
-	return false;
+	return hw_event == bts_event && hwc->sample_period == 1;
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
-- 
2.17.2

