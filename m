Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BD7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB0F2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfAGQ2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:28:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34252 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfAGQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:28:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 220801596;
        Mon,  7 Jan 2019 08:28:05 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A181B3F5A0;
        Mon,  7 Jan 2019 08:28:00 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Russell King <linux@armlinux.org.uk>, suzuki.poulose@arm.com,
        robin.murphy@arm.com, Michael Ellerman <mpe@ellerman.id.au>
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-alpha@vger.kernel.org
Subject: [PATCH v4 05/13] arm: perf: conditionally use PERF_PMU_CAP_NO_EXCLUDE
Date:   Mon,  7 Jan 2019 16:27:22 +0000
Message-Id: <1546878450-20341-6-git-send-email-andrew.murray@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM PMU driver can be used to represent a variety of ARM based
PMUs. Some of these PMUs do not provide support for context
exclusion, where this is the case we advertise the
PERF_PMU_CAP_NO_EXCLUDE capability to ensure that perf prevents us
from handling events where any exclusion flags are set.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index d0b7dd8..eec75b9 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -357,13 +357,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 }
 
 static int
-event_requires_mode_exclusion(struct perf_event_attr *attr)
-{
-	return attr->exclude_idle || attr->exclude_user ||
-	       attr->exclude_kernel || attr->exclude_hv;
-}
-
-static int
 __hw_perf_event_init(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
@@ -393,9 +386,8 @@ __hw_perf_event_init(struct perf_event *event)
 	/*
 	 * Check whether we need to exclude the counter from certain modes.
 	 */
-	if ((!armpmu->set_event_filter ||
-	     armpmu->set_event_filter(hwc, &event->attr)) &&
-	     event_requires_mode_exclusion(&event->attr)) {
+	if (armpmu->set_event_filter &&
+	    armpmu->set_event_filter(hwc, &event->attr)) {
 		pr_debug("ARM performance counters do not support "
 			 "mode exclusion\n");
 		return -EOPNOTSUPP;
@@ -867,6 +859,9 @@ int armpmu_register(struct arm_pmu *pmu)
 	if (ret)
 		return ret;
 
+	if (!pmu->set_event_filter)
+		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
+
 	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
 	if (ret)
 		goto out_destroy;
-- 
2.7.4

