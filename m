Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeEVC7I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 22:59:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:36591 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752791AbeEVC7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 22:59:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="201336075"
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
Subject: [PATCH v9 12/12] KVM: x86: Disable Intel Processor Trace when VMXON in L1 guest
Date: Tue, 22 May 2018 12:52:15 +0800
Message-Id: <1526964735-16566-13-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, Intel Processor Trace do not support tracing in L1 guest
VMX operation(IA32_VMX_MISC[bit 14] is 0). As mentioned in SDM,
on these type of processors, execution of the VMXON instruction will
clears IA32_RTIT_CTL.TraceEn and any attempt to write IA32_RTIT_CTL
causes a general-protection exception (#GP).

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a09157c..093c1f7 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3997,7 +3997,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_RTIT_CTL:
 		if ((pt_mode != PT_MODE_HOST_GUEST) ||
-			vmx_rtit_ctl_check(vcpu, data))
+			vmx_rtit_ctl_check(vcpu, data) ||
+			vmx->nested.vmxon)
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
 		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
@@ -8090,6 +8091,11 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
+	if (pt_mode == PT_MODE_HOST_GUEST) {
+		vmx->pt_desc.guest.ctl = 0;
+		pt_set_intercept_for_msr(vmx, 1);
+	}
+
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
 }
-- 
1.8.3.1
