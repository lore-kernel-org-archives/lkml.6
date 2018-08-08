Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D83C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC0121473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC0121473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeHHSQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:16:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbeHHSQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:16:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70A167A7E8;
        Wed,  8 Aug 2018 15:56:06 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 336692166BA0;
        Wed,  8 Aug 2018 15:56:04 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v4 04/12] KVM: nVMX: add enlightened VMCS state
Date:   Wed,  8 Aug 2018 17:55:44 +0200
Message-Id: <20180808155552.4836-5-vkuznets@redhat.com>
In-Reply-To: <20180808155552.4836-1-vkuznets@redhat.com>
References: <20180808155552.4836-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 08 Aug 2018 15:56:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 08 Aug 2018 15:56:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds hv_evmcs pointer and implement copy_enlightened_to_vmcs12() and
copy_enlightened_to_vmcs12().

prepare_vmcs02()/prepare_vmcs02_full() separation is not valid for
Enlightened VMCS, do full sync for now.

Suggested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 438 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 423 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2721d3651a5b..50fec04a7d56 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -676,10 +676,10 @@ struct nested_vmx {
 	 */
 	struct vmcs12 *cached_shadow_vmcs12;
 	/*
-	 * Indicates if the shadow vmcs must be updated with the
-	 * data hold by vmcs12
+	 * Indicates if the shadow vmcs or enlightened vmcs must be updated
+	 * with the data held by struct vmcs12.
 	 */
-	bool sync_shadow_vmcs;
+	bool need_vmcs12_sync;
 	bool dirty_vmcs12;
 
 	bool change_vmcs01_virtual_apic_mode;
@@ -725,6 +725,8 @@ struct nested_vmx {
 		/* in guest mode on SMM entry? */
 		bool guest_mode;
 	} smm;
+
+	struct hv_enlightened_vmcs *hv_evmcs;
 };
 
 #define POSTED_INTR_ON  0
@@ -8230,7 +8232,7 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
 		/* copy to memory all shadowed fields in case
 		   they were modified */
 		copy_shadow_to_vmcs12(vmx);
-		vmx->nested.sync_shadow_vmcs = false;
+		vmx->nested.need_vmcs12_sync = false;
 		vmx_disable_shadow_vmcs(vmx);
 	}
 	vmx->nested.posted_intr_nv = -1;
@@ -8408,6 +8410,393 @@ static inline int vmcs12_write_any(struct vmcs12 *vmcs12,
 
 }
 
+static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
+{
+	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
+	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
+
+	/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
+	vmcs12->tpr_threshold = evmcs->tpr_threshold;
+	vmcs12->guest_rip = evmcs->guest_rip;
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC))) {
+		vmcs12->guest_rsp = evmcs->guest_rsp;
+		vmcs12->guest_rflags = evmcs->guest_rflags;
+		vmcs12->guest_interruptibility_info =
+			evmcs->guest_interruptibility_info;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
+		vmcs12->cpu_based_vm_exec_control =
+			evmcs->cpu_based_vm_exec_control;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
+		vmcs12->exception_bitmap = evmcs->exception_bitmap;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_ENTRY))) {
+		vmcs12->vm_entry_controls = evmcs->vm_entry_controls;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT))) {
+		vmcs12->vm_entry_intr_info_field =
+			evmcs->vm_entry_intr_info_field;
+		vmcs12->vm_entry_exception_error_code =
+			evmcs->vm_entry_exception_error_code;
+		vmcs12->vm_entry_instruction_len =
+			evmcs->vm_entry_instruction_len;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
+		vmcs12->host_ia32_pat = evmcs->host_ia32_pat;
+		vmcs12->host_ia32_efer = evmcs->host_ia32_efer;
+		vmcs12->host_cr0 = evmcs->host_cr0;
+		vmcs12->host_cr3 = evmcs->host_cr3;
+		vmcs12->host_cr4 = evmcs->host_cr4;
+		vmcs12->host_ia32_sysenter_esp = evmcs->host_ia32_sysenter_esp;
+		vmcs12->host_ia32_sysenter_eip = evmcs->host_ia32_sysenter_eip;
+		vmcs12->host_rip = evmcs->host_rip;
+		vmcs12->host_ia32_sysenter_cs = evmcs->host_ia32_sysenter_cs;
+		vmcs12->host_es_selector = evmcs->host_es_selector;
+		vmcs12->host_cs_selector = evmcs->host_cs_selector;
+		vmcs12->host_ss_selector = evmcs->host_ss_selector;
+		vmcs12->host_ds_selector = evmcs->host_ds_selector;
+		vmcs12->host_fs_selector = evmcs->host_fs_selector;
+		vmcs12->host_gs_selector = evmcs->host_gs_selector;
+		vmcs12->host_tr_selector = evmcs->host_tr_selector;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
+		vmcs12->pin_based_vm_exec_control =
+			evmcs->pin_based_vm_exec_control;
+		vmcs12->vm_exit_controls = evmcs->vm_exit_controls;
+		vmcs12->secondary_vm_exec_control =
+			evmcs->secondary_vm_exec_control;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_IO_BITMAP))) {
+		vmcs12->io_bitmap_a = evmcs->io_bitmap_a;
+		vmcs12->io_bitmap_b = evmcs->io_bitmap_b;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP))) {
+		vmcs12->msr_bitmap = evmcs->msr_bitmap;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2))) {
+		vmcs12->guest_es_base = evmcs->guest_es_base;
+		vmcs12->guest_cs_base = evmcs->guest_cs_base;
+		vmcs12->guest_ss_base = evmcs->guest_ss_base;
+		vmcs12->guest_ds_base = evmcs->guest_ds_base;
+		vmcs12->guest_fs_base = evmcs->guest_fs_base;
+		vmcs12->guest_gs_base = evmcs->guest_gs_base;
+		vmcs12->guest_ldtr_base = evmcs->guest_ldtr_base;
+		vmcs12->guest_tr_base = evmcs->guest_tr_base;
+		vmcs12->guest_gdtr_base = evmcs->guest_gdtr_base;
+		vmcs12->guest_idtr_base = evmcs->guest_idtr_base;
+		vmcs12->guest_es_limit = evmcs->guest_es_limit;
+		vmcs12->guest_cs_limit = evmcs->guest_cs_limit;
+		vmcs12->guest_ss_limit = evmcs->guest_ss_limit;
+		vmcs12->guest_ds_limit = evmcs->guest_ds_limit;
+		vmcs12->guest_fs_limit = evmcs->guest_fs_limit;
+		vmcs12->guest_gs_limit = evmcs->guest_gs_limit;
+		vmcs12->guest_ldtr_limit = evmcs->guest_ldtr_limit;
+		vmcs12->guest_tr_limit = evmcs->guest_tr_limit;
+		vmcs12->guest_gdtr_limit = evmcs->guest_gdtr_limit;
+		vmcs12->guest_idtr_limit = evmcs->guest_idtr_limit;
+		vmcs12->guest_es_ar_bytes = evmcs->guest_es_ar_bytes;
+		vmcs12->guest_cs_ar_bytes = evmcs->guest_cs_ar_bytes;
+		vmcs12->guest_ss_ar_bytes = evmcs->guest_ss_ar_bytes;
+		vmcs12->guest_ds_ar_bytes = evmcs->guest_ds_ar_bytes;
+		vmcs12->guest_fs_ar_bytes = evmcs->guest_fs_ar_bytes;
+		vmcs12->guest_gs_ar_bytes = evmcs->guest_gs_ar_bytes;
+		vmcs12->guest_ldtr_ar_bytes = evmcs->guest_ldtr_ar_bytes;
+		vmcs12->guest_tr_ar_bytes = evmcs->guest_tr_ar_bytes;
+		vmcs12->guest_es_selector = evmcs->guest_es_selector;
+		vmcs12->guest_cs_selector = evmcs->guest_cs_selector;
+		vmcs12->guest_ss_selector = evmcs->guest_ss_selector;
+		vmcs12->guest_ds_selector = evmcs->guest_ds_selector;
+		vmcs12->guest_fs_selector = evmcs->guest_fs_selector;
+		vmcs12->guest_gs_selector = evmcs->guest_gs_selector;
+		vmcs12->guest_ldtr_selector = evmcs->guest_ldtr_selector;
+		vmcs12->guest_tr_selector = evmcs->guest_tr_selector;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2))) {
+		vmcs12->tsc_offset = evmcs->tsc_offset;
+		vmcs12->virtual_apic_page_addr = evmcs->virtual_apic_page_addr;
+		vmcs12->xss_exit_bitmap = evmcs->xss_exit_bitmap;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR))) {
+		vmcs12->cr0_guest_host_mask = evmcs->cr0_guest_host_mask;
+		vmcs12->cr4_guest_host_mask = evmcs->cr4_guest_host_mask;
+		vmcs12->cr0_read_shadow = evmcs->cr0_read_shadow;
+		vmcs12->cr4_read_shadow = evmcs->cr4_read_shadow;
+		vmcs12->guest_cr0 = evmcs->guest_cr0;
+		vmcs12->guest_cr3 = evmcs->guest_cr3;
+		vmcs12->guest_cr4 = evmcs->guest_cr4;
+		vmcs12->guest_dr7 = evmcs->guest_dr7;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER))) {
+		vmcs12->host_fs_base = evmcs->host_fs_base;
+		vmcs12->host_gs_base = evmcs->host_gs_base;
+		vmcs12->host_tr_base = evmcs->host_tr_base;
+		vmcs12->host_gdtr_base = evmcs->host_gdtr_base;
+		vmcs12->host_idtr_base = evmcs->host_idtr_base;
+		vmcs12->host_rsp = evmcs->host_rsp;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT))) {
+		vmcs12->ept_pointer = evmcs->ept_pointer;
+		vmcs12->virtual_processor_id = evmcs->virtual_processor_id;
+	}
+
+	if (unlikely(!(evmcs->hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1))) {
+		vmcs12->vmcs_link_pointer = evmcs->vmcs_link_pointer;
+		vmcs12->guest_ia32_debugctl = evmcs->guest_ia32_debugctl;
+		vmcs12->guest_ia32_pat = evmcs->guest_ia32_pat;
+		vmcs12->guest_ia32_efer = evmcs->guest_ia32_efer;
+		vmcs12->guest_pdptr0 = evmcs->guest_pdptr0;
+		vmcs12->guest_pdptr1 = evmcs->guest_pdptr1;
+		vmcs12->guest_pdptr2 = evmcs->guest_pdptr2;
+		vmcs12->guest_pdptr3 = evmcs->guest_pdptr3;
+		vmcs12->guest_pending_dbg_exceptions =
+			evmcs->guest_pending_dbg_exceptions;
+		vmcs12->guest_sysenter_esp = evmcs->guest_sysenter_esp;
+		vmcs12->guest_sysenter_eip = evmcs->guest_sysenter_eip;
+		vmcs12->guest_bndcfgs = evmcs->guest_bndcfgs;
+		vmcs12->guest_activity_state = evmcs->guest_activity_state;
+		vmcs12->guest_sysenter_cs = evmcs->guest_sysenter_cs;
+	}
+
+	/*
+	 * Not used?
+	 * vmcs12->vm_exit_msr_store_addr = evmcs->vm_exit_msr_store_addr;
+	 * vmcs12->vm_exit_msr_load_addr = evmcs->vm_exit_msr_load_addr;
+	 * vmcs12->vm_entry_msr_load_addr = evmcs->vm_entry_msr_load_addr;
+	 * vmcs12->cr3_target_value0 = evmcs->cr3_target_value0;
+	 * vmcs12->cr3_target_value1 = evmcs->cr3_target_value1;
+	 * vmcs12->cr3_target_value2 = evmcs->cr3_target_value2;
+	 * vmcs12->cr3_target_value3 = evmcs->cr3_target_value3;
+	 * vmcs12->page_fault_error_code_mask =
+	 *		evmcs->page_fault_error_code_mask;
+	 * vmcs12->page_fault_error_code_match =
+	 *		evmcs->page_fault_error_code_match;
+	 * vmcs12->cr3_target_count = evmcs->cr3_target_count;
+	 * vmcs12->vm_exit_msr_store_count = evmcs->vm_exit_msr_store_count;
+	 * vmcs12->vm_exit_msr_load_count = evmcs->vm_exit_msr_load_count;
+	 * vmcs12->vm_entry_msr_load_count = evmcs->vm_entry_msr_load_count;
+	 */
+
+	/*
+	 * Read only fields:
+	 * vmcs12->guest_physical_address = evmcs->guest_physical_address;
+	 * vmcs12->vm_instruction_error = evmcs->vm_instruction_error;
+	 * vmcs12->vm_exit_reason = evmcs->vm_exit_reason;
+	 * vmcs12->vm_exit_intr_info = evmcs->vm_exit_intr_info;
+	 * vmcs12->vm_exit_intr_error_code = evmcs->vm_exit_intr_error_code;
+	 * vmcs12->idt_vectoring_info_field = evmcs->idt_vectoring_info_field;
+	 * vmcs12->idt_vectoring_error_code = evmcs->idt_vectoring_error_code;
+	 * vmcs12->vm_exit_instruction_len = evmcs->vm_exit_instruction_len;
+	 * vmcs12->vmx_instruction_info = evmcs->vmx_instruction_info;
+	 * vmcs12->exit_qualification = evmcs->exit_qualification;
+	 * vmcs12->guest_linear_address = evmcs->guest_linear_address;
+	 *
+	 * Not present in struct vmcs12:
+	 * vmcs12->exit_io_instruction_ecx = evmcs->exit_io_instruction_ecx;
+	 * vmcs12->exit_io_instruction_esi = evmcs->exit_io_instruction_esi;
+	 * vmcs12->exit_io_instruction_edi = evmcs->exit_io_instruction_edi;
+	 * vmcs12->exit_io_instruction_eip = evmcs->exit_io_instruction_eip;
+	 */
+
+	return 0;
+}
+
+static int copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
+{
+	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
+	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
+
+	/*
+	 * Should not be changed by KVM:
+	 *
+	 * evmcs->host_es_selector = vmcs12->host_es_selector;
+	 * evmcs->host_cs_selector = vmcs12->host_cs_selector;
+	 * evmcs->host_ss_selector = vmcs12->host_ss_selector;
+	 * evmcs->host_ds_selector = vmcs12->host_ds_selector;
+	 * evmcs->host_fs_selector = vmcs12->host_fs_selector;
+	 * evmcs->host_gs_selector = vmcs12->host_gs_selector;
+	 * evmcs->host_tr_selector = vmcs12->host_tr_selector;
+	 * evmcs->host_ia32_pat = vmcs12->host_ia32_pat;
+	 * evmcs->host_ia32_efer = vmcs12->host_ia32_efer;
+	 * evmcs->host_cr0 = vmcs12->host_cr0;
+	 * evmcs->host_cr3 = vmcs12->host_cr3;
+	 * evmcs->host_cr4 = vmcs12->host_cr4;
+	 * evmcs->host_ia32_sysenter_esp = vmcs12->host_ia32_sysenter_esp;
+	 * evmcs->host_ia32_sysenter_eip = vmcs12->host_ia32_sysenter_eip;
+	 * evmcs->host_rip = vmcs12->host_rip;
+	 * evmcs->host_ia32_sysenter_cs = vmcs12->host_ia32_sysenter_cs;
+	 * evmcs->host_fs_base = vmcs12->host_fs_base;
+	 * evmcs->host_gs_base = vmcs12->host_gs_base;
+	 * evmcs->host_tr_base = vmcs12->host_tr_base;
+	 * evmcs->host_gdtr_base = vmcs12->host_gdtr_base;
+	 * evmcs->host_idtr_base = vmcs12->host_idtr_base;
+	 * evmcs->host_rsp = vmcs12->host_rsp;
+	 * sync_vmcs12() doesn't read these:
+	 * evmcs->io_bitmap_a = vmcs12->io_bitmap_a;
+	 * evmcs->io_bitmap_b = vmcs12->io_bitmap_b;
+	 * evmcs->msr_bitmap = vmcs12->msr_bitmap;
+	 * evmcs->ept_pointer = vmcs12->ept_pointer;
+	 * evmcs->xss_exit_bitmap = vmcs12->xss_exit_bitmap;
+	 * evmcs->vm_exit_msr_store_addr = vmcs12->vm_exit_msr_store_addr;
+	 * evmcs->vm_exit_msr_load_addr = vmcs12->vm_exit_msr_load_addr;
+	 * evmcs->vm_entry_msr_load_addr = vmcs12->vm_entry_msr_load_addr;
+	 * evmcs->cr3_target_value0 = vmcs12->cr3_target_value0;
+	 * evmcs->cr3_target_value1 = vmcs12->cr3_target_value1;
+	 * evmcs->cr3_target_value2 = vmcs12->cr3_target_value2;
+	 * evmcs->cr3_target_value3 = vmcs12->cr3_target_value3;
+	 * evmcs->tpr_threshold = vmcs12->tpr_threshold;
+	 * evmcs->virtual_processor_id = vmcs12->virtual_processor_id;
+	 * evmcs->exception_bitmap = vmcs12->exception_bitmap;
+	 * evmcs->vmcs_link_pointer = vmcs12->vmcs_link_pointer;
+	 * evmcs->pin_based_vm_exec_control = vmcs12->pin_based_vm_exec_control;
+	 * evmcs->vm_exit_controls = vmcs12->vm_exit_controls;
+	 * evmcs->secondary_vm_exec_control = vmcs12->secondary_vm_exec_control;
+	 * evmcs->page_fault_error_code_mask =
+	 *		vmcs12->page_fault_error_code_mask;
+	 * evmcs->page_fault_error_code_match =
+	 *		vmcs12->page_fault_error_code_match;
+	 * evmcs->cr3_target_count = vmcs12->cr3_target_count;
+	 * evmcs->virtual_apic_page_addr = vmcs12->virtual_apic_page_addr;
+	 * evmcs->tsc_offset = vmcs12->tsc_offset;
+	 * evmcs->guest_ia32_debugctl = vmcs12->guest_ia32_debugctl;
+	 * evmcs->cr0_guest_host_mask = vmcs12->cr0_guest_host_mask;
+	 * evmcs->cr4_guest_host_mask = vmcs12->cr4_guest_host_mask;
+	 * evmcs->cr0_read_shadow = vmcs12->cr0_read_shadow;
+	 * evmcs->cr4_read_shadow = vmcs12->cr4_read_shadow;
+	 * evmcs->vm_exit_msr_store_count = vmcs12->vm_exit_msr_store_count;
+	 * evmcs->vm_exit_msr_load_count = vmcs12->vm_exit_msr_load_count;
+	 * evmcs->vm_entry_msr_load_count = vmcs12->vm_entry_msr_load_count;
+	 *
+	 * Not present in struct vmcs12:
+	 * evmcs->exit_io_instruction_ecx = vmcs12->exit_io_instruction_ecx;
+	 * evmcs->exit_io_instruction_esi = vmcs12->exit_io_instruction_esi;
+	 * evmcs->exit_io_instruction_edi = vmcs12->exit_io_instruction_edi;
+	 * evmcs->exit_io_instruction_eip = vmcs12->exit_io_instruction_eip;
+	 */
+
+	evmcs->guest_es_selector = vmcs12->guest_es_selector;
+	evmcs->guest_cs_selector = vmcs12->guest_cs_selector;
+	evmcs->guest_ss_selector = vmcs12->guest_ss_selector;
+	evmcs->guest_ds_selector = vmcs12->guest_ds_selector;
+	evmcs->guest_fs_selector = vmcs12->guest_fs_selector;
+	evmcs->guest_gs_selector = vmcs12->guest_gs_selector;
+	evmcs->guest_ldtr_selector = vmcs12->guest_ldtr_selector;
+	evmcs->guest_tr_selector = vmcs12->guest_tr_selector;
+
+	evmcs->guest_es_limit = vmcs12->guest_es_limit;
+	evmcs->guest_cs_limit = vmcs12->guest_cs_limit;
+	evmcs->guest_ss_limit = vmcs12->guest_ss_limit;
+	evmcs->guest_ds_limit = vmcs12->guest_ds_limit;
+	evmcs->guest_fs_limit = vmcs12->guest_fs_limit;
+	evmcs->guest_gs_limit = vmcs12->guest_gs_limit;
+	evmcs->guest_ldtr_limit = vmcs12->guest_ldtr_limit;
+	evmcs->guest_tr_limit = vmcs12->guest_tr_limit;
+	evmcs->guest_gdtr_limit = vmcs12->guest_gdtr_limit;
+	evmcs->guest_idtr_limit = vmcs12->guest_idtr_limit;
+
+	evmcs->guest_es_ar_bytes = vmcs12->guest_es_ar_bytes;
+	evmcs->guest_cs_ar_bytes = vmcs12->guest_cs_ar_bytes;
+	evmcs->guest_ss_ar_bytes = vmcs12->guest_ss_ar_bytes;
+	evmcs->guest_ds_ar_bytes = vmcs12->guest_ds_ar_bytes;
+	evmcs->guest_fs_ar_bytes = vmcs12->guest_fs_ar_bytes;
+	evmcs->guest_gs_ar_bytes = vmcs12->guest_gs_ar_bytes;
+	evmcs->guest_ldtr_ar_bytes = vmcs12->guest_ldtr_ar_bytes;
+	evmcs->guest_tr_ar_bytes = vmcs12->guest_tr_ar_bytes;
+
+	evmcs->guest_es_base = vmcs12->guest_es_base;
+	evmcs->guest_cs_base = vmcs12->guest_cs_base;
+	evmcs->guest_ss_base = vmcs12->guest_ss_base;
+	evmcs->guest_ds_base = vmcs12->guest_ds_base;
+	evmcs->guest_fs_base = vmcs12->guest_fs_base;
+	evmcs->guest_gs_base = vmcs12->guest_gs_base;
+	evmcs->guest_ldtr_base = vmcs12->guest_ldtr_base;
+	evmcs->guest_tr_base = vmcs12->guest_tr_base;
+	evmcs->guest_gdtr_base = vmcs12->guest_gdtr_base;
+	evmcs->guest_idtr_base = vmcs12->guest_idtr_base;
+
+	evmcs->guest_ia32_pat = vmcs12->guest_ia32_pat;
+	evmcs->guest_ia32_efer = vmcs12->guest_ia32_efer;
+
+	evmcs->guest_pdptr0 = vmcs12->guest_pdptr0;
+	evmcs->guest_pdptr1 = vmcs12->guest_pdptr1;
+	evmcs->guest_pdptr2 = vmcs12->guest_pdptr2;
+	evmcs->guest_pdptr3 = vmcs12->guest_pdptr3;
+
+	evmcs->guest_pending_dbg_exceptions =
+		vmcs12->guest_pending_dbg_exceptions;
+	evmcs->guest_sysenter_esp = vmcs12->guest_sysenter_esp;
+	evmcs->guest_sysenter_eip = vmcs12->guest_sysenter_eip;
+
+	evmcs->guest_activity_state = vmcs12->guest_activity_state;
+	evmcs->guest_sysenter_cs = vmcs12->guest_sysenter_cs;
+
+	evmcs->guest_cr0 = vmcs12->guest_cr0;
+	evmcs->guest_cr3 = vmcs12->guest_cr3;
+	evmcs->guest_cr4 = vmcs12->guest_cr4;
+	evmcs->guest_dr7 = vmcs12->guest_dr7;
+
+	evmcs->guest_physical_address = vmcs12->guest_physical_address;
+
+	evmcs->vm_instruction_error = vmcs12->vm_instruction_error;
+	evmcs->vm_exit_reason = vmcs12->vm_exit_reason;
+	evmcs->vm_exit_intr_info = vmcs12->vm_exit_intr_info;
+	evmcs->vm_exit_intr_error_code = vmcs12->vm_exit_intr_error_code;
+	evmcs->idt_vectoring_info_field = vmcs12->idt_vectoring_info_field;
+	evmcs->idt_vectoring_error_code = vmcs12->idt_vectoring_error_code;
+	evmcs->vm_exit_instruction_len = vmcs12->vm_exit_instruction_len;
+	evmcs->vmx_instruction_info = vmcs12->vmx_instruction_info;
+
+	evmcs->exit_qualification = vmcs12->exit_qualification;
+
+	evmcs->guest_linear_address = vmcs12->guest_linear_address;
+	evmcs->guest_rsp = vmcs12->guest_rsp;
+	evmcs->guest_rflags = vmcs12->guest_rflags;
+
+	evmcs->guest_interruptibility_info =
+		vmcs12->guest_interruptibility_info;
+	evmcs->cpu_based_vm_exec_control = vmcs12->cpu_based_vm_exec_control;
+	evmcs->vm_entry_controls = vmcs12->vm_entry_controls;
+	evmcs->vm_entry_intr_info_field = vmcs12->vm_entry_intr_info_field;
+	evmcs->vm_entry_exception_error_code =
+		vmcs12->vm_entry_exception_error_code;
+	evmcs->vm_entry_instruction_len = vmcs12->vm_entry_instruction_len;
+
+	evmcs->guest_rip = vmcs12->guest_rip;
+
+	evmcs->guest_bndcfgs = vmcs12->guest_bndcfgs;
+
+	return 0;
+}
+
 /*
  * Copy the writable VMCS shadow fields back to the VMCS12, in case
  * they have been modified by the L1 guest. Note that the "read-only"
@@ -8656,7 +9045,7 @@ static void set_current_vmptr(struct vcpu_vmx *vmx, gpa_t vmptr)
 			      SECONDARY_EXEC_SHADOW_VMCS);
 		vmcs_write64(VMCS_LINK_POINTER,
 			     __pa(vmx->vmcs01.shadow_vmcs));
-		vmx->nested.sync_shadow_vmcs = true;
+		vmx->nested.need_vmcs12_sync = true;
 	}
 	vmx->nested.dirty_vmcs12 = true;
 }
@@ -10361,9 +10750,16 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		vmcs_write32(PLE_WINDOW, vmx->ple_window);
 	}
 
-	if (vmx->nested.sync_shadow_vmcs) {
-		copy_vmcs12_to_shadow(vmx);
-		vmx->nested.sync_shadow_vmcs = false;
+	if (vmx->nested.need_vmcs12_sync) {
+		if (vmx->nested.hv_evmcs) {
+			copy_vmcs12_to_enlightened(vmx);
+			/* All fields are clean */
+			vmx->nested.hv_evmcs->hv_clean_fields |=
+				HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
+		} else {
+			copy_vmcs12_to_shadow(vmx);
+		}
+		vmx->nested.need_vmcs12_sync = false;
 	}
 
 	if (test_bit(VCPU_REGS_RSP, (unsigned long *)&vcpu->arch.regs_dirty))
@@ -11733,7 +12129,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u32 exec_control, vmcs12_exec_ctrl;
 
-	if (vmx->nested.dirty_vmcs12) {
+	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs) {
 		prepare_vmcs02_full(vcpu, vmcs12);
 		vmx->nested.dirty_vmcs12 = false;
 	}
@@ -12317,8 +12713,13 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 		goto out;
 	}
 
-	if (enable_shadow_vmcs)
+	if (vmx->nested.hv_evmcs) {
+		copy_enlightened_to_vmcs12(vmx);
+		/* Enlightened VMCS doesn't have launch state */
+		vmcs12->launch_state = !launch;
+	} else if (enable_shadow_vmcs) {
 		copy_shadow_to_vmcs12(vmx);
+	}
 
 	/*
 	 * The nested entry process starts with enforcing various prerequisites
@@ -12967,8 +13368,8 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	 */
 	kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 
-	if (enable_shadow_vmcs && exit_reason != -1)
-		vmx->nested.sync_shadow_vmcs = true;
+	if ((exit_reason != -1) && (enable_shadow_vmcs || vmx->nested.hv_evmcs))
+		vmx->nested.need_vmcs12_sync = true;
 
 	/* in case we halted in L2 */
 	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
@@ -13047,12 +13448,14 @@ static void nested_vmx_entry_failure(struct kvm_vcpu *vcpu,
 			struct vmcs12 *vmcs12,
 			u32 reason, unsigned long qualification)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = reason | VMX_EXIT_REASONS_FAILED_VMENTRY;
 	vmcs12->exit_qualification = qualification;
 	nested_vmx_succeed(vcpu);
-	if (enable_shadow_vmcs)
-		to_vmx(vcpu)->nested.sync_shadow_vmcs = true;
+	if (enable_shadow_vmcs || vmx->nested.hv_evmcs)
+		vmx->nested.need_vmcs12_sync = true;
 }
 
 static int vmx_check_intercept(struct kvm_vcpu *vcpu,
@@ -13518,6 +13921,11 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 
 	vmx = to_vmx(vcpu);
 	vmcs12 = get_vmcs12(vcpu);
+
+	/* FIXME: Enlightened VMCS is currently unsupported */
+	if (vmx->nested.hv_evmcs)
+		return -ENOTSUPP;
+
 	if (nested_vmx_allowed(vcpu) &&
 	    (vmx->nested.vmxon || vmx->nested.smm.vmxon)) {
 		kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
@@ -13564,7 +13972,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	 */
 	if (is_guest_mode(vcpu))
 		sync_vmcs12(vcpu, vmcs12);
-	else if (enable_shadow_vmcs && !vmx->nested.sync_shadow_vmcs)
+	else if (enable_shadow_vmcs && !vmx->nested.need_vmcs12_sync)
 		copy_shadow_to_vmcs12(vmx);
 
 	if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
-- 
2.14.4

