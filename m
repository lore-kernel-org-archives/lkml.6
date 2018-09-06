Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1C0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2545020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sxHqDpRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2545020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbeIFTtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:49:39 -0400
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:51168
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729991AbeIFTti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6yqyI5liOor91CpCZoerlcPR9chewZGUevzk9167yA=;
 b=sxHqDpRlVE8moovB7ykNmVRSN4HrjRRaWdsmxtPSE2F/2eJI3tT4w1BySw7kUxlHqJ0DkTfMvc6KjnbjloAUkY83XTGcMp0M0F1q9Bkfvf/EQD1XpvAaaq0BfwYIjS2NzAY0w0nq15UC+PHEGVjVgLiS4hJYkmyrb2KmqY4KU+k=
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com (10.161.207.14) by
 BN3PR0201MB1011.namprd02.prod.outlook.com (10.161.207.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Thu, 6 Sep 2018 15:12:39 +0000
Received: from BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e]) by BN3PR0201MB0993.namprd02.prod.outlook.com
 ([fe80::29f7:170b:ce40:9b2e%7]) with mapi id 15.20.1101.016; Thu, 6 Sep 2018
 15:12:39 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB full
 in __dwc3_prepare_one_trb()
Thread-Topic: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB
 full in __dwc3_prepare_one_trb()
Thread-Index: AQHUNiVThZEOCvrQMkaSQCCLSEec7aTjevBw
Date:   Thu, 6 Sep 2018 15:12:39 +0000
Message-ID: <BN3PR0201MB09932A2E75DAA9A1B06DDB3AA7010@BN3PR0201MB0993.namprd02.prod.outlook.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <30102591E157244384E984126FC3CB4F544AB897@us01wembx1.internal.synopsys.com>
 <BN3PR0201MB0993325C7125DB1A084BF9BBA7020@BN3PR0201MB0993.namprd02.prod.outlook.com>
 <30102591E157244384E984126FC3CB4F544ACFED@us01wembx1.internal.synopsys.com>
In-Reply-To: <30102591E157244384E984126FC3CB4F544ACFED@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0201MB1011;6:8M4rc0PSRiHNFf+y2NdJx30AHt5XrI+EU9iDjLOGe5m7q/TPU3hAyPSZd+ceQGMk/Y/RDVEmhsXEVbkD9sdGGywgZzoj5UGVMDnjRPISaKS83/X7sOJ5HI04z8jkpHpskpAKnTPRtOZYPUcDBJ2scaZizLi9LgxNwAl2ApuUjfCEGXCNvVa8PKfPqpIFa9c7eMRrZ1rC/e47thoBQnmzgz1FLDBrrIcR8XdApokOWUw/gk86soG6JYLarvPH3yDtmETDj8GyAmtRIzqqJEWL1+NuTERGkTebOoDuumSXELq0XybhnClbxT7w6N0uC6o+kqCbug4AH8sIcpGSbqXxbZ/3b6OnQ8HsBVg0Bx0czz5+tXRImR36YAP69JBQp9HjCbHwGdK56Y3r8vDvB7syqJFmcKLRQebjHNhXAopbB/AkQHd1NnCURIePxgPcCIxPUHONonf1oB0nN8IsFFJSNQ==;5:3WdHGAr3SG129Vorq0D+TpIkJS/8OFCu4u65VrqS03cYQZJJSjYm9G7ZnCKcJeHR1mrtX+kA75FOHvJgsrTLz3vUF5kbkyfri1nEbO7PC5d67MhoSzd97jODqXj2jVP9LVI8vHAAi95t+cphavFSA+sdaRywwbQAi+jblnpiwi8=;7:au3q0MIqBN9qy/u+37qZHYgw2cYflSz6NAS8iU3LiFDngQoAcXrK6kVOr7DR/dGA8fNBukofL1HyM2G8buwvRQImcgnPLClOdOFcAG0neaw/r1ryYkEXgB29kN11+93NuDml9Roh9ahw00Qep7vpLA/0rcNYmN2jdMgLibGrm3Krhb3wu3psHxBTffKlMbvD//oYOcj4VZT1rFJV3vUbacwlM2T8Xg0tZ46e1EZTWWBx6Fd1ivnITIR7DYlynrlf
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 697bfe7c-67b0-458f-fdeb-08d6140b2f8e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0201MB1011;
x-ms-traffictypediagnostic: BN3PR0201MB1011:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BN3PR0201MB1011087CD39D694F0D1B30B4A7010@BN3PR0201MB1011.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN3PR0201MB1011;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0201MB1011;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(376002)(346002)(136003)(189003)(13464003)(199004)(93886005)(316002)(229853002)(5250100002)(256004)(2900100001)(105586002)(2501003)(53936002)(9686003)(6436002)(55016002)(486006)(446003)(76176011)(6506007)(53546011)(7696005)(26005)(476003)(15760500003)(106356001)(5660300001)(102836004)(11346002)(186003)(99286004)(33656002)(3846002)(81156014)(8676002)(2906002)(68736007)(39060400002)(54906003)(110136005)(86362001)(305945005)(7736002)(6116002)(66066001)(81166006)(8936002)(2201001)(478600001)(97736004)(14454004)(6246003)(4326008)(74316002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0201MB1011;H:BN3PR0201MB0993.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: No5S7J/EiHd9q2iRyb8tLGr/z2HDWaILNYOE0ijEwaWjLuN0OOuROwtAAcb+ysbBnJF9vOHLnK+gg97Pzh4n1VR03CxkYZRozJOvRJ7BHsnobCW+OqX2W+6TdBRNART6KE4SKVauDJ0Sz2Cbvc20+eNMkC0Vpgyo5x0GP3N5CSZszfdF1O6QSWu30F/TPk+CA68ak6ITlU5qdBsD93wPLNsaKDnrvUsxynsvy5CBlAIfJdmUs4849F2jxwx74RUY0kf7NDLliFc7u6p2AtnXI+naUYSxUSNQy+iPUlkynQAnoaDbZj5rsbKh7F6jeuq+EK2VmaGZxw0O3fhhmyCOt6QxW0NWXeGCBfDQtzf/Vrg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697bfe7c-67b0-458f-fdeb-08d6140b2f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 15:12:39.3108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0201MB1011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

>-----Original Message-----
>From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>Sent: Thursday, September 06, 2018 7:28 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; Thinh Nguyen
><Thinh.Nguyen@synopsys.com>; balbi@kernel.org; gregkh@linuxfoundation.org
>Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking TRB =
full in
>__dwc3_prepare_one_trb()
>
>Hi,
>
>On 9/5/2018 2:19 AM, Anurag Kumar Vulisha wrote:
>> Hi Thinh,
>>
>> Thanks for spending your time in reviewing this code, please find my
>> comments inline
>>
>>> -----Original Message-----
>>> From: Thinh Nguyen [mailto:Thinh.Nguyen@synopsys.com]
>>> Sent: Wednesday, September 05, 2018 11:04 AM
>>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; balbi@kernel.org;
>>> gregkh@linuxfoundation.org
>>> Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-
>>> kernel@vger.kernel.org
>>> Subject: Re: [PATCH v2 1/8] usb: dwc3: Correct the logic for checking
>>> TRB full in
>>> __dwc3_prepare_one_trb()
>>>
>>> Hi Anurag,
>>>
>>>> +	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;
>>>> +
>>>>  	if ((!no_interrupt && !chain) ||
>>>>  			(dwc3_calc_trbs_left(dep) =3D=3D 0))
>>>>  		trb->ctrl |=3D DWC3_TRB_CTRL_IOC;
>>>> @@ -1000,8 +1002,6 @@ static void __dwc3_prepare_one_trb(struct
>>>> dwc3_ep
>>> *dep, struct dwc3_trb *trb,
>>>>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capabl=
e)
>>>>  		trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);
>>>>
>>>> -	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;
>>>> -
>>>>  	trace_dwc3_prepare_trb(dep, trb);
>>>>  }
>>>>
>>> How do you reproduce this issue? We should not set HWO before setting
>>> other trb->ctrl bits. Can you provide a driver tracepoint? If there's
>>> an issue with the check if ((!no_interrupt && !chain) ||
>>> dwc3_calc_trbs_left =3D=3D 0), then we may need to fix the check there.
>>>
>> This issue gets triggered very rarely on long runs when dep->trb_enqueue=
 =3D=3D dep-
>>trb_dequeue.
>> In __dwc3_prepare_one_trb() , IOC bit is set when no TRBs are
>> available, so that a complete event can be generated and TRBs can be
>> cleaned  after complete . Dwc3_calc_trbs_left() is called to determine
>> the available TRBs, which depends on the previous TRB's HWO bit set
>> when
>> dep->trb_enqueue =3D=3D dep->trb_dequeue. There are chances where the
>> dep->dwc3_calc_trbs_left() wrongly
>> returns DWC3_TRB_NUM -1 instead of 0 , even though there are no
>> available TRBs. Please consider the below example
>>
>> 1.  Consider a TRB passed to __dwc3_prepare_one_trb() is the last availa=
ble TRB in
>the pool.
>> 2.  __dwc3_prepare_one_trb() calls dwc3_ep_inc_enq() which increments th=
e dep-
>>trb_enqueue
>>    before preparing the TRB and since the current TRB is the last availa=
ble,
>incrementing
>>   dep->enqueue will make dep->enqueue =3D=3D dep->dequeue 3. IOC bit is
>> set by __dwc3_prepare_one_trb()  only when dwc3_calc_trbs_left()
>> returns 0 (empty TRBs) 4. Since dep->enqueue =3D=3D dep->dequeue and the=
 previous
>TRB(the one which we are working)
>>     doesn't yet has the HWO bit set, dwc3_calc_trbs_left() returns DWC3_=
TRB_NUM
>-1 instead of
>>     zero (Though there are no available TRBs) 5. Since
>> Dwc3_calc_trbs_left() returns non-zero value, IOC bit is not set in
>__dwc3_prepare_one_trb()
>>    for the last TRB and no complete event is generated. Because of this =
no further
>TRBs are queued.
>>
>> To avoid the above mentioned issue, I moved the code logic for setting H=
WO bit
>before setting IOC bit.
>> I agree that HWO bit should always be set at the last, but I didn't find=
 any better
>logic for fixing this.
>> Please suggest if any better way to handle this situation.
>>
>
>I haven't tested it, but you can try this:
>
>diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index
>d7a327eaee12..37171d46390b 100644
>--- a/drivers/usb/dwc3/gadget.c
>+++ b/drivers/usb/dwc3/gadget.c
>@@ -924,8 +924,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep=
,
>struct dwc3_trb *trb,
>        struct usb_gadget       *gadget =3D &dwc->gadget;
>        enum usb_device_speed   speed =3D gadget->speed;
>
>-       dwc3_ep_inc_enq(dep);
>-
>        trb->size =3D DWC3_TRB_SIZE_LENGTH(length);
>        trb->bpl =3D lower_32_bits(dma);
>        trb->bph =3D upper_32_bits(dma);
>@@ -1004,7 +1002,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *d=
ep,
>struct dwc3_trb *trb,
>        }
>
>        if ((!no_interrupt && !chain) ||
>-                       (dwc3_calc_trbs_left(dep) =3D=3D 0))
>+                       (dwc3_calc_trbs_left(dep) =3D=3D 1))
>                trb->ctrl |=3D DWC3_TRB_CTRL_IOC;
>
>        if (chain)
>@@ -1013,6 +1011,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *d=
ep,
>struct dwc3_trb *trb,
>        if (usb_endpoint_xfer_bulk(dep->endpoint.desc) &&
>dep->stream_capable)
>                trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);
>
>+       dwc3_ep_inc_enq(dep);
>+
>        trb->ctrl |=3D DWC3_TRB_CTRL_HWO;
>
>        trace_dwc3_prepare_trb(dep, trb);
>

Thanks for pointing out a solution , the fix looks good. I will test with t=
his fix and resend the patches

Best Regards,
Anurag Kumar Vulisha

