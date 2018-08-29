Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9955C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F5020833
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SjcjKomH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F5020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeH2Ojx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:39:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2Ojx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:39:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7TAhU67025773;
        Wed, 29 Aug 2018 10:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=RDpOnvCDyWDT788rVRzX/abois3l1Ut7PyjWTdR2uNc=;
 b=SjcjKomHEOsbNvOStZ5rZZHcpUhn8e79UpxrigVz5k8KFjp8LMzfO5wkX/wDvY71EkYm
 eBozdOqe8tmS1D8UMe7OlAaf93I9y5Wd2H5SUKWxWBav8+o8Q+M22ghEuwSw1yv6kqVD
 LRYvV7RQav98EdSI1pw/OOZt++8q8qbVSf+8+PNEKKrJlIj0/qY1TC75RXQ+LYVhWQry
 OuIJsFpOt4krM7YHCjVhdBjW7D45DdJnh4FQW5dRFvtvAW4wdogSjp+lmc/nZD8/YMKf
 uX2lMOHU6QodxVB+Ryuc7DL8PxgDdH1iDl9dVFx73BUjcogQbKPXmi170cVxZSx+lzya 7w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m2y2ph0tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:43:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7TAhQwl005758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Aug 2018 10:43:26 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7TAhQOF019862;
        Wed, 29 Aug 2018 10:43:26 GMT
Received: from lirans-mbp.ravello.local (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Aug 2018 03:43:25 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] KVM: LAPIC: Fix pv ipis out-of-bounds access
From:   Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20180829102910.rkyato47chayt22s@mwanda>
Date:   Wed, 29 Aug 2018 13:43:21 +0300
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <485CA660-9423-45B7-848F-49E3D13D5CBD@oracle.com>
References: <1535521943-5547-1-git-send-email-wanpengli@tencent.com>
 <A523C29C-C3E8-4FEF-8620-96365F774582@oracle.com>
 <20180829101205.jsp53e2wq7fc6ukd@mwanda>
 <20180829101822.qo3u7lsmghs3kcuf@mwanda>
 <CANRm+Cy9n=2Ssy_cEWRtnoQJczjdqB+m-dA6zesz75r0h532iA@mail.gmail.com>
 <20180829102910.rkyato47chayt22s@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8999 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=783
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808290118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29 Aug 2018, at 13:29, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> On Wed, Aug 29, 2018 at 06:23:08PM +0800, Wanpeng Li wrote:
>> On Wed, 29 Aug 2018 at 18:18, Dan Carpenter =
<dan.carpenter@oracle.com> wrote:
>>>=20
>>> On Wed, Aug 29, 2018 at 01:12:05PM +0300, Dan Carpenter wrote:
>>>> On Wed, Aug 29, 2018 at 12:05:06PM +0300, Liran Alon wrote:
>>>>>> arch/x86/kvm/lapic.c | 17 +++++++++++++----
>>>>>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>>>>>=20
>>>>>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>>>>>> index 0cefba2..86e933c 100644
>>>>>> --- a/arch/x86/kvm/lapic.c
>>>>>> +++ b/arch/x86/kvm/lapic.c
>>>>>> @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, =
unsigned long ipi_bitmap_low,
>>>>>>  rcu_read_lock();
>>>>>>  map =3D rcu_dereference(kvm->arch.apic_map);
>>>>>>=20
>>>>>> + if (unlikely((s32)(map->max_apic_id - __fls(ipi_bitmap_low)) < =
min))
>>>>>> +         goto out;
>>>>>=20
>>>>> I personally think =E2=80=9Cif ((min + __fls(ipi_bitmap_low)) > =
map->max_apic_id)=E2=80=9D is more readable.
>>>>> But that=E2=80=99s just a matter of taste :)
>>>>=20
>>>> That's an integer overflow.
>>>>=20
>>>> But I do prefer to put the variable on the left.  The truth is that =
some
>>>> Smatch checks just ignore code which is backwards written because
>>>> otherwise you have to write duplicate code and the most code is =
written
>>>> with the variable on the left.
>>>>=20
>>>>      if (min > (s32)(map->max_apic_id - __fls(ipi_bitmap_low))
>>>=20
>>> Wait, the (s32) cast doesn't make sense.  We want negative min =
values to
>>> be treated as invalid.
>>=20
>> In v2, how about:
>>=20
>> if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) =
>
>> map->max_apic_id))
>>    goto out;
>=20
> That works, too.  It still has the off by one and we should set
> "count =3D -KVM_EINVAL;".
>=20
> Is the unlikely() really required?  I don't know what the fast paths =
are
> in KVM, so I don't know.
>=20
> regards,
> dan carpenter

Why is =E2=80=9Cmin=E2=80=9D defined as =E2=80=9Cint=E2=80=9D instead of =
=E2=80=9Cunsigned int=E2=80=9D?
It represents the lowest APIC ID in bitmap so it can=E2=80=99t be =
negative=E2=80=A6

"if (unlikely(min > map->max_apic_id || (min + __fls(ipi_bitmap_low)) > =
map->max_apic_id))=E2=80=9D
should indeed be ok.

-Liran


