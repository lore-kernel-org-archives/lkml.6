Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544BBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E7020663
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hzNMbkAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E7020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeK1G5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:57:22 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45052 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1G5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:57:20 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6F39D8365A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 08:58:18 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1543348698;
        bh=Od4A213TLQ3NhGU9HgRrDPyQ1IY8kxAUf1tTzfP3fmU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=hzNMbkAc81lBAjmsuGpngun67cHNHPpsDuPAdDCDqOmVaap64j3I77j1ACcssAe0s
         TyLSJPR5Oem5Vay/4ka2khrFKv3TSUhIkZpOTKFX5dTNpfjcd75fR5ZZzdYxQLBbgZ
         w2s9L8l3sf5x9jkQHYGRiXaGiAXMpNgXkQUMqUgJO6TptLJWvRad50oo/9rwpyKokW
         bDzWbRaf4u4UKXBcD0rpx1BUlu/YY2ug3kLWejBQJcW5BS+iRjNVjt8N59uAB9fCWQ
         Srf9Ag6IGZUNkkR29B25zlshrct/FcF2BGtkehUkFepDuM19kz2mR4iV51JK2UhA1P
         c5GqsOdDQSwcQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5bfda1d90001>; Wed, 28 Nov 2018 08:58:17 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 28 Nov 2018 08:58:18 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 28 Nov 2018 08:58:18 +1300
From:   Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] tty/sysrq: Do not call sync directly from
 sysrq_do_reset()
Thread-Topic: [PATCH RESEND] tty/sysrq: Do not call sync directly from
 sysrq_do_reset()
Thread-Index: AQHUhcqxsQOYM6dIbkaK+PjfzFnZzKVijaSAgACj7IA=
Date:   Tue, 27 Nov 2018 19:58:17 +0000
Message-ID: <6d069b48-da59-911b-19cc-cc24d3136c48@alliedtelesis.co.nz>
References: <20181126205723.14478-1-mark.tomlinson@alliedtelesis.co.nz>
 <20181127101135.GA15856@kroah.com>
In-Reply-To: <20181127101135.GA15856@kroah.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.16.78]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <3E2C62F5D2440C419F1EED802E708020@atlnz.lc>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/11/18 11:11 PM, Greg KH wrote:
> On Tue, Nov 27, 2018 at 09:57:23AM +1300, Mark Tomlinson wrote:
>> sysrq_do_reset() is called in softirq context, so it cannot call
>> sync() directly. Instead, call orderly_reboot(), which creates a work
>> item to run /sbin/reboot, or do emergency_sync and restart if the
>> command fails.
>>
>> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
>> ---
>>   drivers/tty/sysrq.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>> index ad1ee5d01b53..f2ca32c1ad7c 100644
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -660,8 +660,7 @@ static void sysrq_do_reset(struct timer_list *t)
>>  =20
>>   	state->reset_requested =3D true;
>>  =20
>> -	ksys_sync();
>> -	kernel_restart(NULL);
>> +	orderly_reboot();
>=20
> Is this something new?  Why haven't we had reports of this failing in
> the past?  Or has something changed recently to cause this to now be
> needed?
>=20
> thanks,
>=20
> greg k-h
>=20

As far as I can tell, sysrq_do_reset() is only used when setting the=20
"keyset" property in "/chosen/linux,sysrq-reset-seq" (which is what I=20
want to do). No DTS file in the kernel tree sets this, so I don't know=20
if anyone else is using this. I am wondering whether it ever worked. A=20
reboot does occur after a kernel panic, so if the console is not=20
available, it may appear to have worked.

Pressing the standard 'sysrq' key followed by 'b'(reboot) instead calls=20
sysrq_handle_reboot(), which does not call sync at all, but=20
emergency_restart(). Also, the 's'(sync) key calls emergency_sync(),=20
which performs the sync via a work queue.=
