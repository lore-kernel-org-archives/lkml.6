Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63D17C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC56E208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC56E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965673AbeFOKdk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:33:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965590AbeFOKdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:33:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95AEB406F8B0;
        Fri, 15 Jun 2018 10:33:38 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 730A620284D6;
        Fri, 15 Jun 2018 10:33:36 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 3/5] KVM: nVMX: add enlightened VMCS state
References: <cb90878b-bc52-47d8-b53f-3ee3f724fe04@default>
Date:   Fri, 15 Jun 2018 12:33:35 +0200
In-Reply-To: <cb90878b-bc52-47d8-b53f-3ee3f724fe04@default> (Liran Alon's
        message of "Thu, 14 Jun 2018 16:33:16 -0700 (PDT)")
Message-ID: <87h8m4nxts.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 15 Jun 2018 10:33:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 15 Jun 2018 10:33:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

> ----- vkuznets@redhat.com wrote:
>
>> Adds hv_evmcs pointer and implement copy_enlightened_to_vmcs12() and
>> copy_enlightened_to_vmcs12().
>> 
>> prepare_vmcs02()/prepare_vmcs02_full() separation is not valid for
>> Enlightened VMCS, do full sync for now.
>> 
>> Suggested-by: Ladi Prosek <lprosek@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx.c | 431
>> +++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 417 insertions(+), 14 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 51749207cef1..e7fa9f9c6e36 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -640,10 +640,10 @@ struct nested_vmx {
>>  	 */
>>  	struct vmcs12 *cached_vmcs12;
>>  	/*
>> -	 * Indicates if the shadow vmcs must be updated with the
>> -	 * data hold by vmcs12
>> +	 * Indicates if the shadow vmcs or enlightened vmcs must be updated
>> +	 * with the data held by struct vmcs12.
>>  	 */
>> -	bool sync_shadow_vmcs;
>> +	bool need_vmcs12_sync;
>>  	bool dirty_vmcs12;
>>  
>>  	bool change_vmcs01_virtual_apic_mode;
>> @@ -689,6 +689,8 @@ struct nested_vmx {
>>  		/* in guest mode on SMM entry? */
>>  		bool guest_mode;
>>  	} smm;
>> +
>> +	struct hv_enlightened_vmcs *hv_evmcs;
>>  };
>>  
>>  #define POSTED_INTR_ON  0
>> @@ -8010,7 +8012,7 @@ static inline void nested_release_vmcs12(struct
>> vcpu_vmx *vmx)
>>  		/* copy to memory all shadowed fields in case
>>  		   they were modified */
>>  		copy_shadow_to_vmcs12(vmx);
>> -		vmx->nested.sync_shadow_vmcs = false;
>> +		vmx->nested.need_vmcs12_sync = false;
>>  		vmx_disable_shadow_vmcs(vmx);
>>  	}
>>  	vmx->nested.posted_intr_nv = -1;
>> @@ -8187,6 +8189,393 @@ static inline int vmcs12_write_any(struct
>> kvm_vcpu *vcpu,
>>  
>>  }
>>  
>> +static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, bool
>> full)
>> +{
>> +	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
>> +	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
>> +
>> +	/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
>> +	vmcs12->tpr_threshold = evmcs->tpr_threshold;
>> +	vmcs12->guest_rip = evmcs->guest_rip;
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC))) {
>> +		vmcs12->guest_rsp = evmcs->guest_rsp;
>> +		vmcs12->guest_rflags = evmcs->guest_rflags;
>> +		vmcs12->guest_interruptibility_info =
>> +			evmcs->guest_interruptibility_info;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
>> +		vmcs12->cpu_based_vm_exec_control =
>> +			evmcs->cpu_based_vm_exec_control;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
>> +		vmcs12->exception_bitmap = evmcs->exception_bitmap;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_ENTRY))) {
>> +		vmcs12->vm_entry_controls = evmcs->vm_entry_controls;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT))) {
>> +		vmcs12->vm_entry_intr_info_field =
>> +			evmcs->vm_entry_intr_info_field;
>> +		vmcs12->vm_entry_exception_error_code =
>> +			evmcs->vm_entry_exception_error_code;
>> +		vmcs12->vm_entry_instruction_len =
>> +			evmcs->vm_entry_instruction_len;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +		      HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
>> +		vmcs12->host_ia32_pat = evmcs->host_ia32_pat;
>> +		vmcs12->host_ia32_efer = evmcs->host_ia32_efer;
>> +		vmcs12->host_cr0 = evmcs->host_cr0;
>> +		vmcs12->host_cr3 = evmcs->host_cr3;
>> +		vmcs12->host_cr4 = evmcs->host_cr4;
>> +		vmcs12->host_ia32_sysenter_esp = evmcs->host_ia32_sysenter_esp;
>> +		vmcs12->host_ia32_sysenter_eip = evmcs->host_ia32_sysenter_eip;
>> +		vmcs12->host_rip = evmcs->host_rip;
>> +		vmcs12->host_ia32_sysenter_cs = evmcs->host_ia32_sysenter_cs;
>> +		vmcs12->host_es_selector = evmcs->host_es_selector;
>> +		vmcs12->host_cs_selector = evmcs->host_cs_selector;
>> +		vmcs12->host_ss_selector = evmcs->host_ss_selector;
>> +		vmcs12->host_ds_selector = evmcs->host_ds_selector;
>> +		vmcs12->host_fs_selector = evmcs->host_fs_selector;
>> +		vmcs12->host_gs_selector = evmcs->host_gs_selector;
>> +		vmcs12->host_tr_selector = evmcs->host_tr_selector;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
>> +		vmcs12->pin_based_vm_exec_control =
>> +			evmcs->pin_based_vm_exec_control;
>> +		vmcs12->vm_exit_controls = evmcs->vm_exit_controls;
>> +		vmcs12->secondary_vm_exec_control =
>> +			evmcs->secondary_vm_exec_control;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_IO_BITMAP))) {
>> +		vmcs12->io_bitmap_a = evmcs->io_bitmap_a;
>> +		vmcs12->io_bitmap_b = evmcs->io_bitmap_b;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP))) {
>> +		vmcs12->msr_bitmap = evmcs->msr_bitmap;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2))) {
>> +		vmcs12->guest_es_base = evmcs->guest_es_base;
>> +		vmcs12->guest_cs_base = evmcs->guest_cs_base;
>> +		vmcs12->guest_ss_base = evmcs->guest_ss_base;
>> +		vmcs12->guest_ds_base = evmcs->guest_ds_base;
>> +		vmcs12->guest_fs_base = evmcs->guest_fs_base;
>> +		vmcs12->guest_gs_base = evmcs->guest_gs_base;
>> +		vmcs12->guest_ldtr_base = evmcs->guest_ldtr_base;
>> +		vmcs12->guest_tr_base = evmcs->guest_tr_base;
>> +		vmcs12->guest_gdtr_base = evmcs->guest_gdtr_base;
>> +		vmcs12->guest_idtr_base = evmcs->guest_idtr_base;
>> +		vmcs12->guest_es_limit = evmcs->guest_es_limit;
>> +		vmcs12->guest_cs_limit = evmcs->guest_cs_limit;
>> +		vmcs12->guest_ss_limit = evmcs->guest_ss_limit;
>> +		vmcs12->guest_ds_limit = evmcs->guest_ds_limit;
>> +		vmcs12->guest_fs_limit = evmcs->guest_fs_limit;
>> +		vmcs12->guest_gs_limit = evmcs->guest_gs_limit;
>> +		vmcs12->guest_ldtr_limit = evmcs->guest_ldtr_limit;
>> +		vmcs12->guest_tr_limit = evmcs->guest_tr_limit;
>> +		vmcs12->guest_gdtr_limit = evmcs->guest_gdtr_limit;
>> +		vmcs12->guest_idtr_limit = evmcs->guest_idtr_limit;
>> +		vmcs12->guest_es_ar_bytes = evmcs->guest_es_ar_bytes;
>> +		vmcs12->guest_cs_ar_bytes = evmcs->guest_cs_ar_bytes;
>> +		vmcs12->guest_ss_ar_bytes = evmcs->guest_ss_ar_bytes;
>> +		vmcs12->guest_ds_ar_bytes = evmcs->guest_ds_ar_bytes;
>> +		vmcs12->guest_fs_ar_bytes = evmcs->guest_fs_ar_bytes;
>> +		vmcs12->guest_gs_ar_bytes = evmcs->guest_gs_ar_bytes;
>> +		vmcs12->guest_ldtr_ar_bytes = evmcs->guest_ldtr_ar_bytes;
>> +		vmcs12->guest_tr_ar_bytes = evmcs->guest_tr_ar_bytes;
>> +		vmcs12->guest_es_selector = evmcs->guest_es_selector;
>> +		vmcs12->guest_cs_selector = evmcs->guest_cs_selector;
>> +		vmcs12->guest_ss_selector = evmcs->guest_ss_selector;
>> +		vmcs12->guest_ds_selector = evmcs->guest_ds_selector;
>> +		vmcs12->guest_fs_selector = evmcs->guest_fs_selector;
>> +		vmcs12->guest_gs_selector = evmcs->guest_gs_selector;
>> +		vmcs12->guest_ldtr_selector = evmcs->guest_ldtr_selector;
>> +		vmcs12->guest_tr_selector = evmcs->guest_tr_selector;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2))) {
>> +		vmcs12->tsc_offset = evmcs->tsc_offset;
>> +		vmcs12->virtual_apic_page_addr = evmcs->virtual_apic_page_addr;
>> +		vmcs12->xss_exit_bitmap = evmcs->xss_exit_bitmap;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR))) {
>> +		vmcs12->cr0_guest_host_mask = evmcs->cr0_guest_host_mask;
>> +		vmcs12->cr4_guest_host_mask = evmcs->cr4_guest_host_mask;
>> +		vmcs12->cr0_read_shadow = evmcs->cr0_read_shadow;
>> +		vmcs12->cr4_read_shadow = evmcs->cr4_read_shadow;
>> +		vmcs12->guest_cr0 = evmcs->guest_cr0;
>> +		vmcs12->guest_cr3 = evmcs->guest_cr3;
>> +		vmcs12->guest_cr4 = evmcs->guest_cr4;
>> +		vmcs12->guest_dr7 = evmcs->guest_dr7;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER))) {
>> +		vmcs12->host_fs_base = evmcs->host_fs_base;
>> +		vmcs12->host_gs_base = evmcs->host_gs_base;
>> +		vmcs12->host_tr_base = evmcs->host_tr_base;
>> +		vmcs12->host_gdtr_base = evmcs->host_gdtr_base;
>> +		vmcs12->host_idtr_base = evmcs->host_idtr_base;
>> +		vmcs12->host_rsp = evmcs->host_rsp;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT))) {
>> +		vmcs12->ept_pointer = evmcs->ept_pointer;
>> +		vmcs12->virtual_processor_id = evmcs->virtual_processor_id;
>> +	}
>> +
>> +	if (unlikely(full || !(evmcs->hv_clean_fields &
>> +			       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1))) {
>> +		vmcs12->vmcs_link_pointer = evmcs->vmcs_link_pointer;
>> +		vmcs12->guest_ia32_debugctl = evmcs->guest_ia32_debugctl;
>> +		vmcs12->guest_ia32_pat = evmcs->guest_ia32_pat;
>> +		vmcs12->guest_ia32_efer = evmcs->guest_ia32_efer;
>> +		vmcs12->guest_pdptr0 = evmcs->guest_pdptr0;
>> +		vmcs12->guest_pdptr1 = evmcs->guest_pdptr1;
>> +		vmcs12->guest_pdptr2 = evmcs->guest_pdptr2;
>> +		vmcs12->guest_pdptr3 = evmcs->guest_pdptr3;
>> +		vmcs12->guest_pending_dbg_exceptions =
>> +			evmcs->guest_pending_dbg_exceptions;
>> +		vmcs12->guest_sysenter_esp = evmcs->guest_sysenter_esp;
>> +		vmcs12->guest_sysenter_eip = evmcs->guest_sysenter_eip;
>> +		vmcs12->guest_bndcfgs = evmcs->guest_bndcfgs;
>> +		vmcs12->guest_activity_state = evmcs->guest_activity_state;
>> +		vmcs12->guest_sysenter_cs = evmcs->guest_sysenter_cs;
>> +	}
>> +
>> +	/*
>> +	 * Not used?
>> +	 * vmcs12->vm_exit_msr_store_addr = evmcs->vm_exit_msr_store_addr;
>> +	 * vmcs12->vm_exit_msr_load_addr = evmcs->vm_exit_msr_load_addr;
>> +	 * vmcs12->vm_entry_msr_load_addr = evmcs->vm_entry_msr_load_addr;
>> +	 * vmcs12->cr3_target_value0 = evmcs->cr3_target_value0;
>> +	 * vmcs12->cr3_target_value1 = evmcs->cr3_target_value1;
>> +	 * vmcs12->cr3_target_value2 = evmcs->cr3_target_value2;
>> +	 * vmcs12->cr3_target_value3 = evmcs->cr3_target_value3;
>> +	 * vmcs12->page_fault_error_code_mask =
>> +	 *		evmcs->page_fault_error_code_mask;
>> +	 * vmcs12->page_fault_error_code_match =
>> +	 *		evmcs->page_fault_error_code_match;
>> +	 * vmcs12->cr3_target_count = evmcs->cr3_target_count;
>> +	 * vmcs12->vm_exit_msr_store_count =
>> evmcs->vm_exit_msr_store_count;
>> +	 * vmcs12->vm_exit_msr_load_count = evmcs->vm_exit_msr_load_count;
>> +	 * vmcs12->vm_entry_msr_load_count =
>> evmcs->vm_entry_msr_load_count;
>> +	 */
>> +
>> +	/*
>> +	 * Read only fields:
>> +	 * vmcs12->guest_physical_address = evmcs->guest_physical_address;
>> +	 * vmcs12->vm_instruction_error = evmcs->vm_instruction_error;
>> +	 * vmcs12->vm_exit_reason = evmcs->vm_exit_reason;
>> +	 * vmcs12->vm_exit_intr_info = evmcs->vm_exit_intr_info;
>> +	 * vmcs12->vm_exit_intr_error_code =
>> evmcs->vm_exit_intr_error_code;
>> +	 * vmcs12->idt_vectoring_info_field =
>> evmcs->idt_vectoring_info_field;
>> +	 * vmcs12->idt_vectoring_error_code =
>> evmcs->idt_vectoring_error_code;
>> +	 * vmcs12->vm_exit_instruction_len =
>> evmcs->vm_exit_instruction_len;
>> +	 * vmcs12->vmx_instruction_info = evmcs->vmx_instruction_info;
>> +	 * vmcs12->exit_qualification = evmcs->exit_qualification;
>> +	 * vmcs12->guest_linear_address = evmcs->guest_linear_address;
>> +	 *
>> +	 * Not present in struct vmcs12:
>> +	 * vmcs12->exit_io_instruction_ecx =
>> evmcs->exit_io_instruction_ecx;
>> +	 * vmcs12->exit_io_instruction_esi =
>> evmcs->exit_io_instruction_esi;
>> +	 * vmcs12->exit_io_instruction_edi =
>> evmcs->exit_io_instruction_edi;
>> +	 * vmcs12->exit_io_instruction_eip =
>> evmcs->exit_io_instruction_eip;
>> +	 */
>> +
>> +	return 0;
>> +}
>> +
>> +static int copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
>> +{
>> +	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
>> +	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
>> +
>> +	/*
>> +	 * Should not be changed by KVM:
>> +	 *
>> +	 * evmcs->host_es_selector = vmcs12->host_es_selector;
>> +	 * evmcs->host_cs_selector = vmcs12->host_cs_selector;
>> +	 * evmcs->host_ss_selector = vmcs12->host_ss_selector;
>> +	 * evmcs->host_ds_selector = vmcs12->host_ds_selector;
>> +	 * evmcs->host_fs_selector = vmcs12->host_fs_selector;
>> +	 * evmcs->host_gs_selector = vmcs12->host_gs_selector;
>> +	 * evmcs->host_tr_selector = vmcs12->host_tr_selector;
>> +	 * evmcs->host_ia32_pat = vmcs12->host_ia32_pat;
>> +	 * evmcs->host_ia32_efer = vmcs12->host_ia32_efer;
>> +	 * evmcs->host_cr0 = vmcs12->host_cr0;
>> +	 * evmcs->host_cr3 = vmcs12->host_cr3;
>> +	 * evmcs->host_cr4 = vmcs12->host_cr4;
>> +	 * evmcs->host_ia32_sysenter_esp = vmcs12->host_ia32_sysenter_esp;
>> +	 * evmcs->host_ia32_sysenter_eip = vmcs12->host_ia32_sysenter_eip;
>> +	 * evmcs->host_rip = vmcs12->host_rip;
>> +	 * evmcs->host_ia32_sysenter_cs = vmcs12->host_ia32_sysenter_cs;
>> +	 * evmcs->host_fs_base = vmcs12->host_fs_base;
>> +	 * evmcs->host_gs_base = vmcs12->host_gs_base;
>> +	 * evmcs->host_tr_base = vmcs12->host_tr_base;
>> +	 * evmcs->host_gdtr_base = vmcs12->host_gdtr_base;
>> +	 * evmcs->host_idtr_base = vmcs12->host_idtr_base;
>> +	 * evmcs->host_rsp = vmcs12->host_rsp;
>> +	 * sync_vmcs12() doesn't read these:
>> +	 * evmcs->io_bitmap_a = vmcs12->io_bitmap_a;
>> +	 * evmcs->io_bitmap_b = vmcs12->io_bitmap_b;
>> +	 * evmcs->msr_bitmap = vmcs12->msr_bitmap;
>> +	 * evmcs->ept_pointer = vmcs12->ept_pointer;
>> +	 * evmcs->xss_exit_bitmap = vmcs12->xss_exit_bitmap;
>> +	 * evmcs->vm_exit_msr_store_addr = vmcs12->vm_exit_msr_store_addr;
>> +	 * evmcs->vm_exit_msr_load_addr = vmcs12->vm_exit_msr_load_addr;
>> +	 * evmcs->vm_entry_msr_load_addr = vmcs12->vm_entry_msr_load_addr;
>> +	 * evmcs->cr3_target_value0 = vmcs12->cr3_target_value0;
>> +	 * evmcs->cr3_target_value1 = vmcs12->cr3_target_value1;
>> +	 * evmcs->cr3_target_value2 = vmcs12->cr3_target_value2;
>> +	 * evmcs->cr3_target_value3 = vmcs12->cr3_target_value3;
>> +	 * evmcs->tpr_threshold = vmcs12->tpr_threshold;
>> +	 * evmcs->virtual_processor_id = vmcs12->virtual_processor_id;
>> +	 * evmcs->exception_bitmap = vmcs12->exception_bitmap;
>> +	 * evmcs->vmcs_link_pointer = vmcs12->vmcs_link_pointer;
>> +	 * evmcs->pin_based_vm_exec_control =
>> vmcs12->pin_based_vm_exec_control;
>> +	 * evmcs->vm_exit_controls = vmcs12->vm_exit_controls;
>> +	 * evmcs->secondary_vm_exec_control =
>> vmcs12->secondary_vm_exec_control;
>> +	 * evmcs->page_fault_error_code_mask =
>> +	 *		vmcs12->page_fault_error_code_mask;
>> +	 * evmcs->page_fault_error_code_match =
>> +	 *		vmcs12->page_fault_error_code_match;
>> +	 * evmcs->cr3_target_count = vmcs12->cr3_target_count;
>> +	 * evmcs->virtual_apic_page_addr = vmcs12->virtual_apic_page_addr;
>> +	 * evmcs->tsc_offset = vmcs12->tsc_offset;
>> +	 * evmcs->guest_ia32_debugctl = vmcs12->guest_ia32_debugctl;
>> +	 * evmcs->cr0_guest_host_mask = vmcs12->cr0_guest_host_mask;
>> +	 * evmcs->cr4_guest_host_mask = vmcs12->cr4_guest_host_mask;
>> +	 * evmcs->cr0_read_shadow = vmcs12->cr0_read_shadow;
>> +	 * evmcs->cr4_read_shadow = vmcs12->cr4_read_shadow;
>> +	 * evmcs->vm_exit_msr_store_count =
>> vmcs12->vm_exit_msr_store_count;
>> +	 * evmcs->vm_exit_msr_load_count = vmcs12->vm_exit_msr_load_count;
>> +	 * evmcs->vm_entry_msr_load_count =
>> vmcs12->vm_entry_msr_load_count;
>> +	 *
>> +	 * Not present in struct vmcs12:
>> +	 * evmcs->exit_io_instruction_ecx =
>> vmcs12->exit_io_instruction_ecx;
>> +	 * evmcs->exit_io_instruction_esi =
>> vmcs12->exit_io_instruction_esi;
>> +	 * evmcs->exit_io_instruction_edi =
>> vmcs12->exit_io_instruction_edi;
>> +	 * evmcs->exit_io_instruction_eip =
>> vmcs12->exit_io_instruction_eip;
>> +	 */
>> +
>> +	evmcs->guest_es_selector = vmcs12->guest_es_selector;
>> +	evmcs->guest_cs_selector = vmcs12->guest_cs_selector;
>> +	evmcs->guest_ss_selector = vmcs12->guest_ss_selector;
>> +	evmcs->guest_ds_selector = vmcs12->guest_ds_selector;
>> +	evmcs->guest_fs_selector = vmcs12->guest_fs_selector;
>> +	evmcs->guest_gs_selector = vmcs12->guest_gs_selector;
>> +	evmcs->guest_ldtr_selector = vmcs12->guest_ldtr_selector;
>> +	evmcs->guest_tr_selector = vmcs12->guest_tr_selector;
>> +
>> +	evmcs->guest_es_limit = vmcs12->guest_es_limit;
>> +	evmcs->guest_cs_limit = vmcs12->guest_cs_limit;
>> +	evmcs->guest_ss_limit = vmcs12->guest_ss_limit;
>> +	evmcs->guest_ds_limit = vmcs12->guest_ds_limit;
>> +	evmcs->guest_fs_limit = vmcs12->guest_fs_limit;
>> +	evmcs->guest_gs_limit = vmcs12->guest_gs_limit;
>> +	evmcs->guest_ldtr_limit = vmcs12->guest_ldtr_limit;
>> +	evmcs->guest_tr_limit = vmcs12->guest_tr_limit;
>> +	evmcs->guest_gdtr_limit = vmcs12->guest_gdtr_limit;
>> +	evmcs->guest_idtr_limit = vmcs12->guest_idtr_limit;
>> +
>> +	evmcs->guest_es_ar_bytes = vmcs12->guest_es_ar_bytes;
>> +	evmcs->guest_cs_ar_bytes = vmcs12->guest_cs_ar_bytes;
>> +	evmcs->guest_ss_ar_bytes = vmcs12->guest_ss_ar_bytes;
>> +	evmcs->guest_ds_ar_bytes = vmcs12->guest_ds_ar_bytes;
>> +	evmcs->guest_fs_ar_bytes = vmcs12->guest_fs_ar_bytes;
>> +	evmcs->guest_gs_ar_bytes = vmcs12->guest_gs_ar_bytes;
>> +	evmcs->guest_ldtr_ar_bytes = vmcs12->guest_ldtr_ar_bytes;
>> +	evmcs->guest_tr_ar_bytes = vmcs12->guest_tr_ar_bytes;
>> +
>> +	evmcs->guest_es_base = vmcs12->guest_es_base;
>> +	evmcs->guest_cs_base = vmcs12->guest_cs_base;
>> +	evmcs->guest_ss_base = vmcs12->guest_ss_base;
>> +	evmcs->guest_ds_base = vmcs12->guest_ds_base;
>> +	evmcs->guest_fs_base = vmcs12->guest_fs_base;
>> +	evmcs->guest_gs_base = vmcs12->guest_gs_base;
>> +	evmcs->guest_ldtr_base = vmcs12->guest_ldtr_base;
>> +	evmcs->guest_tr_base = vmcs12->guest_tr_base;
>> +	evmcs->guest_gdtr_base = vmcs12->guest_gdtr_base;
>> +	evmcs->guest_idtr_base = vmcs12->guest_idtr_base;
>> +
>> +	evmcs->guest_ia32_pat = vmcs12->guest_ia32_pat;
>> +	evmcs->guest_ia32_efer = vmcs12->guest_ia32_efer;
>> +
>> +	evmcs->guest_pdptr0 = vmcs12->guest_pdptr0;
>> +	evmcs->guest_pdptr1 = vmcs12->guest_pdptr1;
>> +	evmcs->guest_pdptr2 = vmcs12->guest_pdptr2;
>> +	evmcs->guest_pdptr3 = vmcs12->guest_pdptr3;
>> +
>> +	evmcs->guest_pending_dbg_exceptions =
>> +		vmcs12->guest_pending_dbg_exceptions;
>> +	evmcs->guest_sysenter_esp = vmcs12->guest_sysenter_esp;
>> +	evmcs->guest_sysenter_eip = vmcs12->guest_sysenter_eip;
>> +
>> +	evmcs->guest_activity_state = vmcs12->guest_activity_state;
>> +	evmcs->guest_sysenter_cs = vmcs12->guest_sysenter_cs;
>> +
>> +	evmcs->guest_cr0 = vmcs12->guest_cr0;
>> +	evmcs->guest_cr3 = vmcs12->guest_cr3;
>> +	evmcs->guest_cr4 = vmcs12->guest_cr4;
>> +	evmcs->guest_dr7 = vmcs12->guest_dr7;
>> +
>> +	evmcs->guest_physical_address = vmcs12->guest_physical_address;
>> +
>> +	evmcs->vm_instruction_error = vmcs12->vm_instruction_error;
>> +	evmcs->vm_exit_reason = vmcs12->vm_exit_reason;
>> +	evmcs->vm_exit_intr_info = vmcs12->vm_exit_intr_info;
>> +	evmcs->vm_exit_intr_error_code = vmcs12->vm_exit_intr_error_code;
>> +	evmcs->idt_vectoring_info_field = vmcs12->idt_vectoring_info_field;
>> +	evmcs->idt_vectoring_error_code = vmcs12->idt_vectoring_error_code;
>> +	evmcs->vm_exit_instruction_len = vmcs12->vm_exit_instruction_len;
>> +	evmcs->vmx_instruction_info = vmcs12->vmx_instruction_info;
>> +
>> +	evmcs->exit_qualification = vmcs12->exit_qualification;
>> +
>> +	evmcs->guest_linear_address = vmcs12->guest_linear_address;
>> +	evmcs->guest_rsp = vmcs12->guest_rsp;
>> +	evmcs->guest_rflags = vmcs12->guest_rflags;
>> +
>> +	evmcs->guest_interruptibility_info =
>> +		vmcs12->guest_interruptibility_info;
>> +	evmcs->cpu_based_vm_exec_control =
>> vmcs12->cpu_based_vm_exec_control;
>> +	evmcs->vm_entry_controls = vmcs12->vm_entry_controls;
>> +	evmcs->vm_entry_intr_info_field = vmcs12->vm_entry_intr_info_field;
>> +	evmcs->vm_entry_exception_error_code =
>> +		vmcs12->vm_entry_exception_error_code;
>> +	evmcs->vm_entry_instruction_len = vmcs12->vm_entry_instruction_len;
>> +
>> +	evmcs->guest_rip = vmcs12->guest_rip;
>> +
>> +	evmcs->guest_bndcfgs = vmcs12->guest_bndcfgs;
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Copy the writable VMCS shadow fields back to the VMCS12, in case
>>   * they have been modified by the L1 guest. Note that the
>> "read-only"
>> @@ -8398,7 +8787,7 @@ static void set_current_vmptr(struct vcpu_vmx
>> *vmx, gpa_t vmptr)
>>  			      SECONDARY_EXEC_SHADOW_VMCS);
>>  		vmcs_write64(VMCS_LINK_POINTER,
>>  			     __pa(vmx->vmcs01.shadow_vmcs));
>> -		vmx->nested.sync_shadow_vmcs = true;
>> +		vmx->nested.need_vmcs12_sync = true;
>>  	}
>>  	vmx->nested.dirty_vmcs12 = true;
>>  }
>> @@ -9960,9 +10349,16 @@ static void __noclone vmx_vcpu_run(struct
>> kvm_vcpu *vcpu)
>>  		vmcs_write32(PLE_WINDOW, vmx->ple_window);
>>  	}
>>  
>> -	if (vmx->nested.sync_shadow_vmcs) {
>> -		copy_vmcs12_to_shadow(vmx);
>> -		vmx->nested.sync_shadow_vmcs = false;
>> +	if (vmx->nested.need_vmcs12_sync) {
>> +		if (unlikely(vmx->nested.hv_evmcs)) {
>
> Why is this marked with unlikely()?
> In L1 guest use eVMCS, we will always have this as true for vmx_vcpu_run()
> after simulating VMExit from L2 to L1. You should not have here unlikely()
> just like you don't have it in new code added to nested_vmx_run(). 

I think I thought "eVMCS usage is rare" but I think you're right, I'll
drop this unlikely.

>
>> +			copy_vmcs12_to_enlightened(vmx);
>> +			/* All fields are clean */
>> +			vmx->nested.hv_evmcs->hv_clean_fields |=
>> +				HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
>> +		} else {
>> +			copy_vmcs12_to_shadow(vmx);
>> +		}
>> +		vmx->nested.need_vmcs12_sync = false;
>>  	}
>>  
>>  	if (test_bit(VCPU_REGS_RSP, (unsigned long
>> *)&vcpu->arch.regs_dirty))
>> @@ -11281,7 +11677,7 @@ static int prepare_vmcs02(struct kvm_vcpu
>> *vcpu, struct vmcs12 *vmcs12,
>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>  	u32 exec_control, vmcs12_exec_ctrl;
>>  
>> -	if (vmx->nested.dirty_vmcs12) {
>> +	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs) {
>>  		prepare_vmcs02_full(vcpu, vmcs12);
>>  		vmx->nested.dirty_vmcs12 = false;
>>  	}
>> @@ -11757,8 +12153,13 @@ static int nested_vmx_run(struct kvm_vcpu
>> *vcpu, bool launch)
>>  
>>  	vmcs12 = get_vmcs12(vcpu);
>>  
>> -	if (enable_shadow_vmcs)
>> +	if (vmx->nested.hv_evmcs) {
>> +		copy_enlightened_to_vmcs12(vmx, vmx->nested.dirty_vmcs12);
>> +		/* Enlightened VMCS doesn't have launch state */
>> +		vmcs12->launch_state = !launch;
>> +	} else if (enable_shadow_vmcs) {
>>  		copy_shadow_to_vmcs12(vmx);
>> +	}
>>  
>>  	/*
>>  	 * The nested entry process starts with enforcing various
>> prerequisites
>> @@ -12383,8 +12784,8 @@ static void nested_vmx_vmexit(struct kvm_vcpu
>> *vcpu, u32 exit_reason,
>>  	 */
>>  	kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>>  
>> -	if (enable_shadow_vmcs && exit_reason != -1)
>> -		vmx->nested.sync_shadow_vmcs = true;
>> +	if ((exit_reason != -1) && (enable_shadow_vmcs ||
>> vmx->nested.hv_evmcs))
>> +		vmx->nested.need_vmcs12_sync = true;
>>  
>>  	/* in case we halted in L2 */
>>  	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>> @@ -12463,12 +12864,14 @@ static void nested_vmx_entry_failure(struct
>> kvm_vcpu *vcpu,
>>  			struct vmcs12 *vmcs12,
>>  			u32 reason, unsigned long qualification)
>>  {
>> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
>> +
>>  	load_vmcs12_host_state(vcpu, vmcs12);
>>  	vmcs12->vm_exit_reason = reason | VMX_EXIT_REASONS_FAILED_VMENTRY;
>>  	vmcs12->exit_qualification = qualification;
>>  	nested_vmx_succeed(vcpu);
>> -	if (enable_shadow_vmcs)
>> -		to_vmx(vcpu)->nested.sync_shadow_vmcs = true;
>> +	if (enable_shadow_vmcs || vmx->nested.hv_evmcs)
>> +		vmx->nested.need_vmcs12_sync = true;
>>  }
>>  
>>  static int vmx_check_intercept(struct kvm_vcpu *vcpu,
>> -- 
>> 2.14.4

-- 
  Vitaly
