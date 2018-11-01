Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C22C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36F92081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36F92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeKATiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:38:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbeKATit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:38:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100601943"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:23 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 1/8] perf/x86: add support to mask counters from host
Date:   Thu,  1 Nov 2018 18:04:01 +0800
Message-Id: <1541066648-40690-2-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add x86_perf_mask_perf_counters to reserve counters from the host perf
subsystem. The masked counters will not be assigned to any host perf
events. This can be used by the hypervisor to reserve perf counters for
a guest to use.

This function is currently supported on Intel CPUs only, but put in x86
perf core because the counter assignment is implemented here and we need
to re-enable the pmu which is defined in the x86 perf core in the case
that a counter to be masked happens to be used by the host.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/events/core.c            | 37 +++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 106911b..e73135a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -716,6 +716,7 @@ struct perf_sched {
 static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
 			    int num, int wmin, int wmax, int gpmax)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int idx;
 
 	memset(sched, 0, sizeof(*sched));
@@ -723,6 +724,9 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
 	sched->max_weight	= wmax;
 	sched->max_gp		= gpmax;
 	sched->constraints	= constraints;
+#ifdef CONFIG_CPU_SUP_INTEL
+	sched->state.used[0]	= cpuc->intel_ctrl_guest_mask;
+#endif
 
 	for (idx = 0; idx < num; idx++) {
 		if (constraints[idx]->weight == wmin)
@@ -2386,6 +2390,39 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 	}
 }
 
+#ifdef CONFIG_CPU_SUP_INTEL
+/**
+ * x86_perf_mask_perf_counters - mask perf counters
+ * @mask: the bitmask of counters
+ *
+ * Mask the perf counters that are not available to be used by the perf core.
+ * If the counter to be masked has been assigned, it will be taken back and
+ * then the perf core will re-assign usable counters to its events.
+ *
+ * This can be used by a component outside the perf core to reserve counters.
+ * For example, a hypervisor uses it to reserve counters for a guest to use,
+ * and later return the counters by another call with the related bits cleared.
+ */
+void x86_perf_mask_perf_counters(u64 mask)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	/*
+	 * If the counter happens to be used by a host event, take it back
+	 * first, and then restart the pmu after mask that counter as being
+	 * reserved.
+	 */
+	if (mask & cpuc->intel_ctrl_host_mask) {
+		perf_pmu_disable(&pmu);
+		cpuc->intel_ctrl_guest_mask = mask;
+		perf_pmu_enable(&pmu);
+	} else {
+		cpuc->intel_ctrl_guest_mask = mask;
+	}
+}
+EXPORT_SYMBOL_GPL(x86_perf_mask_perf_counters);
+#endif
+
 static inline int
 valid_user_frame(const void __user *fp, unsigned long size)
 {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8bdf749..5b4463e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -297,6 +297,7 @@ static inline void perf_check_microcode(void) { }
 
 #ifdef CONFIG_CPU_SUP_INTEL
  extern void intel_pt_handle_vmx(int on);
+extern void x86_perf_mask_perf_counters(u64 mask);
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
-- 
2.7.4

