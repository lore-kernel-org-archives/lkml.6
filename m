Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0EFC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18782183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 07:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfA2HGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 02:06:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:44929 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfA2HGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 02:06:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 23:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,536,1539673200"; 
   d="scan'208";a="129738102"
Received: from vmm.bj.intel.com ([10.240.192.123])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2019 23:06:28 -0800
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, songliubraving@fb.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, peterz@infradead.org, zsm@chromium.org,
        alexander.shishkin@linux.intel.com, konrad.wilk@oracle.com,
        ak@linux.intel.com, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH 1/3] perf/x86/intel/pt: Move pt structure to global header
Date:   Sat, 19 Jan 2019 15:04:42 -0500
Message-Id: <1547928284-2915-2-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547928284-2915-1-git-send-email-luwei.kang@intel.com>
References: <1547928284-2915-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT structure (struct pt) is in a private header.
Move it (and sub structure) to a global header so that
it can be accessible from KVM code.

The definition of perf_output_handle structure included
in "linux/perf_event.h".

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.h      | 38 --------------------------------------
 arch/x86/include/asm/intel_pt.h | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 269e15a..964948f 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -93,42 +93,4 @@ struct pt_buffer {
 	struct topa_entry	*topa_index[0];
 };
 
-#define PT_FILTERS_NUM	4
-
-/**
- * struct pt_filter - IP range filter configuration
- * @msr_a:	range start, goes to RTIT_ADDRn_A
- * @msr_b:	range end, goes to RTIT_ADDRn_B
- * @config:	4-bit field in RTIT_CTL
- */
-struct pt_filter {
-	unsigned long	msr_a;
-	unsigned long	msr_b;
-	unsigned long	config;
-};
-
-/**
- * struct pt_filters - IP range filtering context
- * @filter:	filters defined for this context
- * @nr_filters:	number of defined filters in the @filter array
- */
-struct pt_filters {
-	struct pt_filter	filter[PT_FILTERS_NUM];
-	unsigned int		nr_filters;
-};
-
-/**
- * struct pt - per-cpu pt context
- * @handle:	perf output handle
- * @filters:		last configured filters
- * @handle_nmi:	do handle PT PMI on this cpu, there's an active event
- * @vmx_on:	1 if VMX is ON on this cpu
- */
-struct pt {
-	struct perf_output_handle handle;
-	struct pt_filters	filters;
-	int			handle_nmi;
-	int			vmx_on;
-};
-
 #endif /* __INTEL_PT_H__ */
diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 634f99b..ee960fb 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_INTEL_PT_H
 #define _ASM_X86_INTEL_PT_H
 
+#include <linux/perf_event.h>
+
 #define PT_CPUID_LEAVES		2
 #define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
 
@@ -24,6 +26,44 @@ enum pt_capabilities {
 	PT_CAP_psb_periods,
 };
 
+#define PT_FILTERS_NUM 4
+
+/**
+ * struct pt_filter - IP range filter configuration
+ * @msr_a:     range start, goes to RTIT_ADDRn_A
+ * @msr_b:     range end, goes to RTIT_ADDRn_B
+ * @config:    4-bit field in RTIT_CTL
+ */
+struct pt_filter {
+	unsigned long   msr_a;
+	unsigned long   msr_b;
+	unsigned long   config;
+};
+
+/**
+ * struct pt_filters - IP range filtering context
+ * @filter:    filters defined for this context
+ * @nr_filters:        number of defined filters in the @filter array
+ */
+struct pt_filters {
+	struct pt_filter        filter[PT_FILTERS_NUM];
+	unsigned int            nr_filters;
+};
+
+/**
+ * struct pt - per-cpu pt context
+ * @handle:    perf output handle
+ * @filters:           last configured filters
+ * @handle_nmi:        do handle PT PMI on this cpu, there's an active event
+ * @vmx_on:    1 if VMX is ON on this cpu
+ */
+struct pt {
+	struct perf_output_handle handle;
+	struct pt_filters       filters;
+	int                     handle_nmi;
+	int                     vmx_on;
+};
+
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 void cpu_emergency_stop_pt(void);
 extern u32 intel_pt_validate_hw_cap(enum pt_capabilities cap);
-- 
1.8.3.1

