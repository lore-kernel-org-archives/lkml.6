Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeDLPZS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:25:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754021AbeDLPZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:25:14 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support
Date: Thu, 12 Apr 2018 17:25:08 +0200
Message-Id: <20180412152508.27617-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enlightened MSR-Bitmap is a natural extension of Enlightened VMCS:
Hyper-V Top Level Functional Specification states:

"The L1 hypervisor may collaborate with the L0 hypervisor to make MSR
accesses more efficient. It can enable enlightened MSR bitmaps by setting
the corresponding field in the enlightened VMCS to 1. When enabled, the L0
hypervisor does not monitor the MSR bitmaps for changes. Instead, the L1
hypervisor must invalidate the corresponding clean field after making
changes to one of the MSR bitmaps."

I reached out to Hyper-V team for additional details and I got the
following information

"Current Hyper-V implementation works as following.

If the enlightened MSR bitmap is not enabled:
- All MSR accesses of L2 guests cause physical VM-Exits

If the enlightened MSR bitmap is enabled:
- Physical VM-Exits for L2 accesses to certain MSRs (currently FS_BASE,
  GS_BASE and KERNEL_GS_BASE) are avoided, thus making these MSR accesses
  faster."

I tested my series with a custom kernel module doing tight rdmsrl loop,
for KERNEL_GS_BASE the results are:

Without Enlightened MSR-Bitmap: 1300 cycles/read
With Enlightened MSR-Bitmap: 120 cycles/read

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h |  9 ++++++++-
 arch/x86/kvm/vmx.c                 | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 1c602ad4bda8..26e7e2240066 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -300,6 +300,9 @@ struct ms_hyperv_tsc_page {
 /* TSC emulation after migration */
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
 
+/* Nested features (CPUID 0x4000000A) EAX */
+#define HV_X64_NESTED_MSR_BITMAP		BIT(19)
+
 struct hv_reenlightenment_control {
 	__u64 vector:8;
 	__u64 reserved1:8;
@@ -665,7 +668,11 @@ struct hv_enlightened_vmcs {
 	u32 hv_clean_fields;
 	u32 hv_padding_32;
 	u32 hv_synthetic_controls;
-	u32 hv_enlightenments_control;
+	struct {
+		u32 nested_flush_hypercall:1;
+		u32 msr_bitmap:1;
+		u32 reserved:30;
+	} hv_enlightenments_control;
 	u32 hv_vp_id;
 
 	u64 hv_vm_id;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b2f8a700aeef..c80a48cffc52 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1014,6 +1014,7 @@ static const u32 vmx_msr_index[] = {
 };
 
 DEFINE_STATIC_KEY_FALSE(enable_evmcs);
+DEFINE_STATIC_KEY_FALSE(enable_emsr_bitmap);
 
 #define current_evmcs ((struct hv_enlightened_vmcs *)this_cpu_read(current_vmcs))
 
@@ -1090,6 +1091,15 @@ static inline u16 evmcs_read16(unsigned long field)
 	return *(u16 *)((char *)current_evmcs + offset);
 }
 
+static inline void evmcs_touch_msr_bitmap(void)
+{
+	if (unlikely(!current_evmcs))
+		return;
+
+	current_evmcs->hv_clean_fields &=
+		~HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP;
+}
+
 static void evmcs_load(u64 phys_addr)
 {
 	struct hv_vp_assist_page *vp_ap =
@@ -1174,6 +1184,7 @@ static inline u32 evmcs_read32(unsigned long field) { return 0; }
 static inline u16 evmcs_read16(unsigned long field) { return 0; }
 static inline void evmcs_load(u64 phys_addr) {}
 static inline void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf) {}
+static inline void evmcs_touch_msr_bitmap(void) {}
 #endif /* IS_ENABLED(CONFIG_HYPERV) */
 
 static inline bool is_exception_n(u32 intr_info, u8 vector)
@@ -4218,6 +4229,13 @@ static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 		if (!loaded_vmcs->msr_bitmap)
 			goto out_vmcs;
 		memset(loaded_vmcs->msr_bitmap, 0xff, PAGE_SIZE);
+
+		if (static_branch_unlikely(&enable_emsr_bitmap)) {
+			struct hv_enlightened_vmcs *evmcs =
+				(struct hv_enlightened_vmcs *)loaded_vmcs->vmcs;
+
+			evmcs->hv_enlightenments_control.msr_bitmap = 1;
+		}
 	}
 	return 0;
 
@@ -5335,6 +5353,9 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
 	if (!cpu_has_vmx_msr_bitmap())
 		return;
 
+	if (static_branch_unlikely(&enable_emsr_bitmap))
+		evmcs_touch_msr_bitmap();
+
 	/*
 	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
 	 * have the write-low and read-high bitmap offsets the wrong way round.
@@ -5370,6 +5391,9 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
 	if (!cpu_has_vmx_msr_bitmap())
 		return;
 
+	if (static_branch_unlikely(&enable_emsr_bitmap))
+		evmcs_touch_msr_bitmap();
+
 	/*
 	 * See Intel PRM Vol. 3, 20.6.9 (MSR-Bitmap Address). Early manuals
 	 * have the write-low and read-high bitmap offsets the wrong way round.
@@ -12790,8 +12814,16 @@ static int __init vmx_init(void)
 		}
 
 		if (enlightened_vmcs) {
-			pr_info("KVM: vmx: using Hyper-V Enlightened VMCS\n");
 			static_branch_enable(&enable_evmcs);
+
+			/* Nested MSR-Bitmap */
+			if (ms_hyperv.nested_features &
+			    HV_X64_NESTED_MSR_BITMAP)
+				static_branch_enable(&enable_emsr_bitmap);
+
+			pr_info("KVM: vmx: using Hyper-V Enlightened VMCS %s\n",
+				!static_branch_likely(&enable_emsr_bitmap) ? ""
+				: "with MSR-Bitmap");
 		}
 	} else {
 		enlightened_vmcs = false;
-- 
2.14.3
