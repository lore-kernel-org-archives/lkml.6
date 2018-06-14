Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B37EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DD3208AF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SRf3Us4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DD3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965130AbeFNXdi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:33:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50148 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965025AbeFNXdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:33:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ENTQAe080869;
        Thu, 14 Jun 2018 23:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=eENzeVISxwyEndh2bfGAKCj9f2kXsFWz/n4AjHuxvbQ=;
 b=SRf3Us4FQLcfKUp4o4tNg+5Idbf5NsV7PPZtCjBkFN0Dg+ejCg7+xZ+dZslMQvLQljBT
 Pok3FooQx4omGZzN+4fjcqatAOLr+HGx3pMc86UszyeW/th6tNVbtX8tWAba+Z59PbhX
 kAgDCpd/urXj10MIeZB5pomXwVjaMHi6OF5E/LBbJFSk1eo0m/A3ytbro9s5fpHUT9WL
 YZfb4VarUFWH53FnDxsdP7BLZpxVZbzOTH95Gk1SCsqP/8fQrq8egPDMogaH+Ck1TFsB
 yMTA5ft3k3OyqrWijXgMP7OKJabDI6bs0bj8ADOS1ZrL2MrF7JtSpbwp7OpIVAHwtGp9 nQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jk0xrf0q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:33:18 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5ENXHj5011416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:33:18 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5ENXHQM029929;
        Thu, 14 Jun 2018 23:33:17 GMT
MIME-Version: 1.0
Message-ID: <cb90878b-bc52-47d8-b53f-3ee3f724fe04@default>
Date:   Thu, 14 Jun 2018 16:33:16 -0700 (PDT)
From:   Liran Alon <liran.alon@oracle.com>
To:     <vkuznets@redhat.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 3/5] KVM: nVMX: add enlightened VMCS state
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- vkuznets@redhat.com wrote:

> Adds hv_evmcs pointer and implement copy_enlightened_to_vmcs12() and
> copy_enlightened_to_vmcs12().
>=20
> prepare_vmcs02()/prepare_vmcs02_full() separation is not valid for
> Enlightened VMCS, do full sync for now.
>=20
> Suggested-by: Ladi Prosek <lprosek@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 431
> +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 417 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 51749207cef1..e7fa9f9c6e36 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -640,10 +640,10 @@ struct nested_vmx {
>  =09 */
>  =09struct vmcs12 *cached_vmcs12;
>  =09/*
> -=09 * Indicates if the shadow vmcs must be updated with the
> -=09 * data hold by vmcs12
> +=09 * Indicates if the shadow vmcs or enlightened vmcs must be updated
> +=09 * with the data held by struct vmcs12.
>  =09 */
> -=09bool sync_shadow_vmcs;
> +=09bool need_vmcs12_sync;
>  =09bool dirty_vmcs12;
> =20
>  =09bool change_vmcs01_virtual_apic_mode;
> @@ -689,6 +689,8 @@ struct nested_vmx {
>  =09=09/* in guest mode on SMM entry? */
>  =09=09bool guest_mode;
>  =09} smm;
> +
> +=09struct hv_enlightened_vmcs *hv_evmcs;
>  };
> =20
>  #define POSTED_INTR_ON  0
> @@ -8010,7 +8012,7 @@ static inline void nested_release_vmcs12(struct
> vcpu_vmx *vmx)
>  =09=09/* copy to memory all shadowed fields in case
>  =09=09   they were modified */
>  =09=09copy_shadow_to_vmcs12(vmx);
> -=09=09vmx->nested.sync_shadow_vmcs =3D false;
> +=09=09vmx->nested.need_vmcs12_sync =3D false;
>  =09=09vmx_disable_shadow_vmcs(vmx);
>  =09}
>  =09vmx->nested.posted_intr_nv =3D -1;
> @@ -8187,6 +8189,393 @@ static inline int vmcs12_write_any(struct
> kvm_vcpu *vcpu,
> =20
>  }
> =20
> +static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, bool
> full)
> +{
> +=09struct vmcs12 *vmcs12 =3D vmx->nested.cached_vmcs12;
> +=09struct hv_enlightened_vmcs *evmcs =3D vmx->nested.hv_evmcs;
> +
> +=09/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
> +=09vmcs12->tpr_threshold =3D evmcs->tpr_threshold;
> +=09vmcs12->guest_rip =3D evmcs->guest_rip;
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC))) {
> +=09=09vmcs12->guest_rsp =3D evmcs->guest_rsp;
> +=09=09vmcs12->guest_rflags =3D evmcs->guest_rflags;
> +=09=09vmcs12->guest_interruptibility_info =3D
> +=09=09=09evmcs->guest_interruptibility_info;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
> +=09=09vmcs12->cpu_based_vm_exec_control =3D
> +=09=09=09evmcs->cpu_based_vm_exec_control;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
> +=09=09vmcs12->exception_bitmap =3D evmcs->exception_bitmap;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_ENTRY))) {
> +=09=09vmcs12->vm_entry_controls =3D evmcs->vm_entry_controls;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EVENT))) {
> +=09=09vmcs12->vm_entry_intr_info_field =3D
> +=09=09=09evmcs->vm_entry_intr_info_field;
> +=09=09vmcs12->vm_entry_exception_error_code =3D
> +=09=09=09evmcs->vm_entry_exception_error_code;
> +=09=09vmcs12->vm_entry_instruction_len =3D
> +=09=09=09evmcs->vm_entry_instruction_len;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09      HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
> +=09=09vmcs12->host_ia32_pat =3D evmcs->host_ia32_pat;
> +=09=09vmcs12->host_ia32_efer =3D evmcs->host_ia32_efer;
> +=09=09vmcs12->host_cr0 =3D evmcs->host_cr0;
> +=09=09vmcs12->host_cr3 =3D evmcs->host_cr3;
> +=09=09vmcs12->host_cr4 =3D evmcs->host_cr4;
> +=09=09vmcs12->host_ia32_sysenter_esp =3D evmcs->host_ia32_sysenter_esp;
> +=09=09vmcs12->host_ia32_sysenter_eip =3D evmcs->host_ia32_sysenter_eip;
> +=09=09vmcs12->host_rip =3D evmcs->host_rip;
> +=09=09vmcs12->host_ia32_sysenter_cs =3D evmcs->host_ia32_sysenter_cs;
> +=09=09vmcs12->host_es_selector =3D evmcs->host_es_selector;
> +=09=09vmcs12->host_cs_selector =3D evmcs->host_cs_selector;
> +=09=09vmcs12->host_ss_selector =3D evmcs->host_ss_selector;
> +=09=09vmcs12->host_ds_selector =3D evmcs->host_ds_selector;
> +=09=09vmcs12->host_fs_selector =3D evmcs->host_fs_selector;
> +=09=09vmcs12->host_gs_selector =3D evmcs->host_gs_selector;
> +=09=09vmcs12->host_tr_selector =3D evmcs->host_tr_selector;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
> +=09=09vmcs12->pin_based_vm_exec_control =3D
> +=09=09=09evmcs->pin_based_vm_exec_control;
> +=09=09vmcs12->vm_exit_controls =3D evmcs->vm_exit_controls;
> +=09=09vmcs12->secondary_vm_exec_control =3D
> +=09=09=09evmcs->secondary_vm_exec_control;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_IO_BITMAP))) {
> +=09=09vmcs12->io_bitmap_a =3D evmcs->io_bitmap_a;
> +=09=09vmcs12->io_bitmap_b =3D evmcs->io_bitmap_b;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_MSR_BITMAP))) {
> +=09=09vmcs12->msr_bitmap =3D evmcs->msr_bitmap;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2))) {
> +=09=09vmcs12->guest_es_base =3D evmcs->guest_es_base;
> +=09=09vmcs12->guest_cs_base =3D evmcs->guest_cs_base;
> +=09=09vmcs12->guest_ss_base =3D evmcs->guest_ss_base;
> +=09=09vmcs12->guest_ds_base =3D evmcs->guest_ds_base;
> +=09=09vmcs12->guest_fs_base =3D evmcs->guest_fs_base;
> +=09=09vmcs12->guest_gs_base =3D evmcs->guest_gs_base;
> +=09=09vmcs12->guest_ldtr_base =3D evmcs->guest_ldtr_base;
> +=09=09vmcs12->guest_tr_base =3D evmcs->guest_tr_base;
> +=09=09vmcs12->guest_gdtr_base =3D evmcs->guest_gdtr_base;
> +=09=09vmcs12->guest_idtr_base =3D evmcs->guest_idtr_base;
> +=09=09vmcs12->guest_es_limit =3D evmcs->guest_es_limit;
> +=09=09vmcs12->guest_cs_limit =3D evmcs->guest_cs_limit;
> +=09=09vmcs12->guest_ss_limit =3D evmcs->guest_ss_limit;
> +=09=09vmcs12->guest_ds_limit =3D evmcs->guest_ds_limit;
> +=09=09vmcs12->guest_fs_limit =3D evmcs->guest_fs_limit;
> +=09=09vmcs12->guest_gs_limit =3D evmcs->guest_gs_limit;
> +=09=09vmcs12->guest_ldtr_limit =3D evmcs->guest_ldtr_limit;
> +=09=09vmcs12->guest_tr_limit =3D evmcs->guest_tr_limit;
> +=09=09vmcs12->guest_gdtr_limit =3D evmcs->guest_gdtr_limit;
> +=09=09vmcs12->guest_idtr_limit =3D evmcs->guest_idtr_limit;
> +=09=09vmcs12->guest_es_ar_bytes =3D evmcs->guest_es_ar_bytes;
> +=09=09vmcs12->guest_cs_ar_bytes =3D evmcs->guest_cs_ar_bytes;
> +=09=09vmcs12->guest_ss_ar_bytes =3D evmcs->guest_ss_ar_bytes;
> +=09=09vmcs12->guest_ds_ar_bytes =3D evmcs->guest_ds_ar_bytes;
> +=09=09vmcs12->guest_fs_ar_bytes =3D evmcs->guest_fs_ar_bytes;
> +=09=09vmcs12->guest_gs_ar_bytes =3D evmcs->guest_gs_ar_bytes;
> +=09=09vmcs12->guest_ldtr_ar_bytes =3D evmcs->guest_ldtr_ar_bytes;
> +=09=09vmcs12->guest_tr_ar_bytes =3D evmcs->guest_tr_ar_bytes;
> +=09=09vmcs12->guest_es_selector =3D evmcs->guest_es_selector;
> +=09=09vmcs12->guest_cs_selector =3D evmcs->guest_cs_selector;
> +=09=09vmcs12->guest_ss_selector =3D evmcs->guest_ss_selector;
> +=09=09vmcs12->guest_ds_selector =3D evmcs->guest_ds_selector;
> +=09=09vmcs12->guest_fs_selector =3D evmcs->guest_fs_selector;
> +=09=09vmcs12->guest_gs_selector =3D evmcs->guest_gs_selector;
> +=09=09vmcs12->guest_ldtr_selector =3D evmcs->guest_ldtr_selector;
> +=09=09vmcs12->guest_tr_selector =3D evmcs->guest_tr_selector;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2))) {
> +=09=09vmcs12->tsc_offset =3D evmcs->tsc_offset;
> +=09=09vmcs12->virtual_apic_page_addr =3D evmcs->virtual_apic_page_addr;
> +=09=09vmcs12->xss_exit_bitmap =3D evmcs->xss_exit_bitmap;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CRDR))) {
> +=09=09vmcs12->cr0_guest_host_mask =3D evmcs->cr0_guest_host_mask;
> +=09=09vmcs12->cr4_guest_host_mask =3D evmcs->cr4_guest_host_mask;
> +=09=09vmcs12->cr0_read_shadow =3D evmcs->cr0_read_shadow;
> +=09=09vmcs12->cr4_read_shadow =3D evmcs->cr4_read_shadow;
> +=09=09vmcs12->guest_cr0 =3D evmcs->guest_cr0;
> +=09=09vmcs12->guest_cr3 =3D evmcs->guest_cr3;
> +=09=09vmcs12->guest_cr4 =3D evmcs->guest_cr4;
> +=09=09vmcs12->guest_dr7 =3D evmcs->guest_dr7;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_POINTER))) {
> +=09=09vmcs12->host_fs_base =3D evmcs->host_fs_base;
> +=09=09vmcs12->host_gs_base =3D evmcs->host_gs_base;
> +=09=09vmcs12->host_tr_base =3D evmcs->host_tr_base;
> +=09=09vmcs12->host_gdtr_base =3D evmcs->host_gdtr_base;
> +=09=09vmcs12->host_idtr_base =3D evmcs->host_idtr_base;
> +=09=09vmcs12->host_rsp =3D evmcs->host_rsp;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_XLAT))) {
> +=09=09vmcs12->ept_pointer =3D evmcs->ept_pointer;
> +=09=09vmcs12->virtual_processor_id =3D evmcs->virtual_processor_id;
> +=09}
> +
> +=09if (unlikely(full || !(evmcs->hv_clean_fields &
> +=09=09=09       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1))) {
> +=09=09vmcs12->vmcs_link_pointer =3D evmcs->vmcs_link_pointer;
> +=09=09vmcs12->guest_ia32_debugctl =3D evmcs->guest_ia32_debugctl;
> +=09=09vmcs12->guest_ia32_pat =3D evmcs->guest_ia32_pat;
> +=09=09vmcs12->guest_ia32_efer =3D evmcs->guest_ia32_efer;
> +=09=09vmcs12->guest_pdptr0 =3D evmcs->guest_pdptr0;
> +=09=09vmcs12->guest_pdptr1 =3D evmcs->guest_pdptr1;
> +=09=09vmcs12->guest_pdptr2 =3D evmcs->guest_pdptr2;
> +=09=09vmcs12->guest_pdptr3 =3D evmcs->guest_pdptr3;
> +=09=09vmcs12->guest_pending_dbg_exceptions =3D
> +=09=09=09evmcs->guest_pending_dbg_exceptions;
> +=09=09vmcs12->guest_sysenter_esp =3D evmcs->guest_sysenter_esp;
> +=09=09vmcs12->guest_sysenter_eip =3D evmcs->guest_sysenter_eip;
> +=09=09vmcs12->guest_bndcfgs =3D evmcs->guest_bndcfgs;
> +=09=09vmcs12->guest_activity_state =3D evmcs->guest_activity_state;
> +=09=09vmcs12->guest_sysenter_cs =3D evmcs->guest_sysenter_cs;
> +=09}
> +
> +=09/*
> +=09 * Not used?
> +=09 * vmcs12->vm_exit_msr_store_addr =3D evmcs->vm_exit_msr_store_addr;
> +=09 * vmcs12->vm_exit_msr_load_addr =3D evmcs->vm_exit_msr_load_addr;
> +=09 * vmcs12->vm_entry_msr_load_addr =3D evmcs->vm_entry_msr_load_addr;
> +=09 * vmcs12->cr3_target_value0 =3D evmcs->cr3_target_value0;
> +=09 * vmcs12->cr3_target_value1 =3D evmcs->cr3_target_value1;
> +=09 * vmcs12->cr3_target_value2 =3D evmcs->cr3_target_value2;
> +=09 * vmcs12->cr3_target_value3 =3D evmcs->cr3_target_value3;
> +=09 * vmcs12->page_fault_error_code_mask =3D
> +=09 *=09=09evmcs->page_fault_error_code_mask;
> +=09 * vmcs12->page_fault_error_code_match =3D
> +=09 *=09=09evmcs->page_fault_error_code_match;
> +=09 * vmcs12->cr3_target_count =3D evmcs->cr3_target_count;
> +=09 * vmcs12->vm_exit_msr_store_count =3D
> evmcs->vm_exit_msr_store_count;
> +=09 * vmcs12->vm_exit_msr_load_count =3D evmcs->vm_exit_msr_load_count;
> +=09 * vmcs12->vm_entry_msr_load_count =3D
> evmcs->vm_entry_msr_load_count;
> +=09 */
> +
> +=09/*
> +=09 * Read only fields:
> +=09 * vmcs12->guest_physical_address =3D evmcs->guest_physical_address;
> +=09 * vmcs12->vm_instruction_error =3D evmcs->vm_instruction_error;
> +=09 * vmcs12->vm_exit_reason =3D evmcs->vm_exit_reason;
> +=09 * vmcs12->vm_exit_intr_info =3D evmcs->vm_exit_intr_info;
> +=09 * vmcs12->vm_exit_intr_error_code =3D
> evmcs->vm_exit_intr_error_code;
> +=09 * vmcs12->idt_vectoring_info_field =3D
> evmcs->idt_vectoring_info_field;
> +=09 * vmcs12->idt_vectoring_error_code =3D
> evmcs->idt_vectoring_error_code;
> +=09 * vmcs12->vm_exit_instruction_len =3D
> evmcs->vm_exit_instruction_len;
> +=09 * vmcs12->vmx_instruction_info =3D evmcs->vmx_instruction_info;
> +=09 * vmcs12->exit_qualification =3D evmcs->exit_qualification;
> +=09 * vmcs12->guest_linear_address =3D evmcs->guest_linear_address;
> +=09 *
> +=09 * Not present in struct vmcs12:
> +=09 * vmcs12->exit_io_instruction_ecx =3D
> evmcs->exit_io_instruction_ecx;
> +=09 * vmcs12->exit_io_instruction_esi =3D
> evmcs->exit_io_instruction_esi;
> +=09 * vmcs12->exit_io_instruction_edi =3D
> evmcs->exit_io_instruction_edi;
> +=09 * vmcs12->exit_io_instruction_eip =3D
> evmcs->exit_io_instruction_eip;
> +=09 */
> +
> +=09return 0;
> +}
> +
> +static int copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
> +{
> +=09struct vmcs12 *vmcs12 =3D vmx->nested.cached_vmcs12;
> +=09struct hv_enlightened_vmcs *evmcs =3D vmx->nested.hv_evmcs;
> +
> +=09/*
> +=09 * Should not be changed by KVM:
> +=09 *
> +=09 * evmcs->host_es_selector =3D vmcs12->host_es_selector;
> +=09 * evmcs->host_cs_selector =3D vmcs12->host_cs_selector;
> +=09 * evmcs->host_ss_selector =3D vmcs12->host_ss_selector;
> +=09 * evmcs->host_ds_selector =3D vmcs12->host_ds_selector;
> +=09 * evmcs->host_fs_selector =3D vmcs12->host_fs_selector;
> +=09 * evmcs->host_gs_selector =3D vmcs12->host_gs_selector;
> +=09 * evmcs->host_tr_selector =3D vmcs12->host_tr_selector;
> +=09 * evmcs->host_ia32_pat =3D vmcs12->host_ia32_pat;
> +=09 * evmcs->host_ia32_efer =3D vmcs12->host_ia32_efer;
> +=09 * evmcs->host_cr0 =3D vmcs12->host_cr0;
> +=09 * evmcs->host_cr3 =3D vmcs12->host_cr3;
> +=09 * evmcs->host_cr4 =3D vmcs12->host_cr4;
> +=09 * evmcs->host_ia32_sysenter_esp =3D vmcs12->host_ia32_sysenter_esp;
> +=09 * evmcs->host_ia32_sysenter_eip =3D vmcs12->host_ia32_sysenter_eip;
> +=09 * evmcs->host_rip =3D vmcs12->host_rip;
> +=09 * evmcs->host_ia32_sysenter_cs =3D vmcs12->host_ia32_sysenter_cs;
> +=09 * evmcs->host_fs_base =3D vmcs12->host_fs_base;
> +=09 * evmcs->host_gs_base =3D vmcs12->host_gs_base;
> +=09 * evmcs->host_tr_base =3D vmcs12->host_tr_base;
> +=09 * evmcs->host_gdtr_base =3D vmcs12->host_gdtr_base;
> +=09 * evmcs->host_idtr_base =3D vmcs12->host_idtr_base;
> +=09 * evmcs->host_rsp =3D vmcs12->host_rsp;
> +=09 * sync_vmcs12() doesn't read these:
> +=09 * evmcs->io_bitmap_a =3D vmcs12->io_bitmap_a;
> +=09 * evmcs->io_bitmap_b =3D vmcs12->io_bitmap_b;
> +=09 * evmcs->msr_bitmap =3D vmcs12->msr_bitmap;
> +=09 * evmcs->ept_pointer =3D vmcs12->ept_pointer;
> +=09 * evmcs->xss_exit_bitmap =3D vmcs12->xss_exit_bitmap;
> +=09 * evmcs->vm_exit_msr_store_addr =3D vmcs12->vm_exit_msr_store_addr;
> +=09 * evmcs->vm_exit_msr_load_addr =3D vmcs12->vm_exit_msr_load_addr;
> +=09 * evmcs->vm_entry_msr_load_addr =3D vmcs12->vm_entry_msr_load_addr;
> +=09 * evmcs->cr3_target_value0 =3D vmcs12->cr3_target_value0;
> +=09 * evmcs->cr3_target_value1 =3D vmcs12->cr3_target_value1;
> +=09 * evmcs->cr3_target_value2 =3D vmcs12->cr3_target_value2;
> +=09 * evmcs->cr3_target_value3 =3D vmcs12->cr3_target_value3;
> +=09 * evmcs->tpr_threshold =3D vmcs12->tpr_threshold;
> +=09 * evmcs->virtual_processor_id =3D vmcs12->virtual_processor_id;
> +=09 * evmcs->exception_bitmap =3D vmcs12->exception_bitmap;
> +=09 * evmcs->vmcs_link_pointer =3D vmcs12->vmcs_link_pointer;
> +=09 * evmcs->pin_based_vm_exec_control =3D
> vmcs12->pin_based_vm_exec_control;
> +=09 * evmcs->vm_exit_controls =3D vmcs12->vm_exit_controls;
> +=09 * evmcs->secondary_vm_exec_control =3D
> vmcs12->secondary_vm_exec_control;
> +=09 * evmcs->page_fault_error_code_mask =3D
> +=09 *=09=09vmcs12->page_fault_error_code_mask;
> +=09 * evmcs->page_fault_error_code_match =3D
> +=09 *=09=09vmcs12->page_fault_error_code_match;
> +=09 * evmcs->cr3_target_count =3D vmcs12->cr3_target_count;
> +=09 * evmcs->virtual_apic_page_addr =3D vmcs12->virtual_apic_page_addr;
> +=09 * evmcs->tsc_offset =3D vmcs12->tsc_offset;
> +=09 * evmcs->guest_ia32_debugctl =3D vmcs12->guest_ia32_debugctl;
> +=09 * evmcs->cr0_guest_host_mask =3D vmcs12->cr0_guest_host_mask;
> +=09 * evmcs->cr4_guest_host_mask =3D vmcs12->cr4_guest_host_mask;
> +=09 * evmcs->cr0_read_shadow =3D vmcs12->cr0_read_shadow;
> +=09 * evmcs->cr4_read_shadow =3D vmcs12->cr4_read_shadow;
> +=09 * evmcs->vm_exit_msr_store_count =3D
> vmcs12->vm_exit_msr_store_count;
> +=09 * evmcs->vm_exit_msr_load_count =3D vmcs12->vm_exit_msr_load_count;
> +=09 * evmcs->vm_entry_msr_load_count =3D
> vmcs12->vm_entry_msr_load_count;
> +=09 *
> +=09 * Not present in struct vmcs12:
> +=09 * evmcs->exit_io_instruction_ecx =3D
> vmcs12->exit_io_instruction_ecx;
> +=09 * evmcs->exit_io_instruction_esi =3D
> vmcs12->exit_io_instruction_esi;
> +=09 * evmcs->exit_io_instruction_edi =3D
> vmcs12->exit_io_instruction_edi;
> +=09 * evmcs->exit_io_instruction_eip =3D
> vmcs12->exit_io_instruction_eip;
> +=09 */
> +
> +=09evmcs->guest_es_selector =3D vmcs12->guest_es_selector;
> +=09evmcs->guest_cs_selector =3D vmcs12->guest_cs_selector;
> +=09evmcs->guest_ss_selector =3D vmcs12->guest_ss_selector;
> +=09evmcs->guest_ds_selector =3D vmcs12->guest_ds_selector;
> +=09evmcs->guest_fs_selector =3D vmcs12->guest_fs_selector;
> +=09evmcs->guest_gs_selector =3D vmcs12->guest_gs_selector;
> +=09evmcs->guest_ldtr_selector =3D vmcs12->guest_ldtr_selector;
> +=09evmcs->guest_tr_selector =3D vmcs12->guest_tr_selector;
> +
> +=09evmcs->guest_es_limit =3D vmcs12->guest_es_limit;
> +=09evmcs->guest_cs_limit =3D vmcs12->guest_cs_limit;
> +=09evmcs->guest_ss_limit =3D vmcs12->guest_ss_limit;
> +=09evmcs->guest_ds_limit =3D vmcs12->guest_ds_limit;
> +=09evmcs->guest_fs_limit =3D vmcs12->guest_fs_limit;
> +=09evmcs->guest_gs_limit =3D vmcs12->guest_gs_limit;
> +=09evmcs->guest_ldtr_limit =3D vmcs12->guest_ldtr_limit;
> +=09evmcs->guest_tr_limit =3D vmcs12->guest_tr_limit;
> +=09evmcs->guest_gdtr_limit =3D vmcs12->guest_gdtr_limit;
> +=09evmcs->guest_idtr_limit =3D vmcs12->guest_idtr_limit;
> +
> +=09evmcs->guest_es_ar_bytes =3D vmcs12->guest_es_ar_bytes;
> +=09evmcs->guest_cs_ar_bytes =3D vmcs12->guest_cs_ar_bytes;
> +=09evmcs->guest_ss_ar_bytes =3D vmcs12->guest_ss_ar_bytes;
> +=09evmcs->guest_ds_ar_bytes =3D vmcs12->guest_ds_ar_bytes;
> +=09evmcs->guest_fs_ar_bytes =3D vmcs12->guest_fs_ar_bytes;
> +=09evmcs->guest_gs_ar_bytes =3D vmcs12->guest_gs_ar_bytes;
> +=09evmcs->guest_ldtr_ar_bytes =3D vmcs12->guest_ldtr_ar_bytes;
> +=09evmcs->guest_tr_ar_bytes =3D vmcs12->guest_tr_ar_bytes;
> +
> +=09evmcs->guest_es_base =3D vmcs12->guest_es_base;
> +=09evmcs->guest_cs_base =3D vmcs12->guest_cs_base;
> +=09evmcs->guest_ss_base =3D vmcs12->guest_ss_base;
> +=09evmcs->guest_ds_base =3D vmcs12->guest_ds_base;
> +=09evmcs->guest_fs_base =3D vmcs12->guest_fs_base;
> +=09evmcs->guest_gs_base =3D vmcs12->guest_gs_base;
> +=09evmcs->guest_ldtr_base =3D vmcs12->guest_ldtr_base;
> +=09evmcs->guest_tr_base =3D vmcs12->guest_tr_base;
> +=09evmcs->guest_gdtr_base =3D vmcs12->guest_gdtr_base;
> +=09evmcs->guest_idtr_base =3D vmcs12->guest_idtr_base;
> +
> +=09evmcs->guest_ia32_pat =3D vmcs12->guest_ia32_pat;
> +=09evmcs->guest_ia32_efer =3D vmcs12->guest_ia32_efer;
> +
> +=09evmcs->guest_pdptr0 =3D vmcs12->guest_pdptr0;
> +=09evmcs->guest_pdptr1 =3D vmcs12->guest_pdptr1;
> +=09evmcs->guest_pdptr2 =3D vmcs12->guest_pdptr2;
> +=09evmcs->guest_pdptr3 =3D vmcs12->guest_pdptr3;
> +
> +=09evmcs->guest_pending_dbg_exceptions =3D
> +=09=09vmcs12->guest_pending_dbg_exceptions;
> +=09evmcs->guest_sysenter_esp =3D vmcs12->guest_sysenter_esp;
> +=09evmcs->guest_sysenter_eip =3D vmcs12->guest_sysenter_eip;
> +
> +=09evmcs->guest_activity_state =3D vmcs12->guest_activity_state;
> +=09evmcs->guest_sysenter_cs =3D vmcs12->guest_sysenter_cs;
> +
> +=09evmcs->guest_cr0 =3D vmcs12->guest_cr0;
> +=09evmcs->guest_cr3 =3D vmcs12->guest_cr3;
> +=09evmcs->guest_cr4 =3D vmcs12->guest_cr4;
> +=09evmcs->guest_dr7 =3D vmcs12->guest_dr7;
> +
> +=09evmcs->guest_physical_address =3D vmcs12->guest_physical_address;
> +
> +=09evmcs->vm_instruction_error =3D vmcs12->vm_instruction_error;
> +=09evmcs->vm_exit_reason =3D vmcs12->vm_exit_reason;
> +=09evmcs->vm_exit_intr_info =3D vmcs12->vm_exit_intr_info;
> +=09evmcs->vm_exit_intr_error_code =3D vmcs12->vm_exit_intr_error_code;
> +=09evmcs->idt_vectoring_info_field =3D vmcs12->idt_vectoring_info_field;
> +=09evmcs->idt_vectoring_error_code =3D vmcs12->idt_vectoring_error_code;
> +=09evmcs->vm_exit_instruction_len =3D vmcs12->vm_exit_instruction_len;
> +=09evmcs->vmx_instruction_info =3D vmcs12->vmx_instruction_info;
> +
> +=09evmcs->exit_qualification =3D vmcs12->exit_qualification;
> +
> +=09evmcs->guest_linear_address =3D vmcs12->guest_linear_address;
> +=09evmcs->guest_rsp =3D vmcs12->guest_rsp;
> +=09evmcs->guest_rflags =3D vmcs12->guest_rflags;
> +
> +=09evmcs->guest_interruptibility_info =3D
> +=09=09vmcs12->guest_interruptibility_info;
> +=09evmcs->cpu_based_vm_exec_control =3D
> vmcs12->cpu_based_vm_exec_control;
> +=09evmcs->vm_entry_controls =3D vmcs12->vm_entry_controls;
> +=09evmcs->vm_entry_intr_info_field =3D vmcs12->vm_entry_intr_info_field;
> +=09evmcs->vm_entry_exception_error_code =3D
> +=09=09vmcs12->vm_entry_exception_error_code;
> +=09evmcs->vm_entry_instruction_len =3D vmcs12->vm_entry_instruction_len;
> +
> +=09evmcs->guest_rip =3D vmcs12->guest_rip;
> +
> +=09evmcs->guest_bndcfgs =3D vmcs12->guest_bndcfgs;
> +
> +=09return 0;
> +}
> +
>  /*
>   * Copy the writable VMCS shadow fields back to the VMCS12, in case
>   * they have been modified by the L1 guest. Note that the
> "read-only"
> @@ -8398,7 +8787,7 @@ static void set_current_vmptr(struct vcpu_vmx
> *vmx, gpa_t vmptr)
>  =09=09=09      SECONDARY_EXEC_SHADOW_VMCS);
>  =09=09vmcs_write64(VMCS_LINK_POINTER,
>  =09=09=09     __pa(vmx->vmcs01.shadow_vmcs));
> -=09=09vmx->nested.sync_shadow_vmcs =3D true;
> +=09=09vmx->nested.need_vmcs12_sync =3D true;
>  =09}
>  =09vmx->nested.dirty_vmcs12 =3D true;
>  }
> @@ -9960,9 +10349,16 @@ static void __noclone vmx_vcpu_run(struct
> kvm_vcpu *vcpu)
>  =09=09vmcs_write32(PLE_WINDOW, vmx->ple_window);
>  =09}
> =20
> -=09if (vmx->nested.sync_shadow_vmcs) {
> -=09=09copy_vmcs12_to_shadow(vmx);
> -=09=09vmx->nested.sync_shadow_vmcs =3D false;
> +=09if (vmx->nested.need_vmcs12_sync) {
> +=09=09if (unlikely(vmx->nested.hv_evmcs)) {

Why is this marked with unlikely()?
In L1 guest use eVMCS, we will always have this as true for vmx_vcpu_run()
after simulating VMExit from L2 to L1. You should not have here unlikely()
just like you don't have it in new code added to nested_vmx_run().=20

> +=09=09=09copy_vmcs12_to_enlightened(vmx);
> +=09=09=09/* All fields are clean */
> +=09=09=09vmx->nested.hv_evmcs->hv_clean_fields |=3D
> +=09=09=09=09HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
> +=09=09} else {
> +=09=09=09copy_vmcs12_to_shadow(vmx);
> +=09=09}
> +=09=09vmx->nested.need_vmcs12_sync =3D false;
>  =09}
> =20
>  =09if (test_bit(VCPU_REGS_RSP, (unsigned long
> *)&vcpu->arch.regs_dirty))
> @@ -11281,7 +11677,7 @@ static int prepare_vmcs02(struct kvm_vcpu
> *vcpu, struct vmcs12 *vmcs12,
>  =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
>  =09u32 exec_control, vmcs12_exec_ctrl;
> =20
> -=09if (vmx->nested.dirty_vmcs12) {
> +=09if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs) {
>  =09=09prepare_vmcs02_full(vcpu, vmcs12);
>  =09=09vmx->nested.dirty_vmcs12 =3D false;
>  =09}
> @@ -11757,8 +12153,13 @@ static int nested_vmx_run(struct kvm_vcpu
> *vcpu, bool launch)
> =20
>  =09vmcs12 =3D get_vmcs12(vcpu);
> =20
> -=09if (enable_shadow_vmcs)
> +=09if (vmx->nested.hv_evmcs) {
> +=09=09copy_enlightened_to_vmcs12(vmx, vmx->nested.dirty_vmcs12);
> +=09=09/* Enlightened VMCS doesn't have launch state */
> +=09=09vmcs12->launch_state =3D !launch;
> +=09} else if (enable_shadow_vmcs) {
>  =09=09copy_shadow_to_vmcs12(vmx);
> +=09}
> =20
>  =09/*
>  =09 * The nested entry process starts with enforcing various
> prerequisites
> @@ -12383,8 +12784,8 @@ static void nested_vmx_vmexit(struct kvm_vcpu
> *vcpu, u32 exit_reason,
>  =09 */
>  =09kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
> =20
> -=09if (enable_shadow_vmcs && exit_reason !=3D -1)
> -=09=09vmx->nested.sync_shadow_vmcs =3D true;
> +=09if ((exit_reason !=3D -1) && (enable_shadow_vmcs ||
> vmx->nested.hv_evmcs))
> +=09=09vmx->nested.need_vmcs12_sync =3D true;
> =20
>  =09/* in case we halted in L2 */
>  =09vcpu->arch.mp_state =3D KVM_MP_STATE_RUNNABLE;
> @@ -12463,12 +12864,14 @@ static void nested_vmx_entry_failure(struct
> kvm_vcpu *vcpu,
>  =09=09=09struct vmcs12 *vmcs12,
>  =09=09=09u32 reason, unsigned long qualification)
>  {
> +=09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +
>  =09load_vmcs12_host_state(vcpu, vmcs12);
>  =09vmcs12->vm_exit_reason =3D reason | VMX_EXIT_REASONS_FAILED_VMENTRY;
>  =09vmcs12->exit_qualification =3D qualification;
>  =09nested_vmx_succeed(vcpu);
> -=09if (enable_shadow_vmcs)
> -=09=09to_vmx(vcpu)->nested.sync_shadow_vmcs =3D true;
> +=09if (enable_shadow_vmcs || vmx->nested.hv_evmcs)
> +=09=09vmx->nested.need_vmcs12_sync =3D true;
>  }
> =20
>  static int vmx_check_intercept(struct kvm_vcpu *vcpu,
> --=20
> 2.14.4
