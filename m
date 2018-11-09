Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5ACC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7AD20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kyOZHZ8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7AD20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeKISXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:23:02 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:33536 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeKISXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:23:02 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 55C1010C13A9;
        Fri,  9 Nov 2018 00:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541753009; bh=HzAGJthD6OOUrbxW5RfuiLsEv3mNoxl3BsPoBs8F/M4=;
        h=From:To:CC:Subject:Date:References:From;
        b=kyOZHZ8sn3MbGzA0964Mn7AUi/WTlMlgUciTRwEgtEkZR6h7ALqdpAg9+nfbEBUmo
         Q3Efqws2HIm19wv6Teol/HafEKoU40x6KwEQxN5UGx0JStkOwNbmjyeoClXVqNgyMU
         u96LJVDkgi/Fj7a2wZh32gKkOUTox2bGMpNjb4xywxzqnzJSnOh1lILe9g7zbQNzO1
         YxQzltax8nz2rBsmLzfY8Fo2aBvofor53t/F19kTLmzL/j+PfpLn1QrAexHvwULMAC
         9zj0HuMzzZuWlrs/7wP3Q39tR9fvplwQwMubGIBACzOlhQ7RScFg5DKyKJeeAhXoDh
         Rww91gnnlF9bw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 003465BC6;
        Fri,  9 Nov 2018 00:43:28 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 9 Nov 2018 00:43:28 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 9 Nov 2018 12:43:25 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arthur.petrosyan@synopsys.com" <arthur.petrosyan@synopsys.com>
Subject: Re: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Thread-Topic: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Thread-Index: AQHUatZW7CBOg1jSlEOevZqXY6bG3Q==
Date:   Fri, 9 Nov 2018 08:43:24 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7A0F2B@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
 <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
 <20181108173654.118f9e3e@donbot>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.150]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
On 11/8/2018 9:37 PM, John Keeping wrote:=0A=
> Hi Minas,=0A=
> =0A=
> On Mon, 5 Nov 2018 08:28:07 +0000=0A=
> Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:=0A=
> =0A=
>> On 10/23/2018 5:43 PM, John Keeping wrote:=0A=
>>> By clearing the overrun flag as soon as the target frame is next=0A=
>>> incremented, we can end up incrementing the target frame more than=0A=
>>> expected in dwc2_gadget_handle_ep_disabled() when the endpoint's=0A=
>>> interval is greater than 1.  This happens if the target frame has=0A=
>>> just wrapped at the point when the endpoint is disabled and the=0A=
>>> frame number has not yet done so.=0A=
>>>=0A=
>>> Instead, wait until the frame number also wraps and then clear the=0A=
>>> overrun flag.=0A=
>>>=0A=
>>> Signed-off-by: John Keeping <john@metanate.com>=0A=
>>> ---=0A=
>>>    drivers/usb/dwc2/gadget.c | 2 +-=0A=
>>>    1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
>>> index 2d6d2c8244de..8da2c052dfa1 100644=0A=
>>> --- a/drivers/usb/dwc2/gadget.c=0A=
>>> +++ b/drivers/usb/dwc2/gadget.c=0A=
>>> @@ -117,7 +117,7 @@ static inline void=0A=
>>> dwc2_gadget_incr_frame_num(struct dwc2_hsotg_ep *hs_ep) if=0A=
>>> (hs_ep->target_frame > DSTS_SOFFN_LIMIT) { hs_ep->frame_overrun =3D=0A=
>>> true; hs_ep->target_frame &=3D DSTS_SOFFN_LIMIT;=0A=
>>> -	} else {=0A=
>>> +	} else if (hs_ep->parent->frame_number <=0A=
>>> hs_ep->target_frame) { hs_ep->frame_overrun =3D false;=0A=
>>>    	}=0A=
>>>    }=0A=
>>>    =0A=
>> Did you tested mentioned by you scenario? If you see issue can you=0A=
>> provide debug log and point the issue line in the log.=0A=
> =0A=
> It only reproduces very occasionally so it's difficult to capture a full=
=0A=
> debug log containing the error.=0A=
> =0A=
> I applied this patch to capture logging specifically around this=0A=
> scenario:=0A=
> =0A=
> -- >8 --=0A=
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
> index 220c0f9b89b0..3770b9d3b523 100644=0A=
> --- a/drivers/usb/dwc2/gadget.c=0A=
> +++ b/drivers/usb/dwc2/gadget.c=0A=
> @@ -2722,13 +2722,20 @@ static void dwc2_gadget_handle_ep_disabled(struct=
 dwc2_hsotg_ep *hs_ep)=0A=
>          }=0A=
>   =0A=
>          do {=0A=
> +               unsigned int target_frame =3D hs_ep->target_frame;=0A=
> +               bool frame_overrun =3D hs_ep->frame_overrun;=0A=
> +=0A=
>                  hs_req =3D get_ep_head(hs_ep);=0A=
>                  if (hs_req)=0A=
>                          dwc2_hsotg_complete_request(hsotg, hs_ep, hs_req=
,=0A=
>                                                      -ENODATA);=0A=
> +=0A=
>                  dwc2_gadget_incr_frame_num(hs_ep);=0A=
>                  /* Update current frame number value. */=0A=
>                  hsotg->frame_number =3D dwc2_hsotg_read_frameno(hsotg);=
=0A=
> +=0A=
> +               dev_warn(hsotg->dev, "%s: expiring request frame_number=
=3D0x%04x target_frame=3D0x%04x overrun=3D%u\n",=0A=
> +                        __func__, hsotg->frame_number, target_frame, fra=
me_overrun);=0A=
>          } while (dwc2_gadget_target_frame_elapsed(hs_ep));=0A=
>   =0A=
>          dwc2_gadget_start_next_request(hs_ep);=0A=
> -- 8< --=0A=
> =0A=
> and I captured this log (the first entry is a separate error and then=0A=
> the remaining ones show this bug being triggered):=0A=
> =0A=
> [  562.571227] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3eb9 target_frame=3D0x3ec0=0A=
> [  562.611213] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff8 target_frame=3D0x0008=0A=
> [  562.611219] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff8 target_frame=3D0x0010=0A=
> [  562.611223] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0018=0A=
> [  562.611228] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0020=0A=
> [  562.611232] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0028=0A=
> [  562.611236] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0030=0A=
> [  562.611240] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0038=0A=
> [  562.611244] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0040=0A=
> [  562.611249] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0048=0A=
> [  562.611253] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0050=0A=
> [  562.611257] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0058=0A=
> [  562.611261] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0060=0A=
> [  562.611265] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0068=0A=
> [  562.611269] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0070=0A=
> [  562.611274] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0078=0A=
> [  562.611278] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0080=0A=
> [  562.611282] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0088=0A=
> [  562.611286] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0090=0A=
> [  562.611290] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x0098=0A=
> [  562.611294] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request frame_number=3D0x3ff9 target_frame=3D0x00a0=0A=
> =0A=
According above patch in debug log should be printed overrun flag also. =0A=
Could you please resend log with this flag.=0A=
=0A=
> =0A=
> This was on v4.19 with an additional patch to disable descriptor DMA=0A=
> because that seems to be causing problems on RK3288 although I haven't=0A=
> figured out exactly why it's a problem.=0A=
=0A=
In which mode you run tests Slave or Buffer DMA?=0A=
> =0A=
> =0A=
> Regards,=0A=
> John=0A=
> =0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
