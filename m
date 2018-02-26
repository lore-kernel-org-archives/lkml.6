Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeBZRLd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:11:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751463AbeBZRL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:11:29 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to HV_X64_MSR_VP_ASSIST_PAGE
Date: Mon, 26 Feb 2018 18:11:17 +0100
Message-Id: <20180226171121.18974-2-vkuznets@redhat.com>
In-Reply-To: <20180226171121.18974-1-vkuznets@redhat.com>
References: <20180226171121.18974-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ladi Prosek <lprosek@redhat.com>

The assist page has been used only for the paravirtual EOI so far, hence
the "APIC" in the MSR name. Renaming to match the Hyper-V TLFS where it's
called "Virtual VP Assist MSR".

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/uapi/asm/hyperv.h | 10 +++++-----
 arch/x86/kvm/hyperv.c              |  8 ++++----
 arch/x86/kvm/lapic.h               |  2 +-
 arch/x86/kvm/x86.c                 |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 1c12aaf33915..45cc62352040 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -189,7 +189,7 @@
 #define HV_X64_MSR_EOI				0x40000070
 #define HV_X64_MSR_ICR				0x40000071
 #define HV_X64_MSR_TPR				0x40000072
-#define HV_X64_MSR_APIC_ASSIST_PAGE		0x40000073
+#define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
 
 /* Define synthetic interrupt controller model specific registers. */
 #define HV_X64_MSR_SCONTROL			0x40000080
@@ -275,10 +275,10 @@ struct hv_tsc_emulation_status {
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 
-#define HV_X64_MSR_APIC_ASSIST_PAGE_ENABLE		0x00000001
-#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT	12
-#define HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_MASK	\
-		(~((1ull << HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
+#define HV_X64_MSR_VP_ASSIST_PAGE_ENABLE	0x00000001
+#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT	12
+#define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
+		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
 
 #define HV_X64_MSR_TSC_REFERENCE_ENABLE		0x00000001
 #define HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT	12
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8e38a6ef84cc..d99465d7002f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1010,17 +1010,17 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 			return 1;
 		hv->vp_index = (u32)data;
 		break;
-	case HV_X64_MSR_APIC_ASSIST_PAGE: {
+	case HV_X64_MSR_VP_ASSIST_PAGE: {
 		u64 gfn;
 		unsigned long addr;
 
-		if (!(data & HV_X64_MSR_APIC_ASSIST_PAGE_ENABLE)) {
+		if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
 			hv->hv_vapic = data;
 			if (kvm_lapic_enable_pv_eoi(vcpu, 0))
 				return 1;
 			break;
 		}
-		gfn = data >> HV_X64_MSR_APIC_ASSIST_PAGE_ADDRESS_SHIFT;
+		gfn = data >> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT;
 		addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
 		if (kvm_is_error_hva(addr))
 			return 1;
@@ -1130,7 +1130,7 @@ static int kvm_hv_get_msr(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 		return kvm_hv_vapic_msr_read(vcpu, APIC_ICR, pdata);
 	case HV_X64_MSR_TPR:
 		return kvm_hv_vapic_msr_read(vcpu, APIC_TASKPRI, pdata);
-	case HV_X64_MSR_APIC_ASSIST_PAGE:
+	case HV_X64_MSR_VP_ASSIST_PAGE:
 		data = hv->hv_vapic;
 		break;
 	case HV_X64_MSR_VP_RUNTIME:
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 56c36014f7b7..edce055e9fd7 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -109,7 +109,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 msr, u64 *data);
 
 static inline bool kvm_hv_vapic_assist_page_enabled(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.hyperv.hv_vapic & HV_X64_MSR_APIC_ASSIST_PAGE_ENABLE;
+	return vcpu->arch.hyperv.hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
 }
 
 int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a3ed81031f1..1d7be99ced4a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1034,7 +1034,7 @@ static u32 emulated_msrs[] = {
 	HV_X64_MSR_VP_RUNTIME,
 	HV_X64_MSR_SCONTROL,
 	HV_X64_MSR_STIMER0_CONFIG,
-	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
+	HV_X64_MSR_VP_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
 	MSR_KVM_PV_EOI_EN,
 
 	MSR_IA32_TSC_ADJUST,
-- 
2.14.3
