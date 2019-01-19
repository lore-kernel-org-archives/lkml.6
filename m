Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED6FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059942177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfA2HGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:06:38 -0500
Received: from mga01.intel.com ([192.55.52.88]:44929 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfA2HGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:06:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 23:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,536,1539673200"; 
   d="scan'208";a="129738115"
Received: from vmm.bj.intel.com ([10.240.192.123])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2019 23:06:32 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, songliubraving@fb.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, zsm@chromium.org,
        alexander.shishkin@linux.intel.com, konrad.wilk@oracle.com,
        ak@linux.intel.com, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH 2/3] perf/x86/intel/pt: Inject PMI for KVM guest
Date:   Sat, 19 Jan 2019 15:04:43 -0500
Message-Id: <1547928284-2915-3-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547928284-2915-1-git-send-email-luwei.kang@intel.com>
References: <1547928284-2915-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject a PMI for KVM guest when Intel PT working
in Host-Guest mode and Guest ToPA entry memory buffer
was completely filled.

The definition of ‘kvm_make_request’ and ‘KVM_REQ_PMI’
depend on "linux/kvm_host.h" header.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.c       | 12 +++++++++++-
 arch/x86/include/asm/intel_pt.h  |  1 +
 arch/x86/include/asm/msr-index.h |  4 ++++
 arch/x86/kvm/x86.h               |  6 ++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 9494ca6..09375bd 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/kvm_host.h>
 
 #include <asm/perf_event.h>
 #include <asm/insn.h>
@@ -33,7 +34,8 @@
 #include "../perf_event.h"
 #include "pt.h"
 
-static DEFINE_PER_CPU(struct pt, pt_ctx);
+DEFINE_PER_CPU(struct pt, pt_ctx);
+EXPORT_PER_CPU_SYMBOL_GPL(pt_ctx);
 
 static struct pt_pmu pt_pmu;
 
@@ -1260,6 +1262,14 @@ void intel_pt_interrupt(void)
 	struct pt_buffer *buf;
 	struct perf_event *event = pt->handle.event;
 
+	if (pt->vcpu) {
+		/* Inject PMI to Guest */
+		kvm_make_request(KVM_REQ_PMI, pt->vcpu);
+		__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+			(unsigned long *)&pt->vcpu->arch.pmu.global_status);
+		return;
+	}
+
 	/*
 	 * There may be a dangling PT bit in the interrupt status register
 	 * after PT has been disabled by pt_event_stop(). Make sure we don't
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index ee960fb..32da2e9 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -62,6 +62,7 @@ struct pt {
 	struct pt_filters       filters;
 	int                     handle_nmi;
 	int                     vmx_on;
+	struct kvm_vcpu         *vcpu;
 };
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 8e40c24..ae01fb0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -775,6 +775,10 @@
 #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
 
+/* PERF_GLOBAL_OVF_CTL bits */
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55
+#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
+
 /* Geode defined MSRs */
 #define MSR_GEODE_BUSCONT_CONF0		0x00001900
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 224cd0a..a9ee498 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -4,6 +4,7 @@
 
 #include <linux/kvm_host.h>
 #include <asm/pvclock.h>
+#include <asm/intel_pt.h>
 #include "kvm_cache_regs.h"
 
 #define KVM_DEFAULT_PLE_GAP		128
@@ -331,15 +332,20 @@ static inline bool kvm_pause_in_guest(struct kvm *kvm)
 }
 
 DECLARE_PER_CPU(struct kvm_vcpu *, current_vcpu);
+DECLARE_PER_CPU(struct pt, pt_ctx);
 
 static inline void kvm_before_interrupt(struct kvm_vcpu *vcpu)
 {
 	__this_cpu_write(current_vcpu, vcpu);
+	if (kvm_x86_ops->pt_supported())
+		this_cpu_ptr(&pt_ctx)->vcpu = vcpu;
 }
 
 static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
 {
 	__this_cpu_write(current_vcpu, NULL);
+	if (kvm_x86_ops->pt_supported())
+		this_cpu_ptr(&pt_ctx)->vcpu = NULL;
 }
 
 #endif
-- 
1.8.3.1

