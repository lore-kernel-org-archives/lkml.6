Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7839C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C53620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C53620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeKATiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:38:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:52047 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeKATiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:38:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 03:36:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,451,1534834800"; 
   d="scan'208";a="100601954"
Received: from devel-ww.sh.intel.com ([10.239.48.119])
  by fmsmga002.fm.intel.com with ESMTP; 01 Nov 2018 03:36:25 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        wei.w.wang@intel.com
Subject: [PATCH v1 2/8] perf/x86/intel: add pmi callback support
Date:   Thu,  1 Nov 2018 18:04:02 +0800
Message-Id: <1541066648-40690-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
References: <1541066648-40690-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the pmi callback support for the counters reserved by
components outside the perf core. For example, a hypervisor may register
such a callback to get the guest notified about the receiving of the
pmi.

The host PMI handling requires the active_events to be non-zero, so we
need active_events to be at least 1 in x86_perf_mask_perf_counters when
there are counters used by the guest.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/events/core.c            | 10 ++++++++++
 arch/x86/events/intel/core.c      | 27 +++++++++++++++++++++++++++
 arch/x86/events/perf_event.h      |  4 ++++
 arch/x86/include/asm/perf_event.h |  5 +++++
 4 files changed, 46 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e73135a..504d102 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2408,6 +2408,16 @@ void x86_perf_mask_perf_counters(u64 mask)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	/*
+	 * Increment active_events by 1 if there are counters reserved for
+	 * the guest to use, and no need to do more increments if there are
+	 * already counters taken by the guest.
+	 */
+	if (!cpuc->intel_ctrl_guest_mask && mask)
+		atomic_inc(&active_events);
+	else if (cpuc->intel_ctrl_guest_mask && !mask)
+		atomic_dec(&active_events);
+
+	/*
 	 * If the counter happens to be used by a host event, take it back
 	 * first, and then restart the pmu after mask that counter as being
 	 * reserved.
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0fb8659..f5e5191 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2283,6 +2283,13 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	status |= cpuc->intel_cp_status;
 
+	if (status & cpuc->intel_ctrl_guest_mask) {
+		cpuc->pmi_callback(cpuc->pmi_opaque,
+				   status & cpuc->intel_ctrl_guest_mask);
+		status &= ~cpuc->intel_ctrl_guest_mask;
+		handled++;
+	}
+
 	for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
 		struct perf_event *event = cpuc->events[bit];
 
@@ -3162,6 +3169,26 @@ struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 }
 EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
 
+void x86_perf_register_pmi_callback(pmi_callback_t callback, void *opaque)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->pmi_callback = callback;
+	cpuc->pmi_opaque = opaque;
+
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+}
+EXPORT_SYMBOL_GPL(x86_perf_register_pmi_callback);
+
+void x86_perf_unregister_pmi_callback(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->pmi_callback = NULL;
+	cpuc->pmi_opaque = NULL;
+}
+EXPORT_SYMBOL_GPL(x86_perf_unregister_pmi_callback);
+
 static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index adae087..06404eb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -197,6 +197,10 @@ struct cpu_hw_events {
 	unsigned int		txn_flags;
 	int			is_fake;
 
+	/* PMI related fields */
+	pmi_callback_t			pmi_callback;
+	void				*pmi_opaque;
+
 	/*
 	 * Intel DebugStore bits
 	 */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5b4463e..fd33688 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -275,6 +275,8 @@ struct perf_guest_switch_msr {
 	u64 host, guest;
 };
 
+typedef void (*pmi_callback_t)(void *opaque, u64 status);
+
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
@@ -298,6 +300,9 @@ static inline void perf_check_microcode(void) { }
 #ifdef CONFIG_CPU_SUP_INTEL
  extern void intel_pt_handle_vmx(int on);
 extern void x86_perf_mask_perf_counters(u64 mask);
+extern void x86_perf_register_pmi_callback(pmi_callback_t callback,
+					   void *opaque);
+extern void x86_perf_unregister_pmi_callback(void);
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
-- 
2.7.4

