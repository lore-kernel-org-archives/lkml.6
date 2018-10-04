Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B76C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBA520652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BimOYIwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBA520652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJDQV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:21:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45872 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeJDQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:21:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w949T2et170427;
        Thu, 4 Oct 2018 09:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=dlqLGUpmb1WnzZyjMex5HUR4KDcwcCCi20QtDQvx/sc=;
 b=BimOYIwSZm1vUmK0pkBQqPYwIK+qJD59JjJJX7zXuVsdLaClJyumYHVXpHKbRUfFNYg/
 uiFK3P67iEkVqw7jk2vXnKarWzSFKKSovuQzrOYYkvQ9rt5JxjJk/VmCy4vanC4VPgmm
 ++F/TwnxMeq3IZqceMN99wz3QmUOLTQNHRwFc/el1pMwGhjmaSw24mJVqQAsoazzkckf
 foAH6TM/n3WbL0jkFqskJvhyIuw9cqrw1IQUGUuYMehxlAZnF+DDtDa8eOMZZJAf0ZWS
 NVvlDM9k1pb8iMo7erNBNylnCj6CLfQCWbCk+Dsgb1YIjXenGfc5gyAt8KpAj3ygkWnI zQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mt21raw9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Oct 2018 09:29:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w949T1nL000806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Oct 2018 09:29:01 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w949T1kd030775;
        Thu, 4 Oct 2018 09:29:01 GMT
Received: from firelight (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Oct 2018 09:29:00 +0000
Message-ID: <5bd9a3728298b32c067be9048b328f6768f85ab2.camel@oracle.com>
Subject: Re: [PATCH v2] kvm: nVMX: fix entry with pending interrupt if APICv
 is enabled
From:   Nikita Leshenko <nikita.leshchenko@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Date:   Thu, 04 Oct 2018 12:28:54 +0300
In-Reply-To: <1538580370-9634-1-git-send-email-pbonzini@redhat.com>
References: <1538580370-9634-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9035 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810040097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 17:26 +0200, Paolo Bonzini wrote:
> Commit b5861e5cf2fcf83031ea3e26b0a69d887adf7d21 introduced a check on
> the interrupt-window and NMI-window CPU execution controls in order to
> inject an external interrupt vmexit before the first guest instruction
> executes.  However, when APIC virtualization is enabled the host does not
> need a vmexit in order to inject an interrupt at the next interrupt windo=
w;
> instead, it just places the interrupt vector in RVI and the processor wil=
l
> inject it as soon as possible.  Therefore, on machines with APICv it is
> not enough to check the CPU execution controls: the same scenario can als=
o
> happen if RVI>0.
>=20
> Fixes: b5861e5cf2fcf83031ea3e26b0a69d887adf7d21
> Cc: Nikita Leshchenko <nikita.leshchenko@oracle.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>

> ---
>  arch/x86/kvm/vmx.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 6ef2d5b139b9..c7ae8ea87bc4 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -6162,6 +6162,11 @@ static void vmx_complete_nested_posted_interrupt(s=
truct kvm_vcpu *vcpu)
>  	nested_mark_vmcs12_pages_dirty(vcpu);
>  }
> =20
> +static u8 vmx_get_rvi(void)
> +{
> +	return vmcs_read16(GUEST_INTR_STATUS) & 0xff;
> +}
> +
>  static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> @@ -6174,7 +6179,7 @@ static bool vmx_guest_apic_has_interrupt(struct kvm=
_vcpu *vcpu)
>  		WARN_ON_ONCE(!vmx->nested.virtual_apic_page))
>  		return false;
> =20
> -	rvi =3D vmcs_read16(GUEST_INTR_STATUS) & 0xff;
> +	rvi =3D vmx_get_rvi();
> =20
>  	vapic_page =3D kmap(vmx->nested.virtual_apic_page);
>  	vppr =3D *((u32 *)(vapic_page + APIC_PROCPRI));
> @@ -10349,6 +10354,14 @@ static int vmx_sync_pir_to_irr(struct kvm_vcpu *=
vcpu)
>  	return max_irr;
>  }
> =20
> +static u8 vmx_has_apicv_interrupt(struct kvm_vcpu *vcpu)
> +{
> +	u8 rvi =3D vmx_get_rvi();
> +	u8 vppr =3D kvm_lapic_get_reg(vcpu->arch.apic, APIC_PROCPRI);
> +
> +	return ((rvi & 0xf0) > (vppr & 0xf0));
> +}
> +
>  static void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bi=
tmap)
>  {
>  	if (!kvm_vcpu_apicv_active(vcpu))
> @@ -12593,10 +12606,13 @@ static int enter_vmx_non_root_mode(struct kvm_v=
cpu *vcpu, u32 *exit_qual)
>  	struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
>  	bool from_vmentry =3D !!exit_qual;
>  	u32 dummy_exit_qual;
> -	u32 vmcs01_cpu_exec_ctrl;
> +	bool evaluate_pending_interrupts;
>  	int r =3D 0;
> =20
> -	vmcs01_cpu_exec_ctrl =3D vmcs_read32(CPU_BASED_VM_EXEC_CONTROL);
> +	evaluate_pending_interrupts =3D vmcs_read32(CPU_BASED_VM_EXEC_CONTROL) =
&
> +		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING);
> +	if (likely(!evaluate_pending_interrupts) && kvm_vcpu_apicv_active(vcpu)=
)
> +		evaluate_pending_interrupts |=3D vmx_has_apicv_interrupt(vcpu);
> =20
>  	enter_guest_mode(vcpu);
> =20
> @@ -12644,16 +12660,14 @@ static int enter_vmx_non_root_mode(struct kvm_v=
cpu *vcpu, u32 *exit_qual)
>  	 * to L1 or delivered directly to L2 (e.g. In case L1 don't
>  	 * intercept EXTERNAL_INTERRUPT).
>  	 *
> -	 * Usually this would be handled by L0 requesting a
> -	 * IRQ/NMI window by setting VMCS accordingly. However,
> -	 * this setting was done on VMCS01 and now VMCS02 is active
> -	 * instead. Thus, we force L0 to perform pending event
> -	 * evaluation by requesting a KVM_REQ_EVENT.
> -	 */
> -	if (vmcs01_cpu_exec_ctrl &
> -		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING)) {
> +	 * Usually this would be handled by the processor noticing an
> +	 * IRQ/NMI window request, or checking RVI during evaluation of
> +	 * pending virtual interrupts.  However, this setting was done
> +	 * on VMCS01 and now VMCS02 is active instead. Thus, we force L0
> +	 * to perform pending event evaluation by requesting a KVM_REQ_EVENT.
> +	 */
> +	if (unlikely(evaluate_pending_interrupts))
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
> -	}
> =20
>  	/*
>  	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point

