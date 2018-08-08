Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9121321A18
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9121321A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeHHRmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:42:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:19265 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHRmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:42:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 08:21:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,458,1531810800"; 
   d="scan'208";a="222982663"
Received: from otc-kbl-h-01.jf.intel.com ([10.54.55.131])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2018 08:21:50 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 1/3] perf/x86/intel: Factor out common code of PMI handler
Date:   Wed,  8 Aug 2018 00:12:06 -0700
Message-Id: <1533712328-2834-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Arch Perfmon v4 PMI handler is substantially different than
the older PMI handler. Instead of adding more and more ifs cleanly
fork the new handler into a new function, with the main common
code factored out into a common function.

Fix complaint from checkpatch.pl by removing "false" from "static bool
warned".

No functional change.

Based-on-code-from: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 arch/x86/events/intel/core.c | 109 ++++++++++++++++++++++++-------------------
 1 file changed, 60 insertions(+), 49 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e2d36491..a7d7759 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2200,59 +2200,15 @@ static void intel_pmu_reset(void)
 	local_irq_restore(flags);
 }
 
-/*
- * This handler is triggered by the local APIC, so the APIC IRQ handling
- * rules apply:
- */
-static int intel_pmu_handle_irq(struct pt_regs *regs)
+static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
 	struct perf_sample_data data;
-	struct cpu_hw_events *cpuc;
-	int bit, loops;
-	u64 status;
-	int handled;
-	int pmu_enabled;
-
-	cpuc = this_cpu_ptr(&cpu_hw_events);
-
-	/*
-	 * Save the PMU state.
-	 * It needs to be restored when leaving the handler.
-	 */
-	pmu_enabled = cpuc->enabled;
-	/*
-	 * No known reason to not always do late ACK,
-	 * but just in case do it opt-in.
-	 */
-	if (!x86_pmu.late_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
-	intel_bts_disable_local();
-	cpuc->enabled = 0;
-	__intel_pmu_disable_all();
-	handled = intel_pmu_drain_bts_buffer();
-	handled += intel_bts_interrupt();
-	status = intel_pmu_get_status();
-	if (!status)
-		goto done;
-
-	loops = 0;
-again:
-	intel_pmu_lbr_read();
-	intel_pmu_ack_status(status);
-	if (++loops > 100) {
-		static bool warned = false;
-		if (!warned) {
-			WARN(1, "perfevents: irq loop stuck!\n");
-			perf_event_print_debug();
-			warned = true;
-		}
-		intel_pmu_reset();
-		goto done;
-	}
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int bit;
+	int handled = 0;
 
 	inc_irq_stat(apic_perf_irqs);
 
-
 	/*
 	 * Ignore a range of extra bits in status that do not indicate
 	 * overflow by themselves.
@@ -2261,7 +2217,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 		    GLOBAL_STATUS_ASIF |
 		    GLOBAL_STATUS_LBRS_FROZEN);
 	if (!status)
-		goto done;
+		return 0;
 	/*
 	 * In case multiple PEBS events are sampled at the same time,
 	 * it is possible to have GLOBAL_STATUS bit 62 set indicating
@@ -2331,6 +2287,61 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 			x86_pmu_stop(event, 0);
 	}
 
+	return handled;
+}
+
+/*
+ * This handler is triggered by the local APIC, so the APIC IRQ handling
+ * rules apply:
+ */
+static int intel_pmu_handle_irq(struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc;
+	int loops;
+	u64 status;
+	int handled;
+	int pmu_enabled;
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * Save the PMU state.
+	 * It needs to be restored when leaving the handler.
+	 */
+	pmu_enabled = cpuc->enabled;
+	/*
+	 * No known reason to not always do late ACK,
+	 * but just in case do it opt-in.
+	 */
+	if (!x86_pmu.late_ack)
+		apic_write(APIC_LVTPC, APIC_DM_NMI);
+	intel_bts_disable_local();
+	cpuc->enabled = 0;
+	__intel_pmu_disable_all();
+	handled = intel_pmu_drain_bts_buffer();
+	handled += intel_bts_interrupt();
+	status = intel_pmu_get_status();
+	if (!status)
+		goto done;
+
+	loops = 0;
+again:
+	intel_pmu_lbr_read();
+	intel_pmu_ack_status(status);
+	if (++loops > 100) {
+		static bool warned;
+
+		if (!warned) {
+			WARN(1, "perfevents: irq loop stuck!\n");
+			perf_event_print_debug();
+			warned = true;
+		}
+		intel_pmu_reset();
+		goto done;
+	}
+
+	handled += handle_pmi_common(regs, status);
+
 	/*
 	 * Repeat if there is more work to be done:
 	 */
-- 
2.7.4

