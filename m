Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbeENNfh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:35:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932244AbeENNfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:35:02 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pawel.moll@arm.com, suzuki.poulose@arm.com
Subject: [PATCH v2 3/3] perf/arm-cci: Allow building as a module
Date: Mon, 14 May 2018 14:34:53 +0100
Message-Id: <92a35ec316251b0ac9ba01fd9c6b32a1d024a8ed.1526303815.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.0.dirty
In-Reply-To: <cover.1526303815.git.robin.murphy@arm.com>
References: <cover.1526303815.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in the few extra bits and annotations needed to make the driver
work properly as a module, and jiggle the Kconfig to expose the
driver-level ARM_CCI_PMU option.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Move ARM/64 dependency up accordingly

 drivers/perf/Kconfig   | 34 ++++++++++++++++++----------------
 drivers/perf/arm-cci.c | 17 ++++++++++++++++-
 2 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 28bb5a029558..110330ecf714 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -6,30 +6,32 @@ menu "Performance monitor support"
 	depends on PERF_EVENTS
 
 config ARM_CCI_PMU
-	bool
+	tristate "ARM CCI PMU driver"
+	depends on (ARM && CPU_V7) || ARM64
 	select ARM_CCI
+	help
+	  Support for PMU events monitoring on the ARM CCI (Cache Coherent
+	  Interconnect) family of products.
+
+	  If compiled as a module, it will be called arm-cci.
 
 config ARM_CCI400_PMU
-	bool "ARM CCI400 PMU support"
-	depends on (ARM && CPU_V7) || ARM64
+	bool "support CCI-400"
+	default y
+	depends on ARM_CCI_PMU
 	select ARM_CCI400_COMMON
-	select ARM_CCI_PMU
 	help
-	  Support for PMU events monitoring on the ARM CCI-400 (cache coherent
-	  interconnect). CCI-400 supports counting events related to the
-	  connected slave/master interfaces.
+	  CCI-400 provides 4 independent event counters counting events related
+	  to the connected slave/master interfaces, plus a cycle counter.
 
 config ARM_CCI5xx_PMU
-	bool "ARM CCI-500/CCI-550 PMU support"
-	depends on (ARM && CPU_V7) || ARM64
-	select ARM_CCI_PMU
+	bool "support CCI-500/CCI-550"
+	default y
+	depends on ARM_CCI_PMU
 	help
-	  Support for PMU events monitoring on the ARM CCI-500/CCI-550 cache
-	  coherent interconnects. Both of them provide 8 independent event counters,
-	  which can count events pertaining to the slave/master interfaces as well
-	  as the internal events to the CCI.
-
-	  If unsure, say Y
+	  CCI-500/CCI-550 both provide 8 independent event counters, which can
+	  count events pertaining to the slave/master interfaces as well as the
+	  internal events to the CCI.
 
 config ARM_CCN
 	tristate "ARM CCN driver support"
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 7029d8fe8f44..09938dd8eb6f 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1416,6 +1416,7 @@ static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
 	pmu_format_attr_group.attrs = model->format_attrs;
 
 	cci_pmu->pmu = (struct pmu) {
+		.module		= THIS_MODULE,
 		.name		= cci_pmu->model->name,
 		.task_ctx_nr	= perf_invalid_context,
 		.pmu_enable	= cci_pmu_enable,
@@ -1581,6 +1582,7 @@ static const struct of_device_id arm_cci_pmu_matches[] = {
 #endif
 	{},
 };
+MODULE_DEVICE_TABLE(of, arm_cci_pmu_matches);
 
 static bool is_duplicate_irq(int irq, int *irqs, int nr_irqs)
 {
@@ -1702,14 +1704,27 @@ static int cci_pmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int cci_pmu_remove(struct platform_device *pdev)
+{
+	if (!g_cci_pmu)
+		return 0;
+
+	cpuhp_remove_state(CPUHP_AP_PERF_ARM_CCI_ONLINE);
+	perf_pmu_unregister(&g_cci_pmu->pmu);
+	g_cci_pmu = NULL;
+
+	return 0;
+}
+
 static struct platform_driver cci_pmu_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = arm_cci_pmu_matches,
 		  },
 	.probe = cci_pmu_probe,
+	.remove = cci_pmu_remove,
 };
 
-builtin_platform_driver(cci_pmu_driver);
+module_platform_driver(cci_pmu_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ARM CCI PMU support");
-- 
2.17.0.dirty
