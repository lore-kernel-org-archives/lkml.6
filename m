Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCWNMt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:12:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:57827 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbeCWNMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:12:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,350,1517904000";
   d="scan'208";a="37536727"
From: Kan Liang <kan.liang@linux.intel.com>
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: eranian@google.com, osk@google.com, mark@voidzero.net,
        ak@linux.intel.com
Subject: [RESEND PATCH 2/2] perf/x86/intel/uncore: Fix SBOX support for Broadwell CPUs
Date: Fri, 23 Mar 2018 09:11:30 -0400
Message-Id: <1521810690-2576-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1521810690-2576-1-git-send-email-kan.liang@linux.intel.com>
References: <1521810690-2576-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oskar Senft <osk@google.com>

This fixes SBOX support for Broadwell CPUs by checking the Power Control
Unit CAPID4 register to determine the number of available SBOXes on the
particular CPU before trying to enable them.

Signed-off-by: Oskar Senft <osk@google.com>
Tested-by: Mark van Dijk <mark@voidzero.net>
Reviewed-by: Kan Liang <kan.liang@intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 47c6910..715eb14 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3060,6 +3060,8 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
+	int pkg = topology_phys_to_logical_pkg(0);
+
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 	uncore_msr_uncores = bdx_msr_uncores;
@@ -3067,7 +3069,15 @@ void bdx_uncore_cpu_init(void)
 	/* BDX-DE doesn't have SBOX */
 	if (boot_cpu_data.x86_model == 86)
 		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
-
+	/* Detect systems with no SBOXes */
+	else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
+		u32 capid4;
+		pci_read_config_dword(
+			uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3],
+			0x94, &capid4);
+		if (((capid4 >> 6) & 0x3) == 0)
+			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+	}
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
 }
 
@@ -3285,6 +3295,11 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6f46),
 		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV, 2),
 	},
+	{ /* PCU.3 (for Capability registers) */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x6fc0),
+		.driver_data = UNCORE_PCI_DEV_DATA(UNCORE_EXTRA_PCI_DEV,
+						   HSWEP_PCI_PCU_3),
+	},
 	{ /* end: all zeroes */ }
 };
 
-- 
2.4.11
