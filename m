Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A362184D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfAWOGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:06:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:53944 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbfAWOGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:06:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="140622288"
Received: from local-michael-cet-test.sh.intel.com ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2019 06:06:34 -0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc:     weijiang.yang@intel.com, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: [PATCH v2 6/7] KVM:VMX: Load Guest CET via VMCS when CET is enabled in Guest
Date:   Wed, 23 Jan 2019 04:59:08 +0800
Message-Id: <20190122205909.24165-7-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190122205909.24165-1-weijiang.yang@intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Load Guest CET state" bit controls whether guest CET states
will be loaded on Guest entry. Before doing that, KVM needs
to check if CET feature is exposed to Guest.

Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 arch/x86/kvm/vmx.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 68c0e5e41cb1..9c8cecac80ea 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -55,6 +55,7 @@
 #include <asm/mmu_context.h>
 #include <asm/spec-ctrl.h>
 #include <asm/mshyperv.h>
+#include <asm/cet.h>
 
 #include "trace.h"
 #include "pmu.h"
@@ -4065,6 +4066,18 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 	return !(val & ~valid_bits);
 }
 
+static int vmx_guest_cet_cap(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+	int r = 0;
+
+	best = kvm_find_cpuid_entry(vcpu, 7, 0);
+	if (best && best->function == 0x7)
+		r = (best->ecx & bit(X86_FEATURE_SHSTK)) |
+		    (best->edx & bit(X86_FEATURE_IBT)) ? 1 : 0;
+	return r;
+}
+
 static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
@@ -5409,6 +5422,26 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 			return 1;
 	}
 
+	/*
+	 * To enable Guest CET, first check if Guest CET feature is
+	 * available, if it's not available but its CR4.CET is being set,
+	 * return a fault to Guest; then check if Host CET is enabled and
+	 * CR4.CET is toggled, if they are, then enable loading CET state
+	 * bit in entry control, otherwise, clear the bit to
+	 * disable guest CET state loading.
+	 */
+	if (vmx_guest_cet_cap(vcpu)) {
+		if (hw_cr4 & cr4 & X86_CR4_CET) {
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

