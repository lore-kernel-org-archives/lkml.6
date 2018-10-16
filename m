Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D40C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BC32089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BC32089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeJQAlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbeJQAlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C8B588312;
        Tue, 16 Oct 2018 16:50:20 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E45516BF7B;
        Tue, 16 Oct 2018 16:50:17 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 02/13] KVM: VMX: refactor evmcs_sanitize_exec_ctrls()
Date:   Tue, 16 Oct 2018 18:50:00 +0200
Message-Id: <20181016165011.6607-3-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 16 Oct 2018 16:50:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split off EVMCS1_UNSUPPORTED_* macros so we can re-use them when
enabling Enlightened VMCS for Hyper-V on KVM.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 108 ++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a9ed7a723a0c..509d4e34dd62 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1392,6 +1392,49 @@ DEFINE_STATIC_KEY_FALSE(enable_evmcs);
 
 #define KVM_EVMCS_VERSION 1
 
+/*
+ * Enlightened VMCSv1 doesn't support these:
+ *
+ *	POSTED_INTR_NV                  = 0x00000002,
+ *	GUEST_INTR_STATUS               = 0x00000810,
+ *	APIC_ACCESS_ADDR		= 0x00002014,
+ *	POSTED_INTR_DESC_ADDR           = 0x00002016,
+ *	EOI_EXIT_BITMAP0                = 0x0000201c,
+ *	EOI_EXIT_BITMAP1                = 0x0000201e,
+ *	EOI_EXIT_BITMAP2                = 0x00002020,
+ *	EOI_EXIT_BITMAP3                = 0x00002022,
+ *	GUEST_PML_INDEX			= 0x00000812,
+ *	PML_ADDRESS			= 0x0000200e,
+ *	VM_FUNCTION_CONTROL             = 0x00002018,
+ *	EPTP_LIST_ADDRESS               = 0x00002024,
+ *	VMREAD_BITMAP                   = 0x00002026,
+ *	VMWRITE_BITMAP                  = 0x00002028,
+ *
+ *	TSC_MULTIPLIER                  = 0x00002032,
+ *	PLE_GAP                         = 0x00004020,
+ *	PLE_WINDOW                      = 0x00004022,
+ *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
+ *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
+ *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
+ *
+ * Currently unsupported in KVM:
+ *	GUEST_IA32_RTIT_CTL		= 0x00002814,
+ */
+#define EVMCS1_UNSUPPORTED_PINCTRL (PIN_BASED_POSTED_INTR | \
+				    PIN_BASED_VMX_PREEMPTION_TIMER)
+#define EVMCS1_UNSUPPORTED_2NDEXEC					\
+	(SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |				\
+	 SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |			\
+	 SECONDARY_EXEC_APIC_REGISTER_VIRT |				\
+	 SECONDARY_EXEC_ENABLE_PML |					\
+	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
+	 SECONDARY_EXEC_SHADOW_VMCS |					\
+	 SECONDARY_EXEC_TSC_SCALING |					\
+	 SECONDARY_EXEC_PAUSE_LOOP_EXITING)
+#define EVMCS1_UNSUPPORTED_VMEXIT_CTRL (VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL)
+#define EVMCS1_UNSUPPORTED_VMENTRY_CTRL (VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL)
+#define EVMCS1_UNSUPPORTED_VMFUNC (VMX_VMFUNC_EPTP_SWITCHING)
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static bool __read_mostly enlightened_vmcs = true;
 module_param(enlightened_vmcs, bool, 0444);
@@ -1484,69 +1527,12 @@ static void evmcs_load(u64 phys_addr)
 
 static void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
 {
-	/*
-	 * Enlightened VMCSv1 doesn't support these:
-	 *
-	 *	POSTED_INTR_NV                  = 0x00000002,
-	 *	GUEST_INTR_STATUS               = 0x00000810,
-	 *	APIC_ACCESS_ADDR		= 0x00002014,
-	 *	POSTED_INTR_DESC_ADDR           = 0x00002016,
-	 *	EOI_EXIT_BITMAP0                = 0x0000201c,
-	 *	EOI_EXIT_BITMAP1                = 0x0000201e,
-	 *	EOI_EXIT_BITMAP2                = 0x00002020,
-	 *	EOI_EXIT_BITMAP3                = 0x00002022,
-	 */
-	vmcs_conf->pin_based_exec_ctrl &= ~PIN_BASED_POSTED_INTR;
-	vmcs_conf->cpu_based_2nd_exec_ctrl &=
-		~SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
-	vmcs_conf->cpu_based_2nd_exec_ctrl &=
-		~SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
-	vmcs_conf->cpu_based_2nd_exec_ctrl &=
-		~SECONDARY_EXEC_APIC_REGISTER_VIRT;
-
-	/*
-	 *	GUEST_PML_INDEX			= 0x00000812,
-	 *	PML_ADDRESS			= 0x0000200e,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_PML;
+	vmcs_conf->pin_based_exec_ctrl &= ~EVMCS1_UNSUPPORTED_PINCTRL;
+	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~EVMCS1_UNSUPPORTED_2NDEXEC;
 
-	/*	VM_FUNCTION_CONTROL             = 0x00002018, */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
-
-	/*
-	 *	EPTP_LIST_ADDRESS               = 0x00002024,
-	 *	VMREAD_BITMAP                   = 0x00002026,
-	 *	VMWRITE_BITMAP                  = 0x00002028,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_SHADOW_VMCS;
+	vmcs_conf->vmexit_ctrl &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
+	vmcs_conf->vmentry_ctrl &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
 
-	/*
-	 *	TSC_MULTIPLIER                  = 0x00002032,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_TSC_SCALING;
-
-	/*
-	 *	PLE_GAP                         = 0x00004020,
-	 *	PLE_WINDOW                      = 0x00004022,
-	 */
-	vmcs_conf->cpu_based_2nd_exec_ctrl &= ~SECONDARY_EXEC_PAUSE_LOOP_EXITING;
-
-	/*
-	 *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
-	 */
-	vmcs_conf->pin_based_exec_ctrl &= ~PIN_BASED_VMX_PREEMPTION_TIMER;
-
-	/*
-	 *      GUEST_IA32_PERF_GLOBAL_CTRL     = 0x00002808,
-	 *      HOST_IA32_PERF_GLOBAL_CTRL      = 0x00002c04,
-	 */
-	vmcs_conf->vmexit_ctrl &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
-	vmcs_conf->vmentry_ctrl &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
-
-	/*
-	 * Currently unsupported in KVM:
-	 *	GUEST_IA32_RTIT_CTL		= 0x00002814,
-	 */
 }
 
 /* check_ept_pointer() should be under protection of ept_pointer_lock. */
-- 
2.17.1

