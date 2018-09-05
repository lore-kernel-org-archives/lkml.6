Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F018C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23130204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RAeP6UL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23130204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIEKCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:02:07 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:35242 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeIEKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:02:07 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DBB3924E0691;
        Tue,  4 Sep 2018 22:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536125619; bh=c7EtLAb92J0LGi/FBVcTkCghg+Xo9oymN8ajVVX02Zg=;
        h=From:To:CC:Subject:Date:References:From;
        b=RAeP6UL5Z4gN9opBwTMXiWS0NGlctxQoxkhD2x4XITBbRCm0ltCB7y0RiGBVlxULY
         0+ndtZO81JghT5a79dmLTMoiE97nNej54xNGA2r3S6x2q3/XNgzbnPf+9CJV66Imqu
         NluLEilSnM/AXf0qOG05OlMPO8hJezmIpJ+HQmt0JAEAqfKG7q/kclH791kfeohFQk
         NzGhB2urzAH7RYMT/fb1XW1dBm/LuKpoDRQN5FyUx3iRVU9Vwjxkx883gAcVBN8QK5
         fHnZ/rggtkXgw3Lwd8GZrskDfVdshsOY+4rFFpKCRPPwCFzyOj81MCnSTF40fOIoUS
         I0D3VUlxJrBAg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id BFE573D6D;
        Tue,  4 Sep 2018 22:33:39 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue, 4
 Sep 2018 22:33:39 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
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
Date:   Wed, 5 Sep 2018 05:33:39 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544AB897@us01wembx1.internal.synopsys.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
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
On 8/17/2018 5:25 AM, Anurag Kumar Vulisha wrote:=0A=
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
>=0A=
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=0A=
> ---=0A=
>  Changes in v2:=0A=
> 	1. Changed the commit message=0A=
> ---=0A=
>  drivers/usb/dwc3/gadget.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
> index 69bf137..f73d219 100644=0A=
> --- a/drivers/usb/dwc3/gadget.c=0A=
> +++ b/drivers/usb/dwc3/gadget.c=0A=
> @@ -990,6 +990,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *de=
p, struct dwc3_trb *trb,=0A=
>  			trb->ctrl |=3D DWC3_TRB_CTRL_ISP_IMI;=0A=
>  	}=0A=
>  =0A=
> +	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
> +=0A=
>  	if ((!no_interrupt && !chain) ||=0A=
>  			(dwc3_calc_trbs_left(dep) =3D=3D 0))=0A=
>  		trb->ctrl |=3D DWC3_TRB_CTRL_IOC;=0A=
> @@ -1000,8 +1002,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *=
dep, struct dwc3_trb *trb,=0A=
>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)=
=0A=
>  		trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);=0A=
>  =0A=
> -	trb->ctrl |=3D DWC3_TRB_CTRL_HWO;=0A=
> -=0A=
>  	trace_dwc3_prepare_trb(dep, trb);=0A=
>  }=0A=
>  =0A=
How do you reproduce this issue? We should not set HWO before setting=0A=
other trb->ctrl bits. Can you provide a driver tracepoint? If there's an=0A=
issue with the check if ((!no_interrupt && !chain) ||=0A=
dwc3_calc_trbs_left =3D=3D 0), then we may need to fix the check there.=0A=
=0A=
BR,=0A=
Thinh=0A=
