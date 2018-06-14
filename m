Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC807C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADEF20896
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MsJek/LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADEF20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965122AbeFNX3Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:29:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965025AbeFNX3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:29:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5ENNnao077666;
        Thu, 14 Jun 2018 23:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=6OpLHZV74QZlml+YPOKgiedzaGxmllZMQMUacQzJrAU=;
 b=MsJek/LXMmvIz69NkcuItkn3AvZ7B7ne/itKc5WHKMKUjoYge1QAzCLKnzut8IvQQZW+
 o16fgNwPKrJJQ585wwvTw8yBTNseU2UQbRDXnFURC/3hnXdnmX6SYcQoCBxFqFmNocO2
 0iQwQXQ8cUqLTarHHHsCxlDkelCeN9dxh+zbfaaFJra58DUPqcu80IKsM0xQ2Tu05wqw
 WcDVsIs8NibLfQ+cIN8lP9Us5873F7ZiuHbpH1F+kxDgoi//520rxr4TDPi9hljLEZHd
 ggJrd74ejvM0VZTB2pcIxYbCgvT6BI06CyDuFBM5NFLSUkfsDQctTaXGQNnKd/XLTgXz cg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jk0xrf0f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:28:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5ENSvfb025575
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 23:28:57 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5ENSueo022216;
        Thu, 14 Jun 2018 23:28:56 GMT
MIME-Version: 1.0
Message-ID: <d5fe158e-9c1f-4fba-a138-72bcc5ce85b3@default>
Date:   Thu, 14 Jun 2018 16:28:56 -0700 (PDT)
From:   Liran Alon <liran.alon@oracle.com>
To:     <vkuznets@redhat.com>
Cc:     <mmorsy@redhat.com>, <rkagan@virtuozzo.com>, <jmattson@google.com>,
        <Michael.H.Kelley@microsoft.com>, <kys@microsoft.com>,
        <rkrcmar@redhat.com>, <cavery@redhat.com>, <pbonzini@redhat.com>,
        <linux-kernel@vger.kernel.org>, <sthemmin@microsoft.com>,
        <haiyangz@microsoft.com>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 4/5] KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- vkuznets@redhat.com wrote:

> Per Hyper-V TLFS 5.0b:
>=20
> "The L1 hypervisor may choose to use enlightened VMCSs by writing 1
> to
> the corresponding field in the VP assist page (see section 7.8.7).
> Another field in the VP assist page controls the currently active
> enlightened VMCS. Each enlightened VMCS is exactly one page (4 KB) in
> size and must be initially zeroed. No VMPTRLD instruction must be
> executed to make an enlightened VMCS active or current.
>=20
> After the L1 hypervisor performs a VM entry with an enlightened VMCS,
> the VMCS is considered active on the processor. An enlightened VMCS
> can only be active on a single processor at the same time. The L1
> hypervisor can execute a VMCLEAR instruction to transition an
> enlightened VMCS from the active to the non-active state. Any VMREAD
> or VMWRITE instructions while an enlightened VMCS is active is
> unsupported and can result in unexpected behavior."
>=20
> Keep Enlightened VMCS structure for the current L2 guest permanently
> mapped
> from struct nested_vmx instead of mapping it every time.
>=20
> Suggested-by: Ladi Prosek <lprosek@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 98
> ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 91 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index e7fa9f9c6e36..6802ba91468c 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -20,6 +20,7 @@
>  #include "mmu.h"
>  #include "cpuid.h"
>  #include "lapic.h"
> +#include "hyperv.h"
> =20
>  #include <linux/kvm_host.h>
>  #include <linux/module.h>
> @@ -690,6 +691,8 @@ struct nested_vmx {
>  =09=09bool guest_mode;
>  =09} smm;
> =20
> +=09gpa_t hv_evmcs_vmptr;
> +=09struct page *hv_evmcs_page;
>  =09struct hv_enlightened_vmcs *hv_evmcs;
>  };
> =20
> @@ -7695,7 +7698,9 @@ static void nested_vmx_failInvalid(struct
> kvm_vcpu *vcpu)
>  static void nested_vmx_failValid(struct kvm_vcpu *vcpu,
>  =09=09=09=09=09u32 vm_instruction_error)
>  {
> -=09if (to_vmx(vcpu)->nested.current_vmptr =3D=3D -1ull) {
> +=09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +
> +=09if (vmx->nested.current_vmptr =3D=3D -1ull && !vmx->nested.hv_evmcs) =
{
>  =09=09/*
>  =09=09 * failValid writes the error number to the current VMCS, which
>  =09=09 * can't be done there isn't a current VMCS.
> @@ -8003,6 +8008,18 @@ static void vmx_disable_shadow_vmcs(struct
> vcpu_vmx *vmx)
>  =09vmcs_write64(VMCS_LINK_POINTER, -1ull);
>  }
> =20
> +static inline void nested_release_evmcs(struct vcpu_vmx *vmx)
> +{
> +=09if (!vmx->nested.hv_evmcs)
> +=09=09return;
> +
> +=09kunmap(vmx->nested.hv_evmcs_page);
> +=09kvm_release_page_dirty(vmx->nested.hv_evmcs_page);
> +=09vmx->nested.hv_evmcs_vmptr =3D -1ull;
> +=09vmx->nested.hv_evmcs_page =3D NULL;
> +=09vmx->nested.hv_evmcs =3D NULL;
> +}
> +
>  static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
>  {
>  =09if (vmx->nested.current_vmptr =3D=3D -1ull)
> @@ -8062,6 +8079,8 @@ static void free_nested(struct vcpu_vmx *vmx)
>  =09=09vmx->nested.pi_desc =3D NULL;
>  =09}
> =20
> +=09nested_release_evmcs(vmx);
> +
>  =09free_loaded_vmcs(&vmx->nested.vmcs02);
>  }
> =20
> @@ -8098,12 +8117,18 @@ static int handle_vmclear(struct kvm_vcpu
> *vcpu)
>  =09=09return kvm_skip_emulated_instruction(vcpu);
>  =09}
> =20
> -=09if (vmptr =3D=3D vmx->nested.current_vmptr)
> -=09=09nested_release_vmcs12(vmx);
> +=09if (vmx->nested.hv_evmcs_page) {
> +=09=09if (vmptr =3D=3D vmx->nested.hv_evmcs_vmptr)
> +=09=09=09nested_release_evmcs(vmx);
> +=09} else {
> +=09=09if (vmptr =3D=3D vmx->nested.current_vmptr)
> +=09=09=09nested_release_vmcs12(vmx);
> =20
> -=09kvm_vcpu_write_guest(vcpu,
> -=09=09=09vmptr + offsetof(struct vmcs12, launch_state),
> -=09=09=09&zero, sizeof(zero));
> +=09=09kvm_vcpu_write_guest(vcpu,
> +=09=09=09=09     vmptr + offsetof(struct vmcs12,
> +=09=09=09=09=09=09      launch_state),
> +=09=09=09=09     &zero, sizeof(zero));
> +=09}
> =20
>  =09nested_vmx_succeed(vcpu);
>  =09return kvm_skip_emulated_instruction(vcpu);
> @@ -8814,6 +8839,10 @@ static int handle_vmptrld(struct kvm_vcpu
> *vcpu)
>  =09=09return kvm_skip_emulated_instruction(vcpu);
>  =09}
> =20
> +=09/* Forbid normal VMPTRLD if Enlightened version was used */
> +=09if (vmx->nested.hv_evmcs)
> +=09=09return 1;
> +
>  =09if (vmx->nested.current_vmptr !=3D vmptr) {
>  =09=09struct vmcs12 *new_vmcs12;
>  =09=09struct page *page;
> @@ -8847,6 +8876,55 @@ static int handle_vmptrld(struct kvm_vcpu
> *vcpu)
>  =09return kvm_skip_emulated_instruction(vcpu);
>  }
> =20
> +/*
> + * This is an equivalent of the nested hypervisor executing the
> vmptrld
> + * instruction.
> + */
> +static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu
> *vcpu)
> +{
> +=09struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> +=09struct hv_vp_assist_page assist_page;
> +
> +=09if (likely(!vmx->nested.enlightened_vmcs_enabled))
> +=09=09return 1;
> +
> +=09if (unlikely(!kvm_hv_get_assist_page(vcpu, &assist_page)))
> +=09=09return 1;
> +
> +=09if (unlikely(!assist_page.enlighten_vmentry))
> +=09=09return 1;
> +
> +=09if (unlikely(assist_page.current_nested_vmcs !=3D
> +=09=09     vmx->nested.hv_evmcs_vmptr)) {
> +
> +=09=09if (!vmx->nested.hv_evmcs)
> +=09=09=09vmx->nested.current_vmptr =3D -1ull;
> +
> +=09=09nested_release_evmcs(vmx);
> +
> +=09=09vmx->nested.hv_evmcs_page =3D kvm_vcpu_gpa_to_page(
> +=09=09=09vcpu, assist_page.current_nested_vmcs);
> +
> +=09=09if (unlikely(is_error_page(vmx->nested.hv_evmcs_page)))
> +=09=09=09return 0;
> +
> +=09=09vmx->nested.hv_evmcs =3D kmap(vmx->nested.hv_evmcs_page);
> +=09=09vmx->nested.dirty_vmcs12 =3D true;
> +=09=09vmx->nested.hv_evmcs_vmptr =3D assist_page.current_nested_vmcs;
> +
> +=09=09/*
> +=09=09 * Unlike normal vmcs12, enlightened vmcs12 is not fully
> +=09=09 * reloaded from guest's memory (read only fields, fields not
> +=09=09 * present in struct hv_enlightened_vmcs, ...). Make sure there
> +=09=09 * are no leftovers.
> +=09=09 */
> +=09=09memset(vmx->nested.cached_vmcs12, 0,
> +=09=09       sizeof(*vmx->nested.cached_vmcs12));
> +
> +=09}
> +=09return 1;
> +}
> +
>  /* Emulate the VMPTRST instruction */
>  static int handle_vmptrst(struct kvm_vcpu *vcpu)
>  {
> @@ -8858,6 +8936,9 @@ static int handle_vmptrst(struct kvm_vcpu
> *vcpu)
>  =09if (!nested_vmx_check_permission(vcpu))
>  =09=09return 1;
> =20
> +=09if (unlikely(to_vmx(vcpu)->nested.hv_evmcs))
> +=09=09return 1;
> +
>  =09if (get_vmx_mem_address(vcpu, exit_qualification,
>  =09=09=09vmx_instruction_info, true, &vmcs_gva))
>  =09=09return 1;
> @@ -12148,7 +12229,10 @@ static int nested_vmx_run(struct kvm_vcpu
> *vcpu, bool launch)
>  =09if (!nested_vmx_check_permission(vcpu))
>  =09=09return 1;
> =20
> -=09if (!nested_vmx_check_vmcs12(vcpu))
> +=09if (!nested_vmx_handle_enlightened_vmptrld(vcpu))
> +=09=09return 1;
> +
> +=09if (!vmx->nested.hv_evmcs && !nested_vmx_check_vmcs12(vcpu))
>  =09=09goto out;
> =20
>  =09vmcs12 =3D get_vmcs12(vcpu);
> --=20
> 2.14.4

Reviewed-By: Liran Alon <liran.alon@oracle.com>
