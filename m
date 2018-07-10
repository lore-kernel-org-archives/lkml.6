Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5332DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5DB20883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5DB20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbeGJSXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:23:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732266AbeGJSXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:23:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40EC81DC8;
        Tue, 10 Jul 2018 11:06:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 536C93F589;
        Tue, 10 Jul 2018 11:06:15 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] perf/core: fix possible spectre-v1 write
Date:   Tue, 10 Jul 2018 19:06:07 +0100
Message-Id: <20180710180607.56624-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for userspace to control event_id. Sanitize event_id when
using it as an array index, to inhibit the potential spectre-v1 write
gadget.

This class of issue is also known as CVE-2018-3693, or "bounds check bypass
store".

Found by smatch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

For Arm CPUs, more details can be found in the Arm Cache Speculation
Side-channels whitepaper, available from the Arm security updates site [1].

Mark.

[1] https://developer.arm.com/support/arm-security-updates/speculative-processor-vulnerability

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..eece719bd18e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8155,6 +8155,7 @@ struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
 static void sw_perf_event_destroy(struct perf_event *event)
 {
 	u64 event_id = event->attr.config;
+	event_id = array_index_nospec(event_id, PERF_COUNT_SW_MAX);
 
 	WARN_ON(event->parent);
 
@@ -8186,6 +8187,7 @@ static int perf_swevent_init(struct perf_event *event)
 
 	if (event_id >= PERF_COUNT_SW_MAX)
 		return -ENOENT;
+	event_id = array_index_nospec(event_id, PERF_COUNT_SW_MAX);
 
 	if (!event->parent) {
 		int err;
-- 
2.11.0

