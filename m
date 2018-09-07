Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E433C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E3C20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 02:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DrSLtoaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E3C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeIGGjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:39:24 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:48404 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeIGGjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:39:24 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id E312224E0B5D;
        Thu,  6 Sep 2018 19:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536285660; bh=l3SWH33V5MUb5dNZVm3yBhxOrJQQyCSgZ6zctd/T7Wk=;
        h=From:To:CC:Subject:Date:References:From;
        b=DrSLtoaqkO6a5qilPSM7HUZE/jDMi0eAlY/6kJxhJjcveQESkQpL1cmFuwWobJsV5
         KSEJDMHyNRwSsSKPVlrR78l6+fNdQtrHsjxxVC5HcBgUmxw81b21oP/lZYymZdphGw
         S8lK60OQbl2sz09KIZtleuihb3gAI09ZuH7jOCpERL4L2TJPikxPomfmEqG2aUp0Pe
         WjqJy7RQYuGJz1p20QUK2n52+cyN4gvZZEjLBcznN1g2V6he8QQntO3cm8CeQ2qIHm
         cHKfBqnwFyJ1Tzc7gBnLkmZdHCbCnLHE6p0/iG6JiL0AQSPkKCtm6BAEyUie//Z66H
         pe4TmeihdfNnw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id C6AB350CA;
        Thu,  6 Sep 2018 19:00:59 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Thu, 6 Sep 2018 19:00:59 -0700
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
Date:   Fri, 7 Sep 2018 02:00:58 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544AD412@us01wembx1.internal.synopsys.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AB897@us01wembx1.internal.synopsys.com>
 <BN3PR0201MB0993325C7125DB1A084BF9BBA7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
 <30102591E157244384E984126FC3CB4F544ACFED@us01wembx1.internal.synopsys.com>
 <BN3PR0201MB09932A2E75DAA9A1B06DDB3AA7010@BN3PR0201MB0993.namprd02.prod.outlook.com>
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

Hi Anurag,=0A=
=0A=
On 9/6/2018 8:12 AM, Anurag Kumar Vulisha wrote:=0A=
> Hi Thinh,=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]=0A=
>> Sent: Thursday, September 06, 2018 7:28 AM=0A=
>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Thinh Nguyen=0A=
>> <Thinh.Nguyen@synopsys.com>; balbi@kernel.org; gregkh@linuxfoundation.or=
g=0A=
>> Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-=0A=
>> kernel@vger.kernel.org=0A=
>> Subject: Re: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TR=
B full in=0A=
>> __dwc3_prepare_one_trb()=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> On 9/5/2018 2:19 AM, Anurag Kumar Vulisha wrote:=0A=
>>> Hi Thinh,=0A=
>>>=0A=
>>> Thanks for spending your time in reviewing this code, please find my=0A=
>>> comments inline=0A=
>>>=0A=
>>>> -----Original Message-----=0A=
>>>> From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]=0A=
>>>> Sent: Wednesday, September 05, 2018 11:04 AM=0A=
>>>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; balbi@kernel.org;=0A=
>>>> gregkh@linuxfoundation.org=0A=
>>>> Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-=0A=
>>>> kernel@vger.kernel.org=0A=
>>>> Subject: Re: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking=
=0A=
>>>> TRB full in=0A=
>>>> __dwc3_prepare_one_trb()=0A=
>>>>=0A=
>>>> Hi Anurag,=0A=
>>>>=0A=
>>>>> +	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
>>>>> +=0A=
>>>>>  	if ((!no_interrupt && !chain) ||=0A=
>>>>>  			(dwc3_calc_trbs_left(dep) =3D=3D 0))=0A=
>>>>>  		trb->ctrl |=3D DWC3_TRB_CTRL_IOC;=0A=
>>>>> @@ -1000,8 +1002,6 @@ static void __dwc3_prepare_one_trb(struct=0A=
>>>>> dwc3_ep=0A=
>>>> *dep, struct dwc3_trb *trb,=0A=
>>>>>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capab=
le)=0A=
>>>>>  		trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);=0A=
>>>>>=0A=
>>>>> -	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
>>>>> -=0A=
>>>>>  	trace_dwc3_prepare_trb(dep, trb);=0A=
>>>>>  }=0A=
>>>>>=0A=
>>>> How do you reproduce this issue? We should not set HWO before setting=
=0A=
>>>> other trb->ctrl bits. Can you provide a driver tracepoint? If there's=
=0A=
>>>> an issue with the check if ((!no_interrupt && !chain) ||=0A=
>>>> dwc3_calc_trbs_left =3D=3D 0), then we may need to fix the check there=
.=0A=
>>>>=0A=
>>> This issue gets triggered very rarely on long runs when dep->trb_enqueu=
e =3D=3D dep-=0A=
>>> trb_dequeue.=0A=
>>> In __dwc3_prepare_one_trb() , IOC bit is set when no TRBs are=0A=
>>> available, so that a complete event can be generated and TRBs can be=0A=
>>> cleaned  after complete . Dwc3_calc_trbs_left() is called to determine=
=0A=
>>> the available TRBs, which depends on the previous TRB's HWO bit set=0A=
>>> when=0A=
>>> dep->trb_enqueue =3D=3D dep->trb_dequeue. There are chances where the=
=0A=
>>> dep->dwc3_calc_trbs_left() wrongly=0A=
>>> returns DWC3_TRB_NUM -1 instead of 0 , even though there are no=0A=
>>> available TRBs. Please consider the below example=0A=
>>>=0A=
>>> 1.  Consider a TRB passed to __dwc3_prepare_one_trb() is the last avail=
able TRB in=0A=
>> the pool.=0A=
>>> 2.  __dwc3_prepare_one_trb() calls dwc3_ep_inc_enq() which increments t=
he dep-=0A=
>>> trb_enqueue=0A=
>>>    before preparing the TRB and since the current TRB is the last avail=
able,=0A=
>> incrementing=0A=
>>>   dep->enqueue will make dep->enqueue =3D=3D dep->dequeue 3. IOC bit is=
=0A=
>>> set by __dwc3_prepare_one_trb()  only when dwc3_calc_trbs_left()=0A=
>>> returns 0 (empty TRBs) 4. Since dep->enqueue =3D=3D dep->dequeue and th=
e previous=0A=
>> TRB(the one which we are working)=0A=
>>>     doesn't yet has the HWO bit set, dwc3_calc_trbs_left() returns DWC3=
_TRB_NUM=0A=
>> -1 instead of=0A=
>>>     zero (Though there are no available TRBs) 5. Since=0A=
>>> Dwc3_calc_trbs_left() returns non-zero value, IOC bit is not set in=0A=
>> __dwc3_prepare_one_trb()=0A=
>>>    for the last TRB and no complete event is generated. Because of this=
 no further=0A=
>> TRBs are queued.=0A=
>>> To avoid the above mentioned issue, I moved the code logic for setting =
HWO bit=0A=
>> before setting IOC bit.=0A=
>>> I agree that HWO bit should always be set at the last, but I didn't fin=
d any better=0A=
>> logic for fixing this.=0A=
>>> Please suggest if any better way to handle this situation.=0A=
>>>=0A=
>> I haven't tested it, but you can try this:=0A=
>>=0A=
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index=
=0A=
>> d7a327eaee12..37171d46390b 100644=0A=
>> --- a/drivers/usb/dwc3/gadget.c=0A=
>> +++ b/drivers/usb/dwc3/gadget.c=0A=
>> @@ -924,8 +924,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *d=
ep,=0A=
>> struct dwc3_trb *trb,=0A=
>>        struct usb_gadget       *gadget =3D &dwc->gadget;=0A=
>>        enum usb_device_speed   speed =3D gadget->speed;=0A=
>>=0A=
>> -       dwc3_ep_inc_enq(dep);=0A=
>> -=0A=
>>        trb->size =3D DWC3_TRB_SIZE_LENGTH(length);=0A=
>>        trb->bpl =3D lower_32_bits(dma);=0A=
>>        trb->bph =3D upper_32_bits(dma);=0A=
>> @@ -1004,7 +1002,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep =
*dep,=0A=
>> struct dwc3_trb *trb,=0A=
>>        }=0A=
>>=0A=
>>        if ((!no_interrupt && !chain) ||=0A=
>> -                       (dwc3_calc_trbs_left(dep) =3D=3D 0))=0A=
>> +                       (dwc3_calc_trbs_left(dep) =3D=3D 1))=0A=
>>                trb->ctrl |=3D DWC3_TRB_CTRL_IOC;=0A=
>>=0A=
>>        if (chain)=0A=
>> @@ -1013,6 +1011,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep =
*dep,=0A=
>> struct dwc3_trb *trb,=0A=
>>        if (usb_endpoint_xfer_bulk(dep->endpoint.desc) &&=0A=
>> dep->stream_capable)=0A=
>>                trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);=0A=
>>=0A=
>> +       dwc3_ep_inc_enq(dep);=0A=
>> +=0A=
>>        trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
>>=0A=
>>        trace_dwc3_prepare_trb(dep, trb);=0A=
>>=0A=
> Thanks for pointing out a solution , the fix looks good. I will test with=
 this fix and resend the patches=0A=
>=0A=
> Best Regards,=0A=
> Anurag Kumar Vulisha=0A=
>=0A=
>=0A=
=0A=
The rest of the patch series looks fine to me.=0A=
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
=0A=
BR,=0A=
Thinh=0A=
