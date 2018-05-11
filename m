Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeEKNiB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:38:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752977AbeEKNh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:37:57 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: [PATCH RFC v2 1/5] KVM: hyperv: define VP assist page helpers
Date: Fri, 11 May 2018 15:37:47 +0200
Message-Id: <20180511133751.13414-2-vkuznets@redhat.com>
In-Reply-To: <20180511133751.13414-1-vkuznets@redhat.com>
References: <20180511133751.13414-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ladi Prosek <lprosek@redhat.com>

The state related to the VP assist page is still managed by the LAPIC
code in the pv_eoi field.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 23 +++++++++++++++++++++--
 arch/x86/kvm/hyperv.h |  4 ++++
 arch/x86/kvm/lapic.c  |  4 ++--
 arch/x86/kvm/lapic.h  |  2 +-
 arch/x86/kvm/x86.c    |  2 +-
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 98618e397342..494ef47b4120 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -688,6 +688,24 @@ void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu)
 		stimer_cleanup(&hv_vcpu->stimer[i]);
 }
 
+bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.hyperv.hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE))
+		return false;
+	return vcpu->arch.pv_eoi.msr_val & KVM_MSR_ENABLED;
+}
+EXPORT_SYMBOL_GPL(kvm_hv_assist_page_enabled);
+
+bool kvm_hv_get_assist_page(struct kvm_vcpu *vcpu,
+			    struct hv_vp_assist_page *assist_page)
+{
+	if (!kvm_hv_assist_page_enabled(vcpu))
+		return false;
+	return !kvm_read_guest_cached(vcpu->kvm, &vcpu->arch.pv_eoi.data,
+				      assist_page, sizeof(*assist_page));
+}
+EXPORT_SYMBOL_GPL(kvm_hv_get_assist_page);
+
 static void stimer_prepare_msg(struct kvm_vcpu_hv_stimer *stimer)
 {
 	struct hv_message *msg = &stimer->msg;
@@ -1048,7 +1066,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 
 		if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
 			hv->hv_vapic = data;
-			if (kvm_lapic_enable_pv_eoi(vcpu, 0))
+			if (kvm_lapic_enable_pv_eoi(vcpu, 0, 0))
 				return 1;
 			break;
 		}
@@ -1061,7 +1079,8 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		hv->hv_vapic = data;
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
 		if (kvm_lapic_enable_pv_eoi(vcpu,
-					    gfn_to_gpa(gfn) | KVM_MSR_ENABLED))
+					    gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
+					    sizeof(struct hv_vp_assist_page)))
 			return 1;
 		break;
 	}
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 837465d69c6d..db825bb7efc7 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -62,6 +62,10 @@ void kvm_hv_vcpu_init(struct kvm_vcpu *vcpu);
 void kvm_hv_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_hv_vcpu_uninit(struct kvm_vcpu *vcpu);
 
+bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu);
+bool kvm_hv_get_assist_page(struct kvm_vcpu *vcpu,
+			    struct hv_vp_assist_page *assist_page);
+
 static inline struct kvm_vcpu_hv_stimer *vcpu_to_stimer(struct kvm_vcpu *vcpu,
 							int timer_index)
 {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 70dcb5548022..7d16fcc50450 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2539,7 +2539,7 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 reg, u64 *data)
 	return 0;
 }
 
-int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data)
+int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len)
 {
 	u64 addr = data & ~KVM_MSR_ENABLED;
 	if (!IS_ALIGNED(addr, 4))
@@ -2549,7 +2549,7 @@ int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data)
 	if (!pv_eoi_enabled(vcpu))
 		return 0;
 	return kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.pv_eoi.data,
-					 addr, sizeof(u8));
+					 addr, len);
 }
 
 void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index edce055e9fd7..0a824a4dc78c 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -112,7 +112,7 @@ static inline bool kvm_hv_vapic_assist_page_enabled(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hyperv.hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE;
 }
 
-int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data);
+int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len);
 void kvm_lapic_init(void);
 void kvm_lapic_exit(void);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 51ecd381793b..fcc05e4e0916 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2434,7 +2434,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		break;
 	case MSR_KVM_PV_EOI_EN:
-		if (kvm_lapic_enable_pv_eoi(vcpu, data))
+		if (kvm_lapic_enable_pv_eoi(vcpu, data, sizeof(u8)))
 			return 1;
 		break;
 
-- 
2.14.3
