Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeECKUA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:20:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:65515 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbeECKTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:19:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36546585"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 13/13] KVM: x86: Disable Intel Processor Trace when VMXON in L1 guest
Date: Thu,  3 May 2018 20:13:28 +0800
Message-Id: <1525349608-10352-14-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
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
 arch/x86/kvm/vmx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c125fb1..1e800d0 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3952,7 +3952,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		break;
 	case MSR_IA32_RTIT_CTL:
 		if ((pt_mode != PT_MODE_HOST_GUEST) ||
-			vmx_rtit_ctl_check(vcpu, data))
+			vmx_rtit_ctl_check(vcpu, data) ||
+			vmx->nested.vmxon)
 			return 1;
 		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
 		pt_set_intercept_for_msr(vmx, !(data & RTIT_CTL_TRACEEN));
@@ -8029,6 +8030,12 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	if (ret)
 		return ret;
 
+	if (pt_mode == PT_MODE_HOST_GUEST) {
+		vmx->pt_desc.guest.ctl = 0;
+		vmcs_write64(GUEST_IA32_RTIT_CTL, 0);
+		pt_set_intercept_for_msr(vmx, 1);
+	}
+
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
 }
-- 
1.8.3.1
