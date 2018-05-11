Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeEKNiK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:38:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753212AbeEKNiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:38:05 -0400
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
Subject: [PATCH RFC v2 5/5] KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
Date: Fri, 11 May 2018 15:37:51 +0200
Message-Id: <20180511133751.13414-6-vkuznets@redhat.com>
In-Reply-To: <20180511133751.13414-1-vkuznets@redhat.com>
References: <20180511133751.13414-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Enlightened VMCS is in use by L1 hypervisor we can avoid vmwriting
VMCS fields which did not change.

Our first goal is to achieve minimal impact on traditional VMCS case so
we're not wrapping each vmwrite() with an if-changed checker. We also can't
utilize static keys as Enlightened VMCS usage is per-guest.

This patch implements the simpliest solution: checking fields in groups.
We skip sing vmwrite() statements as doing the check will cost us something
even in non-evmcs case and the win is tiny. Unfortunately, this makes
prepare_vmcs02_full{,_full}() code Enlightened VMCS-dependent (and ugly).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 143 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 82 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c74374f74ea7..cd27a7e96ed7 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11357,51 +11357,80 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
 	return 0;
 }
 
+/*
+ * Check if L1 hypervisor changed the particular field in Enlightened
+ * VMCS and avoid redundant vmwrite if it didn't. Can only be used when
+ * the value we're about to write is unchanged vmcs12->field.
+ */
+#define evmcs_needs_write(vmx, clean_field) ((vmx)->nested.dirty_vmcs12 ||\
+	!(vmx->nested.hv_evmcs->hv_clean_fields & 			\
+	  HV_VMX_ENLIGHTENED_CLEAN_FIELD_##clean_field))
+
 static void prepare_vmcs02_full(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			       bool from_vmentry)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
+
+	if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP2)) {
+		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
+		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
+		vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
+		vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
+		vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
+		vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
+		vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
+		vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
+		vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
+		vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
+		vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
+		vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
+		vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
+		vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
+		vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
+		vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
+		vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
+		vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
+		vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
+		vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
+		vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
+		vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
+		vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
+		vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
+		vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
+		vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
+		vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
+		vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
+		vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
+		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
+		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
+	}
+
+	if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP1)) {
+		vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
+		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
+			    vmcs12->guest_pending_dbg_exceptions);
+		vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
+		vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
+
+		if (vmx_mpx_supported())
+			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
 
-	vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
-	vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
-	vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
-	vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
-	vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
-	vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
-	vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
-	vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
-	vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
-	vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
-	vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
-	vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
-	vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
-	vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
-	vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
-	vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
-	vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
-	vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
-	vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
-	vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
-	vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
-	vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
-	vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
-	vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
-	vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
-	vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
-	vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
-	vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
-	vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
-	vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
-	vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
-
-	vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
-	vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
-		vmcs12->guest_pending_dbg_exceptions);
-	vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
-	vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
+		/*
+		 * L1 may access the L2's PDPTR, so save them to construct
+		 * vmcs12
+		 */
+		if (enable_ept) {
+			vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
+			vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
+			vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
+			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
+		}
+	}
 
 	if (nested_cpu_has_xsaves(vmcs12))
 		vmcs_write64(XSS_EXIT_BITMAP, vmcs12->xss_exit_bitmap);
+
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
 
 	if (cpu_has_vmx_posted_intr())
@@ -11456,9 +11485,6 @@ static void prepare_vmcs02_full(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 
 	set_cr4_guest_host_mask(vmx);
 
-	if (vmx_mpx_supported())
-		vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
-
 	if (enable_vpid) {
 		if (nested_cpu_has_vpid(vmcs12) && vmx->nested.vpid02)
 			vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->nested.vpid02);
@@ -11466,16 +11492,6 @@ static void prepare_vmcs02_full(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->vpid);
 	}
 
-	/*
-	 * L1 may access the L2's PDPTR, so save them to construct vmcs12
-	 */
-	if (enable_ept) {
-		vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
-		vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
-		vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
-		vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
-	}
-
 	if (cpu_has_vmx_msr_bitmap())
 		vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
 }
@@ -11496,17 +11512,20 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 exec_control, vmcs12_exec_ctrl;
+	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
 
 	/*
 	 * First, the fields that are shadowed.  This must be kept in sync
 	 * with vmx_shadow_fields.h.
 	 */
 
-	vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
-	vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
-	vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
-	vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
-	vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
+	if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP2)) {
+		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
+		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
+		vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
+		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
+		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
+	}
 
 	/*
 	 * Not in vmcs02: GUEST_PML_INDEX, HOST_FS_SELECTOR, HOST_GS_SELECTOR,
@@ -11522,12 +11541,14 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.vmcs01_debugctl);
 	}
 	if (from_vmentry) {
-		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
-			     vmcs12->vm_entry_intr_info_field);
-		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
-			     vmcs12->vm_entry_exception_error_code);
-		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
-			     vmcs12->vm_entry_instruction_len);
+		if (!hv_evmcs || evmcs_needs_write(vmx, CONTROL_EVENT)) {
+			vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
+				     vmcs12->vm_entry_intr_info_field);
+			vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
+				     vmcs12->vm_entry_exception_error_code);
+			vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
+				     vmcs12->vm_entry_instruction_len);
+		}
 		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
 			     vmcs12->guest_interruptibility_info);
 		vmx->loaded_vmcs->nmi_known_unmasked =
-- 
2.14.3
