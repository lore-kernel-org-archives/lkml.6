Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E43C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B71206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eko6Cau/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B71206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeH2NBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:01:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60326 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2NBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:01:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7T8x5Yu108146;
        Wed, 29 Aug 2018 09:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=xVMpFbOYXC0tLMzZasy6N2jLDB/RJuziyDBSWNUzF58=;
 b=Eko6Cau/nQSW74epCCiLdRNwMYSTiAquwYfvPRjKW3i9+RIR6/OfvHA1kZvGtXUyIDFT
 eop7LXzyFxsF8xNQZoBS+qMogiDNDOuPY/0qjP4+y+VPnNPSWVGSBlzSrkSxM38GsQFg
 FP8KTOS2dVzwYHySRGE5EhnSYvKZro43LJstyq3BJyxbJ7wIkLtOW/SKIz96VUr+nTB7
 jmLItAamI7IhQHVlEuwAfDt86Fo/TjOjipOdFt/fWHmU4Vmn2Z/R4sNMx+QeFzqWZVht
 oTaSVsiqX0H2YG/0uIes0Xs2MEvI2lGhq7m40LQ6xW15ubsDE9oHYxLpTLoTL5jjs9PZ 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2m2xhtrmpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 09:05:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7T95AQJ018221
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 09:05:11 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7T95Aw8029599;
        Wed, 29 Aug 2018 09:05:10 GMT
Received: from lirans-mbp.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 02:05:10 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
Date:   Wed, 29 Aug 2018 12:05:06 +0300
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
To:     Wanpeng Li <kernellwp@gmail.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=882
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29 Aug 2018, at 8:52, Wanpeng Li <kernellwp@gmail.com> wrote:
>=20
> From: Wanpeng Li <wanpengli@tencent.com>
>=20
> Dan Carpenter reported that the untrusted data returns from =
kvm_register_read()
> results in the following static checker warning:
>  arch/x86/kvm/lapic.c:576 kvm_pv_send_ipi()
>  error: buffer underflow 'map->phys_map' 's32min-s32max'
>=20
> KVM guest can easily trigger this by executing the following assembly =
sequence=20
> in Ring0:
>=20
> mov $10, %rax
> mov $0xFFFFFFFF, %rbx
> mov $0xFFFFFFFF, %rdx
> mov $0, %rsi
> vmcall
>=20
> As this will cause KVM to execute the following code-path:
> vmx_handle_exit() -> handle_vmcall() -> kvm_emulate_hypercall() -> =
kvm_pv_send_ipi()
> which will reach out-of-bounds access.
>=20
> This patch fixes it by adding a check to kvm_pv_send_ipi() against =
map->max_apic_id=20
> and also checking whether or not map->phys_map[min + i] is NULL since =
the max_apic_id=20
> is set according to the max apic id, however, some phys_map maybe NULL =
when apic id=20
> is sparse, in addition, kvm also unconditionally set max_apic_id to =
255 to reserve=20
> enough space for any xAPIC ID.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> arch/x86/kvm/lapic.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 0cefba2..86e933c 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned =
long ipi_bitmap_low,
> 	rcu_read_lock();
> 	map =3D rcu_dereference(kvm->arch.apic_map);
>=20
> +	if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < =
min))
> +		goto out;

I personally think =E2=80=9Cif ((min + __fls(ipi_bitmap_low)) > =
map->max_apic_id)=E2=80=9D is more readable.
But that=E2=80=99s just a matter of taste :)

> 	/* Bits above cluster_size are masked in the caller.  */
> 	for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
> -		vcpu =3D map->phys_map[min + i]->vcpu;
> -		count +=3D kvm_apic_set_irq(vcpu, &irq, NULL);
> +		if (map->phys_map[min + i]) {
> +			vcpu =3D map->phys_map[min + i]->vcpu;
> +			count +=3D kvm_apic_set_irq(vcpu, &irq, NULL);
> +		}
> 	}
>=20
> 	min +=3D cluster_size;
> +	if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_high)) < =
min))
> +		goto out;
> 	for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
> -		vcpu =3D map->phys_map[min + i]->vcpu;
> -		count +=3D kvm_apic_set_irq(vcpu, &irq, NULL);
> +		if (map->phys_map[min + i]) {
> +			vcpu =3D map->phys_map[min + i]->vcpu;
> +			count +=3D kvm_apic_set_irq(vcpu, &irq, NULL);
> +		}
> 	}
>=20
> +out:
> 	rcu_read_unlock();
> 	return count;
> }
> --=20
> 2.7.4
>=20

Reviewed-By: Liran Alon <liran.alon@oracle.com>


