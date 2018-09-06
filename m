Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079F1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5DC205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gf/SxRa6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5DC205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeIFGbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:31:14 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:51880 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbeIFGbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:31:14 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 17A9224E056C;
        Wed,  5 Sep 2018 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536199098; bh=9fUWKDhpJ6gISc3NIX8jQB7HXksPb+Z/n0rSycfl8vw=;
        h=From:To:CC:Subject:Date:References:From;
        b=gf/SxRa6xSHXZ2JUVpf7JIutppJEvpzz/VQ/IRoPVJpgoTBdB0cEB5lP6Sk53atfF
         fB7r4LP+pUkE3IXQa49tMQXFEnadOi5LkpLkwnaxxddevXMbpy6Vr2Wcw8hD7+s2fK
         moThrFDKjDsD9zUSjjjAfhujetaToydDfmmwsUYE5YhPnBKClD5aPCa58rtxTeODKQ
         uLG5SpneuQ4Z1kfRP9AKx08JNdTE6UiSE3c42MlsHstiivDb0W1fGi1FdVywCl5f7f
         sJPaWqJC4PPtbYZ0PHkdQsj458S8JyTWQdp4JzWSE2FRxUf3VDPSf3KudKIoM9KGfX
         jMPJhFUEsH5vw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id EAACC3D1E;
        Wed,  5 Sep 2018 18:58:17 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Wed, 5 Sep 2018 18:58:17 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB
 full in __dwc3_prepare_one_trb()
Thread-Topic: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB
 full in __dwc3_prepare_one_trb()
Thread-Index: AQHUNiVe6PVhPxbQeEm3tnXrG8X9Mg==
Date:   Thu, 6 Sep 2018 01:58:16 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544ACFED@us01wembx1.internal.synopsys.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AB897@us01wembx1.internal.synopsys.com>
 <BN3PR0201MB0993325C7125DB1A084BF9BBA7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
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

Hi,=0A=
=0A=
On 9/5/2018 2:19 AM, Anurag Kumar Vulisha wrote:=0A=
> Hi Thinh,=0A=
>=0A=
> Thanks for spending your time in reviewing this code, please find my comm=
ents inline=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]=0A=
>> Sent: Wednesday, September 05, 2018 11:04 AM=0A=
>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; balbi@kernel.org;=0A=
>> gregkh@linuxfoundation.org=0A=
>> Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-=0A=
>> kernel@vger.kernel.org=0A=
>> Subject: Re: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TR=
B full in=0A=
>> __dwc3_prepare_one_trb()=0A=
>>=0A=
>> Hi Anurag,=0A=
>>=0A=
>> On 8/17/2018 5:25 AM, Anurag Kumar Vulisha wrote:=0A=
>>> Availability of TRB's are calculated using dwc3_calc_trbs_left(), which=
=0A=
>>> determines available TRB's based on the HWO bit set in a TRB.=0A=
>>>=0A=
>>> __dwc3_prepare_one_trb() is called with a TRB which needs to be prepare=
d=0A=
>>> for transfer. This __dwc3_prepare_one_trb() calls dwc3_calc_trbs_left()=
=0A=
>>> to determine total available TRBs and set IOC bit if the total availabl=
e=0A=
>>> TRBs are zero. Since the present working TRB(which is passed as an=0A=
>>> argument to __dwc3_prepare_one_trb() )  doesn't have HWO bit already se=
t,=0A=
>>> there are chances where dwc3_calc_trbs_left() wrongly calculates this=
=0A=
>>> present working TRB as free(since the HWO bit is not yet set). This cou=
ld=0A=
>>> be a problem. This patch correct this issue by setting HWO bit before=
=0A=
>>> calling dwc3_calc_trbs_left()=0A=
>>>=0A=
>>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=
=0A=
>>> ---=0A=
>>>  Changes in v2:=0A=
>>> 	1. Changed the commit message=0A=
>>> ---=0A=
>>>  drivers/usb/dwc3/gadget.c | 4 ++--=0A=
>>>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
>>> index 69bf137..f73d219 100644=0A=
>>> --- a/drivers/usb/dwc3/gadget.c=0A=
>>> +++ b/drivers/usb/dwc3/gadget.c=0A=
>>> @@ -990,6 +990,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *=
dep,=0A=
>> struct dwc3_trb *trb,=0A=
>>>  			trb->ctrl |=3D DWC3_TRB_CTRL_ISP_IMI;=0A=
>>>  	}=0A=
>>>=0A=
>>> +	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
>>> +=0A=
>>>  	if ((!no_interrupt && !chain) ||=0A=
>>>  			(dwc3_calc_trbs_left(dep) =3D=3D 0))=0A=
>>>  		trb->ctrl |=3D DWC3_TRB_CTRL_IOC;=0A=
>>> @@ -1000,8 +1002,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep=
=0A=
>> *dep, struct dwc3_trb *trb,=0A=
>>>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable=
)=0A=
>>>  		trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);=0A=
>>>=0A=
>>> -	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
>>> -=0A=
>>>  	trace_dwc3_prepare_trb(dep, trb);=0A=
>>>  }=0A=
>>>=0A=
>> How do you reproduce this issue? We should not set HWO before setting=0A=
>> other trb->ctrl bits. Can you provide a driver tracepoint? If there's an=
=0A=
>> issue with the check if ((!no_interrupt && !chain) ||=0A=
>> dwc3_calc_trbs_left =3D=3D 0), then we may need to fix the check there.=
=0A=
>>=0A=
> This issue gets triggered very rarely on long runs when dep->trb_enqueue =
=3D=3D dep->trb_dequeue.=0A=
> In __dwc3_prepare_one_trb() , IOC bit is set when no TRBs are available, =
so that a complete=0A=
> event can be generated and TRBs can be cleaned  after complete . Dwc3_cal=
c_trbs_left() is called =0A=
> to determine the available TRBs, which depends on the previous TRB's HWO =
bit set when =0A=
> dep->trb_enqueue =3D=3D dep->trb_dequeue. There are chances where the dwc=
3_calc_trbs_left() wrongly=0A=
> returns DWC3_TRB_NUM -1 instead of 0 , even though there are no available=
 TRBs. Please=0A=
> consider the below example=0A=
>=0A=
> 1.  Consider a TRB passed to __dwc3_prepare_one_trb() is the last availab=
le TRB in the pool. =0A=
> 2.  __dwc3_prepare_one_trb() calls dwc3_ep_inc_enq() which increments the=
 dep->trb_enqueue=0A=
>    before preparing the TRB and since the current TRB is the last availab=
le, incrementing=0A=
>   dep->enqueue will make dep->enqueue =3D=3D dep->dequeue =0A=
> 3. IOC bit is set by __dwc3_prepare_one_trb()  only when dwc3_calc_trbs_l=
eft()  returns 0 (empty TRBs)=0A=
> 4. Since dep->enqueue =3D=3D dep->dequeue and the previous TRB(the one wh=
ich we are working)=0A=
>     doesn't yet has the HWO bit set, dwc3_calc_trbs_left() returns DWC3_T=
RB_NUM -1 instead of=0A=
>     zero (Though there are no available TRBs)=0A=
> 5. Since  Dwc3_calc_trbs_left() returns non-zero value, IOC bit is not se=
t in __dwc3_prepare_one_trb()=0A=
>    for the last TRB and no complete event is generated. Because of this n=
o further TRBs are queued.=0A=
>=0A=
> To avoid the above mentioned issue, I moved the code logic for setting HW=
O bit before setting IOC bit.=0A=
> I agree that HWO bit should always be set at the last, but I didn't find =
any better logic for fixing this.=0A=
> Please suggest if any better way to handle this situation.   =0A=
>=0A=
=0A=
I haven't tested it, but you can try this:=0A=
=0A=
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
index d7a327eaee12..37171d46390b 100644=0A=
--- a/drivers/usb/dwc3/gadget.c=0A=
+++ b/drivers/usb/dwc3/gadget.c=0A=
@@ -924,8 +924,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep=0A=
*dep, struct dwc3_trb *trb,=0A=
        struct usb_gadget       *gadget =3D &dwc->gadget;=0A=
        enum usb_device_speed   speed =3D gadget->speed;=0A=
 =0A=
-       dwc3_ep_inc_enq(dep);=0A=
-=0A=
        trb->size =3D DWC3_TRB_SIZE_LENGTH(length);=0A=
        trb->bpl =3D lower_32_bits(dma);=0A=
        trb->bph =3D upper_32_bits(dma);=0A=
@@ -1004,7 +1002,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep=0A=
*dep, struct dwc3_trb *trb,=0A=
        }=0A=
 =0A=
        if ((!no_interrupt && !chain) ||=0A=
-                       (dwc3_calc_trbs_left(dep) =3D=3D 0))=0A=
+                       (dwc3_calc_trbs_left(dep) =3D=3D 1))=0A=
                trb->ctrl |=3D DWC3_TRB_CTRL_IOC;=0A=
 =0A=
        if (chain)=0A=
@@ -1013,6 +1011,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep=0A=
*dep, struct dwc3_trb *trb,=0A=
        if (usb_endpoint_xfer_bulk(dep->endpoint.desc) &&=0A=
dep->stream_capable)=0A=
                trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);=0A=
 =0A=
+       dwc3_ep_inc_enq(dep);=0A=
+=0A=
        trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
 =0A=
        trace_dwc3_prepare_trb(dep, trb);=0A=
=0A=
BR,=0A=
Thinh=0A=
