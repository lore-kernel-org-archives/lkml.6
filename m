Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FD7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C7C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C7C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeK3TRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:17:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:17648 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbeK3TRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:17:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:08:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="113902224"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2018 00:08:32 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id AE7B0580213;
        Fri, 30 Nov 2018 00:08:30 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 03/11] KVM: VMX: Added VMX SPP feature flags and VM-Execution Controls.
Date:   Fri, 30 Nov 2018 16:08:15 +0800
Message-Id: <43d18efb9e731f45de01a3a40d0d325c44e5a201.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new secondary processor-based VM-execution control bit which
defined as "sub-page write permission", same as VMX Procbased MSR,
bit 23 is the enable bit of SPP.

Also we introduced a enable_ept_spp parameter to control the
SPP is ON/OFF, Set the default is OFF as we are on the way of
enabling.

Now SPP is active when the "Sub-page Write Protection"
in Secondary VM-Execution Control is set and enable the kernel
parameter by "spp=on".

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: He Chen <he.chen@linux.intel.com>
---
 arch/x86/include/asm/vmx.h |  1 +
 arch/x86/kvm/vmx.c         | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index ade0f15..2aa088f 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -78,6 +78,7 @@
 #define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
 #define SECONDARY_EXEC_ENABLE_PML               0x00020000
 #define SECONDARY_EXEC_XSAVES			0x00100000
+#define SECONDARY_EXEC_ENABLE_SPP		0x00800000
 #define SECONDARY_EXEC_TSC_SCALING              0x02000000
 
 #define PIN_BASED_EXT_INTR_MASK                 0x00000001
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4555077..f76d3fb 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -92,6 +92,9 @@ module_param_named(unrestricted_guest,
 static bool __read_mostly enable_ept_ad_bits = 1;
 module_param_named(eptad, enable_ept_ad_bits, bool, S_IRUGO);
 
+static bool __read_mostly enable_ept_spp;
+module_param_named(spp, enable_ept_spp, bool, S_IRUGO);
+
 static bool __read_mostly emulate_invalid_guest_state = true;
 module_param(emulate_invalid_guest_state, bool, S_IRUGO);
 
@@ -1941,6 +1944,11 @@ static inline bool cpu_has_vmx_pml(void)
 	return vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_ENABLE_PML;
 }
 
+static inline bool cpu_has_vmx_ept_spp(void)
+{
+	return vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_ENABLE_SPP;
+}
+
 static inline bool cpu_has_vmx_tsc_scaling(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
@@ -4583,6 +4591,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 			SECONDARY_EXEC_RDSEED_EXITING |
 			SECONDARY_EXEC_RDRAND_EXITING |
 			SECONDARY_EXEC_ENABLE_PML |
+			SECONDARY_EXEC_ENABLE_SPP |
 			SECONDARY_EXEC_TSC_SCALING |
 			SECONDARY_EXEC_ENABLE_VMFUNC |
 			SECONDARY_EXEC_ENCLS_EXITING;
@@ -6486,6 +6495,9 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 	if (!enable_pml)
 		exec_control &= ~SECONDARY_EXEC_ENABLE_PML;
 
+	if (!enable_ept_spp)
+		exec_control &= ~SECONDARY_EXEC_ENABLE_SPP;
+
 	if (vmx_xsaves_supported()) {
 		/* Exposing XSAVES only when XSAVE is exposed */
 		bool xsaves_enabled =
@@ -7927,6 +7939,9 @@ static __init int hardware_setup(void)
 	if (!cpu_has_vmx_unrestricted_guest() || !enable_ept)
 		enable_unrestricted_guest = 0;
 
+	if (!cpu_has_vmx_ept_spp() || !enable_ept)
+		enable_ept_spp = 0;
+
 	if (!cpu_has_vmx_flexpriority())
 		flexpriority_enabled = 0;
 
-- 
2.7.4

