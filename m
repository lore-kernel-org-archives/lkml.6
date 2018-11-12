Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60FBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5136922360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N4DVPr6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5136922360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeKLSpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:45:54 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:58998 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKLSpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:45:53 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C765710C1102;
        Mon, 12 Nov 2018 00:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542012820; bh=QA5q6GpD+nqz0fxDWQerMoerwRAOLN+SDHbzHlcRGa4=;
        h=From:To:CC:Subject:Date:References:From;
        b=N4DVPr6ZhrI7r9y/PVFjox9Drw4VjCQph9o652QavHxIb9dxfOyyOZgFVSAo6N5VB
         0RTA01NKo8DrCelOVDMTmIbinGyt+IUqEEmyd+n85nTfNvTnaYWst5B2Xc+RGYdxUA
         xtoR0jqomU3ca2X6TlXCWGsQ4ZC82563OiOikzhbM0Ubsb+V3bNBdmzhw/EKG/keXY
         gl+LlrI/90nxl+APS4KiqVyHfzPTV6kZ6DgsvNWKUuKWvSeypvmQkZ+D4JUW3W/cvy
         KP3igjUCbNqc9Zvo9Tm9kZanEPsCpSeIQBPQ0qi/jXooIL4Eg6pYQ6TTW2TANLnnjq
         2F2JwoMv2r/fA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6B3643A89;
        Mon, 12 Nov 2018 00:53:40 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 12 Nov 2018 00:53:39 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 12 Nov 2018 12:53:37 +0400
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
Date:   Mon, 12 Nov 2018 08:53:36 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7A27D7@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
 <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
 <20181108173654.118f9e3e@donbot>
 <410670D7E743164D87FA6160E7907A56013A7A0F2B@am04wembxa.internal.synopsys.com>
 <410670D7E743164D87FA6160E7907A56013A7A12C1@am04wembxa.internal.synopsys.com>
 <20181109184246.33cb4487@donbot>
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
On 11/9/2018 10:43 PM, John Keeping wrote:=0A=
> Hi Minas,=0A=
> =0A=
> On Fri, 9 Nov 2018 14:36:36 +0000=0A=
> Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:=0A=
> =0A=
>> On 11/9/2018 12:43 PM, Minas Harutyunyan wrote:=0A=
>>> Hi John,=0A=
>>>=0A=
>>> On 11/8/2018 9:37 PM, John Keeping wrote:=0A=
>>>> Hi Minas,=0A=
>>>>=0A=
>>>> On Mon, 5 Nov 2018 08:28:07 +0000=0A=
>>>> Minas Harutyunyan <minas.harutyunyan@synopsys.com> wrote:=0A=
>>>>=0A=
>>>>> On 10/23/2018 5:43 PM, John Keeping wrote:=0A=
>>>>>> By clearing the overrun flag as soon as the target frame is next=0A=
>>>>>> incremented, we can end up incrementing the target frame more=0A=
>>>>>> than expected in dwc2_gadget_handle_ep_disabled() when the=0A=
>>>>>> endpoint's interval is greater than 1.  This happens if the=0A=
>>>>>> target frame has just wrapped at the point when the endpoint is=0A=
>>>>>> disabled and the frame number has not yet done so.=0A=
>>>>>>=0A=
>>>>>> Instead, wait until the frame number also wraps and then clear=0A=
>>>>>> the overrun flag.=0A=
>>>>>>=0A=
>>>>>> Signed-off-by: John Keeping <john@metanate.com>=0A=
>>>>>> ---=0A=
>>>>>>      drivers/usb/dwc2/gadget.c | 2 +-=0A=
>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>>>>>=0A=
>>>>>> diff --git a/drivers/usb/dwc2/gadget.c=0A=
>>>>>> b/drivers/usb/dwc2/gadget.c index 2d6d2c8244de..8da2c052dfa1=0A=
>>>>>> 100644 --- a/drivers/usb/dwc2/gadget.c=0A=
>>>>>> +++ b/drivers/usb/dwc2/gadget.c=0A=
>>>>>> @@ -117,7 +117,7 @@ static inline void=0A=
>>>>>> dwc2_gadget_incr_frame_num(struct dwc2_hsotg_ep *hs_ep) if=0A=
>>>>>> (hs_ep->target_frame > DSTS_SOFFN_LIMIT) { hs_ep->frame_overrun =3D=
=0A=
>>>>>> true; hs_ep->target_frame &=3D DSTS_SOFFN_LIMIT;=0A=
>>>>>> -	} else {=0A=
>>>>>> +	} else if (hs_ep->parent->frame_number <=0A=
>>>>>> hs_ep->target_frame) { hs_ep->frame_overrun =3D false;=0A=
>>>>>>      	}=0A=
>>>>>>      }=0A=
>>>>>>      =0A=
>>>>> Did you tested mentioned by you scenario? If you see issue can you=0A=
>>>>> provide debug log and point the issue line in the log.=0A=
>>>>=0A=
>>>> It only reproduces very occasionally so it's difficult to capture=0A=
>>>> a full debug log containing the error.=0A=
>>>>=0A=
>>>> I applied this patch to capture logging specifically around this=0A=
>>>> scenario:=0A=
>>>>=0A=
>>>> -- >8 --=0A=
>>>> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
>>>> index 220c0f9b89b0..3770b9d3b523 100644=0A=
>>>> --- a/drivers/usb/dwc2/gadget.c=0A=
>>>> +++ b/drivers/usb/dwc2/gadget.c=0A=
>>>> @@ -2722,13 +2722,20 @@ static void=0A=
>>>> dwc2_gadget_handle_ep_disabled(struct dwc2_hsotg_ep *hs_ep) }=0A=
>>>>     =0A=
>>>>            do {=0A=
>>>> +               unsigned int target_frame =3D hs_ep->target_frame;=0A=
>>>> +               bool frame_overrun =3D hs_ep->frame_overrun;=0A=
>>>> +=0A=
>>>>                    hs_req =3D get_ep_head(hs_ep);=0A=
>>>>                    if (hs_req)=0A=
>>>>                            dwc2_hsotg_complete_request(hsotg,=0A=
>>>> hs_ep, hs_req, -ENODATA);=0A=
>>>> +=0A=
>>>>                    dwc2_gadget_incr_frame_num(hs_ep);=0A=
>>>>                    /* Update current frame number value. */=0A=
>>>>                    hsotg->frame_number =3D=0A=
>>>> dwc2_hsotg_read_frameno(hsotg); +=0A=
>>>> +               dev_warn(hsotg->dev, "%s: expiring request=0A=
>>>> frame_number=3D0x%04x target_frame=3D0x%04x overrun=3D%u\n",=0A=
>>>> +                        __func__, hsotg->frame_number,=0A=
>>>> target_frame, frame_overrun); } while=0A=
>>>> (dwc2_gadget_target_frame_elapsed(hs_ep));=0A=
>>>>            dwc2_gadget_start_next_request(hs_ep);=0A=
>>>> -- 8< --=0A=
>>>>=0A=
>>> According above patch in debug log should be printed overrun flag=0A=
>>> also. Could you please resend log with this flag.=0A=
> =0A=
> D'oh!  I included a log from an earlier version before I added the=0A=
> overrun flag.=0A=
> =0A=
>> One more request. Please add EP number to debug print.=0A=
> =0A=
> Here's an updated log:=0A=
> =0A=
> -- >8 --=0A=
> [  264.926385] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x2161 target_frame=3D0x2168 overrun=3D0=0A=
> [  265.905413] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0008 overrun=3D0=0A=
> [  265.905421] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0010 overrun=3D0=0A=
> [  265.905427] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0018 overrun=3D0=0A=
> [  265.905432] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0020 overrun=3D0=0A=
> [  265.905438] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0028 overrun=3D0=0A=
> [  265.905443] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0030 overrun=3D0=0A=
> [  265.905448] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0038 overrun=3D0=0A=
> [  265.905454] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0040 overrun=3D0=0A=
> [  265.905459] dwc2 ff580000.usb: dwc2_gadget_handle_ep_disabled: expirin=
g request ep=3D2 frame_number=3D0x3ff9 target_frame=3D0x0048 overrun=3D0=0A=
> -- 8< --=0A=
> =0A=
> Once again there is an initial failure before it enters the failure mode=
=0A=
> my patch is trying to address.  This seems to be consistent, so it may=0A=
> be important, but there is ~80ms before the failure starts.=0A=
> =0A=
>>>> This was on v4.19 with an additional patch to disable descriptor=0A=
>>>> DMA because that seems to be causing problems on RK3288 although I=0A=
>>>> haven't figured out exactly why it's a problem.=0A=
>>>=0A=
>>> In which mode you run tests Slave or Buffer DMA?=0A=
> =0A=
> Buffer DMA but with descriptor DMA forced off (g_dma=3D1, g_dma_desc=3D0)=
.=0A=
> =0A=
> For the record, my test case is the standard UAC2 gadget with:=0A=
> =0A=
> 	c_srate =3D p_srate =3D 44100=0A=
> 	c_ssize =3D p_ssize =3D 4=0A=
> 	c_chmask =3D 0xf=0A=
> 	p_chmask =3D 3=0A=
> =0A=
> and it seems that the failure only triggers when using arecord to=0A=
> capture from the gadget interface (this is with a host program both=0A=
> streaming in both directions over the USB connection); I suspect that=0A=
> actually it just makes it more likely because there is more work done in=
=0A=
> the completion handler, but I haven't seen the failure without arecord=0A=
> running.=0A=
> =0A=
> =0A=
> Regards,=0A=
> John=0A=
> =0A=
I think cause of issue not in dwc2_gadget_target_frame_elapsed() =0A=
function, but in do-while loop in dwc2_gadget_handle_ep_disabled().=0A=
Could you please try below patch:=0A=
=0A=
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
index 8eb25e3597b0..4ad869853bfa 100644=0A=
--- a/drivers/usb/dwc2/gadget.c=0A=
+++ b/drivers/usb/dwc2/gadget.c=0A=
@@ -2762,8 +2762,11 @@ static void dwc2_gadget_handle_ep_disabled(struct =
=0A=
dwc2_hsotg_ep *hs_ep)=0A=
=0A=
         do {=0A=
                 hs_req =3D get_ep_head(hs_ep);=0A=
-               if (hs_req)=0A=
-                       dwc2_hsotg_complete_request(hsotg, hs_ep, hs_req,=
=0A=
+               if (!hs_req) {=0A=
+                       dev_warn(hsotg->dev, "%s: ISOC EP queue =0A=
empty\n", __func__);=0A=
+                       return;=0A=
+               }=0A=
+               dwc2_hsotg_complete_request(hsotg, hs_ep, hs_req,=0A=
                                                     -ENODATA);=0A=
                 dwc2_gadget_incr_frame_num(hs_ep);=0A=
                 /* Update current frame number value. */=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
