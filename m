Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3DBE8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A83208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A83208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965648AbeFOKbu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:31:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965590AbeFOKbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DDB94023841;
        Fri, 15 Jun 2018 10:31:48 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E62C72017D02;
        Fri, 15 Jun 2018 10:31:45 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Liran Alon <liran.alon@oracle.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 5/5] KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case
References: <55506b65-0b32-45cf-8fd5-5c2d1b0ac30c@default>
Date:   Fri, 15 Jun 2018 12:31:44 +0200
In-Reply-To: <55506b65-0b32-45cf-8fd5-5c2d1b0ac30c@default> (Liran Alon's
        message of "Thu, 14 Jun 2018 16:37:23 -0700 (PDT)")
Message-ID: <87o9gcnxwv.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 15 Jun 2018 10:31:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 15 Jun 2018 10:31:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liran Alon <liran.alon@oracle.com> writes:

> ----- vkuznets@redhat.com wrote:
>
>> When Enlightened VMCS is in use by L1 hypervisor we can avoid
>> vmwriting
>> VMCS fields which did not change.
>> 
>> Our first goal is to achieve minimal impact on traditional VMCS case
>> so
>> we're not wrapping each vmwrite() with an if-changed checker. We also
>> can't
>> utilize static keys as Enlightened VMCS usage is per-guest.
>> 
>> This patch implements the simpliest solution: checking fields in
>> groups.
>> We skip single vmwrite() statements as doing the check will cost us
>> something even in non-evmcs case and the win is tiny. Unfortunately,
>> this
>> makes prepare_vmcs02_full{,_full}() code Enlightened VMCS-dependent
>> (and
>> a bit ugly).
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/vmx.c | 143
>> ++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 82 insertions(+), 61 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 6802ba91468c..9a7d76c5c92b 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -11619,50 +11619,79 @@ static int nested_vmx_load_cr3(struct
>> kvm_vcpu *vcpu, unsigned long cr3, bool ne
>>  	return 0;
>>  }
>>  
>> +/*
>> + * Check if L1 hypervisor changed the particular field in
>> Enlightened
>> + * VMCS and avoid redundant vmwrite if it didn't. Can only be used
>> when
>> + * the value we're about to write is unchanged vmcs12->field.
>> + */
>> +#define evmcs_needs_write(vmx, clean_field)
>> ((vmx)->nested.dirty_vmcs12 ||\
>> +	!(vmx->nested.hv_evmcs->hv_clean_fields &\
>> +	  HV_VMX_ENLIGHTENED_CLEAN_FIELD_##clean_field))
>
> Why declare this is a macro instead of an static inline small function?
> Just to shorten the name of the clean-field constant?
>

To be completely honest I forgot why I used define but I think yes, it
was because HV_VMX_ENLIGHTENED_CLEAN_FIELD_* constants are very long.

>> +
>>  static void prepare_vmcs02_full(struct kvm_vcpu *vcpu, struct vmcs12
>> *vmcs12)
>>  {
>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>> +	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
>> +
>> +	if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP2)) {
>> +		vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
>> +		vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
>> +		vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
>> +		vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
>> +		vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
>> +		vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
>> +		vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
>> +		vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
>> +		vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
>> +		vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
>> +		vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
>> +		vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
>> +		vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
>> +		vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
>> +		vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
>> +		vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
>> +		vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
>> +		vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
>> +		vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
>> +		vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
>> +		vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
>> +		vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
>> +		vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
>> +		vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
>> +		vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
>> +		vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
>> +		vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
>> +		vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
>> +		vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
>> +		vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
>> +		vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
>> +	}
>> +
>> +	if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP1)) {
>> +		vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
>> +		vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
>> +			    vmcs12->guest_pending_dbg_exceptions);
>> +		vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
>> +		vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
>> +
>> +		if (vmx_mpx_supported())
>> +			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
>>  
>> -	vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
>> -	vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
>> -	vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
>> -	vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
>> -	vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
>> -	vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
>> -	vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
>> -	vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
>> -	vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
>> -	vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
>> -	vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
>> -	vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
>> -	vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
>> -	vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
>> -	vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
>> -	vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
>> -	vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
>> -	vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
>> -	vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
>> -	vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
>> -	vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
>> -	vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
>> -	vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
>> -	vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
>> -	vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
>> -	vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
>> -	vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
>> -	vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
>> -	vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
>> -	vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
>> -	vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
>> -
>> -	vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
>> -	vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
>> -		vmcs12->guest_pending_dbg_exceptions);
>> -	vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
>> -	vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
>> +		/*
>> +		 * L1 may access the L2's PDPTR, so save them to construct
>> +		 * vmcs12
>> +		 */
>> +		if (enable_ept) {
>> +			vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
>> +			vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
>> +			vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
>> +			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
>> +		}
>> +	}
>>  
>>  	if (nested_cpu_has_xsaves(vmcs12))
>>  		vmcs_write64(XSS_EXIT_BITMAP, vmcs12->xss_exit_bitmap);
>> +
>>  	vmcs_write64(VMCS_LINK_POINTER, -1ull);
>>  
>>  	if (cpu_has_vmx_posted_intr())
>> @@ -11717,9 +11746,6 @@ static void prepare_vmcs02_full(struct
>> kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
>>  
>>  	set_cr4_guest_host_mask(vmx);
>>  
>> -	if (vmx_mpx_supported())
>> -		vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
>> -
>>  	if (enable_vpid) {
>>  		if (nested_cpu_has_vpid(vmcs12) && vmx->nested.vpid02)
>>  			vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->nested.vpid02);
>> @@ -11727,16 +11753,6 @@ static void prepare_vmcs02_full(struct
>> kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
>>  			vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->vpid);
>>  	}
>>  
>> -	/*
>> -	 * L1 may access the L2's PDPTR, so save them to construct vmcs12
>> -	 */
>> -	if (enable_ept) {
>> -		vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
>> -		vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
>> -		vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
>> -		vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
>> -	}
>> -
>>  	if (cpu_has_vmx_msr_bitmap())
>>  		vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
>>  }
>> @@ -11757,6 +11773,7 @@ static int prepare_vmcs02(struct kvm_vcpu
>> *vcpu, struct vmcs12 *vmcs12,
>>  {
>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>  	u32 exec_control, vmcs12_exec_ctrl;
>> +	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
>>  
>>  	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs) {
>>  		prepare_vmcs02_full(vcpu, vmcs12);
>> @@ -11768,11 +11785,13 @@ static int prepare_vmcs02(struct kvm_vcpu
>> *vcpu, struct vmcs12 *vmcs12,
>>  	 * with vmx_shadow_fields.h.
>>  	 */
>>  
>> -	vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>> -	vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>> -	vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
>> -	vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
>> -	vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
>> +	if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP2)) {
>> +		vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>> +		vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>> +		vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
>> +		vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
>> +		vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
>> +	}
>>  
>>  	/*
>>  	 * Not in vmcs02: GUEST_PML_INDEX, HOST_FS_SELECTOR,
>> HOST_GS_SELECTOR,
>> @@ -11788,12 +11807,14 @@ static int prepare_vmcs02(struct kvm_vcpu
>> *vcpu, struct vmcs12 *vmcs12,
>>  		vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.vmcs01_debugctl);
>>  	}
>>  	if (vmx->nested.nested_run_pending) {
>> -		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
>> -			     vmcs12->vm_entry_intr_info_field);
>> -		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
>> -			     vmcs12->vm_entry_exception_error_code);
>> -		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
>> -			     vmcs12->vm_entry_instruction_len);
>> +		if (!hv_evmcs || evmcs_needs_write(vmx, CONTROL_EVENT)) {
>> +			vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
>> +				     vmcs12->vm_entry_intr_info_field);
>> +			vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
>> +				     vmcs12->vm_entry_exception_error_code);
>> +			vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
>> +				     vmcs12->vm_entry_instruction_len);
>> +		}
>>  		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
>>  			     vmcs12->guest_interruptibility_info);
>>  		vmx->loaded_vmcs->nmi_known_unmasked =
>> -- 
>> 2.14.4

-- 
  Vitaly
