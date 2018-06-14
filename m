Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC8B1C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493FB20864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fY0sAN3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493FB20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965157AbeFNXhq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:37:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53362 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965031AbeFNXho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:37:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ENTs4K081485;
        Thu, 14 Jun 2018 23:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=36raE4yUXyeK2YKmcfV+p4RYCaYE8Y8r9lm7hk8EEsc=;
 b=fY0sAN3dxtwP2aYeeLW0T36dV/KR1YdY/qgDW3/vh20wsoeTDOhz9tLf+M5q70FU3M1R
 wWUmJBbl3+T6HctUM1iLEv2oONTIJqmy+UaYT2ndTDfHbUyRMcemMrb8m7D2SjoLJ4gT
 Xrxkov+Q8yNAK+NljmpiqQYJSpuVoZRaqX+fDo+GcPU2hEWseaKJJT4RmViB2pzsZov8
 vr78XWRiL7OUFqpF3lAEls68fvVleX4Cez/S8JoO8JqpEgoSvkYZCGU9IrycRvHSbzHp
 xZGK8RjFV4jfvDEuV0B0Jwcz3a40ZEX/57uG35UUn8f/kK1k0I23sL1+Yifv/HpmXKTr SQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jk0xrf0y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:37:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5ENbOBO012723
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:37:25 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5ENbNKj031927;
        Thu, 14 Jun 2018 23:37:24 GMT
MIME-Version: 1.0
Message-ID: <55506b65-0b32-45cf-8fd5-5c2d1b0ac30c@default>
Date:   Thu, 14 Jun 2018 16:37:23 -0700 (PDT)
From:   Liran Alon <liran.alon@oracle.com>
To:     <vkuznets@redhat.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 5/5] KVM: nVMX: optimize prepare_vmcs02{,_full} for
 Enlightened VMCS case
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

> When Enlightened VMCS is in use by L1 hypervisor we can avoid
> vmwriting
> VMCS fields which did not change.
>=20
> Our first goal is to achieve minimal impact on traditional VMCS case
> so
> we're not wrapping each vmwrite() with an if-changed checker. We also
> can't
> utilize static keys as Enlightened VMCS usage is per-guest.
>=20
> This patch implements the simpliest solution: checking fields in
> groups.
> We skip single vmwrite() statements as doing the check will cost us
> something even in non-evmcs case and the win is tiny. Unfortunately,
> this
> makes prepare_vmcs02_full{,_full}() code Enlightened VMCS-dependent
> (and
> a bit ugly).
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 143
> ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 82 insertions(+), 61 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 6802ba91468c..9a7d76c5c92b 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -11619,50 +11619,79 @@ static int nested_vmx_load_cr3(struct
> kvm_vcpu *vcpu, unsigned long cr3, bool ne
>  =09return 0;
>  }
> =20
> +/*
> + * Check if L1 hypervisor changed the particular field in
> Enlightened
> + * VMCS and avoid redundant vmwrite if it didn't. Can only be used
> when
> + * the value we're about to write is unchanged vmcs12->field.
> + */
> +#define evmcs_needs_write(vmx, clean_field)
> ((vmx)->nested.dirty_vmcs12 ||\
> +=09!(vmx->nested.hv_evmcs->hv_clean_fields &\
> +=09  HV_VMX_ENLIGHTENED_CLEAN_FIELD_##clean_field))

Why declare this is a macro instead of an static inline small function?
Just to shorten the name of the clean-field constant?

> +
>  static void prepare_vmcs02_full(struct kvm_vcpu *vcpu, struct vmcs12
> *vmcs12)
>  {
>  =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +=09struct hv_enlightened_vmcs *hv_evmcs =3D vmx->nested.hv_evmcs;
> +
> +=09if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP2)) {
> +=09=09vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
> +=09=09vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
> +=09=09vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
> +=09=09vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
> +=09=09vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
> +=09=09vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
> +=09=09vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
> +=09=09vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
> +=09=09vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
> +=09=09vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
> +=09=09vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
> +=09=09vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
> +=09=09vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
> +=09=09vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
> +=09=09vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
> +=09=09vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
> +=09=09vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
> +=09=09vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
> +=09=09vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
> +=09=09vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
> +=09=09vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
> +=09=09vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
> +=09=09vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
> +=09=09vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
> +=09=09vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
> +=09=09vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
> +=09=09vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
> +=09=09vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
> +=09=09vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
> +=09=09vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
> +=09=09vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
> +=09}
> +
> +=09if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP1)) {
> +=09=09vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
> +=09=09vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> +=09=09=09    vmcs12->guest_pending_dbg_exceptions);
> +=09=09vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
> +=09=09vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
> +
> +=09=09if (vmx_mpx_supported())
> +=09=09=09vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
> =20
> -=09vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
> -=09vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
> -=09vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
> -=09vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
> -=09vmcs_write16(GUEST_GS_SELECTOR, vmcs12->guest_gs_selector);
> -=09vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
> -=09vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
> -=09vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
> -=09vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
> -=09vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
> -=09vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
> -=09vmcs_write32(GUEST_GS_LIMIT, vmcs12->guest_gs_limit);
> -=09vmcs_write32(GUEST_LDTR_LIMIT, vmcs12->guest_ldtr_limit);
> -=09vmcs_write32(GUEST_TR_LIMIT, vmcs12->guest_tr_limit);
> -=09vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
> -=09vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
> -=09vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
> -=09vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
> -=09vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
> -=09vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
> -=09vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
> -=09vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
> -=09vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
> -=09vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
> -=09vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
> -=09vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
> -=09vmcs_writel(GUEST_GS_BASE, vmcs12->guest_gs_base);
> -=09vmcs_writel(GUEST_LDTR_BASE, vmcs12->guest_ldtr_base);
> -=09vmcs_writel(GUEST_TR_BASE, vmcs12->guest_tr_base);
> -=09vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
> -=09vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
> -
> -=09vmcs_write32(GUEST_SYSENTER_CS, vmcs12->guest_sysenter_cs);
> -=09vmcs_writel(GUEST_PENDING_DBG_EXCEPTIONS,
> -=09=09vmcs12->guest_pending_dbg_exceptions);
> -=09vmcs_writel(GUEST_SYSENTER_ESP, vmcs12->guest_sysenter_esp);
> -=09vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->guest_sysenter_eip);
> +=09=09/*
> +=09=09 * L1 may access the L2's PDPTR, so save them to construct
> +=09=09 * vmcs12
> +=09=09 */
> +=09=09if (enable_ept) {
> +=09=09=09vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
> +=09=09=09vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
> +=09=09=09vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
> +=09=09=09vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
> +=09=09}
> +=09}
> =20
>  =09if (nested_cpu_has_xsaves(vmcs12))
>  =09=09vmcs_write64(XSS_EXIT_BITMAP, vmcs12->xss_exit_bitmap);
> +
>  =09vmcs_write64(VMCS_LINK_POINTER, -1ull);
> =20
>  =09if (cpu_has_vmx_posted_intr())
> @@ -11717,9 +11746,6 @@ static void prepare_vmcs02_full(struct
> kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
> =20
>  =09set_cr4_guest_host_mask(vmx);
> =20
> -=09if (vmx_mpx_supported())
> -=09=09vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
> -
>  =09if (enable_vpid) {
>  =09=09if (nested_cpu_has_vpid(vmcs12) && vmx->nested.vpid02)
>  =09=09=09vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->nested.vpid02);
> @@ -11727,16 +11753,6 @@ static void prepare_vmcs02_full(struct
> kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
>  =09=09=09vmcs_write16(VIRTUAL_PROCESSOR_ID, vmx->vpid);
>  =09}
> =20
> -=09/*
> -=09 * L1 may access the L2's PDPTR, so save them to construct vmcs12
> -=09 */
> -=09if (enable_ept) {
> -=09=09vmcs_write64(GUEST_PDPTR0, vmcs12->guest_pdptr0);
> -=09=09vmcs_write64(GUEST_PDPTR1, vmcs12->guest_pdptr1);
> -=09=09vmcs_write64(GUEST_PDPTR2, vmcs12->guest_pdptr2);
> -=09=09vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
> -=09}
> -
>  =09if (cpu_has_vmx_msr_bitmap())
>  =09=09vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
>  }
> @@ -11757,6 +11773,7 @@ static int prepare_vmcs02(struct kvm_vcpu
> *vcpu, struct vmcs12 *vmcs12,
>  {
>  =09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
>  =09u32 exec_control, vmcs12_exec_ctrl;
> +=09struct hv_enlightened_vmcs *hv_evmcs =3D vmx->nested.hv_evmcs;
> =20
>  =09if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs) {
>  =09=09prepare_vmcs02_full(vcpu, vmcs12);
> @@ -11768,11 +11785,13 @@ static int prepare_vmcs02(struct kvm_vcpu
> *vcpu, struct vmcs12 *vmcs12,
>  =09 * with vmx_shadow_fields.h.
>  =09 */
> =20
> -=09vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
> -=09vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
> -=09vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
> -=09vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
> -=09vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
> +=09if (!hv_evmcs || evmcs_needs_write(vmx, GUEST_GRP2)) {
> +=09=09vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
> +=09=09vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
> +=09=09vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
> +=09=09vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
> +=09=09vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
> +=09}
> =20
>  =09/*
>  =09 * Not in vmcs02: GUEST_PML_INDEX, HOST_FS_SELECTOR,
> HOST_GS_SELECTOR,
> @@ -11788,12 +11807,14 @@ static int prepare_vmcs02(struct kvm_vcpu
> *vcpu, struct vmcs12 *vmcs12,
>  =09=09vmcs_write64(GUEST_IA32_DEBUGCTL, vmx->nested.vmcs01_debugctl);
>  =09}
>  =09if (vmx->nested.nested_run_pending) {
> -=09=09vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
> -=09=09=09     vmcs12->vm_entry_intr_info_field);
> -=09=09vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
> -=09=09=09     vmcs12->vm_entry_exception_error_code);
> -=09=09vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
> -=09=09=09     vmcs12->vm_entry_instruction_len);
> +=09=09if (!hv_evmcs || evmcs_needs_write(vmx, CONTROL_EVENT)) {
> +=09=09=09vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
> +=09=09=09=09     vmcs12->vm_entry_intr_info_field);
> +=09=09=09vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
> +=09=09=09=09     vmcs12->vm_entry_exception_error_code);
> +=09=09=09vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
> +=09=09=09=09     vmcs12->vm_entry_instruction_len);
> +=09=09}
>  =09=09vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
>  =09=09=09     vmcs12->guest_interruptibility_info);
>  =09=09vmx->loaded_vmcs->nmi_known_unmasked =3D
> --=20
> 2.14.4
