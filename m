Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5135CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B0D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B0D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbeGJI7L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:59:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43014 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933025AbeGJI6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:58:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 822631713;
        Tue, 10 Jul 2018 01:58:24 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E9423F318;
        Tue, 10 Jul 2018 01:58:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com, robin.murphy@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 4/7] arm_pmu: Tidy up clear_event_idx call backs
Date:   Tue, 10 Jul 2018 09:58:01 +0100
Message-Id: <1531213084-27417-5-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
References: <1531213084-27417-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The armpmu uses get_event_idx callback to allocate an event
counter for a given event, which marks the selected counter
as "used". Now, when we delete the counter, the arm_pmu goes
ahead and clears the "used" bit and then invokes the "clear_event_idx"
call back, which kind of splits the job between the core code
and the backend. To keep things tidy, mandate the implementation
of clear_event_idx() and add it for exisiting backends.
This will be useful for adding the chained event support, where
we leave the event idx maintenance to the backend.

Also, when an event is removed from the PMU, reset the hw.idx
to indicate that a counter is not allocated for this event,
to help the backends do better checks. This will be also used
for the chain counter support.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v4:
 - Add missing clear_event_idx call back for xscale PMU
---
 arch/arm/kernel/perf_event_v6.c     | 8 ++++++++
 arch/arm/kernel/perf_event_v7.c     | 9 +++++++++
 arch/arm/kernel/perf_event_xscale.c | 8 ++++++++
 arch/arm64/kernel/perf_event.c      | 7 +++++++
 drivers/perf/arm_pmu.c              | 7 +++----
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 0729f98..1ae99de 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -411,6 +411,12 @@ armv6pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	}
 }
 
+static void armv6pmu_clear_event_idx(struct pmu_hw_events *cpuc,
+				     struct perf_event *event)
+{
+	clear_bit(event->hw.idx, cpuc->used_mask);
+}
+
 static void armv6pmu_disable_event(struct perf_event *event)
 {
 	unsigned long val, mask, evt, flags;
@@ -491,6 +497,7 @@ static void armv6pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter	= armv6pmu_read_counter;
 	cpu_pmu->write_counter	= armv6pmu_write_counter;
 	cpu_pmu->get_event_idx	= armv6pmu_get_event_idx;
+	cpu_pmu->clear_event_idx = armv6pmu_clear_event_idx;
 	cpu_pmu->start		= armv6pmu_start;
 	cpu_pmu->stop		= armv6pmu_stop;
 	cpu_pmu->map_event	= armv6_map_event;
@@ -541,6 +548,7 @@ static int armv6mpcore_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter	= armv6pmu_read_counter;
 	cpu_pmu->write_counter	= armv6pmu_write_counter;
 	cpu_pmu->get_event_idx	= armv6pmu_get_event_idx;
+	cpu_pmu->clear_event_idx = armv6pmu_clear_event_idx;
 	cpu_pmu->start		= armv6pmu_start;
 	cpu_pmu->stop		= armv6pmu_stop;
 	cpu_pmu->map_event	= armv6mpcore_map_event;
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index fd7ce01..acb49a9 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1058,6 +1058,12 @@ static int armv7pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return -EAGAIN;
 }
 
+static void armv7pmu_clear_event_idx(struct pmu_hw_events *cpuc,
+				     struct perf_event *event)
+{
+	clear_bit(event->hw.idx, cpuc->used_mask);
+}
+
 /*
  * Add an event filter to a given event. This will only work for PMUv2 PMUs.
  */
@@ -1167,6 +1173,7 @@ static void armv7pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter	= armv7pmu_read_counter;
 	cpu_pmu->write_counter	= armv7pmu_write_counter;
 	cpu_pmu->get_event_idx	= armv7pmu_get_event_idx;
+	cpu_pmu->clear_event_idx = armv7pmu_clear_event_idx;
 	cpu_pmu->start		= armv7pmu_start;
 	cpu_pmu->stop		= armv7pmu_stop;
 	cpu_pmu->reset		= armv7pmu_reset;
@@ -1637,6 +1644,7 @@ static void krait_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	bool venum_event = EVENT_VENUM(hwc->config_base);
 	bool krait_event = EVENT_CPU(hwc->config_base);
 
+	armv7pmu_clear_event_idx(cpuc, event);
 	if (venum_event || krait_event) {
 		bit = krait_event_to_bit(event, region, group);
 		clear_bit(bit, cpuc->used_mask);
@@ -1966,6 +1974,7 @@ static void scorpion_pmu_clear_event_idx(struct pmu_hw_events *cpuc,
 	bool venum_event = EVENT_VENUM(hwc->config_base);
 	bool scorpion_event = EVENT_CPU(hwc->config_base);
 
+	armv7pmu_clear_event_idx(cpuc, event);
 	if (venum_event || scorpion_event) {
 		bit = scorpion_event_to_bit(event, region, group);
 		clear_bit(bit, cpuc->used_mask);
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index 942230f..f6cdcac 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -292,6 +292,12 @@ xscale1pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	}
 }
 
+static void xscalepmu_clear_event_idx(struct pmu_hw_events *cpuc,
+				     struct perf_event *event)
+{
+	clear_bit(event->hw.idx, cpuc->used_mask);
+}
+
 static void xscale1pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags, val;
@@ -370,6 +376,7 @@ static int xscale1pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter	= xscale1pmu_read_counter;
 	cpu_pmu->write_counter	= xscale1pmu_write_counter;
 	cpu_pmu->get_event_idx	= xscale1pmu_get_event_idx;
+	cpu_pmu->clear_event_idx = xscalepmu_clear_event_idx;
 	cpu_pmu->start		= xscale1pmu_start;
 	cpu_pmu->stop		= xscale1pmu_stop;
 	cpu_pmu->map_event	= xscale_map_event;
@@ -738,6 +745,7 @@ static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter	= xscale2pmu_read_counter;
 	cpu_pmu->write_counter	= xscale2pmu_write_counter;
 	cpu_pmu->get_event_idx	= xscale2pmu_get_event_idx;
+	cpu_pmu->clear_event_idx = xscalepmu_clear_event_idx;
 	cpu_pmu->start		= xscale2pmu_start;
 	cpu_pmu->stop		= xscale2pmu_stop;
 	cpu_pmu->map_event	= xscale_map_event;
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 66a2ffd..ac66851 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -778,6 +778,12 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return -EAGAIN;
 }
 
+static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
+				  struct perf_event *event)
+{
+	clear_bit(event->hw.idx, cpuc->used_mask);
+}
+
 /*
  * Add an event filter to a given event. This will only work for PMUv2 PMUs.
  */
@@ -956,6 +962,7 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter		= armv8pmu_read_counter,
 	cpu_pmu->write_counter		= armv8pmu_write_counter,
 	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
+	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx,
 	cpu_pmu->start			= armv8pmu_start,
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 8cad6b5..a288810 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -238,11 +238,10 @@ armpmu_del(struct perf_event *event, int flags)
 
 	armpmu_stop(event, PERF_EF_UPDATE);
 	hw_events->events[idx] = NULL;
-	clear_bit(idx, hw_events->used_mask);
-	if (armpmu->clear_event_idx)
-		armpmu->clear_event_idx(hw_events, event);
-
+	armpmu->clear_event_idx(hw_events, event);
 	perf_event_update_userpage(event);
+	/* Clear the allocated counter */
+	hwc->idx = -1;
 }
 
 static int
-- 
2.7.4

