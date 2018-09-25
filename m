Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D83C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A0621480
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JizVTj1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A0621480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeIYQK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:10:59 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:41994 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeIYQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:10:59 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4A9FB24E01D9;
        Tue, 25 Sep 2018 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537869851; bh=9JB8j4TY7S8HvAOSB1Ms0lI+jf2wTh9A7606N7tHaGA=;
        h=From:To:CC:Subject:Date:References:From;
        b=JizVTj1k7fzwHCjV1G5Al8/cUf/ByeH0JRKRt8NAOa5pdwnwLYWGasxo0/UOkFeXX
         S4iev0E433tbkxifhaeLHOJHHPCq1oKy5gqKRjoNNGysz7drQduwDk9DFonzZPoJdo
         hcZtaKfeL0b7/xwQ8wazo0UK4d8Fq70HN/s7luOI5VEXkE8ekGwfP/r715vbyysyYB
         MhfuZofuBYsDdifcv1f3ueDXFJ+RhSfVonwOUeHjnjavgT8k2O9iQs/SpcsQfB/GP2
         GLHGfMYfG8a3GCChgh+dxU9rAgsVPnEK0J2CzL89R62WQAlpp9pgDp69e1oscY5Gvt
         5T9JgyAdoCILw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id CDAD848CA;
        Tue, 25 Sep 2018 03:04:10 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 25 Sep 2018 03:04:10 -0700
Received: from AM04WEMBXB.internal.synopsys.com ([fe80::1006:bcdd:1b7:579b])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 25 Sep 2018 14:04:07 +0400
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
Date:   Tue, 25 Sep 2018 10:04:07 +0000
Message-ID: <3AD91E696667BF4BA728303C178E8A63532AB5E5@am04wembxb.internal.synopsys.com>
References: <1526690943-8211-1-git-send-email-john.stultz@linaro.org>
 <410670D7E743164D87FA6160E7907A5601313531E1@am04wembxa.internal.synopsys.com>
 <CALAqxLVZXs97sryfPaGY5Gq50-FZROgaBADNXXadcyiNhP3EPQ@mail.gmail.com>
 <410670D7E743164D87FA6160E7907A560131356C4E@am04wembxa.internal.synopsys.com>
 <CALAqxLU3sWrgPjFqZ2vK0m8wVThtE1hDsbNq9zRC7ritzyNHmQ@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AAF6D@am04wembxb.internal.synopsys.com>
 <CALAqxLXKOG8fxtrDaRLDGhJUfD1-4qc5QU60+ZmB3+9LsW69Lg@mail.gmail.com>
 <3AD91E696667BF4BA728303C178E8A63532AB36A@am04wembxb.internal.synopsys.com>
 <CALAqxLXy0YXNLwFQEUZxSsjFKC9boVcGkt+50XwmVfwKCcqsEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.104.24]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
On 9/24/2018 22:52, John Stultz wrote:=0A=
> On Sun, Sep 23, 2018 at 10:57 PM, Artur Petrosyan=0A=
> <arthur.petrosyan@synopsys.com> wrote:=0A=
>> Hi John,=0A=
>>=0A=
>> On 9/21/2018 05:05, John Stultz wrote:=0A=
>>> On Thu, Sep 20, 2018 at 7:17 AM, Artur Petrosyan=0A=
>>> <Arthur.Petrosyan@synopsys.com> wrote:=0A=
>>>> On 5/23/2018 01:57, John Stultz wrote:=0A=
>>>>> Its done automatically, when the OTG cable is detected it the host=0A=
>>>>> ports are disabled and when the OTG port is empty the host ports are=
=0A=
>>>>> enabled.=0A=
>>>>>=0A=
>>>>> Let me know if you need anything else!=0A=
>>>>>=0A=
>>>>=0A=
>>>> Please apply the patch set with this cover letter "[PATCH 0/3] usb:=0A=
>>>> dwc2: Fix hibernation for switching between host and device modes."=0A=
>>>=0A=
>>> Sorry, can you send the patches to me, or point me to a git tree? I'm=
=0A=
>>> not seeing that thread in my mailbox or on google.=0A=
>>>=0A=
>>>> Enable the power down on his devices. Let me know if you still see any=
=0A=
>>>> issue. If there is no issue, please provide Tested-by tag.=0A=
>>>=0A=
>>> Would be happy to test it, thought I'm traveling tomorrow, so I may=0A=
>>> not be able to validate till monday.=0A=
>>>=0A=
>>> thanks=0A=
>>> -john=0A=
>>>=0A=
>>=0A=
>> You can find the patch set following to this link.=0A=
>>=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__marc.info_-3Fl-3D=
linux-2Dusb-26m-3D153745139408236-26w-3D2&d=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWq=
B0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI&m=3Ddfaz_WctFBdFgywM2g=
9w0XVhgOdAS4gIsj9o23RnyvY&s=3D_Nz3ephAop_nqrfcICii4OgMkV14Mi4yaKk8-qPqdis&e=
=3D=0A=
> =0A=
> I applied those three patches, and it seems to work ok.=0A=
> =0A=
> Just to be clear, was there anything else I was needing to do while testi=
ng it?=0A=
> =0A=
> Otherwise,=0A=
> Tested-by: John Stultz <john.stultz@linaro.org>   #On HiKey=0A=
> =0A=
> thanks=0A=
> -john=0A=
> =0A=
=0A=
Just a clarification by this commit "[PATCH] usb: dwc2: Fix HiKey =0A=
regression caused by power_down feature"=0A=
https://marc.info/?l=3Dlinux-usb&m=3D152669095513248&w=3D2=0A=
=0A=
the power_down is disabled setting "p->power_down =3D false;" in =0A=
"dwc2_set_his_params" function.=0A=
=0A=
Could you please clarify that the testes done for those 3 patches were =0A=
done enabling "p->power_down =3D true;" in "dwc2_set_his_params" function.=
=0A=
=0A=
Regards,=0A=
Artur=0A=
=0A=
=0A=
=0A=
