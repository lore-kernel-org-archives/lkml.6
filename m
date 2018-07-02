Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06D25381
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD06D25381
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeGBPM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:12:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752075AbeGBPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:12:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A14BF80D;
        Mon,  2 Jul 2018 08:12:55 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9318B3F2EA;
        Mon,  2 Jul 2018 08:12:54 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH] perf/core: don't sample kernel regs upon skid
Date:   Mon,  2 Jul 2018 16:12:50 +0100
Message-Id: <20180702151250.14536-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users can request that general purpose registers, instruction pointer,
etc, are sampled when a perf event counter overflows. To try to avoid
this resulting in kernel state being leaked, unprivileged users are
usually forbidden from opening events which count while the kernel is
running.

Unfortunately, this is not sufficient to avoid leading kernel state.

For various reasons, there can be a delay between the overflow occurring
and the resulting overflow exception (e.g. an NMI) being taken. During
this window, other instructions may be executed, resulting in skid.

This skid means that a userspace-only event overflowing may result in an
exception being taken *after* entry to the kernel, allowing kernel
registers to be sampled. Depending on the amount of skid, this may only
leak the PC (breaking KASLR), or it may leak secrets which are currently
live in GPRs.

Let's avoid this by only sampling from the user registers when an event
is supposed to exclude the kernel, providing the illusion that the
overflow exception is taken from userspace.

We also have similar cases when sampling a guest, where we get the host
regs in some cases. It's not entirely clear to me how we should handle
these.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..2ab2548b2e66 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6361,6 +6361,32 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	return callchain ?: &__empty_callchain;
 }
 
+static struct pt_regs *perf_get_sample_regs(struct perf_event *event,
+					    struct pt_regs *regs)
+{
+	/*
+	 * Due to interrupt latency (AKA "skid"), we may enter the kernel
+	 * before taking an overflow, even if the PMU is only counting user
+	 * events.
+	 *
+	 * If we're not counting kernel events, always use the user regs when
+	 * sampling.
+	 *
+	 * TODO: what do we do about sampling a guest's registers? The IP is
+	 * special-cased, but for the rest of the regs they'll get the
+	 * user/kernel regs depending on whether exclude_kernel is set, which
+	 * is nonsensical.
+	 *
+	 * We can't get at the full set of regs in all cases (e.g. Xen's PV PMU
+	 * can't provide the GPRs), so should we just zero the GPRs when in a
+	 * guest? Or skip outputting the regs in perf_output_sample?
+	 */
+	if (event->attr.exclude_kernel && !user_mode(regs))
+		return task_pt_regs(current);
+
+	return regs;
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
@@ -6368,6 +6394,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 {
 	u64 sample_type = event->attr.sample_type;
 
+	regs = perf_get_sample_regs(event, regs);
+
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = sizeof(*header) + event->header_size;
 
-- 
2.11.0

