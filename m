Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeC2WaX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:30:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:60714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751868AbeC2W3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:29:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="28690099"
From: Vikas Shivappa <vikas.shivappa@linux.intel.com>
To: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, ak@linux.intel.com,
        vikas.shivappa@linux.intel.com
Subject: [PATCH 4/6] x86/intel_rdt/mba_sc: Add schemata support
Date: Thu, 29 Mar 2018 15:26:14 -0700
Message-Id: <1522362376-3505-5-git-send-email-vikas.shivappa@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently user specifies the maximum memory bandwidth percentage per
domain in the "schemata" file. When user updates the schemata, kernel
writes the corresponding b/w percentage values to the
IA32_MBA_THRTL_MSR.

When MBA is expressed in MegaBytes(MB), the schemata format is changed
to have the per package memory b/w in MB instead of being specified in
b/w percentage. The b/w percentage values are only <= 100 and the b/w in
MB could be upto U32_MAX. We do not write the MSRs when the schemata is
updated as that is handled separately after the m/w in MB is converted
to b/w in percentage values.

Signed-off-by: Vikas Shivappa <vikas.shivappa@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 10 +++++++++-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 10 ++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 8a32561..8a12d26 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -179,7 +179,7 @@ struct rdt_resource rdt_resources_all[] = {
 		.msr_update		= mba_wrmsr,
 		.cache_level		= 3,
 		.parse_ctrlval		= parse_bw,
-		.format_str		= "%d=%*d",
+		.format_str		= "%d=%*u",
 		.fflags			= RFTYPE_RES_MB,
 	},
 };
@@ -356,6 +356,14 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
 {
 	unsigned int i;
 
+	/*
+	 * The ctrl_val should not be written when
+	 * MBA is expressed in Megabytes because the Megabyte value
+	 * need to be first converted to delay values that can be
+	 * programmed to the MSR.
+	 */
+	WARN_ON(is_mba_MBctrl());
+
 	/*  Write the delay values for mba. */
 	for (i = m->low; i < m->high; i++)
 		wrmsrl(r->msr_base + i, delay_bw_map(d->ctrl_val[i], r));
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 23e1d5c..6372e4f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -53,7 +53,8 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
+	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
+	    !is_mba_MBctrl()) {
 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
 				    r->membw.min_bw, r->default_ctrl);
 		return false;
@@ -194,7 +195,12 @@ static int update_domains(struct rdt_resource *r, int closid)
 			d->ctrl_val[closid] = d->new_ctrl;
 		}
 	}
-	if (cpumask_empty(cpu_mask))
+
+	/*
+	 * Avoid writing the control msr with control values when
+	 * MBA is expressed in Megabytes.
+	*/
+	if (cpumask_empty(cpu_mask) || is_mba_MBctrl())
 		goto done;
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
-- 
1.9.1
