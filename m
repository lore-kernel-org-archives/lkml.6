Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeDTLWa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 07:22:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52893 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbeDTLW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 07:22:28 -0400
Date: Fri, 20 Apr 2018 04:22:05 -0700
From: tip-bot for Oskar Senft <tipbot@zytor.com>
Message-ID: <tip-15a3e845b01ce2342cf187dc123c92c44c3c8170@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, osk@google.com,
        mingo@kernel.org, hpa@zytor.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, mark@voidzero.net
Reply-To: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        osk@google.com, hpa@zytor.com, kan.liang@intel.com, mark@voidzero.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <1521810690-2576-2-git-send-email-kan.liang@linux.intel.com>
References: <1521810690-2576-2-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Fix SBOX support for
 Broadwell CPUs
Git-Commit-ID: 15a3e845b01ce2342cf187dc123c92c44c3c8170
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  15a3e845b01ce2342cf187dc123c92c44c3c8170
Gitweb:     https://git.kernel.org/tip/15a3e845b01ce2342cf187dc123c92c44c3c8170
Author:     Oskar Senft <osk@google.com>
AuthorDate: Fri, 23 Mar 2018 09:11:30 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Apr 2018 13:17:50 +0200

perf/x86/intel/uncore: Fix SBOX support for Broadwell CPUs

SBOX on some Broadwell CPUs is broken because it's enabled unconditionally
despite the fact that there are no SBOXes available.

Check the Power Control Unit CAPID4 register to determine the number of
available SBOXes on the particular CPU before trying to enable them. If
there are none, nullify the SBOX descriptor so it isn't tried to be
initialized.

Signed-off-by: Oskar Senft <osk@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mark van Dijk <mark@voidzero.net>
Reviewed-by: Kan Liang <kan.liang@intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: ak@linux.intel.com
Cc: peterz@infradead.org
Cc: eranian@google.com
Link: https://lkml.kernel.org/r/1521810690-2576-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 5bbbbee11879..77076a102e34 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3060,14 +3060,25 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
 
 void bdx_uncore_cpu_init(void)
 {
+	int pkg = topology_phys_to_logical_pkg(0);
+
 	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 	uncore_msr_uncores = bdx_msr_uncores;
 
 	/* BDX-DE doesn't have SBOX */
-	if (boot_cpu_data.x86_model == 86)
+	if (boot_cpu_data.x86_model == 86) {
 		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+	/* Detect systems with no SBOXes */
+	} else if (uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3]) {
+		struct pci_dev *pdev;
+		u32 capid4;
 
+		pdev = uncore_extra_pci_dev[pkg].dev[HSWEP_PCI_PCU_3];
+		pci_read_config_dword(pdev, 0x94, &capid4);
+		if (((capid4 >> 6) & 0x3) == 0)
+			bdx_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+	}
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
 }
 
@@ -3285,6 +3296,11 @@ static const struct pci_device_id bdx_uncore_pci_ids[] = {
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
 
