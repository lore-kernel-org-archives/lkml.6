Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeAaROZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:14:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932099AbeAaROW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:14:22 -0500
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
Subject: [PATCH 5/5] x86/kvm: use Enlightened VMCS when running on Hyper-V
Date: Wed, 31 Jan 2018 18:13:41 +0100
Message-Id: <20180131171341.21478-6-vkuznets@redhat.com>
In-Reply-To: <20180131171341.21478-1-vkuznets@redhat.com>
References: <20180131171341.21478-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enlightened VMCS is just a structure in memory, the main benefit
besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
mask: we tell the underlying hypervisor which fields were modified
since VMEXIT so there's no need to inspect them all.

Tight CPUID loop test shows significant speedup:
Before: 20766 cycles
After: 8912 cycles

Static key is being used to avoid performance penalty for non-Hyper-V
deployments. Tests show we add around 3 (three) CPU cycles on each
VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
but I don't see a clean way to use static key in assembly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 561 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 553 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index becf4ba053c9..26bbede946b2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -51,6 +51,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
+#include <asm/mshyperv.h>
 
 #include "trace.h"
 #include "pmu.h"
@@ -995,6 +996,442 @@ static const u32 vmx_msr_index[] = {
 	MSR_EFER, MSR_TSC_AUX, MSR_STAR,
 };
 
+DEFINE_STATIC_KEY_FALSE(enable_evmcs);
+
+#define current_evmcs ((struct hv_enlightened_vmcs *)this_cpu_read(current_vmcs))
+
+#if IS_ENABLED(CONFIG_HYPERV)
+static bool __read_mostly enlightened_vmcs = true;
+module_param(enlightened_vmcs, bool, 0444);
+
+#define EVMCS1_OFFSET(x) offsetof(struct hv_enlightened_vmcs, x)
+#define EVMCS1_FIELD(number, name, clean_mask)[ROL16(number, 6)] = \
+		(u32)EVMCS1_OFFSET(name) | ((u32)clean_mask << 16)
+
+/*
+ * Lower 16 bits encode offset of the field in struct hv_enlightened_vmcs,
+ * upped 16 bits hold clean field mask.
+ */
+static const u32 vmcs_field_to_evmcs_1[] = {
+	/* 64 bit rw */
+	EVMCS1_FIELD(GUEST_RIP, guest_rip,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(GUEST_RSP, guest_rsp,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC),
+	EVMCS1_FIELD(GUEST_RFLAGS, guest_rflags,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC),
+	EVMCS1_FIELD(HOST_IA32_PAT, host_ia32_pat,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_IA32_EFER, host_ia32_efer,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_CR0, host_cr0,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_CR3, host_cr3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_CR4, host_cr4,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_IA32_SYSENTER_ESP, host_ia32_sysenter_esp,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_IA32_SYSENTER_EIP, host_ia32_sysenter_eip,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_RIP, host_rip,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(IO_BITMAP_A, io_bitmap_a,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_IO_BITMAP),
+	EVMCS1_FIELD(IO_BITMAP_B, io_bitmap_b,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_IO_BITMAP),
+	EVMCS1_FIELD(MSR_BITMAP, msr_bitmap,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP),
+	EVMCS1_FIELD(GUEST_ES_BASE, guest_es_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_CS_BASE, guest_cs_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_SS_BASE, guest_ss_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_DS_BASE, guest_ds_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_FS_BASE, guest_fs_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_GS_BASE, guest_gs_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_LDTR_BASE, guest_ldtr_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_TR_BASE, guest_tr_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_GDTR_BASE, guest_gdtr_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IDTR_BASE, guest_idtr_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(TSC_OFFSET, tsc_offset,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+	EVMCS1_FIELD(VIRTUAL_APIC_PAGE_ADDR, virtual_apic_page_addr,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+	EVMCS1_FIELD(VMCS_LINK_POINTER, vmcs_link_pointer,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_IA32_DEBUGCTL, guest_ia32_debugctl,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_IA32_PAT, guest_ia32_pat,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_IA32_EFER, guest_ia32_efer,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_PDPTR0, guest_pdptr0,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_PDPTR1, guest_pdptr1,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_PDPTR2, guest_pdptr2,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_PDPTR3, guest_pdptr3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_PENDING_DBG_EXCEPTIONS, guest_pending_dbg_exceptions,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_SYSENTER_ESP, guest_sysenter_esp,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_SYSENTER_EIP, guest_sysenter_eip,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(CR0_GUEST_HOST_MASK, cr0_guest_host_mask,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(CR4_GUEST_HOST_MASK, cr4_guest_host_mask,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(CR0_READ_SHADOW, cr0_read_shadow,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(CR4_READ_SHADOW, cr4_read_shadow,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(GUEST_CR0, guest_cr0,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(GUEST_CR3, guest_cr3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(GUEST_CR4, guest_cr4,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(GUEST_DR7, guest_dr7,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR),
+	EVMCS1_FIELD(HOST_FS_BASE, host_fs_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_GS_BASE, host_gs_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_TR_BASE, host_tr_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_GDTR_BASE, host_gdtr_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_IDTR_BASE, host_idtr_base,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(HOST_RSP, host_rsp,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER),
+	EVMCS1_FIELD(EPT_POINTER, ept_pointer,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT),
+	EVMCS1_FIELD(GUEST_BNDCFGS, guest_bndcfgs,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(XSS_EXIT_BITMAP, xss_exit_bitmap,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
+
+	/* 64 bit read only */
+	EVMCS1_FIELD(GUEST_PHYSICAL_ADDRESS, guest_physical_address,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(EXIT_QUALIFICATION, exit_qualification,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	/*
+	 * Not defined in KVM:
+	 *
+	 * EVMCS1_FIELD(0x00006402, exit_io_instruction_ecx,
+	 *		HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE);
+	 * EVMCS1_FIELD(0x00006404, exit_io_instruction_esi,
+	 *		HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE);
+	 * EVMCS1_FIELD(0x00006406, exit_io_instruction_esi,
+	 *		HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE);
+	 * EVMCS1_FIELD(0x00006408, exit_io_instruction_eip,
+	 *		HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE);
+	 */
+	EVMCS1_FIELD(GUEST_LINEAR_ADDRESS, guest_linear_address,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+
+	/*
+	 * No mask defined in the spec as Hyper-V doesn't currently support
+	 * these. Future proof by resetting the whole clean field mask on
+	 * access.
+	 */
+	EVMCS1_FIELD(VM_EXIT_MSR_STORE_ADDR, vm_exit_msr_store_addr,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(VM_EXIT_MSR_LOAD_ADDR, vm_exit_msr_load_addr,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(VM_ENTRY_MSR_LOAD_ADDR, vm_entry_msr_load_addr,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(CR3_TARGET_VALUE0, cr3_target_value0,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(CR3_TARGET_VALUE1, cr3_target_value1,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(CR3_TARGET_VALUE2, cr3_target_value2,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(CR3_TARGET_VALUE3, cr3_target_value3,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+
+	/* 32 bit rw */
+	EVMCS1_FIELD(TPR_THRESHOLD, tpr_threshold,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(GUEST_INTERRUPTIBILITY_INFO, guest_interruptibility_info,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC),
+	EVMCS1_FIELD(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC),
+	EVMCS1_FIELD(EXCEPTION_BITMAP, exception_bitmap,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EXCPN),
+	EVMCS1_FIELD(VM_ENTRY_CONTROLS, vm_entry_controls,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_ENTRY),
+	EVMCS1_FIELD(VM_ENTRY_INTR_INFO_FIELD, vm_entry_intr_info_field,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT),
+	EVMCS1_FIELD(VM_ENTRY_EXCEPTION_ERROR_CODE,
+		     vm_entry_exception_error_code,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT),
+	EVMCS1_FIELD(VM_ENTRY_INSTRUCTION_LEN, vm_entry_instruction_len,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT),
+	EVMCS1_FIELD(HOST_IA32_SYSENTER_CS, host_ia32_sysenter_cs,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(PIN_BASED_VM_EXEC_CONTROL, pin_based_vm_exec_control,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1),
+	EVMCS1_FIELD(VM_EXIT_CONTROLS, vm_exit_controls,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1),
+	EVMCS1_FIELD(SECONDARY_VM_EXEC_CONTROL, secondary_vm_exec_control,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1),
+	EVMCS1_FIELD(GUEST_ES_LIMIT, guest_es_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_CS_LIMIT, guest_cs_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_SS_LIMIT, guest_ss_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_DS_LIMIT, guest_ds_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_FS_LIMIT, guest_fs_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_GS_LIMIT, guest_gs_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_LDTR_LIMIT, guest_ldtr_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_TR_LIMIT, guest_tr_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_GDTR_LIMIT, guest_gdtr_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_IDTR_LIMIT, guest_idtr_limit,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_ES_AR_BYTES, guest_es_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_CS_AR_BYTES, guest_cs_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_SS_AR_BYTES, guest_ss_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_DS_AR_BYTES, guest_ds_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_FS_AR_BYTES, guest_fs_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_GS_AR_BYTES, guest_gs_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_LDTR_AR_BYTES, guest_ldtr_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_TR_AR_BYTES, guest_tr_ar_bytes,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_ACTIVITY_STATE, guest_activity_state,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+	EVMCS1_FIELD(GUEST_SYSENTER_CS, guest_sysenter_cs,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1),
+
+	/* 32 bit read only */
+	EVMCS1_FIELD(VM_INSTRUCTION_ERROR, vm_instruction_error,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(VM_EXIT_REASON, vm_exit_reason,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(VM_EXIT_INTR_INFO, vm_exit_intr_info,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(VM_EXIT_INTR_ERROR_CODE, vm_exit_intr_error_code,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(IDT_VECTORING_INFO_FIELD, idt_vectoring_info_field,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(IDT_VECTORING_ERROR_CODE, idt_vectoring_error_code,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(VM_EXIT_INSTRUCTION_LEN, vm_exit_instruction_len,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+	EVMCS1_FIELD(VMX_INSTRUCTION_INFO, vmx_instruction_info,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE),
+
+	/* No mask defined in the spec (not used) */
+	EVMCS1_FIELD(PAGE_FAULT_ERROR_CODE_MASK, page_fault_error_code_mask,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(PAGE_FAULT_ERROR_CODE_MATCH, page_fault_error_code_match,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(CR3_TARGET_COUNT, cr3_target_count,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(VM_EXIT_MSR_STORE_COUNT, vm_exit_msr_store_count,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(VM_EXIT_MSR_LOAD_COUNT, vm_exit_msr_load_count,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+	EVMCS1_FIELD(VM_ENTRY_MSR_LOAD_COUNT, vm_entry_msr_load_count,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL),
+
+	/* 16 bit rw */
+	EVMCS1_FIELD(HOST_ES_SELECTOR, host_es_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_CS_SELECTOR, host_cs_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_SS_SELECTOR, host_ss_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_DS_SELECTOR, host_ds_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_FS_SELECTOR, host_fs_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_GS_SELECTOR, host_gs_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(HOST_TR_SELECTOR, host_tr_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1),
+	EVMCS1_FIELD(GUEST_ES_SELECTOR, guest_es_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_CS_SELECTOR, guest_cs_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_SS_SELECTOR, guest_ss_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_DS_SELECTOR, guest_ds_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_FS_SELECTOR, guest_fs_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_GS_SELECTOR, guest_gs_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_LDTR_SELECTOR, guest_ldtr_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(GUEST_TR_SELECTOR, guest_tr_selector,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2),
+	EVMCS1_FIELD(VIRTUAL_PROCESSOR_ID, virtual_processor_id,
+		     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT),
+
+/*
+ *  Enlightened VMCSv1 doesn't support these:
+ *	POSTED_INTR_NV                  = 0x00000002,
+ *	GUEST_INTR_STATUS               = 0x00000810,
+ *	GUEST_PML_INDEX			= 0x00000812,
+ *	PML_ADDRESS			= 0x0000200e,
+ *	APIC_ACCESS_ADDR		= 0x00002014,
+ *	POSTED_INTR_DESC_ADDR           = 0x00002016,
+ *	VM_FUNCTION_CONTROL             = 0x00002018,
+ *	EOI_EXIT_BITMAP0                = 0x0000201c,
+ *	EOI_EXIT_BITMAP1                = 0x0000201e,
+ *	EOI_EXIT_BITMAP2                = 0x00002020,
+ *	EOI_EXIT_BITMAP3                = 0x00002022,
+ *	EPTP_LIST_ADDRESS               = 0x00002024,
+ *	VMREAD_BITMAP                   = 0x00002026,
+ *	VMWRITE_BITMAP                  = 0x00002028,
+ *	TSC_MULTIPLIER                  = 0x00002032,
+ *	GUEST_IA32_PERF_GLOBAL_CTRL	= 0x00002808,
+ *	GUEST_IA32_RTIT_CTL		= 0x00002814,
+ *	HOST_IA32_PERF_GLOBAL_CTRL	= 0x00002c04,
+ *	PLE_GAP                         = 0x00004020,
+ *	PLE_WINDOW                      = 0x00004022,
+ *	VMX_PREEMPTION_TIMER_VALUE      = 0x0000482E,
+ */
+};
+
+static inline u16 get_evmcs_offset(unsigned long field)
+{
+	unsigned int index = ROL16(field, 6);
+
+	if (index >= ARRAY_SIZE(vmcs_field_to_evmcs_1))
+		return 0;
+
+	return (u16)vmcs_field_to_evmcs_1[index];
+}
+
+static inline u16 get_evmcs_offset_cf(unsigned long field, u16 *clean_field)
+{
+	unsigned int index = ROL16(field, 6);
+	u32 evmcs_field;
+
+	if (index >= ARRAY_SIZE(vmcs_field_to_evmcs_1))
+		return 0;
+
+	evmcs_field = vmcs_field_to_evmcs_1[index];
+
+	*clean_field = evmcs_field >> 16;
+
+	return (u16)evmcs_field;
+}
+
+static inline void evmcs_write64(unsigned long field, u64 value)
+{
+	u16 clean_field;
+	u16 offset = get_evmcs_offset_cf(field, &clean_field);
+
+	if (!offset)
+		return;
+
+	*(u64 *)((char *)current_evmcs + offset) = value;
+
+	current_evmcs->hv_clean_fields &= ~clean_field;
+}
+
+static inline void evmcs_write32(unsigned long field, u32 value)
+{
+	u16 clean_field;
+	u16 offset = get_evmcs_offset_cf(field, &clean_field);
+
+	if (!offset)
+		return;
+
+	*(u32 *)((char *)current_evmcs + offset) = value;
+	current_evmcs->hv_clean_fields &= ~clean_field;
+}
+
+static inline void evmcs_write16(unsigned long field, u16 value)
+{
+	u16 clean_field;
+	u16 offset = get_evmcs_offset_cf(field, &clean_field);
+
+	if (!offset)
+		return;
+
+	*(u16 *)((char *)current_evmcs + offset) = value;
+	current_evmcs->hv_clean_fields &= ~clean_field;
+}
+
+static inline u64 evmcs_read64(unsigned long field)
+{
+	u16 offset = get_evmcs_offset(field);
+
+	if (!offset)
+		return 0;
+
+	return *(u64 *)((char *)current_evmcs + offset);
+}
+
+static inline u32 evmcs_read32(unsigned long field)
+{
+	u16 offset = get_evmcs_offset(field);
+
+	if (!offset)
+		return 0;
+
+	return *(u32 *)((char *)current_evmcs + offset);
+}
+
+static inline u16 evmcs_read16(unsigned long field)
+{
+	u16 offset = get_evmcs_offset(field);
+
+	if (!offset)
+		return 0;
+
+	return *(u16 *)((char *)current_evmcs + offset);
+}
+
+static void vmcs_load_enlightened(u64 phys_addr)
+{
+	struct hv_vp_assist_page *vp_ap =
+		hv_get_vp_assist_page(smp_processor_id());
+
+	vp_ap->current_nested_vmcs = phys_addr;
+	vp_ap->enlighten_vmentry = 1;
+}
+#else /* !IS_ENABLED(CONFIG_HYPERV) */
+static inline void evmcs_write64(unsigned long field, u64 value) {}
+static inline void evmcs_write32(unsigned long field, u32 value) {}
+static inline void evmcs_write16(unsigned long field, u16 value) {}
+static inline u64 evmcs_read64(unsigned long field) { return 0; }
+static inline u32 evmcs_read32(unsigned long field) { return 0; }
+static inline u16 evmcs_read16(unsigned long field) { return 0; }
+static inline void vmcs_load_enlightened(u64 phys_addr) {}
+#endif /* IS_ENABLED(CONFIG_HYPERV) */
+
 static inline bool is_exception_n(u32 intr_info, u8 vector)
 {
 	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
@@ -1468,6 +1905,9 @@ static void vmcs_load(struct vmcs *vmcs)
 	u64 phys_addr = __pa(vmcs);
 	u8 error;
 
+	if (static_branch_unlikely(&enable_evmcs))
+		return vmcs_load_enlightened(phys_addr);
+
 	asm volatile (__ex(ASM_VMX_VMPTRLD_RAX) "; setna %0"
 			: "=qm"(error) : "a"(&phys_addr), "m"(phys_addr)
 			: "cc", "memory");
@@ -1641,18 +2081,24 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 static __always_inline u16 vmcs_read16(unsigned long field)
 {
 	vmcs_check16(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_read16(field);
 	return __vmcs_readl(field);
 }
 
 static __always_inline u32 vmcs_read32(unsigned long field)
 {
 	vmcs_check32(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_read32(field);
 	return __vmcs_readl(field);
 }
 
 static __always_inline u64 vmcs_read64(unsigned long field)
 {
 	vmcs_check64(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_read64(field);
 #ifdef CONFIG_X86_64
 	return __vmcs_readl(field);
 #else
@@ -1663,6 +2109,8 @@ static __always_inline u64 vmcs_read64(unsigned long field)
 static __always_inline unsigned long vmcs_readl(unsigned long field)
 {
 	vmcs_checkl(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_read64(field);
 	return __vmcs_readl(field);
 }
 
@@ -1686,18 +2134,27 @@ static __always_inline void __vmcs_writel(unsigned long field, unsigned long val
 static __always_inline void vmcs_write16(unsigned long field, u16 value)
 {
 	vmcs_check16(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_write16(field, value);
+
 	__vmcs_writel(field, value);
 }
 
 static __always_inline void vmcs_write32(unsigned long field, u32 value)
 {
 	vmcs_check32(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_write32(field, value);
+
 	__vmcs_writel(field, value);
 }
 
 static __always_inline void vmcs_write64(unsigned long field, u64 value)
 {
 	vmcs_check64(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_write64(field, value);
+
 	__vmcs_writel(field, value);
 #ifndef CONFIG_X86_64
 	asm volatile ("");
@@ -1708,6 +2165,9 @@ static __always_inline void vmcs_write64(unsigned long field, u64 value)
 static __always_inline void vmcs_writel(unsigned long field, unsigned long value)
 {
 	vmcs_checkl(field);
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_write64(field, value);
+
 	__vmcs_writel(field, value);
 }
 
@@ -1715,6 +2175,9 @@ static __always_inline void vmcs_clear_bits(unsigned long field, u32 mask)
 {
         BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6000) == 0x2000,
 			 "vmcs_clear_bits does not support 64-bit fields");
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_write32(field, evmcs_read32(field) & ~mask);
+
 	__vmcs_writel(field, __vmcs_readl(field) & ~mask);
 }
 
@@ -1722,6 +2185,9 @@ static __always_inline void vmcs_set_bits(unsigned long field, u32 mask)
 {
         BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6000) == 0x2000,
 			 "vmcs_set_bits does not support 64-bit fields");
+	if (static_branch_unlikely(&enable_evmcs))
+		return evmcs_write32(field, evmcs_read32(field) | mask);
+
 	__vmcs_writel(field, __vmcs_readl(field) | mask);
 }
 
@@ -3461,6 +3927,14 @@ static int hardware_enable(void)
 	if (cr4_read_shadow() & X86_CR4_VMXE)
 		return -EBUSY;
 
+	/*
+	 * This can happen if we hot-added a CPU but failed to allocate
+	 * VP assist page for it.
+	 */
+	if (static_branch_unlikely(&enable_evmcs) &&
+	    !hv_get_vp_assist_page(cpu))
+		return -EFAULT;
+
 	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
 	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
 	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
@@ -3694,7 +4168,12 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 	vmcs_conf->size = vmx_msr_high & 0x1fff;
 	vmcs_conf->order = get_order(vmcs_conf->size);
 	vmcs_conf->basic_cap = vmx_msr_high & ~0x1fff;
-	vmcs_conf->revision_id = vmx_msr_low;
+
+	/* KVM supports Enlightened VMCS v1 only */
+	if (static_branch_unlikely(&enable_evmcs))
+		vmcs_conf->revision_id = 1;
+	else
+		vmcs_conf->revision_id = vmx_msr_low;
 
 	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
 	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
@@ -9270,7 +9749,7 @@ static void vmx_arm_hv_timer(struct kvm_vcpu *vcpu)
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long cr3, cr4;
+	unsigned long cr3, cr4, evmcs_rsp;
 
 	/* Record the guest's net vcpu time for enforced NMI injections. */
 	if (unlikely(!enable_vnmi &&
@@ -9327,6 +9806,10 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	vmx_arm_hv_timer(vcpu);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
+
+	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
+		(unsigned long)&current_evmcs->host_rsp : 0;
+
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
@@ -9335,15 +9818,21 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		"cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
 		"je 1f \n\t"
 		"mov %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
+		/* Avoid VMWRITE when Enlightened VMCS is in use */
+		"test %%" _ASM_SI ", %%" _ASM_SI " \n\t"
+		"jz 2f \n\t"
+		"mov %%" _ASM_SP ", (%%" _ASM_SI ") \n\t"
+		"jmp 1f \n\t"
+		"2: \n\t"
 		__ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
 		"1: \n\t"
 		/* Reload cr2 if changed */
 		"mov %c[cr2](%0), %%" _ASM_AX " \n\t"
 		"mov %%cr2, %%" _ASM_DX " \n\t"
 		"cmp %%" _ASM_AX ", %%" _ASM_DX " \n\t"
-		"je 2f \n\t"
+		"je 3f \n\t"
 		"mov %%" _ASM_AX", %%cr2 \n\t"
-		"2: \n\t"
+		"3: \n\t"
 		/* Check if vmlaunch of vmresume is needed */
 		"cmpl $0, %c[launched](%0) \n\t"
 		/* Load guest registers.  Don't clobber flags. */
@@ -9412,7 +9901,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		".global vmx_return \n\t"
 		"vmx_return: " _ASM_PTR " 2b \n\t"
 		".popsection"
-	      : : "c"(vmx), "d"((unsigned long)HOST_RSP),
+	      : : "c"(vmx), "d"((unsigned long)HOST_RSP), "S"(evmcs_rsp),
 		[launched]"i"(offsetof(struct vcpu_vmx, __launched)),
 		[fail]"i"(offsetof(struct vcpu_vmx, fail)),
 		[host_rsp]"i"(offsetof(struct vcpu_vmx, host_rsp)),
@@ -9437,16 +9926,21 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		[wordsize]"i"(sizeof(ulong))
 	      : "cc", "memory"
 #ifdef CONFIG_X86_64
-		, "rax", "rbx", "rdi", "rsi"
+		, "rax", "rbx", "rdi"
 		, "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15"
 #else
-		, "eax", "ebx", "edi", "esi"
+		, "eax", "ebx", "edi"
 #endif
 	      );
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
+	/* All fields are clean at this point */
+	if (static_branch_unlikely(&enable_evmcs))
+		current_evmcs->hv_clean_fields |=
+			HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
+
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
 	if (vmx->host_debugctlmsr)
 		update_debugctlmsr(vmx->host_debugctlmsr);
@@ -12225,7 +12719,35 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
 
 static int __init vmx_init(void)
 {
-	int r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
+	int r;
+
+#if IS_ENABLED(CONFIG_HYPERV)
+	/*
+	 * Enlightened VMCS usage should be recommended and the host needs
+	 * to support eVMCS v1 or above. We can also disable eVMCS support
+	 * with module parameter.
+	 */
+	if (enlightened_vmcs &&
+	    ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED &&
+	    (ms_hyperv.nested_features & 0xff) >= 1) {
+		int cpu;
+
+		/* Check that we have assist pages on all online CPUs */
+		for_each_online_cpu(cpu) {
+			if (!hv_get_vp_assist_page(cpu)) {
+				enlightened_vmcs = false;
+				break;
+			}
+		}
+
+		if (enlightened_vmcs) {
+			pr_info("kvm: vmx: using Hyper-V Enlightened VMCS\n");
+			static_branch_enable(&enable_evmcs);
+		}
+	}
+#endif
+
+	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
                      __alignof__(struct vcpu_vmx), THIS_MODULE);
 	if (r)
 		return r;
@@ -12246,6 +12768,29 @@ static void __exit vmx_exit(void)
 #endif
 
 	kvm_exit();
+
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (static_branch_unlikely(&enable_evmcs)) {
+		int cpu;
+		struct hv_vp_assist_page *vp_ap;
+		/*
+		 * Reset everything to support using non-enlightened VMCS
+		 * access later (e.g. when we reload the module with
+		 * enlightened_vmcs=0)
+		 */
+		for_each_online_cpu(cpu) {
+			vp_ap =	hv_get_vp_assist_page(cpu);
+
+			if (!vp_ap)
+				continue;
+
+			vp_ap->current_nested_vmcs = 0;
+			vp_ap->enlighten_vmentry = 0;
+		}
+
+		static_branch_disable(&enable_evmcs);
+	}
+#endif
 }
 
 module_init(vmx_init)
-- 
2.14.3
