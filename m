Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbeBBNuP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:50:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:38331 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752007AbeBBNtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:49:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="14968356"
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: platform-driver-x86@vger.kernel.org
Cc: dvhart@infradead.org, andy@infradead.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com, srinivas.pandruvada@linux.intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Subject: [Patch v2 5/5] platform/x86: intel_pmc_core: Special case for Coffeelake
Date: Fri,  2 Feb 2018 19:13:37 +0530
Message-Id: <1517579017-19935-6-git-send-email-rajneesh.bhardwaj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
References: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel CoffeeLake SoC uses CPU ID of KabyLake but has Cannonlake PCH, so in
this case PMC register details from Cannonlake PCH must be used.

In order to identify whether the given platform is Coffeelake, scan for the
Sunrisepoint PMC PCI Id.

		KBL CPUID	SPT PCIID
-------------------------------------
KBL	|	Y	|	Y	|
-------------------------------------
CFL	|	Y	|	N	|
-------------------------------------

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index a255c4b0f7a8..b89bef140c8b 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
@@ -537,6 +538,11 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
 
+static const struct pci_device_id pmc_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, SPT_PMC_PCI_DEVICE_ID), 0},
+	{ 0, },
+};
+
 static int __init pmc_core_probe(void)
 {
 	struct pmc_dev *pmcdev = &pmc;
@@ -550,6 +556,14 @@ static int __init pmc_core_probe(void)
 
 	pmcdev->map = (struct pmc_reg_map *)cpu_id->driver_data;
 
+	/*
+	 * Coffeelake has CPU ID of Kabylake and Cannonlake PCH. So here
+	 * Sunrisepoint PCH regmap can't be used. Use Cannonlake PCH regmap
+	 * in this case.
+	 */
+	if (!pci_dev_present(pmc_pci_ids))
+		pmcdev->map = (struct pmc_reg_map *)&cnp_reg_map;
+
 	if (lpit_read_residency_count_address(&slp_s0_addr))
 		pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
 	else
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 8b7731e6dea2..5fa5f97870aa 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -23,6 +23,8 @@
 
 #define PMC_BASE_ADDR_DEFAULT			0xFE000000
 
+/* Sunrise Point Power Management Controller PCI Device ID */
+#define SPT_PMC_PCI_DEVICE_ID			0x9d21
 #define SPT_PMC_BASE_ADDR_OFFSET		0x48
 #define SPT_PMC_SLP_S0_RES_COUNTER_OFFSET	0x13c
 #define SPT_PMC_PM_CFG_OFFSET			0x18
-- 
2.7.4
