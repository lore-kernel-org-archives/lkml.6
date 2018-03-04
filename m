Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932679AbeCEB50 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:57:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:39574 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932649AbeCEB5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:57:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,425,1515484800";
   d="scan'208";a="21986120"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Chao Peng <chao.p.peng@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v5 10/11] KVM: x86: Set intercept for Intel PT MSRs
Date: Sun,  4 Mar 2018 20:07:20 +0800
Message-Id: <1520165241-15819-11-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
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
index 16943a8..0a55772 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -935,6 +935,7 @@ static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
 static bool vmx_pt_supported(void);
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -3713,6 +3714,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
 		vmx->pt_desc.guest.ctl = data;
+		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
 		break;
 	case MSR_IA32_RTIT_STATUS:
 		if (!vmx_pt_supported() ||
@@ -5496,6 +5498,24 @@ static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
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
