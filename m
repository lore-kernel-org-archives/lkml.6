Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6E6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7300B2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zBm7EwhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7300B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKGW3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:29:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGW3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:29:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA7CmdVe167337;
        Wed, 7 Nov 2018 12:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=nKud3UATwc76gkx5/Pz33XLfjBqEZFTNvU/O8gvjEOQ=;
 b=zBm7EwhQY6oTeA+kQSlM6G+js3byfTyZ5Fao4YFUdk5u64yxeBGCSJ3l+s+n6v5WZyjc
 oKoVVcy3SqS1XDY/SVdEQKMz6SZz0BNRuv/JFLcbEwOI2cpevIueuE1++k+QKLO/5ozP
 jDuYPhvWEjxSVCxzmN3BzH+0GyOolVWnGAckPYdwPzz2tkGREWyYkjVqd26E9HsvI7xk
 f2aEpkziwlb1UBzH2JaXM8P/slOYYnLW4Wo7BABjeUFb1ntdn0zXFiXMImPXT+4xRG0X
 MLLK844fuj3IHvTr8t7xi9dt7zDO3LTRT5sH4Yw+wvDqbXQpPyonBOU5DPRnq9VzXoCn zg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nh4aqu667-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Nov 2018 12:58:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA7CwtVu019637
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Nov 2018 12:58:56 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA7Cwtvp026430;
        Wed, 7 Nov 2018 12:58:55 GMT
Received: from lirans-mbp.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Nov 2018 04:58:55 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: KMSAN: kernel-infoleak in kvm_vcpu_write_guest_page
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <9d2e26fb-1d2a-248f-5451-ee95d8a6c017@redhat.com>
Date:   Wed, 7 Nov 2018 14:58:52 +0200
Cc:     Alexander Potapenko <glider@google.com>,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A114BC0-96E7-41AF-A975-EC3B87A5A60D@oracle.com>
References: <0000000000005de8da057a092ba2@google.com>
 <CAG_fn=Wmc+YU8BMcY_RXxAvVTpAMez5QUFyQSH3UsRg4Y-ZwMQ@mail.gmail.com>
 <9d2e26fb-1d2a-248f-5451-ee95d8a6c017@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811070117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Nov 2018, at 14:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 07/11/2018 13:10, Alexander Potapenko wrote:
>> This appears to be a real bug in KVM.
>> Please see a simplified reproducer attached.
>=20
> Thanks, I agree it's a reael bug.  The basic issue is that the
> kvm_state->size member is too small (1040) in the KVM_SET_NESTED_STATE
> ioctl, aka 0x4080aebf.
>=20
> One way to fix it would be to just change kmalloc to kzalloc when
> allocating cached_vmcs12 and cached_shadow_vmcs12, but really the =
ioctl
> is wrong and should be rejected.  And the case where a shadow VMCS has
> to be loaded is even more wrong, and we have to fix it anyway, so I
> don't really like the idea of papering over the bug in the allocation.
>=20
> I'll test this patch and submit it formally:
>=20
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index c645f777b425..c546f0b1f3e0 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -14888,10 +14888,13 @@ static int vmx_set_nested_state(struct
> kvm_vcpu *vcpu,
> 	if (ret)
> 		return ret;
>=20
> -	/* Empty 'VMXON' state is permitted */
> -	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
> +	/* Empty 'VMXON' state is permitted.  A partial VMCS12 is not.  =
*/
> +	if (kvm_state->size =3D=3D sizeof(kvm_state))
> 		return 0;
>=20
> +	if (kvm_state->size < sizeof(kvm_state) + VMCS12_SIZE)
> +		return -EINVAL;
> +

I don=E2=80=99t think that this test is sufficient to fully resolve =
issue.
What if malicious userspace supplies valid size but pages containing =
nested_state->vmcs12 is unmapped?
This will result in vmx_set_nested_state() still calling =
set_current_vmptr() but failing on copy_from_user()
which still leaks cached_vmcs12 on next VMPTRLD of guest.

Therefore, I think that the correct patch should be to change =
vmx_set_nested_state() to
first gather all relevant information from userspace and validate it,
and only then start applying it to KVM=E2=80=99s internal vCPU state.

> 	if (kvm_state->vmx.vmcs_pa !=3D -1ull) {
> 		if (kvm_state->vmx.vmcs_pa =3D=3D =
kvm_state->vmx.vmxon_pa ||
> 		    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
> @@ -14917,6 +14920,7 @@ static int vmx_set_nested_state(struct =
kvm_vcpu
> *vcpu,
> 	}
>=20
> 	vmcs12 =3D get_vmcs12(vcpu);
> +	BUILD_BUG_ON(sizeof(*vmcs12) > VMCS12_SIZE);

Why put this BUILD_BUG_ON() specifically here?
There are many places which assumes cached_vmcs12 is of size =
VMCS12_SIZE.
(Such as nested_release_vmcs12() and handle_vmptrld()).

> 	if (copy_from_user(vmcs12, user_kvm_nested_state->data, =
sizeof(*vmcs12)))
> 		return -EFAULT;
>=20
> @@ -14932,7 +14936,7 @@ static int vmx_set_nested_state(struct =
kvm_vcpu
> *vcpu,
> 	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
> 	    vmcs12->vmcs_link_pointer !=3D -1ull) {
> 		struct vmcs12 *shadow_vmcs12 =3D =
get_shadow_vmcs12(vcpu);
> -		if (kvm_state->size < sizeof(kvm_state) + 2 * =
sizeof(*vmcs12))
> +		if (kvm_state->size < sizeof(kvm_state) + 2 * =
VMCS12_SIZE)
> 			return -EINVAL;
>=20
> 		if (copy_from_user(shadow_vmcs12,
>=20
> Paolo

-Liran


