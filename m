Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA5CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D9D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="V1DP0JPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbeLNVnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:43:00 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:40510 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730758AbeLNVnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:43:00 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A328624E0EC0;
        Fri, 14 Dec 2018 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544823779; bh=Wu+TVcoDh+xsDcUVrnmqZ6QOZuZZGH4Y3fupPjy9T9M=;
        h=From:To:CC:Subject:Date:References:From;
        b=V1DP0JPOhr0BdyvFMjEHjmM4Ks7ah1CkR9Wn+9zgEXtTCxE1tAHLVSsdWae1rqexT
         q76ftOZIS3lw1oLnVgL5p2ZRHZWDwd0jlXts2tqhfr9DHV+DSCo+kzz0KFH4qNG/F0
         cM7Ae/V+383VuPe1lEJ1xc9wOO4mxHzRYjm52/erNmm30NTaVRdmAzQkWrWTw+XAG/
         s8xUjBD//5mJLhaBIkdz8yndybaoPFgoBiupY9y+F2oZqh/FFeLJ6jQg0+NBgSK2LT
         DE2V7g4tzf8eN/uec0QPqfG5Sxl3kEhA0dAtzyw04OmXZrzJrJXicfR5weQPSfzxw6
         ikfxFEsjCrLCg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id CAE61376E;
        Fri, 14 Dec 2018 13:42:55 -0800 (PST)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.228]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 14 Dec 2018 13:42:55 -0800
From:   Thinh Nguyen <thinh.nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
CC:     liangshengjun <liangshengjun@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
Subject: Re: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Topic: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by
 IRQ latency
Thread-Index: AQHUk4c4aTEJCOLnsUKRaItzQg17Vw==
Date:   Fri, 14 Dec 2018 21:42:54 +0000
Message-ID: <30102591E157244384E984126FC3CB4F639AA2A3@us01wembx1.internal.synopsys.com>
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
 <87efaklcd1.fsf@linux.intel.com>
 <678F3D1BB717D949B966B68EAEB446ED24E20BE5@dggemm526-mbx.china.huawei.com>
 <878t0sl5br.fsf@linux.intel.com>
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
On 12/14/2018 3:24 AM, Felipe Balbi wrote:=0A=
> Hi,=0A=
>=0A=
> "Zengtao (B)" <prime.zeng@hisilicon.com> writes:=0A=
>>> -----Original Message-----=0A=
>>> From: Felipe Balbi [mailto:balbi@kernel.org]=0A=
>>> Sent: Friday, December 14, 2018 4:52 PM=0A=
>>> To: Zengtao (B) <prime.zeng@hisilicon.com>=0A=
>>> Cc: liangshengjun <liangshengjun@hisilicon.com>; Zengtao (B)=0A=
>>> <prime.zeng@hisilicon.com>; Greg Kroah-Hartman=0A=
>>> <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org;=0A=
>>> linux-kernel@vger.kernel.org=0A=
>>> Subject: Re: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced =
by=0A=
>>> IRQ latency=0A=
>>>=0A=
>>> * PGP Signed by an unknown key=0A=
>>>=0A=
>>> Zeng Tao <prime.zeng@hisilicon.com> writes:=0A=
>>>=0A=
>>>> If it's a busy system, some times when we start an isoc transfer, the=
=0A=
>>>> framenumber get from the event buffer may be already elasped, in this=
=0A=
>>>> case, we will get all the packets dropped due to miss isoc. And we=0A=
>>>> turn into transfer nothing, to fix this issue, we need to fix the=0A=
>>>> framenumber to make sure that it's not out of date.=0A=
>>>>=0A=
>>>> Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>=0A=
>>>> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>=0A=
>>> There's a patch going upstream already doing this:=0A=
>>>=0A=
>>> https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?h=
=0A=
>>> =3Dnext&id=3Dd53701067f048b8b11635e964b6d3bd9a248c622=0A=
>>>=0A=
>> Sorry, I think I missed to update to the latest version. But I think my =
=0A=
>> patch is more efficient. Because I just sync the frame from the HW, it=
=0A=
>>  won't fail and there is no need to extra tries.=0A=
>>=0A=
>> What do you think about it?=0A=
> the 14 bits you use for your check is not representative of the actual=0A=
> micro-frame you're currently in. Thinh explained that in the discussion=
=0A=
> we had until we came to the patch I pointed you to above. Please look at=
=0A=
> the mailing list archives for details.=0A=
>=0A=
=0A=
There are several issues with this patch.=0A=
1) Your frame elapsed time check is not based on interval but statically=0A=
DWC3_EVENT_PRAM_SOFFN / 2. That's about 1 second. So it doesn't account=0A=
for isoc transfers with large service interval of 1 sec or more.=0A=
2) This function __dwc3_gadget_target_frame_elapsed() should have=0A=
comments for what it does. The name implies that this function checks=0A=
for eframe > cframe, and not eframe > cframe + 1s.=0A=
3) If this check fails, then it will do DWC3_ALIGN_FRAME() at least=0A=
twice. The isoc transfer will start 1 more interval into the future than=0A=
it needs to.=0A=
=0A=
Also, I think the role of this check should be from the controller as it=0A=
has more information and its own logic to decide if the selected future=0A=
uframe has elapsed.=0A=
=0A=
BR,=0A=
Thinh=0A=
