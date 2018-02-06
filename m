Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBFO1G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:27:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34422 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeBFO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:26:35 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 1/3] drivers/perf: arm_pmu: Add platform hardware setup hooks.
Date: Tue,  6 Feb 2018 15:26:27 +0100
Message-Id: <20180206142629.534-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
References: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow platform specific code to be called when enabling or
disabling the hardware.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
[rebased to v4.12]
Signed-off-by: Nandor Han <nandor.han@ge.com>
[Simplify and cleanup for upstreaming]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/perf/arm_pmu.c       | 12 ++++++++++++
 include/linux/perf/arm_pmu.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 7bc5eee96b31..9c282914ee67 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -452,8 +452,10 @@ static int armpmu_event_init(struct perf_event *event)
 static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
 	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
+	int err;
 
 	/* For task-bound events we may be called on other CPUs */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
@@ -461,17 +463,27 @@ static void armpmu_enable(struct pmu *pmu)
 
 	if (enabled)
 		armpmu->start(armpmu);
+
+	if (platdata && platdata->reserve_hardware) {
+		err = platdata->reserve_hardware(armpmu);
+		if (err)
+			dev_warn(&armpmu->plat_device->dev, "Could not reserve PMU hardware!\n");
+	}
 }
 
 static void armpmu_disable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
+	struct arm_pmu_platdata *platdata = armpmu_get_platdata(armpmu);
 
 	/* For task-bound events we may be called on other CPUs */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
 		return;
 
 	armpmu->stop(armpmu);
+
+	if (platdata && platdata->release_hardware)
+		platdata->release_hardware(armpmu);
 }
 
 /*
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index af0f44effd44..942ae9bfe971 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -17,6 +17,8 @@
 #include <linux/sysfs.h>
 #include <asm/cputype.h>
 
+struct arm_pmu;
+
 /*
  * struct arm_pmu_platdata - ARM PMU platform data
  *
@@ -31,6 +33,8 @@
 struct arm_pmu_platdata {
 	irqreturn_t (*handle_irq)(int irq, void *dev,
 				  irq_handler_t pmu_handler);
+	int (*reserve_hardware)(struct arm_pmu *arm_pmu);
+	void (*release_hardware)(struct arm_pmu *arm_pmu);
 	unsigned long irq_flags;
 };
 
@@ -112,6 +116,7 @@ struct arm_pmu {
 	int		(*map_event)(struct perf_event *event);
 	int		num_events;
 	u64		max_period;
+	bool		reserved_hardware;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
-- 
2.15.1
