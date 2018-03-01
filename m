Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031345AbeCAOQm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:16:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031248AbeCAOPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:15:20 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PATCH v2 1/3] x86/kvm/hyper-v: add reenlightenment MSRs support
Date: Thu,  1 Mar 2018 15:15:12 +0100
Message-Id: <20180301141514.3482-2-vkuznets@redhat.com>
In-Reply-To: <20180301141514.3482-1-vkuznets@redhat.com>
References: <20180301141514.3482-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nested Hyper-V/Windows guest running on top of KVM will use TSC page
clocksource in two cases:
- L0 exposes invariant TSC (CPUID.80000007H:EDX[8]).
- L0 provides Hyper-V Reenlightenment support (CPUID.40000003H:EAX[13]).

Exposing invariant TSC effectively blocks migration to hosts with different
TSC frequencies, providing reenlightenment support will be needed when we
start migrating nested workloads.

Implement rudimentary support for reenlightenment MSRs. For now, these are
just read/write MSRs with no effect.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++++
 arch/x86/kvm/hyperv.c           | 21 +++++++++++++++++++++
 arch/x86/kvm/x86.c              | 12 +++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 516798431328..eff8aa880333 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -752,6 +752,10 @@ struct kvm_hv {
 	u64 hv_crash_ctl;
 
 	HV_REFERENCE_TSC_PAGE tsc_ref;
+
+	u64 hv_reenlightenment_control;
+	u64 hv_tsc_emulation_control;
+	u64 hv_tsc_emulation_status;
 };
 
 enum kvm_irqchip_mode {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index dc97f2544b6f..05f414525538 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -736,6 +736,9 @@ static bool kvm_hv_msr_partition_wide(u32 msr)
 	case HV_X64_MSR_CRASH_CTL:
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 	case HV_X64_MSR_RESET:
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		r = true;
 		break;
 	}
@@ -981,6 +984,15 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 			kvm_make_request(KVM_REQ_HV_RESET, vcpu);
 		}
 		break;
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+		hv->hv_reenlightenment_control = data;
+		break;
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+		hv->hv_tsc_emulation_control = data;
+		break;
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
+		hv->hv_tsc_emulation_status = data;
+		break;
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V uhandled wrmsr: 0x%x data 0x%llx\n",
 			    msr, data);
@@ -1105,6 +1117,15 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
 	case HV_X64_MSR_RESET:
 		data = 0;
 		break;
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+		data = hv->hv_reenlightenment_control;
+		break;
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+		data = hv->hv_tsc_emulation_control;
+		break;
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
+		data = hv->hv_tsc_emulation_status;
+		break;
 	default:
 		vcpu_unimpl(vcpu, "Hyper-V unhandled rdmsr: 0x%x\n", msr);
 		return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c53298dfbf50..d97ab134b2d9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1026,7 +1026,11 @@ static u32 emulated_msrs[] = {
 	HV_X64_MSR_VP_RUNTIME,
 	HV_X64_MSR_SCONTROL,
 	HV_X64_MSR_STIMER0_CONFIG,
-	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
+	HV_X64_MSR_APIC_ASSIST_PAGE,
+	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
+	HV_X64_MSR_TSC_EMULATION_STATUS,
+
+	MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
 	MSR_KVM_PV_EOI_EN,
 
 	MSR_IA32_TSC_ADJUST,
@@ -2325,6 +2329,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 	case HV_X64_MSR_CRASH_CTL:
 	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		return kvm_hv_set_msr_common(vcpu, msr, data,
 					     msr_info->host_initiated);
 	case MSR_IA32_BBL_CR_CTL3:
@@ -2551,6 +2558,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 	case HV_X64_MSR_CRASH_CTL:
 	case HV_X64_MSR_STIMER0_CONFIG ... HV_X64_MSR_STIMER3_COUNT:
+	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_CONTROL:
+	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		return kvm_hv_get_msr_common(vcpu,
 					     msr_info->index, &msr_info->data);
 		break;
-- 
2.14.3
