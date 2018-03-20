Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeCUBLj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 21:11:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:19664 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751943AbeCUBLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 21:11:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="39779415"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v6 10/11] KVM: x86: Set intercept for Intel PT MSRs
Date: Tue, 20 Mar 2018 19:21:57 +0800
Message-Id: <1521544918-31084-11-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521544918-31084-1-git-send-email-luwei.kang@intel.com>
References: <1521544918-31084-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Disable interrcept Intel PT MSRs only when Intel PT is
enabled in guest. But MSR_IA32_RTIT_CTL will alway be
intercept.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 0334100..27185da 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -941,6 +941,7 @@ static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -3765,6 +3766,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx_rtit_ctl_check(vcpu, data))
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
+		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
 		vmx->pt_desc.guest.ctl = data;
 		break;
 	case MSR_IA32_RTIT_STATUS:
@@ -5554,6 +5556,24 @@ static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 	vmx->msr_bitmap_mode = mode;
 }
 
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag)
+{
+	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
+	u32 i;
+
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_STATUS,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_BASE,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_OUTPUT_MASK,
+							MSR_TYPE_RW, flag);
+	vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_CR3_MATCH,
+							MSR_TYPE_RW, flag);
+	for (i = 0; i < vmx->pt_desc.range_cnt; i++)
+		vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_RTIT_ADDR0_A + i,
+							MSR_TYPE_RW, flag);
+}
+
 static bool vmx_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 	return enable_apicv;
-- 
1.8.3.1
