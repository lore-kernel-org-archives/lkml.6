Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C357C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F021473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M8TXnCxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbeLQUMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:12:33 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:36794 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLQUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:12:33 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EAE1224E27BE;
        Mon, 17 Dec 2018 12:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545077553; bh=mov5V4V9PrRPxOkNxmZs7m6p9hogr2tW63ajosGBWj0=;
        h=From:To:CC:Subject:Date:References:From;
        b=M8TXnCxzYTugTCO6WETVORCJqSzPXzD2KsHc8kJdDAgWlJFF2Q1B7h3HAcSyB58kg
         WDJiBPF15WRQiSfTWQnqiJmSaW4ZYiNYo7mceYzyMMZA94oGzSFcRY66qeTml6CzJ5
         ccRBAVRTCZhfWkpcnfX7TXmmF4DyGu98D3wFO0I7c4Vo3Fe6npLW/EwaoIMfgkUIEC
         keoHIqWhjpUq1vq1rL8tUOKcaq2coyTcZpR8IBodM6hkCIekV0HjAb1/0xZvjXuJpd
         C+NWaZ/8/qEKkbHTiQnXhKL9G8/ki73CuxmWbE3yE+X9YgNB7gDu2QJ72g2FOQuhiF
         J8m5v3Q8mTYgA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9D5D63CC7;
        Mon, 17 Dec 2018 12:12:32 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Mon, 17 Dec 2018 12:12:32 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     liangshengjun <liangshengjun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Topic: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Index: AQHUk4c4aTEJCOLnsUKRaItzQg17Vw==
Date:   Mon, 17 Dec 2018 20:12:31 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639AAB35@us01wembx1.internal.synopsys.com>
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
 <87efaklcd1.fsf@linux.intel.com>
 <678F3D1BB717D949B966B68EAEB446ED24E20BE5@dggemm526-mbx.china.huawei.com>
 <878t0sl5br.fsf@linux.intel.com>
 <30102591E157244384E984126FC3CB4F639AA2A3@us01wembx1.internal.synopsys.com>
 <678F3D1BB717D949B966B68EAEB446ED24E217B3@dggemm526-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.20]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zengtao,=0A=
=0A=
On 12/16/2018 5:45 PM, Zengtao (B) wrote:=0A=
>>>>>> If it's a busy system, some times when we start an isoc transfer,=0A=
>>>>>> the framenumber get from the event buffer may be already elasped,=0A=
>>>>>> in this case, we will get all the packets dropped due to miss isoc.=
=0A=
>>>>>> And we turn into transfer nothing, to fix this issue, we need to=0A=
>>>>>> fix the framenumber to make sure that it's not out of date.=0A=
>>>>>>=0A=
>>>>>> Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>=0A=
>>>>>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>=0A=
>>>>> There's a patch going upstream already doing this:=0A=
>>>>>=0A=
>>>>>=0A=
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_balbi_usb.git_commit&d=3DDwIGaQ&c=3DDPL6_X_6JkXFx7AX=
WqB0tg&r=3Du9FYoxKtyhjrGFcyixFYqTjw1ZX0VsG2d8FCmzkTY-w&m=3DyGrN_JnamczN1G0w=
Y4Th67vAfxSJEouaUgJdu0u6Av8&s=3Dv4xeWOLyCSNoHxHS6kI8_bJfHgddFsPkqzgLFTJZOG8=
&e=3D=0A=
>>>>> /?h=0A=
>>>>> =3Dnext&id=3Dd53701067f048b8b11635e964b6d3bd9a248c622=0A=
>>>>>=0A=
>>>> Sorry, I think I missed to update to the latest version. But I think=
=0A=
>>>> my patch is more efficient. Because I just sync the frame from the=0A=
>>>> HW, it  won't fail and there is no need to extra tries.=0A=
>>>>=0A=
>>>> What do you think about it?=0A=
>>> the 14 bits you use for your check is not representative of the actual=
=0A=
>>> micro-frame you're currently in. Thinh explained that in the=0A=
>>> discussion we had until we came to the patch I pointed you to above.=0A=
>>> Please look at the mailing list archives for details.=0A=
>>>=0A=
>> There are several issues with this patch.=0A=
>> 1) Your frame elapsed time check is not based on interval but statically=
=0A=
>> DWC3_EVENT_PRAM_SOFFN / 2. That's about 1 second. So it doesn't=0A=
>> account for isoc transfers with large service interval of 1 sec or more.=
=0A=
>=0A=
> This is just for checking whether the Frame number is overflow or not. So=
=0A=
> 1 second should a reason value.=0A=
=0A=
Why when there's another way to solve this issue without creating a new=0A=
logic that only works within 1 second limit.=0A=
=0A=
>=0A=
>> 2) This function __dwc3_gadget_target_frame_elapsed() should have=0A=
>> comments for what it does. The name implies that this function checks=0A=
>> for eframe > cframe, and not eframe > cframe + 1s.=0A=
> eframe > cframe + 1s is used to deal with the Frame number overflow.=0A=
=0A=
Right. You need to provide comments for that. It's not obvious that=0A=
DWC3_EVENT_PRAM_SOFFN / 2 is around 1 second.=0A=
=0A=
>=0A=
>> 3) If this check fails, then it will do DWC3_ALIGN_FRAME() at least twic=
e.=0A=
>> The isoc transfer will start 1 more interval into the future than it nee=
ds to.=0A=
>>=0A=
> If the interval is one, 1 more interval should be more reasonable because=
 the=0A=
> core always fetch the trb one frame ahead.=0A=
=0A=
Did it fail with your setup when you test with interval of 1? It didn't=0A=
fail from my testing setup. Your check applies for all intervals and not=0A=
just interval of 1. Also, the databook doesn't mention this limitation=0A=
that you have to do 2 intervals into the future if the service interval=0A=
is 1.=0A=
=0A=
Regardless, if the __dwc3_gadget_target_frame_elapsed() passes for=0A=
service interval of 1, then you'd only do DWC3_ALIGN_FRAME() once. This=0A=
is different than what you said/wanted to do.=0A=
=0A=
>=0A=
>> Also, I think the role of this check should be from the controller as it=
 has=0A=
>> more information and its own logic to decide if the selected future ufra=
me=0A=
>> has elapsed.=0A=
> Yes, agree, but I think if the sw can be used to do the same thing and mo=
re=0A=
> effective, Why not? =0A=
>=0A=
=0A=
No. The SW cannot do the same thing. As Felipe mentioned previously,=0A=
__dwc3_gadget_get_frame() can only get a 14-bit frame number. The=0A=
controller keeps track of the frame number with at least 16 bits. It has=0A=
more information and can work with larger service intervals.=0A=
=0A=
Can you test with Felipe's patches to see if they work for you? We can=0A=
come back and review if there are still issues.=0A=
=0A=
Thanks,=0A=
Thinh=0A=
