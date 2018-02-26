Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeBZMk6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:40:58 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40442 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbeBZMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:40:48 -0500
X-Google-Smtp-Source: AH8x227gQE9KGJEiWwa+AAStdIwsf6g/TTVf/3ujoo4ZFNRuiAJT6Bd3HLA21j+uC5GxU+FSlMvYcw==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: dmatlack@google.com
Subject: [PATCH 1/2] KVM: nVMX: introduce struct nested_vmx_msrs
Date: Mon, 26 Feb 2018 13:40:08 +0100
Message-Id: <1519648809-16694-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519648809-16694-1-git-send-email-pbonzini@redhat.com>
References: <1519648809-16694-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the MSRs to a separate struct, so that we can introduce a global
instance and return it from the /dev/kvm KVM_GET_MSRS ioctl.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 352 +++++++++++++++++++++++++++--------------------------
 1 file changed, 178 insertions(+), 174 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 99689061e11e..e304e92d37db 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -424,6 +424,35 @@ struct __packed vmcs12 {
  */
 #define VMCS12_MAX_FIELD_INDEX 0x17
 
+struct nested_vmx_msrs {
+	/*
+	 * We only store the "true" versions of the VMX capability MSRs. We
+	 * generate the "non-true" versions by setting the must-be-1 bits
+	 * according to the SDM.
+	 */
+	u32 procbased_ctls_low;
+	u32 procbased_ctls_high;
+	u32 secondary_ctls_low;
+	u32 secondary_ctls_high;
+	u32 pinbased_ctls_low;
+	u32 pinbased_ctls_high;
+	u32 exit_ctls_low;
+	u32 exit_ctls_high;
+	u32 entry_ctls_low;
+	u32 entry_ctls_high;
+	u32 misc_low;
+	u32 misc_high;
+	u32 ept_caps;
+	u32 vpid_caps;
+	u64 basic;
+	u64 cr0_fixed0;
+	u64 cr0_fixed1;
+	u64 cr4_fixed0;
+	u64 cr4_fixed1;
+	u64 vmcs_enum;
+	u64 vmfunc_controls;
+};
+
 /*
  * The nested_vmx structure is part of vcpu_vmx, and holds information we need
  * for correct emulation of VMX (i.e., nested VMX) on this vcpu.
@@ -475,32 +504,7 @@ struct nested_vmx {
 	u16 vpid02;
 	u16 last_vpid;
 
-	/*
-	 * We only store the "true" versions of the VMX capability MSRs. We
-	 * generate the "non-true" versions by setting the must-be-1 bits
-	 * according to the SDM.
-	 */
-	u32 nested_vmx_procbased_ctls_low;
-	u32 nested_vmx_procbased_ctls_high;
-	u32 nested_vmx_secondary_ctls_low;
-	u32 nested_vmx_secondary_ctls_high;
-	u32 nested_vmx_pinbased_ctls_low;
-	u32 nested_vmx_pinbased_ctls_high;
-	u32 nested_vmx_exit_ctls_low;
-	u32 nested_vmx_exit_ctls_high;
-	u32 nested_vmx_entry_ctls_low;
-	u32 nested_vmx_entry_ctls_high;
-	u32 nested_vmx_misc_low;
-	u32 nested_vmx_misc_high;
-	u32 nested_vmx_ept_caps;
-	u32 nested_vmx_vpid_caps;
-	u64 nested_vmx_basic;
-	u64 nested_vmx_cr0_fixed0;
-	u64 nested_vmx_cr0_fixed1;
-	u64 nested_vmx_cr4_fixed0;
-	u64 nested_vmx_cr4_fixed1;
-	u64 nested_vmx_vmcs_enum;
-	u64 nested_vmx_vmfunc_controls;
+	struct nested_vmx_msrs msrs;
 
 	/* SMM related state */
 	struct {
@@ -1313,7 +1317,7 @@ static inline bool report_flexpriority(void)
 
 static inline unsigned nested_cpu_vmx_misc_cr3_count(struct kvm_vcpu *vcpu)
 {
-	return vmx_misc_cr3_count(to_vmx(vcpu)->nested.nested_vmx_misc_low);
+	return vmx_misc_cr3_count(to_vmx(vcpu)->nested.msrs.misc_low);
 }
 
 static inline bool nested_cpu_has(struct vmcs12 *vmcs12, u32 bit)
@@ -2682,7 +2686,7 @@ static inline bool nested_vmx_allowed(struct kvm_vcpu *vcpu)
  * bit in the high half is on if the corresponding bit in the control field
  * may be on. See also vmx_control_verify().
  */
-static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
+static void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, bool apicv)
 {
 	/*
 	 * Note that as a general rule, the high half of the MSRs (bits in
@@ -2701,70 +2705,70 @@ static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
 
 	/* pin-based controls */
 	rdmsr(MSR_IA32_VMX_PINBASED_CTLS,
-		vmx->nested.nested_vmx_pinbased_ctls_low,
-		vmx->nested.nested_vmx_pinbased_ctls_high);
-	vmx->nested.nested_vmx_pinbased_ctls_low |=
+		msrs->pinbased_ctls_low,
+		msrs->pinbased_ctls_high);
+	msrs->pinbased_ctls_low |=
 		PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
-	vmx->nested.nested_vmx_pinbased_ctls_high &=
+	msrs->pinbased_ctls_high &=
 		PIN_BASED_EXT_INTR_MASK |
 		PIN_BASED_NMI_EXITING |
 		PIN_BASED_VIRTUAL_NMIS;
-	vmx->nested.nested_vmx_pinbased_ctls_high |=
+	msrs->pinbased_ctls_high |=
 		PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR |
 		PIN_BASED_VMX_PREEMPTION_TIMER;
-	if (kvm_vcpu_apicv_active(&vmx->vcpu))
-		vmx->nested.nested_vmx_pinbased_ctls_high |=
+	if (apicv)
+		msrs->pinbased_ctls_high |=
 			PIN_BASED_POSTED_INTR;
 
 	/* exit controls */
 	rdmsr(MSR_IA32_VMX_EXIT_CTLS,
-		vmx->nested.nested_vmx_exit_ctls_low,
-		vmx->nested.nested_vmx_exit_ctls_high);
-	vmx->nested.nested_vmx_exit_ctls_low =
+		msrs->exit_ctls_low,
+		msrs->exit_ctls_high);
+	msrs->exit_ctls_low =
 		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR;
 
-	vmx->nested.nested_vmx_exit_ctls_high &=
+	msrs->exit_ctls_high &=
 #ifdef CONFIG_X86_64
 		VM_EXIT_HOST_ADDR_SPACE_SIZE |
 #endif
 		VM_EXIT_LOAD_IA32_PAT | VM_EXIT_SAVE_IA32_PAT;
-	vmx->nested.nested_vmx_exit_ctls_high |=
+	msrs->exit_ctls_high |=
 		VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
 		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
 		VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT;
 
 	if (kvm_mpx_supported())
-		vmx->nested.nested_vmx_exit_ctls_high |= VM_EXIT_CLEAR_BNDCFGS;
+		msrs->exit_ctls_high |= VM_EXIT_CLEAR_BNDCFGS;
 
 	/* We support free control of debug control saving. */
-	vmx->nested.nested_vmx_exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
+	msrs->exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
 
 	/* entry controls */
 	rdmsr(MSR_IA32_VMX_ENTRY_CTLS,
-		vmx->nested.nested_vmx_entry_ctls_low,
-		vmx->nested.nested_vmx_entry_ctls_high);
-	vmx->nested.nested_vmx_entry_ctls_low =
+		msrs->entry_ctls_low,
+		msrs->entry_ctls_high);
+	msrs->entry_ctls_low =
 		VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR;
-	vmx->nested.nested_vmx_entry_ctls_high &=
+	msrs->entry_ctls_high &=
 #ifdef CONFIG_X86_64
 		VM_ENTRY_IA32E_MODE |
 #endif
 		VM_ENTRY_LOAD_IA32_PAT;
-	vmx->nested.nested_vmx_entry_ctls_high |=
+	msrs->entry_ctls_high |=
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER);
 	if (kvm_mpx_supported())
-		vmx->nested.nested_vmx_entry_ctls_high |= VM_ENTRY_LOAD_BNDCFGS;
+		msrs->entry_ctls_high |= VM_ENTRY_LOAD_BNDCFGS;
 
 	/* We support free control of debug control loading. */
-	vmx->nested.nested_vmx_entry_ctls_low &= ~VM_ENTRY_LOAD_DEBUG_CONTROLS;
+	msrs->entry_ctls_low &= ~VM_ENTRY_LOAD_DEBUG_CONTROLS;
 
 	/* cpu-based controls */
 	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS,
-		vmx->nested.nested_vmx_procbased_ctls_low,
-		vmx->nested.nested_vmx_procbased_ctls_high);
-	vmx->nested.nested_vmx_procbased_ctls_low =
+		msrs->procbased_ctls_low,
+		msrs->procbased_ctls_high);
+	msrs->procbased_ctls_low =
 		CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
-	vmx->nested.nested_vmx_procbased_ctls_high &=
+	msrs->procbased_ctls_high &=
 		CPU_BASED_VIRTUAL_INTR_PENDING |
 		CPU_BASED_VIRTUAL_NMI_PENDING | CPU_BASED_USE_TSC_OFFSETING |
 		CPU_BASED_HLT_EXITING | CPU_BASED_INVLPG_EXITING |
@@ -2784,12 +2788,12 @@ static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
 	 * can use it to avoid exits to L1 - even when L0 runs L2
 	 * without MSR bitmaps.
 	 */
-	vmx->nested.nested_vmx_procbased_ctls_high |=
+	msrs->procbased_ctls_high |=
 		CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR |
 		CPU_BASED_USE_MSR_BITMAPS;
 
 	/* We support free control of CR3 access interception. */
-	vmx->nested.nested_vmx_procbased_ctls_low &=
+	msrs->procbased_ctls_low &=
 		~(CPU_BASED_CR3_LOAD_EXITING | CPU_BASED_CR3_STORE_EXITING);
 
 	/*
@@ -2797,10 +2801,10 @@ static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
 	 * depend on CPUID bits, they are added later by vmx_cpuid_update.
 	 */
 	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		vmx->nested.nested_vmx_secondary_ctls_low,
-		vmx->nested.nested_vmx_secondary_ctls_high);
-	vmx->nested.nested_vmx_secondary_ctls_low = 0;
-	vmx->nested.nested_vmx_secondary_ctls_high &=
+		msrs->secondary_ctls_low,
+		msrs->secondary_ctls_high);
+	msrs->secondary_ctls_low = 0;
+	msrs->secondary_ctls_high &=
 		SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
 		SECONDARY_EXEC_DESC |
 		SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
@@ -2810,33 +2814,33 @@ static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
 
 	if (enable_ept) {
 		/* nested EPT: emulate EPT also to L1 */
-		vmx->nested.nested_vmx_secondary_ctls_high |=
+		msrs->secondary_ctls_high |=
 			SECONDARY_EXEC_ENABLE_EPT;
-		vmx->nested.nested_vmx_ept_caps = VMX_EPT_PAGE_WALK_4_BIT |
+		msrs->ept_caps = VMX_EPT_PAGE_WALK_4_BIT |
 			 VMX_EPTP_WB_BIT | VMX_EPT_INVEPT_BIT;
 		if (cpu_has_vmx_ept_execute_only())
-			vmx->nested.nested_vmx_ept_caps |=
+			msrs->ept_caps |=
 				VMX_EPT_EXECUTE_ONLY_BIT;
-		vmx->nested.nested_vmx_ept_caps &= vmx_capability.ept;
-		vmx->nested.nested_vmx_ept_caps |= VMX_EPT_EXTENT_GLOBAL_BIT |
+		msrs->ept_caps &= vmx_capability.ept;
+		msrs->ept_caps |= VMX_EPT_EXTENT_GLOBAL_BIT |
 			VMX_EPT_EXTENT_CONTEXT_BIT | VMX_EPT_2MB_PAGE_BIT |
 			VMX_EPT_1GB_PAGE_BIT;
 		if (enable_ept_ad_bits) {
-			vmx->nested.nested_vmx_secondary_ctls_high |=
+			msrs->secondary_ctls_high |=
 				SECONDARY_EXEC_ENABLE_PML;
-			vmx->nested.nested_vmx_ept_caps |= VMX_EPT_AD_BIT;
+			msrs->ept_caps |= VMX_EPT_AD_BIT;
 		}
 	}
 
 	if (cpu_has_vmx_vmfunc()) {
-		vmx->nested.nested_vmx_secondary_ctls_high |=
+		msrs->secondary_ctls_high |=
 			SECONDARY_EXEC_ENABLE_VMFUNC;
 		/*
 		 * Advertise EPTP switching unconditionally
 		 * since we emulate it
 		 */
 		if (enable_ept)
-			vmx->nested.nested_vmx_vmfunc_controls =
+			msrs->vmfunc_controls =
 				VMX_VMFUNC_EPTP_SWITCHING;
 	}
 
@@ -2847,25 +2851,25 @@ static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
 	 * not failing the single-context invvpid, and it is worse.
 	 */
 	if (enable_vpid) {
-		vmx->nested.nested_vmx_secondary_ctls_high |=
+		msrs->secondary_ctls_high |=
 			SECONDARY_EXEC_ENABLE_VPID;
-		vmx->nested.nested_vmx_vpid_caps = VMX_VPID_INVVPID_BIT |
+		msrs->vpid_caps = VMX_VPID_INVVPID_BIT |
 			VMX_VPID_EXTENT_SUPPORTED_MASK;
 	}
 
 	if (enable_unrestricted_guest)
-		vmx->nested.nested_vmx_secondary_ctls_high |=
+		msrs->secondary_ctls_high |=
 			SECONDARY_EXEC_UNRESTRICTED_GUEST;
 
 	/* miscellaneous data */
 	rdmsr(MSR_IA32_VMX_MISC,
-		vmx->nested.nested_vmx_misc_low,
-		vmx->nested.nested_vmx_misc_high);
-	vmx->nested.nested_vmx_misc_low &= VMX_MISC_SAVE_EFER_LMA;
-	vmx->nested.nested_vmx_misc_low |=
+		msrs->misc_low,
+		msrs->misc_high);
+	msrs->misc_low &= VMX_MISC_SAVE_EFER_LMA;
+	msrs->misc_low |=
 		VMX_MISC_EMULATED_PREEMPTION_TIMER_RATE |
 		VMX_MISC_ACTIVITY_HLT;
-	vmx->nested.nested_vmx_misc_high = 0;
+	msrs->misc_high = 0;
 
 	/*
 	 * This MSR reports some information about VMX support. We
@@ -2873,14 +2877,14 @@ static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
 	 * guest, and the VMCS structure we give it - not about the
 	 * VMX support of the underlying hardware.
 	 */
-	vmx->nested.nested_vmx_basic =
+	msrs->basic =
 		VMCS12_REVISION |
 		VMX_BASIC_TRUE_CTLS |
 		((u64)VMCS12_SIZE << VMX_BASIC_VMCS_SIZE_SHIFT) |
 		(VMX_BASIC_MEM_TYPE_WB << VMX_BASIC_MEM_TYPE_SHIFT);
 
 	if (cpu_has_vmx_basic_inout())
-		vmx->nested.nested_vmx_basic |= VMX_BASIC_INOUT;
+		msrs->basic |= VMX_BASIC_INOUT;
 
 	/*
 	 * These MSRs specify bits which the guest must keep fixed on
@@ -2889,15 +2893,15 @@ static void nested_vmx_setup_ctls_msrs(struct vcpu_vmx *vmx)
 	 */
 #define VMXON_CR0_ALWAYSON     (X86_CR0_PE | X86_CR0_PG | X86_CR0_NE)
 #define VMXON_CR4_ALWAYSON     X86_CR4_VMXE
-	vmx->nested.nested_vmx_cr0_fixed0 = VMXON_CR0_ALWAYSON;
-	vmx->nested.nested_vmx_cr4_fixed0 = VMXON_CR4_ALWAYSON;
+	msrs->cr0_fixed0 = VMXON_CR0_ALWAYSON;
+	msrs->cr4_fixed0 = VMXON_CR4_ALWAYSON;
 
 	/* These MSRs specify bits which the guest must keep fixed off. */
-	rdmsrl(MSR_IA32_VMX_CR0_FIXED1, vmx->nested.nested_vmx_cr0_fixed1);
-	rdmsrl(MSR_IA32_VMX_CR4_FIXED1, vmx->nested.nested_vmx_cr4_fixed1);
+	rdmsrl(MSR_IA32_VMX_CR0_FIXED1, msrs->cr0_fixed1);
+	rdmsrl(MSR_IA32_VMX_CR4_FIXED1, msrs->cr4_fixed1);
 
 	/* highest index: VMX_PREEMPTION_TIMER_VALUE */
-	vmx->nested.nested_vmx_vmcs_enum = VMCS12_MAX_FIELD_INDEX << 1;
+	msrs->vmcs_enum = VMCS12_MAX_FIELD_INDEX << 1;
 }
 
 /*
@@ -2934,7 +2938,7 @@ static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 		BIT_ULL(49) | BIT_ULL(54) | BIT_ULL(55) |
 		/* reserved */
 		BIT_ULL(31) | GENMASK_ULL(47, 45) | GENMASK_ULL(63, 56);
-	u64 vmx_basic = vmx->nested.nested_vmx_basic;
+	u64 vmx_basic = vmx->nested.msrs.basic;
 
 	if (!is_bitwise_subset(vmx_basic, data, feature_and_reserved))
 		return -EINVAL;
@@ -2953,7 +2957,7 @@ static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 	if (vmx_basic_vmcs_size(vmx_basic) > vmx_basic_vmcs_size(data))
 		return -EINVAL;
 
-	vmx->nested.nested_vmx_basic = data;
+	vmx->nested.msrs.basic = data;
 	return 0;
 }
 
@@ -2965,24 +2969,24 @@ static int vmx_restore_vmx_basic(struct vcpu_vmx *vmx, u64 data)
 
 	switch (msr_index) {
 	case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
-		lowp = &vmx->nested.nested_vmx_pinbased_ctls_low;
-		highp = &vmx->nested.nested_vmx_pinbased_ctls_high;
+		lowp = &vmx->nested.msrs.pinbased_ctls_low;
+		highp = &vmx->nested.msrs.pinbased_ctls_high;
 		break;
 	case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
-		lowp = &vmx->nested.nested_vmx_procbased_ctls_low;
-		highp = &vmx->nested.nested_vmx_procbased_ctls_high;
+		lowp = &vmx->nested.msrs.procbased_ctls_low;
+		highp = &vmx->nested.msrs.procbased_ctls_high;
 		break;
 	case MSR_IA32_VMX_TRUE_EXIT_CTLS:
-		lowp = &vmx->nested.nested_vmx_exit_ctls_low;
-		highp = &vmx->nested.nested_vmx_exit_ctls_high;
+		lowp = &vmx->nested.msrs.exit_ctls_low;
+		highp = &vmx->nested.msrs.exit_ctls_high;
 		break;
 	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
-		lowp = &vmx->nested.nested_vmx_entry_ctls_low;
-		highp = &vmx->nested.nested_vmx_entry_ctls_high;
+		lowp = &vmx->nested.msrs.entry_ctls_low;
+		highp = &vmx->nested.msrs.entry_ctls_high;
 		break;
 	case MSR_IA32_VMX_PROCBASED_CTLS2:
-		lowp = &vmx->nested.nested_vmx_secondary_ctls_low;
-		highp = &vmx->nested.nested_vmx_secondary_ctls_high;
+		lowp = &vmx->nested.msrs.secondary_ctls_low;
+		highp = &vmx->nested.msrs.secondary_ctls_high;
 		break;
 	default:
 		BUG();
@@ -3013,13 +3017,13 @@ static int vmx_restore_vmx_misc(struct vcpu_vmx *vmx, u64 data)
 		GENMASK_ULL(13, 9) | BIT_ULL(31);
 	u64 vmx_misc;
 
-	vmx_misc = vmx_control_msr(vmx->nested.nested_vmx_misc_low,
-				   vmx->nested.nested_vmx_misc_high);
+	vmx_misc = vmx_control_msr(vmx->nested.msrs.misc_low,
+				   vmx->nested.msrs.misc_high);
 
 	if (!is_bitwise_subset(vmx_misc, data, feature_and_reserved_bits))
 		return -EINVAL;
 
-	if ((vmx->nested.nested_vmx_pinbased_ctls_high &
+	if ((vmx->nested.msrs.pinbased_ctls_high &
 	     PIN_BASED_VMX_PREEMPTION_TIMER) &&
 	    vmx_misc_preemption_timer_rate(data) !=
 	    vmx_misc_preemption_timer_rate(vmx_misc))
@@ -3034,8 +3038,8 @@ static int vmx_restore_vmx_misc(struct vcpu_vmx *vmx, u64 data)
 	if (vmx_misc_mseg_revid(data) != vmx_misc_mseg_revid(vmx_misc))
 		return -EINVAL;
 
-	vmx->nested.nested_vmx_misc_low = data;
-	vmx->nested.nested_vmx_misc_high = data >> 32;
+	vmx->nested.msrs.misc_low = data;
+	vmx->nested.msrs.misc_high = data >> 32;
 	return 0;
 }
 
@@ -3043,15 +3047,15 @@ static int vmx_restore_vmx_ept_vpid_cap(struct vcpu_vmx *vmx, u64 data)
 {
 	u64 vmx_ept_vpid_cap;
 
-	vmx_ept_vpid_cap = vmx_control_msr(vmx->nested.nested_vmx_ept_caps,
-					   vmx->nested.nested_vmx_vpid_caps);
+	vmx_ept_vpid_cap = vmx_control_msr(vmx->nested.msrs.ept_caps,
+					   vmx->nested.msrs.vpid_caps);
 
 	/* Every bit is either reserved or a feature bit. */
 	if (!is_bitwise_subset(vmx_ept_vpid_cap, data, -1ULL))
 		return -EINVAL;
 
-	vmx->nested.nested_vmx_ept_caps = data;
-	vmx->nested.nested_vmx_vpid_caps = data >> 32;
+	vmx->nested.msrs.ept_caps = data;
+	vmx->nested.msrs.vpid_caps = data >> 32;
 	return 0;
 }
 
@@ -3061,10 +3065,10 @@ static int vmx_restore_fixed0_msr(struct vcpu_vmx *vmx, u32 msr_index, u64 data)
 
 	switch (msr_index) {
 	case MSR_IA32_VMX_CR0_FIXED0:
-		msr = &vmx->nested.nested_vmx_cr0_fixed0;
+		msr = &vmx->nested.msrs.cr0_fixed0;
 		break;
 	case MSR_IA32_VMX_CR4_FIXED0:
-		msr = &vmx->nested.nested_vmx_cr4_fixed0;
+		msr = &vmx->nested.msrs.cr4_fixed0;
 		break;
 	default:
 		BUG();
@@ -3128,7 +3132,7 @@ static int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 	case MSR_IA32_VMX_EPT_VPID_CAP:
 		return vmx_restore_vmx_ept_vpid_cap(vmx, data);
 	case MSR_IA32_VMX_VMCS_ENUM:
-		vmx->nested.nested_vmx_vmcs_enum = data;
+		vmx->nested.msrs.vmcs_enum = data;
 		return 0;
 	default:
 		/*
@@ -3139,77 +3143,75 @@ static int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 }
 
 /* Returns 0 on success, non-0 otherwise. */
-static int vmx_get_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata)
+static int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u32 msr_index, u64 *pdata)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	switch (msr_index) {
 	case MSR_IA32_VMX_BASIC:
-		*pdata = vmx->nested.nested_vmx_basic;
+		*pdata = msrs->basic;
 		break;
 	case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
 	case MSR_IA32_VMX_PINBASED_CTLS:
 		*pdata = vmx_control_msr(
-			vmx->nested.nested_vmx_pinbased_ctls_low,
-			vmx->nested.nested_vmx_pinbased_ctls_high);
+			msrs->pinbased_ctls_low,
+			msrs->pinbased_ctls_high);
 		if (msr_index == MSR_IA32_VMX_PINBASED_CTLS)
 			*pdata |= PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
 		break;
 	case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
 	case MSR_IA32_VMX_PROCBASED_CTLS:
 		*pdata = vmx_control_msr(
-			vmx->nested.nested_vmx_procbased_ctls_low,
-			vmx->nested.nested_vmx_procbased_ctls_high);
+			msrs->procbased_ctls_low,
+			msrs->procbased_ctls_high);
 		if (msr_index == MSR_IA32_VMX_PROCBASED_CTLS)
 			*pdata |= CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR;
 		break;
 	case MSR_IA32_VMX_TRUE_EXIT_CTLS:
 	case MSR_IA32_VMX_EXIT_CTLS:
 		*pdata = vmx_control_msr(
-			vmx->nested.nested_vmx_exit_ctls_low,
-			vmx->nested.nested_vmx_exit_ctls_high);
+			msrs->exit_ctls_low,
+			msrs->exit_ctls_high);
 		if (msr_index == MSR_IA32_VMX_EXIT_CTLS)
 			*pdata |= VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR;
 		break;
 	case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
 	case MSR_IA32_VMX_ENTRY_CTLS:
 		*pdata = vmx_control_msr(
-			vmx->nested.nested_vmx_entry_ctls_low,
-			vmx->nested.nested_vmx_entry_ctls_high);
+			msrs->entry_ctls_low,
+			msrs->entry_ctls_high);
 		if (msr_index == MSR_IA32_VMX_ENTRY_CTLS)
 			*pdata |= VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR;
 		break;
 	case MSR_IA32_VMX_MISC:
 		*pdata = vmx_control_msr(
-			vmx->nested.nested_vmx_misc_low,
-			vmx->nested.nested_vmx_misc_high);
+			msrs->misc_low,
+			msrs->misc_high);
 		break;
 	case MSR_IA32_VMX_CR0_FIXED0:
-		*pdata = vmx->nested.nested_vmx_cr0_fixed0;
+		*pdata = msrs->cr0_fixed0;
 		break;
 	case MSR_IA32_VMX_CR0_FIXED1:
-		*pdata = vmx->nested.nested_vmx_cr0_fixed1;
+		*pdata = msrs->cr0_fixed1;
 		break;
 	case MSR_IA32_VMX_CR4_FIXED0:
-		*pdata = vmx->nested.nested_vmx_cr4_fixed0;
+		*pdata = msrs->cr4_fixed0;
 		break;
 	case MSR_IA32_VMX_CR4_FIXED1:
-		*pdata = vmx->nested.nested_vmx_cr4_fixed1;
+		*pdata = msrs->cr4_fixed1;
 		break;
 	case MSR_IA32_VMX_VMCS_ENUM:
-		*pdata = vmx->nested.nested_vmx_vmcs_enum;
+		*pdata = msrs->vmcs_enum;
 		break;
 	case MSR_IA32_VMX_PROCBASED_CTLS2:
 		*pdata = vmx_control_msr(
-			vmx->nested.nested_vmx_secondary_ctls_low,
-			vmx->nested.nested_vmx_secondary_ctls_high);
+			msrs->secondary_ctls_low,
+			msrs->secondary_ctls_high);
 		break;
 	case MSR_IA32_VMX_EPT_VPID_CAP:
-		*pdata = vmx->nested.nested_vmx_ept_caps |
-			((u64)vmx->nested.nested_vmx_vpid_caps << 32);
+		*pdata = msrs->ept_caps |
+			((u64)msrs->vpid_caps << 32);
 		break;
 	case MSR_IA32_VMX_VMFUNC:
-		*pdata = vmx->nested.nested_vmx_vmfunc_controls;
+		*pdata = msrs->vmfunc_controls;
 		break;
 	default:
 		return 1;
@@ -3312,7 +3314,8 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
 		if (!nested_vmx_allowed(vcpu))
 			return 1;
-		return vmx_get_vmx_msr(vcpu, msr_info->index, &msr_info->data);
+		return vmx_get_vmx_msr(&vmx->nested.msrs, msr_info->index,
+				       &msr_info->data);
 	case MSR_IA32_XSS:
 		if (!vmx_xsaves_supported())
 			return 1;
@@ -4342,11 +4345,11 @@ static void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 
 static bool nested_guest_cr0_valid(struct kvm_vcpu *vcpu, unsigned long val)
 {
-	u64 fixed0 = to_vmx(vcpu)->nested.nested_vmx_cr0_fixed0;
-	u64 fixed1 = to_vmx(vcpu)->nested.nested_vmx_cr0_fixed1;
+	u64 fixed0 = to_vmx(vcpu)->nested.msrs.cr0_fixed0;
+	u64 fixed1 = to_vmx(vcpu)->nested.msrs.cr0_fixed1;
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
-	if (to_vmx(vcpu)->nested.nested_vmx_secondary_ctls_high &
+	if (to_vmx(vcpu)->nested.msrs.secondary_ctls_high &
 		SECONDARY_EXEC_UNRESTRICTED_GUEST &&
 	    nested_cpu_has2(vmcs12, SECONDARY_EXEC_UNRESTRICTED_GUEST))
 		fixed0 &= ~(X86_CR0_PE | X86_CR0_PG);
@@ -4356,16 +4359,16 @@ static bool nested_guest_cr0_valid(struct kvm_vcpu *vcpu, unsigned long val)
 
 static bool nested_host_cr0_valid(struct kvm_vcpu *vcpu, unsigned long val)
 {
-	u64 fixed0 = to_vmx(vcpu)->nested.nested_vmx_cr0_fixed0;
-	u64 fixed1 = to_vmx(vcpu)->nested.nested_vmx_cr0_fixed1;
+	u64 fixed0 = to_vmx(vcpu)->nested.msrs.cr0_fixed0;
+	u64 fixed1 = to_vmx(vcpu)->nested.msrs.cr0_fixed1;
 
 	return fixed_bits_valid(val, fixed0, fixed1);
 }
 
 static bool nested_cr4_valid(struct kvm_vcpu *vcpu, unsigned long val)
 {
-	u64 fixed0 = to_vmx(vcpu)->nested.nested_vmx_cr4_fixed0;
-	u64 fixed1 = to_vmx(vcpu)->nested.nested_vmx_cr4_fixed1;
+	u64 fixed0 = to_vmx(vcpu)->nested.msrs.cr4_fixed0;
+	u64 fixed1 = to_vmx(vcpu)->nested.msrs.cr4_fixed1;
 
 	return fixed_bits_valid(val, fixed0, fixed1);
 }
@@ -5568,10 +5571,10 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 
 		if (nested) {
 			if (xsaves_enabled)
-				vmx->nested.nested_vmx_secondary_ctls_high |=
+				vmx->nested.msrs.secondary_ctls_high |=
 					SECONDARY_EXEC_XSAVES;
 			else
-				vmx->nested.nested_vmx_secondary_ctls_high &=
+				vmx->nested.msrs.secondary_ctls_high &=
 					~SECONDARY_EXEC_XSAVES;
 		}
 	}
@@ -5583,10 +5586,10 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 
 		if (nested) {
 			if (rdtscp_enabled)
-				vmx->nested.nested_vmx_secondary_ctls_high |=
+				vmx->nested.msrs.secondary_ctls_high |=
 					SECONDARY_EXEC_RDTSCP;
 			else
-				vmx->nested.nested_vmx_secondary_ctls_high &=
+				vmx->nested.msrs.secondary_ctls_high &=
 					~SECONDARY_EXEC_RDTSCP;
 		}
 	}
@@ -5604,10 +5607,10 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 
 		if (nested) {
 			if (invpcid_enabled)
-				vmx->nested.nested_vmx_secondary_ctls_high |=
+				vmx->nested.msrs.secondary_ctls_high |=
 					SECONDARY_EXEC_ENABLE_INVPCID;
 			else
-				vmx->nested.nested_vmx_secondary_ctls_high &=
+				vmx->nested.msrs.secondary_ctls_high &=
 					~SECONDARY_EXEC_ENABLE_INVPCID;
 		}
 	}
@@ -5619,10 +5622,10 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 
 		if (nested) {
 			if (rdrand_enabled)
-				vmx->nested.nested_vmx_secondary_ctls_high |=
+				vmx->nested.msrs.secondary_ctls_high |=
 					SECONDARY_EXEC_RDRAND_EXITING;
 			else
-				vmx->nested.nested_vmx_secondary_ctls_high &=
+				vmx->nested.msrs.secondary_ctls_high &=
 					~SECONDARY_EXEC_RDRAND_EXITING;
 		}
 	}
@@ -5634,10 +5637,10 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
 
 		if (nested) {
 			if (rdseed_enabled)
-				vmx->nested.nested_vmx_secondary_ctls_high |=
+				vmx->nested.msrs.secondary_ctls_high |=
 					SECONDARY_EXEC_RDSEED_EXITING;
 			else
-				vmx->nested.nested_vmx_secondary_ctls_high &=
+				vmx->nested.msrs.secondary_ctls_high &=
 					~SECONDARY_EXEC_RDSEED_EXITING;
 		}
 	}
@@ -7956,9 +7959,9 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 		u64 eptp, gpa;
 	} operand;
 
-	if (!(vmx->nested.nested_vmx_secondary_ctls_high &
+	if (!(vmx->nested.msrs.secondary_ctls_high &
 	      SECONDARY_EXEC_ENABLE_EPT) ||
-	    !(vmx->nested.nested_vmx_ept_caps & VMX_EPT_INVEPT_BIT)) {
+	    !(vmx->nested.msrs.ept_caps & VMX_EPT_INVEPT_BIT)) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
 	}
@@ -7969,7 +7972,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 	type = kvm_register_readl(vcpu, (vmx_instruction_info >> 28) & 0xf);
 
-	types = (vmx->nested.nested_vmx_ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
+	types = (vmx->nested.msrs.ept_caps >> VMX_EPT_EXTENT_SHIFT) & 6;
 
 	if (type >= 32 || !(types & (1 << type))) {
 		nested_vmx_failValid(vcpu,
@@ -8020,9 +8023,9 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 		u64 gla;
 	} operand;
 
-	if (!(vmx->nested.nested_vmx_secondary_ctls_high &
+	if (!(vmx->nested.msrs.secondary_ctls_high &
 	      SECONDARY_EXEC_ENABLE_VPID) ||
-			!(vmx->nested.nested_vmx_vpid_caps & VMX_VPID_INVVPID_BIT)) {
+			!(vmx->nested.msrs.vpid_caps & VMX_VPID_INVVPID_BIT)) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
 	}
@@ -8033,7 +8036,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 	type = kvm_register_readl(vcpu, (vmx_instruction_info >> 28) & 0xf);
 
-	types = (vmx->nested.nested_vmx_vpid_caps &
+	types = (vmx->nested.msrs.vpid_caps &
 			VMX_VPID_EXTENT_SUPPORTED_MASK) >> 8;
 
 	if (type >= 32 || !(types & (1 << type))) {
@@ -8127,11 +8130,11 @@ static bool valid_ept_address(struct kvm_vcpu *vcpu, u64 address)
 	/* Check for memory type validity */
 	switch (address & VMX_EPTP_MT_MASK) {
 	case VMX_EPTP_MT_UC:
-		if (!(vmx->nested.nested_vmx_ept_caps & VMX_EPTP_UC_BIT))
+		if (!(vmx->nested.msrs.ept_caps & VMX_EPTP_UC_BIT))
 			return false;
 		break;
 	case VMX_EPTP_MT_WB:
-		if (!(vmx->nested.nested_vmx_ept_caps & VMX_EPTP_WB_BIT))
+		if (!(vmx->nested.msrs.ept_caps & VMX_EPTP_WB_BIT))
 			return false;
 		break;
 	default:
@@ -8148,7 +8151,7 @@ static bool valid_ept_address(struct kvm_vcpu *vcpu, u64 address)
 
 	/* AD, if set, should be supported */
 	if (address & VMX_EPTP_AD_ENABLE_BIT) {
-		if (!(vmx->nested.nested_vmx_ept_caps & VMX_EPT_AD_BIT))
+		if (!(vmx->nested.msrs.ept_caps & VMX_EPT_AD_BIT))
 			return false;
 	}
 
@@ -9786,7 +9789,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	}
 
 	if (nested) {
-		nested_vmx_setup_ctls_msrs(vmx);
+		nested_vmx_setup_ctls_msrs(&vmx->nested.msrs,
+					   kvm_vcpu_apicv_active(&vmx->vcpu));
 		vmx->nested.vpid02 = allocate_vpid();
 	}
 
@@ -9913,12 +9917,12 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_cpuid_entry2 *entry;
 
-	vmx->nested.nested_vmx_cr0_fixed1 = 0xffffffff;
-	vmx->nested.nested_vmx_cr4_fixed1 = X86_CR4_PCE;
+	vmx->nested.msrs.cr0_fixed1 = 0xffffffff;
+	vmx->nested.msrs.cr4_fixed1 = X86_CR4_PCE;
 
 #define cr4_fixed1_update(_cr4_mask, _reg, _cpuid_mask) do {		\
 	if (entry && (entry->_reg & (_cpuid_mask)))			\
-		vmx->nested.nested_vmx_cr4_fixed1 |= (_cr4_mask);	\
+		vmx->nested.msrs.cr4_fixed1 |= (_cr4_mask);	\
 } while (0)
 
 	entry = kvm_find_cpuid_entry(vcpu, 0x1, 0);
@@ -10015,7 +10019,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	kvm_mmu_unload(vcpu);
 	kvm_init_shadow_ept_mmu(vcpu,
-			to_vmx(vcpu)->nested.nested_vmx_ept_caps &
+			to_vmx(vcpu)->nested.msrs.ept_caps &
 			VMX_EPT_EXECUTE_ONLY_BIT,
 			nested_ept_ad_enabled(vcpu));
 	vcpu->arch.mmu.set_cr3           = vmx_set_cr3;
@@ -10991,26 +10995,26 @@ static int check_vmentry_prereqs(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 		return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
 
 	if (!vmx_control_verify(vmcs12->cpu_based_vm_exec_control,
-				vmx->nested.nested_vmx_procbased_ctls_low,
-				vmx->nested.nested_vmx_procbased_ctls_high) ||
+				vmx->nested.msrs.procbased_ctls_low,
+				vmx->nested.msrs.procbased_ctls_high) ||
 	    (nested_cpu_has(vmcs12, CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) &&
 	     !vmx_control_verify(vmcs12->secondary_vm_exec_control,
-				 vmx->nested.nested_vmx_secondary_ctls_low,
-				 vmx->nested.nested_vmx_secondary_ctls_high)) ||
+				 vmx->nested.msrs.secondary_ctls_low,
+				 vmx->nested.msrs.secondary_ctls_high)) ||
 	    !vmx_control_verify(vmcs12->pin_based_vm_exec_control,
-				vmx->nested.nested_vmx_pinbased_ctls_low,
-				vmx->nested.nested_vmx_pinbased_ctls_high) ||
+				vmx->nested.msrs.pinbased_ctls_low,
+				vmx->nested.msrs.pinbased_ctls_high) ||
 	    !vmx_control_verify(vmcs12->vm_exit_controls,
-				vmx->nested.nested_vmx_exit_ctls_low,
-				vmx->nested.nested_vmx_exit_ctls_high) ||
+				vmx->nested.msrs.exit_ctls_low,
+				vmx->nested.msrs.exit_ctls_high) ||
 	    !vmx_control_verify(vmcs12->vm_entry_controls,
-				vmx->nested.nested_vmx_entry_ctls_low,
-				vmx->nested.nested_vmx_entry_ctls_high))
+				vmx->nested.msrs.entry_ctls_low,
+				vmx->nested.msrs.entry_ctls_high))
 		return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
 
 	if (nested_cpu_has_vmfunc(vmcs12)) {
 		if (vmcs12->vm_function_control &
-		    ~vmx->nested.nested_vmx_vmfunc_controls)
+		    ~vmx->nested.msrs.vmfunc_controls)
 			return VMXERR_ENTRY_INVALID_CONTROL_FIELD;
 
 		if (nested_cpu_has_eptp_switching(vmcs12)) {
-- 
1.8.3.1
