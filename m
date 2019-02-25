Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996ACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4E3217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfBZGdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 01:33:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:18116 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfBZGc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 01:32:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 22:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="141666175"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2019 22:32:55 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com
Cc:     Yang Weijiang <weijiang.yang@intel.com>,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v3 6/8] KVM:VMX: Load Guest CET via VMCS when CET is enabled in Guest
Date:   Mon, 25 Feb 2019 21:27:14 +0800
Message-Id: <20190225132716.6982-7-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225132716.6982-1-weijiang.yang@intel.com>
References: <20190225132716.6982-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Load Guest CET state" bit controls whether guest CET states
will be loaded at Guest entry. Before doing that, KVM needs
to check if CPU CET feature is available.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/vmx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 89ee086e1729..d32cee9ee079 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -55,6 +55,7 @@
 #include <asm/mmu_context.h>
 #include <asm/spec-ctrl.h>
 #include <asm/mshyperv.h>
+#include <asm/cet.h>
 
 #include "trace.h"
 #include "pmu.h"
@@ -4065,6 +4066,20 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 	return !(val & ~valid_bits);
 }
 
+static int vmx_guest_cet_cap(struct kvm_vcpu *vcpu)
+{
+	u32 eax, ebx, ecx, edx;
+
+	/*
+	 * Guest CET can work as long as HW supports the feature, independent
+	 * to Host SW enabling status.
+	 */
+	cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
+
+	return ((ecx & bit(X86_FEATURE_SHSTK)) |
+		(edx & bit(X86_FEATURE_IBT))) ? 1 : 0;
+}
+
 static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
@@ -5409,6 +5424,23 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
+	/*
+	 * To enable Guest CET, check whether CPU CET feature is
+	 * available, if it's there, set Guest CET state loading bit
+	 * per CR4.CET status, otherwise, return a fault to Guest.
+	 */
+	if (vmx_guest_cet_cap(vcpu)) {
+		if (cr4 & X86_CR4_CET) {
+			vmcs_set_bits(VM_ENTRY_CONTROLS,
+				      VM_ENTRY_LOAD_GUEST_CET_STATE);
+		} else {
+			vmcs_clear_bits(VM_ENTRY_CONTROLS,
+					VM_ENTRY_LOAD_GUEST_CET_STATE);
+		}
+	} else if (cr4 & X86_CR4_CET) {
+		return 1;
+	}
+
 	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
 		return 1;
 
-- 
2.17.1

