Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeEULRT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:17:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47190 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeEULRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:17:14 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/arm-cci: Remove unnecessary period adjustment
Date: Mon, 21 May 2018 12:17:09 +0100
Message-Id: <9e5b7638ff44111334aff53b76bdcd1f26f08179.1526901337.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.0.dirty
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since sampling events are rejected up-front by cci_pmu_event_init(), it
doesn't make much sense to go fiddling with the sampling period later.
This would seem to be just another leftover artefact of the arm_pmu
framwork, and as such can go.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cci.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 09938dd8eb6f..e6fadc8e1178 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1297,15 +1297,6 @@ static int __hw_perf_event_init(struct perf_event *event)
 	 */
 	hwc->config_base	    |= (unsigned long)mapping;
 
-	/*
-	 * Limit the sample_period to half of the counter width. That way, the
-	 * new counter value is far less likely to overtake the previous one
-	 * unless you have some serious IRQ latency issues.
-	 */
-	hwc->sample_period  = CCI_PMU_CNTR_MASK >> 1;
-	hwc->last_period    = hwc->sample_period;
-	local64_set(&hwc->period_left, hwc->sample_period);
-
 	if (event->group_leader != event) {
 		if (validate_group(event) != 0)
 			return -EINVAL;
-- 
2.17.0.dirty
