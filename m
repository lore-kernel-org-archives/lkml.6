Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A10C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A1526612
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A1526612
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932758AbeF0IsO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:48:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932234AbeF0IsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:48:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R8ieIe065530
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 04:48:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jv4qn6syh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 04:48:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 27 Jun 2018 09:48:05 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 09:48:03 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5R8m2VB13566172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 08:48:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3415D4C040;
        Wed, 27 Jun 2018 09:47:53 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 002DC4C04E;
        Wed, 27 Jun 2018 09:47:52 +0100 (BST)
Received: from [9.152.224.155] (unknown [9.152.224.155])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 09:47:52 +0100 (BST)
Subject: Re: [PATCH] userfaultfd: hugetlbfs: Fix userfaultfd_huge_must_wait
 pte access
To:     Mike Kravetz <mike.kravetz@oracle.com>, aarcange@redhat.com
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180626132421.78084-1-frankja@linux.ibm.com>
 <c9c5c76c-23e5-671f-1fdc-8326e42917b9@oracle.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 xsFNBFfqIWIBEAC9u1ku3alDY4YilAfKidqWZ46kCnu7WPXkdcgH3ww/9CcgIDoeSr90SnaU
 T9gQRO92ESh2OO0ff3RMfmQpPG7hivVKu9G8z4Fsblxqi3sSHBNpZu3wYE81UQTlG2EJpccX
 DXlBUGmMI44Ra3+NoeYbsTn0vU2ke69NgOz9MxE87ZpsvQaDfl7XgxTqo+6DJMRpiCJiSgWs
 SXa73uTdHWgmauAbUkaExe+Mb0txAHPweh6zDrLmiMHO2aZLRCPiY6aaP4m6DtjAaZcBQRcG
 kliWjsiPs1i8UPJp00/oZW2sDvHntDcp34JXDEdxpRXlsBFOVaWs/9hkI+91M78+fgVxNyQD
 bc1KH7wiwoND/OSgeJqvI1kN/bz+qdwlQaoAEfSkOkfu7yC1yyx/VpQSdL1ozczGF/4ABZ+G
 FteQmDEjdg1C5vHAdmoh+yHqsNSDVgwi7Vr03r3D9ESUA8bLbQtBVc772rZpEEeuyKZhMi/f
 SF5aEk16cjp2EiXW5DJSGGKEut2FQQEWeya0A4/MItCplho1nUBGhtCoj5EpCdl7Z6mc4amO
 00m6TKFc03cU5Vo/ta3TwIZgmsnpWulgzlZYpxyezc3oJiOjTyQHo9QgChPOBXNe2mKs8pVY
 TtVksdg6V9UtuFz+FS9B/yuJO+3hMXcg+SOWvCs0HTNP8e4l8wARAQABzSVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+wsF9BBMBCAAnBQJay0EFAhsjBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEBcO/8Q8ZEV5BHEP/jaHXSQQQjBkACPIiejAqKZn
 GtRCnvYCvNDq801cvy20bEjKDYBVqWa958gTaynYdeDIoodyij+Vo/07O7J8Hua0ygJBJcEL
 IsQ4mikMO4AexFxulkk94Zcddukrhx8PHFCJqTEeNggYthI/Is+f+ypfkYq7A8MUFf+1K7Cz
 xJ+1e3eEM+3ZwOpI/qmGTnOpraxzu7nOhp+sezmvUPyiQ5YKz0nHUGQmrKS0Unoiz2Ooemmv
 WmFALdBa8Mep56PNKiucSckX49u5r7+4UHngJ569rOxevoUPZRgwpCgB4HWAsuNgpNrd3UJ5
 DIwQpwD4tJP0r/Pfz61MiE9ViCsNFMAGEZ6Sth4rHAnZrVtBmWcvqRTlP80PLjUeDZ3GtzsP
 CgspTxG5RRC2o1wpJeUfwiGRFgZ/x+j7cLjlfVGr3s3o8m0Ig2R17PMQh0r9RZ09MyZAqIvA
 A5MLX8Bs7znzlePwan7piToOGSOP5r7V7kejA+UGJLGmZHC5F9n7y8Pot1D99y/TiZW+wToy
 ESvPLCyTbMzzVxYxtKhoQXhazDeuoj+j9n8eaXVv2QXxWjDK4rjZj3gQw+yoxMt/pMMIVF7o
 PMdcaxXz3kSjwuknG9cmKmbVpl8nSVrtaewG2+A9lmv77XAYoZB7qynJH5dZXNpZJKZZLz8g
 1pWzSrI44X9QzsFNBFfqIWIBEACxMNRjr5jNnVCWusQTFMrn/IqlQ2pTRszzeHPJ3KYPE+m9
 z+WvNWJeaFXKnfza0HWvIZb5eMJ5DXZ/h6yMNcU2waCZA3HU4Qu0waGGzPdjNNhdv+qETp+5
 PHSwrqVt/cRDBGy9sv/MsDfo1bZkr5uBA73He/eeiLykxmYXgIYaXm/iBocclLDmMkHR4YS1
 IFk1Z27o2tz4nZ135jR22Leqf8MJluV8r+PGGY1NRAneXR9utS6oJnoWUJotBBIEP5ix/8Pt
 HrxvisS9VEu0kxa+mexJWnwHxFDTM9IsGgWMH0J5bm9W9fodoZCnZAh090mcUC7N3GVDJNgP
 620oBeBrd4gGUSLte0gy68hNujFDcbQ1w084lo5KETKx6Pd3UGjx+XgLyOpcV6yt5gn06bNk
 0PLJiBDWlI0+pT7R3mvP3CNwi3gbygViJ3gqNNNhiER78v+RQEylLgOHANnfJFsa2llKzUVO
 a74WcCA08SbNvGSywTriVAgrC1nyqC6wv8s2IsVvVJsI5dEXxlA05llbTgFXfrysPQnR04hm
 hwa7OmtvPzh67VbKUR1tJxiaRZuVeBhjNInNsx+0fWSX6cNr3Yp9GAEtKEfcUWnjttHgSQ2B
 B7J+WOIlmlhIhDFKBQrXT/sYxIu055o7YGxgO+cqJVrC5n2HoaCeTAVA6r1xKQARAQABwsFl
 BBgBAgAPBQJX6iFiAhsMBQkSzAMAAAoJEBcO/8Q8ZEV5R+oQAJgaEDxy1cpGmGva0s0Oxvia
 s5b4+otopF5pnlElTZcqWY1bx3vh2c5NZjCCubY1tb8548x6IprwAYtpmx3XlOXb12Jki/HT
 qHgeSscyleLbneNO+s8LfhJKY15smPqVKG6leCbtIpliZ0TI2Zif+gYvDZRruHYgHwi9bQzH
 +wEVDrgess/1dDq3Pt+W7NRhFoKKq7ZQOYkyHE1qdck/cGvq4/XCL9np7+3CBEql+QOtuR2o
 AdES5cnZwKm7peagQBEaFqgni26de11pW294pJRG0U36mSqxEoyqe97vKUYzsdy1hPPbOPfy
 7img6Ifh6WL1b4FIIn9TFbooQ1WRSQvbOzxL+E2x+vmEPfNxpzAuuS+ASLJ6Zv9QCOUAvzBn
 Lfg7BvkfUhALMIZnAoyYmxutcWL4XYYAvMG13l8hFYpoQcF4WEnUoP0UuNwXmR4QZvOuiE8u
 CyL9U2LEYbrPVTIsEtUVmDlCyD1Kq+6LE3aU+n06soITGp9a3/WNLpXUbUYfzRvYJ3p6jssI
 Pe50r3yPfdgbWIWzeWuLimNVTlbIZAi1Y0VIdCDbDQpXl2DDTB9zZw2yz0kRKxasMCAEsvlA
 CT0NLoyQplUjM1ir5e6QTwy9+v3niCCesupe7owsFfrg/YZsE9jCy8vWgdPjSnRJkwQqV2Fw
 lFM6NIuMAY1Y
Date:   Wed, 27 Jun 2018 10:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c9c5c76c-23e5-671f-1fdc-8326e42917b9@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EOx6EeNelUcnckrJL4sELenaLgzAW7D4j"
X-TM-AS-GCONF: 00
x-cbid: 18062708-0016-0000-0000-000001E0980C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062708-0017-0000-0000-00003234D5C3
Message-Id: <961dc253-b071-8a72-c046-c23cae377e2c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOx6EeNelUcnckrJL4sELenaLgzAW7D4j
Content-Type: multipart/mixed; boundary="y0PnyKh8xwW8SWzdhueygGCUBDtCbMUus";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Mike Kravetz <mike.kravetz@oracle.com>, aarcange@redhat.com
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <961dc253-b071-8a72-c046-c23cae377e2c@linux.ibm.com>
Subject: Re: [PATCH] userfaultfd: hugetlbfs: Fix userfaultfd_huge_must_wait
 pte access
References: <20180626132421.78084-1-frankja@linux.ibm.com>
 <c9c5c76c-23e5-671f-1fdc-8326e42917b9@oracle.com>
In-Reply-To: <c9c5c76c-23e5-671f-1fdc-8326e42917b9@oracle.com>

--y0PnyKh8xwW8SWzdhueygGCUBDtCbMUus
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.06.2018 19:00, Mike Kravetz wrote:
> On 06/26/2018 06:24 AM, Janosch Frank wrote:
>> Use huge_ptep_get to translate huge ptes to normal ptes so we can
>> check them with the huge_pte_* functions. Otherwise some architectures=

>> will check the wrong values and will not wait for userspace to bring
>> in the memory.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Fixes: 369cd2121be4 ("userfaultfd: hugetlbfs: userfaultfd_huge_must_wa=
it for hugepmd ranges")
> Adding linux-mm and Andrew on Cc:
>=20
> Thanks for catching and fixing this.

Sure
I'd be happy if we get less of these problems with time, this one was
rather painful to debug. :)

> I think this needs to be fixed in stable as well.  Correct?  Assuming
> userfaultfd is/can be enabled for impacted architectures.

Correct, it seems I forgot the CC stable...

>=20
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks

> -- Mike Kravetz
>> ---
>>  fs/userfaultfd.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index 123bf7d516fc..594d192b2331 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -222,24 +222,26 @@ static inline bool userfaultfd_huge_must_wait(st=
ruct userfaultfd_ctx *ctx,
>>  					 unsigned long reason)
>>  {
>>  	struct mm_struct *mm =3D ctx->mm;
>> -	pte_t *pte;
>> +	pte_t *ptep, pte;
>>  	bool ret =3D true;
>> =20
>>  	VM_BUG_ON(!rwsem_is_locked(&mm->mmap_sem));
>> =20
>> -	pte =3D huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
>> -	if (!pte)
>> +	ptep =3D huge_pte_offset(mm, address, vma_mmu_pagesize(vma));
>> +
>> +	if (!ptep)
>>  		goto out;
>> =20
>>  	ret =3D false;
>> +	pte =3D huge_ptep_get(ptep);
>> =20
>>  	/*
>>  	 * Lockless access: we're in a wait_event so it's ok if it
>>  	 * changes under us.
>>  	 */
>> -	if (huge_pte_none(*pte))
>> +	if (huge_pte_none(pte))
>>  		ret =3D true;
>> -	if (!huge_pte_write(*pte) && (reason & VM_UFFD_WP))
>> +	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
>>  		ret =3D true;
>>  out:
>>  	return ret;
>>



--y0PnyKh8xwW8SWzdhueygGCUBDtCbMUus--

--EOx6EeNelUcnckrJL4sELenaLgzAW7D4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbM09BAAoJEBcO/8Q8ZEV5i9oQAIqm1ue34kTJFM07C7AD3/H0
FU7fNoU9KCPnqyq9eyS3AWeW/tKu53JtuOn8zEtsExGpv1UkQKxfEmUd5PuOlAam
vdnxGv/xjVwggismVKu27LP39RhspCEPoZG4tGcPOMrCdM/xqE/3QSoSGdRVzab5
g9AykXJ9hOGd73VCBAMTAtVLFEBuqjY+kxlptxM0IuMQfBvltCsdGpncOIkF8UWQ
MiToGV1hF1r/MnOQn8IlkQZu3Ftgsm4Z8sGc3jfON+oad+P2OtaU1vbjMN3l0qW4
V9fWNN2QL7fMpqpV8AXDMYkLTo3iB6+ryd7BAt0Fo0nLt4NIo6eU+A809Wnx62d2
IhkbRpe0raZzDuK93LuhDeSp9Q4Xp597/u5cuIfL+kz2IugekVVc1E0wySZtvYoG
nscene1bQH9OJG7KnfUkEOm8Wpx5b0ys0/oqJgg7uSLaAoH591wgEYBAXZMvtJuD
afzap8+hSaLcyPC6QHMS+juh39YD/P0CVT1MvkOi6SaClKM2AUYH0UJep0BkA5Te
YCq22Qjy5KB8ruXwlgBtIrPxw3ADY9bOjpOglyd4lCoCge08FGaeWrB7t6aPZpjp
oqlcZ15gSMFmg/g7oCe5C7FuCTKwaoYLZU0TmLx2kny78WvrkPOjh6QkchYmpNgw
rY5WahobUYtljzX/yFqN
=8cRD
-----END PGP SIGNATURE-----

--EOx6EeNelUcnckrJL4sELenaLgzAW7D4j--

