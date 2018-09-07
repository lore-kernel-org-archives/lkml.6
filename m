Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FFF2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cmnTk1lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FFF2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeIHEMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:12:16 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:39160 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeIHEMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:12:16 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7496F24E0691;
        Fri,  7 Sep 2018 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536362938; bh=ygyKDWROYWcWby6xQGVRG1weRKfXOseAZi6aTlbMYRg=;
        h=From:To:CC:Subject:Date:References:From;
        b=cmnTk1lgcmblW0UO/GmN8q1kAQEYF227njcpppADG9kIrJzDDQoIzy8rfvWP9vfLi
         +f6Z7q0F918XtomOiXj6THRPfwwmgFPMl1GBDsmB4Gj3Di+OBDGyHVznxbfe0jh6wa
         gWLxlJqoZvynQ9b+RItRT2Oblu4BX/DnbpOEzBQVyJPrghCjugg7ITfNqvJ20dNMek
         hQV5d5n3dOk4dsszK56Jp5d1AR5Ym6q1Eq8a8+8LeQnMaS1U8nO3kBFwXXG3Qnc6m1
         tXjfyRIQGToKxoEChbjXfS8whDsH6WwTldo9JnT9udqMzOKJGhmcrmKlBW2Mf1/qiK
         3wXrgTMzi/AJg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5C01A38C6;
        Fri,  7 Sep 2018 16:28:58 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Fri, 7 Sep 2018 16:28:58 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH v3 1/8] usb: dwc3: Correct the logic for checking TRB
 full in __dwc3_prepare_one_trb()
Thread-Topic: [PATCH v3 1/8] usb: dwc3: Correct the logic for checking TRB
 full in __dwc3_prepare_one_trb()
Thread-Index: AQHURqy3eaJ+tpig0kSKsepPhxN7aQ==
Date:   Fri, 7 Sep 2018 23:28:57 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544AD8B3@us01wembx1.internal.synopsys.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536326029-16327-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
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
On 9/7/2018 6:14 AM, Anurag Kumar Vulisha wrote:=0A=
> Availability of TRB's are calculated using dwc3_calc_trbs_left(), which=
=0A=
> determines available TRB's based on the HWO bit set in a TRB.=0A=
>=0A=
> __dwc3_prepare_one_trb() is called with a TRB which needs to be prepared=
=0A=
> for transfer. This __dwc3_prepare_one_trb() calls dwc3_calc_trbs_left()=
=0A=
> to determine total available TRBs and set IOC bit if the total available=
=0A=
> TRBs are zero. Since the present working TRB(which is passed as an=0A=
> argument to __dwc3_prepare_one_trb() )  doesn't have HWO bit already set,=
=0A=
> there are chances where dwc3_calc_trbs_left() wrongly calculates this=0A=
> present working TRB as free(since the HWO bit is not yet set). This could=
=0A=
> be a problem. This patch correct this issue by setting HWO bit before=0A=
> calling dwc3_calc_trbs_left()=0A=
=0A=
Please revise your commit message to reflect your new change.=0A=
=0A=
>=0A=
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=0A=
> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
> ---=0A=
>  Changes in v3:=0A=
> 	1. Corrected the logic for setting HWO bit as suggested by "Thinh Nguyen=
"=0A=
>=0A=
>  Changes in v2:=0A=
> 	1. Changed the commit message=0A=
> ---=0A=
>  drivers/usb/dwc3/gadget.c | 6 +++---=0A=
>  1 file changed, 3 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
> index 032ea7d..8a1622b 100644=0A=
> --- a/drivers/usb/dwc3/gadget.c=0A=
> +++ b/drivers/usb/dwc3/gadget.c=0A=
> @@ -911,8 +911,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *de=
p, struct dwc3_trb *trb,=0A=
>  	struct usb_gadget	*gadget =3D &dwc->gadget;=0A=
>  	enum usb_device_speed	speed =3D gadget->speed;=0A=
>  =0A=
> -	dwc3_ep_inc_enq(dep);=0A=
> -=0A=
>  	trb->size =3D DWC3_TRB_SIZE_LENGTH(length);=0A=
>  	trb->bpl =3D lower_32_bits(dma);=0A=
>  	trb->bph =3D upper_32_bits(dma);=0A=
> @@ -991,7 +989,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *de=
p, struct dwc3_trb *trb,=0A=
>  	}=0A=
>  =0A=
>  	if ((!no_interrupt && !chain) ||=0A=
> -			(dwc3_calc_trbs_left(dep) =3D=3D 0))=0A=
> +			(dwc3_calc_trbs_left(dep) =3D=3D 1))=0A=
>  		trb->ctrl |=3D DWC3_TRB_CTRL_IOC;=0A=
>  =0A=
>  	if (chain)=0A=
> @@ -1002,6 +1000,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *=
dep, struct dwc3_trb *trb,=0A=
>  =0A=
>  	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
>  =0A=
> +	dwc3_ep_inc_enq(dep);=0A=
> +=0A=
>  	trace_dwc3_prepare_trb(dep, trb);=0A=
>  }=0A=
>  =0A=
=0A=
BR,=0A=
Thinh=0A=
