Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD24FC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AF52089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UbsJgUy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82AF52089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJCVZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:25:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeJCVZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:25:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w93ET7AR104300;
        Wed, 3 Oct 2018 14:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : subject
 : from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=corp-2018-07-02;
 bh=XpDQjjUiKYfAOHZvTIK8ECwxAx4kiiqvoL3CCgo4gto=;
 b=UbsJgUy+zpE0BWjZluE/YAjZ1E1v+TQ2UkkGcaGRRexcHMRwBn5e+3QJRLZIGfdWMAD/
 h+2FRy55Bf4PrcSwcnKFj3/+r9iw02WFPzki83I++u1VVb+/qXOv1mzRUDMHHbPHjtyK
 pD7Q/KYn5VcfOoRvNZS2g9UnarLIqC5ro1yCbjNweV977bxA0kV6r1/zJU0lS7WIcIjr
 B6W34vcwOuNQ4/SpT6CO3XQwHaNYxa09y90HPl0K/KbHqhl5j+J07wjCfxPkU/NumCVB
 5Dnr1iVKQyzSNyjZTHkyCVZbUO/51njIIOSyjx25lfp2HwUhFH9DeZ9fzzn5BvJICjXM Gw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mt1bq4cer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Oct 2018 14:36:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w93EaOUR019790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Oct 2018 14:36:25 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w93EaOag031945;
        Wed, 3 Oct 2018 14:36:24 GMT
Received: from firelight (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Oct 2018 14:36:24 +0000
Message-ID: <31248579054378dd2b820682c8ea99c9fb9b62cb.camel@oracle.com>
Subject: Re: [PATCH] kvm: nVMX: fix entry with pending interrupt if APICv is
 enabled
From:   Nikita Leshenko <nikita.leshchenko@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Date:   Wed, 03 Oct 2018 17:36:15 +0300
In-Reply-To: <1538567267-2343-1-git-send-email-pbonzini@redhat.com>
References: <1538567267-2343-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9034 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=783
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810030141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-03 at 13:47 +0200, Paolo Bonzini wrote:
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
> ---
>  arch/x86/kvm/vmx.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 6ef2d5b139b9..c0c7689f0049 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10280,6 +10280,11 @@ static void vmx_hwapic_isr_update(struct kvm_vcp=
u *vcpu, int max_isr)
>  	}
>  }
> =20
> +static u8 vmx_get_rvi(void)
> +{
> +	return vmcs_read16(GUEST_INTR_STATUS) & 0xff;
> +}
> +
>  static void vmx_set_rvi(int vector)
>  {
>  	u16 status;
> @@ -12593,10 +12598,13 @@ static int enter_vmx_non_root_mode(struct kvm_v=
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
> +	if (enable_apicv && kvm_vcpu_apicv_active(vcpu))
> +		evaluate_pending_interrupts |=3D vmx_get_rvi() > 0;

You should check for RVI > VPPR, similarly to how it is done in
vmx_guest_apic_has_interrupt().

Also, now that you introduced vmx_get_rvi(), it could be nice to use it
in vmx_guest_apic_has_interrupt() as well.

Apart from that, looks good.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>

Thanks,
Nikita

> =20
>  	enter_guest_mode(vcpu);
> =20
> @@ -12650,10 +12658,8 @@ static int enter_vmx_non_root_mode(struct kvm_vc=
pu *vcpu, u32 *exit_qual)
>  	 * instead. Thus, we force L0 to perform pending event
>  	 * evaluation by requesting a KVM_REQ_EVENT.
>  	 */
> -	if (vmcs01_cpu_exec_ctrl &
> -		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING)) {
> +	if (evaluate_pending_interrupts)
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
> -	}
> =20
>  	/*
>  	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point

