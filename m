Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E33C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E31721C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E31721C16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeHIInz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:43:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727230AbeHIIny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:43:54 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w796JCQu062298
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 02:20:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2krf8ysur4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 02:20:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 9 Aug 2018 07:20:35 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 07:20:32 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w796KUfW41615472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 06:20:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F08CDAE04D;
        Thu,  9 Aug 2018 09:20:22 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE3FFAE051;
        Thu,  9 Aug 2018 09:20:21 +0100 (BST)
Received: from [9.145.17.67] (unknown [9.145.17.67])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Aug 2018 09:20:21 +0100 (BST)
Subject: Re: [PATCH v8 20/22] KVM: s390: Handling of Cypto control block in
 VSIE
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
        Pierre Morel <pmorel@linux.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date:   Thu, 9 Aug 2018 08:20:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw"
X-TM-AS-GCONF: 00
x-cbid: 18080906-0016-0000-0000-000001F43C76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080906-0017-0000-0000-0000324A4DA3
Message-Id: <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=989 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw
Content-Type: multipart/mixed; boundary="zoIkknPCBIS9fHSmo77lJf57uLCc1UdSj";
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
 Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <dc8b3e66-9ba4-2b78-1e49-12a35d5d234b@linux.ibm.com>
Subject: Re: [PATCH v8 20/22] KVM: s390: Handling of Cypto control block in
 VSIE
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>
In-Reply-To: <1533739472-7172-21-git-send-email-akrowiak@linux.vnet.ibm.com>

--zoIkknPCBIS9fHSmo77lJf57uLCc1UdSj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.08.2018 16:44, Tony Krowiak wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> +#define ECA_APIE 0x00000008

That shouldn't be necessary, it's defined in kvm_host.h which vsie.c
includes. Or is it not?

> +static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page)
> +{
> +	struct kvm_s390_sie_block *scb_s =3D &vsie_page->scb_s;
> +	struct kvm_s390_sie_block *scb_o =3D vsie_page->scb_o;
> +	const uint32_t crycbd_o =3D READ_ONCE(scb_o->crycbd);
> +	const u32 crycb_addr =3D crycbd_o & 0x7ffffff8U;
> +	int g2_fmt =3D vcpu->arch.sie_block->crycbd & CRYCB_FORMAT_MASK;
> +	int g3_fmt =3D crycbd_o & CRYCB_FORMAT_MASK;
> +	int g2_apie, g2_msa3, g3_apie, g3_msa3;
> +	int size, ret;
> +
> +	/* crycb should not cross a page boundary */
> +	size =3D (g3_fmt =3D=3D CRYCB_FORMAT2) ? 0x100 : 0x80;
> +	if ((crycb_addr & PAGE_MASK) !=3D ((crycb_addr + size) & PAGE_MASK))
> +		return set_validity_icpt(scb_s, 0x003CU);
> +
> +	g2_apie =3D vcpu->arch.sie_block->eca & ECA_APIE;
> +	g3_apie =3D scb_o->eca & g2_apie;
> +
> +	g2_msa3 =3D test_kvm_facility(vcpu->kvm, 76);
> +	g3_msa3 =3D (g3_fmt !=3D CRYCB_FORMAT0) & g2_msa3;
> +
> +	scb_s->crycbd =3D 0;
> +	/* If no AP instructions and no keys we just set crycbd to 0 */
> +	if (!(g3_apie || g3_msa3))
> +		return 0;
> +
> +	if (!crycb_addr)
> +		return set_validity_icpt(scb_s, 0x0039U);
> +
> +	if (g3_apie) {
> +		ret =3D copy_apcb(vcpu, vsie_page, g2_fmt, g3_fmt);
> +		if (ret)
> +			goto out;

s/goto out;/return ret;/

> +		scb_s->eca |=3D g3_apie;
> +	}
> +
> +	if (g3_msa3)
> +		ret =3D copy_key_masks(vcpu, vsie_page);
> +
> +	if (!ret)
> +		scb_s->crycbd =3D ((__u32)(__u64) &vsie_page->crycb) | g2_fmt;
> +
> +out:
> +	return ret;
> +}
> +
>  /* shadow (round up/down) the ibc to avoid validity icpt */
>  static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_=
page)
>  {
>=20



--zoIkknPCBIS9fHSmo77lJf57uLCc1UdSj--

--7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJba90sAAoJEBcO/8Q8ZEV5flIP/0PqKs8xJo6i8IQM8Ig1oFyn
I8KXYstwekyKeZ5ebKxCxu57/lQ/tlrtz2cHl8FtskaNbd5eRRDfIbm/gXyx10l5
+8O8rC3AYFOJJ2ofJRGXUb6mh0efyOpa897V8Qs8TwJ6ZkBOXj/xL2++Im+iq/GT
lqmuWuBsQiIzmPe5r9ueF63x1EQzf8exJwXBvBarhgFGOqlguJk85uMHrYITUU0M
n3WdAmzeFlhWis6eTx9IqyyViMmlKCz15W57LTntcWboHWZV/+1HsBlPhkslxbWJ
lu4X3mnKfog062Ob12PIjZzvRske7yfVqJDfi3KezeHmRfjggdak+h/CYEpymo67
8GxIbLAoy+qlRGPBiRoV+dremAfcsCsmVBGm8CNqPFFBDBadqB+bc+WlNjB5CMAk
aIDgNGK0MAlwsRsJCDWe9Bcm/BuWNeypdnyOefRVUaT4m1O+Wn1JZHbDts2zaJ4O
OApsIWikbkExJQNeXu9BcWmcmjh8+gILHHMUQai5j0UswcaHkCUZC5M8wcWdsNug
I23b1gVPKukGifAGTL7j+7iaBI4BfpIu1RfOeauWRezWMS60xJAdFKphhzyrCgVa
i2VG4Xu7R/0uppwc+Xl666xlfR60lskYV6Zev3NR49sW06cFEx/DKcU4NUaFrZIP
h148Whx21lFUVb2kRbEM
=5ukE
-----END PGP SIGNATURE-----

--7yP7ABIUzi2Flvscp0MxtQKgqiq9qW3nw--

