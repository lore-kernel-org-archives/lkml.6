Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE76C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A102021508
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="emAUjlKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A102021508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeLDLIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbeLDLIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF6882087F;
        Tue,  4 Dec 2018 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921702;
        bh=0SczjAMoJMjaMg2ucflbq2ipWq00zrmYpMhIsmm8llI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emAUjlKYOehCH9zI1Px61IdgaSoHYYULZytj4FDP9eryipA6vOZ+xTu+OuKU4TgsE
         xVWYNMZ6lwo6f/I/jVFMWqLMu/kbJCjeqz1QkbESx2KY3rZWkI6hzzNR8PrYKRWIjo
         hvVr2YDCuts8MSWZHDr9Ynrrnti7FkKDmAXjcgOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 26/50] perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts()
Date:   Tue,  4 Dec 2018 11:50:21 +0100
Message-Id: <20181204103715.836596245@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 67266c1080ad56c31af72b9c18355fde8ccc124a upstream.

Currently we check the branch tracing only by checking for the
PERF_COUNT_HW_BRANCH_INSTRUCTIONS event of PERF_TYPE_HARDWARE
type. But we can define the same event with the PERF_TYPE_RAW
type.

Changing the intel_pmu_has_bts() code to check on event's final
hw config value, so both HW types are covered.

Adding unlikely to intel_pmu_has_bts() condition calls, because
it was used in the original code in intel_bts_constraints.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20181121101612.16272-2-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |   17 +++--------------
 arch/x86/events/perf_event.h |   13 +++++++++----
 2 files changed, 12 insertions(+), 18 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2198,16 +2198,7 @@ done:
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
@@ -2825,10 +2816,8 @@ static unsigned long intel_pmu_free_runn
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
@@ -2887,7 +2876,7 @@ static int intel_pmu_hw_config(struct pe
 		/*
 		 * BTS is set up earlier in this path, so don't account twice
 		 */
-		if (!intel_pmu_has_bts(event)) {
+		if (!unlikely(intel_pmu_has_bts(event))) {
 			/* disallow lbr if conflicting events are present */
 			if (x86_add_exclusive(x86_lbr_exclusive_lbr))
 				return -EBUSY;
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -835,11 +835,16 @@ static inline int amd_pmu_init(void)
 
 static inline bool intel_pmu_has_bts(struct perf_event *event)
 {
-	if (event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS &&
-	    !event->attr.freq && event->hw.sample_period == 1)
-		return true;
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int hw_event, bts_event;
 
-	return false;
+	if (event->attr.freq)
+		return false;
+
+	hw_event = hwc->config & INTEL_ARCH_EVENT_MASK;
+	bts_event = x86_pmu.event_map(PERF_COUNT_HW_BRANCH_INSTRUCTIONS);
+
+	return hw_event == bts_event && hwc->sample_period == 1;
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);


