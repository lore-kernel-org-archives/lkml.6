Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeENNfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:35:03 -0400
Received: from foss.arm.com ([217.140.101.70]:42712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbeENNfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:35:01 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pawel.moll@arm.com, suzuki.poulose@arm.com
Subject: [PATCH v2 2/3] perf/arm-cci: Remove pointless PMU disabling
Date: Mon, 14 May 2018 14:34:52 +0100
Message-Id: <2befe1cf83b94856fa574f7f483c08bb4c3cc8c6.1526303815.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.0.dirty
In-Reply-To: <cover.1526303815.git.robin.murphy@arm.com>
References: <cover.1526303815.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CCI PMU driver bears some legacy remnants of the arm_pmu framework
from when it was split in c6f85cb4305b ("bus: cci: move away from
arm_pmu framework"). In particular this perf_pmu_{dis,en}able() dance
around pmu->add which was fixed for arm_pmu in a9e469d1c89b
("drivers/perf: arm_pmu: remove pointless PMU disabling").

For the exact same reasons (i.e. perf core already does this around the
call anyway), give cci_pmu_add() the exact same change, which also
prevents having to export those core functions to build it as a module.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Add Mark's ack

 drivers/perf/arm-cci.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 53c774b20563..7029d8fe8f44 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1184,16 +1184,11 @@ static int cci_pmu_add(struct perf_event *event, int flags)
 	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
 	struct hw_perf_event *hwc = &event->hw;
 	int idx;
-	int err = 0;
-
-	perf_pmu_disable(event->pmu);
 
 	/* If we don't have a space for the counter then finish early. */
 	idx = pmu_get_event_idx(hw_events, event);
-	if (idx < 0) {
-		err = idx;
-		goto out;
-	}
+	if (idx < 0)
+		return idx;
 
 	event->hw.idx = idx;
 	hw_events->events[idx] = event;
@@ -1205,9 +1200,7 @@ static int cci_pmu_add(struct perf_event *event, int flags)
 	/* Propagate our changes to the userspace mapping. */
 	perf_event_update_userpage(event);
 
-out:
-	perf_pmu_enable(event->pmu);
-	return err;
+	return 0;
 }
 
 static void cci_pmu_del(struct perf_event *event, int flags)
-- 
2.17.0.dirty
