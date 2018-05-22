Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeEVC67 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:58:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:35511 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbeEVC6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:58:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="201336054"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        chao.p.peng@linux.intel.com, thomas.lendacky@amd.com, bp@suse.de,
        Kan.liang@intel.com, Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v9 11/12] KVM: x86: Set intercept for Intel PT MSRs read/write
Date: Tue, 22 May 2018 12:52:14 +0800
Message-Id: <1526964735-16566-12-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Disable intercept Intel PT MSRs only when Intel PT is
enabled in guest. But MSR_IA32_RTIT_CTL will alway be
intercept.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 770cb7c..a09157c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -948,6 +948,7 @@ static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
+static void pt_set_intercept_for_msr(struct vcpu_vmx *vmx, bool flag);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
 static DEFINE_PER_CPU(struct vmcs *, current_vmcs);
@@ -3999,6 +4000,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			vmx_rtit_ctl_check(vcpu, data))
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
+		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
 		vmx->pt_desc.guest.ctl = data;
 		break;
 	case MSR_IA32_RTIT_STATUS:
@@ -5820,6 +5822,27 @@ static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
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
+	for (i = 0; i < vmx->pt_desc.addr_range; i++) {
+		vmx_set_intercept_for_msr(msr_bitmap,
+			MSR_IA32_RTIT_ADDR0_A + i * 2, MSR_TYPE_RW, flag);
+		vmx_set_intercept_for_msr(msr_bitmap,
+			MSR_IA32_RTIT_ADDR0_B + i * 2, MSR_TYPE_RW, flag);
+	}
+}
+
 static bool vmx_get_enable_apicv(struct kvm_vcpu *vcpu)
 {
 	return enable_apicv;
-- 
1.8.3.1
