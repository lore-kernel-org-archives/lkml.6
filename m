Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754610AbeDTKnz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:43:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeDTKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:43:54 -0400
Date: Fri, 20 Apr 2018 03:43:15 -0700
From: tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-d7717587ac6deae00e0b66c0113a046be2c6fb1c@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        kan.liang@intel.com, eranian@google.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, kan.liang@intel.com, eranian@google.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com
In-Reply-To: <1521810690-2576-1-git-send-email-kan.liang@linux.intel.com>
References: <1521810690-2576-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Revert "Remove SBOX
 support for Broadwell server"
Git-Commit-ID: d7717587ac6deae00e0b66c0113a046be2c6fb1c
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

Commit-ID:  d7717587ac6deae00e0b66c0113a046be2c6fb1c
Gitweb:     https://git.kernel.org/tip/d7717587ac6deae00e0b66c0113a046be2c6fb1c
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Fri, 23 Mar 2018 09:11:29 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Apr 2018 12:41:17 +0200

perf/x86/intel/uncore: Revert "Remove SBOX support for Broadwell server"

This reverts commit 3b94a891667c ("perf/x86/intel/uncore: Remove
SBOX support for Broadwell server")

Revert because there exists a proper workaround for Broadwell-EP servers
without SBOX now. Note that BDX-DE does not have a SBOX.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kan Liang <kan.liang@intel.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: ak@linux.intel.com
Cc: osk@google.com
Cc: mark@voidzero.net
Link: https://lkml.kernel.org/r/1521810690-2576-1-git-send-email-kan.liang@linux.intel.com

---
 arch/x86/events/intel/uncore_snbep.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index c98b943e58b4..5bbbbee11879 100644
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
 
