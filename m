Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8DC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0617521BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0617521BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeHIIVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:21:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727417AbeHIIVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:21:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w795nQGv123684
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 01:58:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2krf8ys2md-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 01:58:23 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 9 Aug 2018 06:58:21 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 06:58:17 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w795wFHw42401864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 05:58:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CB96AE055;
        Thu,  9 Aug 2018 08:58:08 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7AE3AE053;
        Thu,  9 Aug 2018 08:58:06 +0100 (BST)
Received: from [9.145.17.67] (unknown [9.145.17.67])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 08:58:06 +0100 (BST)
Subject: Re: [PATCH v8 07/22] KVM: s390: refactor crypto initialization
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date:   Thu, 9 Aug 2018 07:58:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z"
X-TM-AS-GCONF: 00
x-cbid: 18080905-0008-0000-0000-0000025F3A30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080905-0009-0000-0000-000021C7482B
Message-Id: <169d2a44-34ae-3785-bdac-77018dc2ad13@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z
Content-Type: multipart/mixed; boundary="qEDmeonOndwJ9PknMSp0f5Fn5g8xo9EIb";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
 bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
 alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
 jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
 berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
 Tony Krowiak <akrowiak@linux.ibm.com>
Message-ID: <169d2a44-34ae-3785-bdac-77018dc2ad13@linux.ibm.com>
Subject: Re: [PATCH v8 07/22] KVM: s390: refactor crypto initialization
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1533739472-7172-8-git-send-email-akrowiak@linux.vnet.ibm.com>

--qEDmeonOndwJ9PknMSp0f5Fn5g8xo9EIb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.08.2018 16:44, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
>=20
> This patch refactors the code that initializes and sets up the
> crypto configuration for a guest. The following changes are
> implemented via this patch:
>=20
> 1. Prior to the introduction of AP device virtualization, it
>    was not necessary to provide guest access to the CRYCB
>    unless the MSA extension 3 (MSAX3) facility was installed
>    on the host system. With the introduction of AP device
>    virtualization, the CRYCB must be made accessible to the
>    guest if the AP instructions are installed on the host
>    and are to be provided to the guest.
>=20
> 2. Introduces a flag indicating AP instructions executed on
>    the guest shall be interpreted by the firmware. It is
>    initialized to indicate AP instructions are to be
>    to be interpreted and is used to set the SIE bit for
>    each vcpu during vcpu setup.
>=20
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Michael Mueller <mimu@linux.ibm.com>
> Tested-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  arch/s390/include/asm/kvm_host.h |    3 +
>  arch/s390/include/uapi/asm/kvm.h |    1 +
>  arch/s390/kvm/kvm-s390.c         |   86 ++++++++++++++++++++----------=
--------
>  3 files changed, 49 insertions(+), 41 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/k=
vm_host.h
> index af39561..0c13f61 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -187,6 +187,7 @@ struct kvm_s390_sie_block {
>  #define ECA_AIV		0x00200000
>  #define ECA_VX		0x00020000
>  #define ECA_PROTEXCI	0x00002000
> +#define ECA_APIE	0x00000008
>  #define ECA_SII		0x00000001
>  	__u32	eca;			/* 0x004c */
>  #define ICPT_INST	0x04
> @@ -256,6 +257,7 @@ struct kvm_s390_sie_block {
>  	__u8	reservede4[4];		/* 0x00e4 */
>  	__u64	tecmc;			/* 0x00e8 */
>  	__u8	reservedf0[12];		/* 0x00f0 */
> +#define CRYCB_FORMAT_MASK 0x00000003
>  #define CRYCB_FORMAT1 0x00000001
>  #define CRYCB_FORMAT2 0x00000003
>  	__u32	crycbd;			/* 0x00fc */
> @@ -714,6 +716,7 @@ struct kvm_s390_crypto {
>  	__u32 crycbd;
>  	__u8 aes_kw;
>  	__u8 dea_kw;
> +	__u8 apie;

In the last review I wanted a comment here to know what they do.

>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>  {
> -	if (!test_kvm_facility(vcpu->kvm, 76))
> +	/*
> +	 * If neither the AP instructions nor the MSAX3 facility are installe=
d
> +	 * on the host, then there is no need for a CRYCB in SIE because the
> +	 * they will not be installed on the guest either.

the they

> +	 */
> +	if (ap_instructions_available() && !test_facility(76))
>  		return;

I know you're not responsible for that one :) but 0 being the wanted
value here is a bit counter-intuitive.

> =20
> -	vcpu->arch.sie_block->ecb3 &=3D ~(ECB3_AES | ECB3_DEA);
> +	vcpu->arch.sie_block->crycbd =3D vcpu->kvm->arch.crypto.crycbd;
> +
> +	vcpu->arch.sie_block->eca &=3D ~ECA_APIE;

The scb is zero allocated, are the ECA and the ECB3s set somewhere
in-between, or is that your way of making sure the controls are
definitely gone for good?

> +	if (vcpu->kvm->arch.crypto.apie &&
> +	    test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
> +		vcpu->arch.sie_block->eca |=3D ECA_APIE;
> =20
> -	if (vcpu->kvm->arch.crypto.aes_kw)
> -		vcpu->arch.sie_block->ecb3 |=3D ECB3_AES;
> -	if (vcpu->kvm->arch.crypto.dea_kw)
> -		vcpu->arch.sie_block->ecb3 |=3D ECB3_DEA;
> +	/* If MSAX3 is installed on the guest, set up protected key support *=
/
> +	if (test_kvm_facility(vcpu->kvm, 76)) {
> +		vcpu->arch.sie_block->ecb3 &=3D ~(ECB3_AES | ECB3_DEA);
> =20
> -	vcpu->arch.sie_block->crycbd =3D vcpu->kvm->arch.crypto.crycbd;
> +		if (vcpu->kvm->arch.crypto.aes_kw)
> +			vcpu->arch.sie_block->ecb3 |=3D ECB3_AES;
> +		if (vcpu->kvm->arch.crypto.dea_kw)
> +			vcpu->arch.sie_block->ecb3 |=3D ECB3_DEA;
> +	}
>  }
> =20
>  void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>=20



--qEDmeonOndwJ9PknMSp0f5Fn5g8xo9EIb--

--aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJba9f1AAoJEBcO/8Q8ZEV5okMP/2LGSAqduKIyTLeynwB91p+C
F+Ev84sNUlY2WoQEhH3yeFpRQK8IGTdWHTUGNaxnMA79g97TarK8ceDqy4nRRIy0
uj9thAwt1QiAVcflrNnSELG1Z9TMlQhLvh+nrkKHFOF+jkoocBiFGW/3Aie1xUIW
Yo2Jb5cZCZxZl7b5AnJperH0IDj9cPm8IgTVuovcj+wlYTV5BLbTU6thyJXHCgUv
VFwO+gMraqH2/8wWlr8NJysgFf6v112+5XI3cM24NMhgnAV+S+5f3UIPVd7iv+5w
S4HMawP6pR9vVA0xXexL9hkeGyuCy4vRHjObydYzmFzJLkgp4gxFELasdUhXM6JN
+VpN0GbA9izALUzKC2bRRoXhde9+pxVyRYYCreZtL+0lDk2PFh3P5pXdrMzoHVY6
CsXGlGl3wOICIo355xuUYHfAr7N+PKCubk/mQfKeB1o3v0/NJsEwOXpwWbVHZgqT
SicDTXKUpahMpp/yIPncTc708L7YhjzZBqceBe7OmebQu8AmMhidJWElzaLR2Yx1
XhK+vIWy5YjdI5gUgzcfXgWsi1ZD41qvPKsg3VTOhnRMVQX+RckWBZBPdW1yFzy9
+7XwOUR52D4XXgPjLwBkUgHXTjr4s7aOJsRerHRgP5ymS/8hl7F6B+VQZJ0z9Tc+
j1k2aQiCphGwOIhICQXn
=zeW0
-----END PGP SIGNATURE-----

--aA7KH5SKfwKCjCWTE2SNS5CNdTZqETw6Z--

