Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E2D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ddNCHJ5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E2D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeIZMOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:14:00 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:54870 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbeIZMOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:14:00 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B7BF924E08FE;
        Tue, 25 Sep 2018 23:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537941765; bh=pxlQm2dZ3Yxt2r9Lftg6++qsyxu3o6OkIiKMvYj1SJI=;
        h=From:To:CC:Subject:Date:References:From;
        b=ddNCHJ5bAwpCpk3cyvzx/Ae+aKu7R6Ddpow+cV/PTajcgRfn4Tlx0KoN458VXIWpn
         x7MXzFKIH0BmQGt8dF7QQoiCPVjmnSlGHUT4SQL4vLchOyuPuwbzl9/jH7ih8gCWTv
         lPlsw5DsinKAVpteKfoqVaLA1avKg5VcTdnAyfnTGU0SGpNmgcl0KEXa0QxNiK3SnF
         DGNFvuah2cqx69Y6MQ0OLTSt/Ee15MN9AqyaHHKhQG/zauqUqO1L3a01RuAqixWmrN
         4JgOGR/tf/fqLQj/7NxTfCtJQRqg2IXsThUG1jDfmdQHu+wO4FisZgotqhZrhuBVZr
         f8pXES0l6vqYw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6894E3494;
        Tue, 25 Sep 2018 23:02:45 -0700 (PDT)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 25 Sep 2018 23:02:44 -0700
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed,
 26 Sep 2018 10:02:42 +0400
From:   Artur Petrosyan <arthur.petrosyan@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Artur Petrosyan <arthur.petrosyan@synopsys.com>
CC:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        lkml <linux-kernel@vger.kernel.org>,
        John Youn <John.Youn@synopsys.com>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Topic: [PATCH] usb: dwc2: Fix HiKey regression caused by power_down
 feature
Thread-Index: AQHT7ws4O+8B/axYs0CeMD+6l4m0jQ==
Date:   Wed, 26 Sep 2018 06:02:41 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532AB864@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
 <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
 <CALAqxLXy0YXNLwFQEUZxSsjFKC9boVcGkt+50XwmVfwKCcqsEw@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB5E5@am04wembxb.internal.synopsys.com>
 <CALAqxLW=jT+oUASGKxcFghfHZEU7LtFJBiBBkmMM1oarKjSBKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.210]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
On 9/25/2018 21:59, John Stultz wrote:=0A=
> On Tue, Sep 25, 2018 at 3:04 AM, Artur Petrosyan=0A=
> <arthur.petrosyan@synopsys.com> wrote:=0A=
>> Just a clarification by this commit "[PATCH] usb: dwc2: Fix HiKey=0A=
>> regression caused by power_down feature"=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3Fl-3D=
linux-2Dusb-26m-3D152669095513248-26w-3D2&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWq=
B0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3D0lMkv7adFVwkzyaUzD=
6-pUG0iwg4fd6b1-aHQgbqvSI&s=3Dm8SZvo3J_Za08sMbo-S9EkhoA06YnzEN-SRm-uTPnbg&e=
=3D=0A=
>>=0A=
>> the power_down is disabled setting "p->power_down =3D false;" in=0A=
>> "dwc2_set_his_params" function.=0A=
>>=0A=
>> Could you please clarify that the testes done for those 3 patches were=
=0A=
>> done enabling "p->power_down =3D true;" in "dwc2_set_his_params" functio=
n.=0A=
> =0A=
> So if I remove the "power_down =3D true" initialization, USB does not=0A=
> seem to function.=0A=
> =0A=
> If I boot w/ the gadget port removed, the USB host ports do work, but=0A=
> plugging in the gadget cable results in a bunch of:=0A=
>     dwc2 f72c0000.usb: Waiting for Host Mode, Mode=3DPeripheral=0A=
> messages.=0A=
> =0A=
> If I boot w/ the gadget port plugged in, USB gadget mode doesn't seem=0A=
> to function at all, and when I remove the gadget cable nothing=0A=
> happens, it doesn't switch to host mode.=0A=
> =0A=
> thanks=0A=
> -john=0A=
> =0A=
=0A=
Could you please send the dmesg logs for those situations?=0A=
Also, please specify the version of the kernel that the testes has been =0A=
done on.=0A=
=0A=
Regards,=0A=
Artur=0A=
=0A=
