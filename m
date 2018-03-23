Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCWNMo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 09:12:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:57827 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeCWNMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 09:12:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,350,1517904000";
   d="scan'208";a="37536720"
From: Kan Liang <kan.liang@linux.intel.com>
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: eranian@google.com, osk@google.com, mark@voidzero.net,
        ak@linux.intel.com
Subject: [RESEND PATCH 1/2] perf/x86/intel/uncore: Revert "Remove SBOX support for Broadwell server"
Date: Fri, 23 Mar 2018 09:11:29 -0400
Message-Id: <1521810690-2576-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

This reverts commit 3b94a891667c ("perf/x86/intel/uncore: Remove
SBOX support for Broadwell server")

Rvert because we have a workaround for Broadwell-EP servers without
SBOX (subsequent patch). Note that BDX-DE does not have a SBOX.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Kan Liang <kan.liang@intel.com>
---

Here is the original patch set.
https://lkml.org/lkml/2016/11/15/611
Only rebase with lastest code.

 arch/x86/events/intel/uncore_snbep.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 22ec65b..47c6910 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3028,10 +3028,27 @@ static struct intel_uncore_type bdx_uncore_cbox = {
 	.format_group		= &hswep_uncore_cbox_format_group,
 };
 
+static struct intel_uncore_type bdx_uncore_sbox = {
+	.name			= "sbox",
+	.num_counters		= 4,
+	.num_boxes		= 4,
+	.perf_ctr_bits		= 48,
+	.event_ctl		= HSWEP_S0_MSR_PMON_CTL0,
+	.perf_ctr		= HSWEP_S0_MSR_PMON_CTR0,
+	.event_mask		= HSWEP_S_MSR_PMON_RAW_EVENT_MASK,
+	.box_ctl		= HSWEP_S0_MSR_PMON_BOX_CTL,
+	.msr_offset		= HSWEP_SBOX_MSR_OFFSET,
+	.ops			= &hswep_uncore_sbox_msr_ops,
+	.format_group		= &hswep_uncore_sbox_format_group,
+};
+
+#define BDX_MSR_UNCORE_SBOX	3
+
 static struct intel_uncore_type *bdx_msr_uncores[] = {
 	&bdx_uncore_ubox,
 	&bdx_uncore_cbox,
 	&hswep_uncore_pcu,
+	&bdx_uncore_sbox,
 	NULL,
 };
 
@@ -3047,6 +3064,10 @@ void bdx_uncore_cpu_init(void)
 		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
 	uncore_msr_uncores = bdx_msr_uncores;
 
+	/* BDX-DE doesn't have SBOX */
+	if (boot_cpu_data.x86_model == 86)
+		uncore_msr_uncores[BDX_MSR_UNCORE_SBOX] = NULL;
+
 	hswep_uncore_pcu.constraints = bdx_uncore_pcu_constraints;
 }
 
-- 
2.4.11
