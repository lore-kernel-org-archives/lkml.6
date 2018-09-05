Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA012064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hXy8zVpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA012064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeIEKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:07:07 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:35996 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeIEKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:07:07 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 30BE510C0C06;
        Tue,  4 Sep 2018 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536125919; bh=hSqBsNZBm0xKFS3U9th9XrLGAWHA8peqHqx+2yeTMII=;
        h=From:To:CC:Subject:Date:References:From;
        b=hXy8zVpIeT7zXxjDn7bqx/T6HujwOH1QdHDQ6iLaotArrpEwc+N3rZiTyJ/rcT3fW
         BHbiY1gt1tUO9ID33jSVW5PNmClUEK9gmih0O1WUHHw/RFAITiLhTbcsfn6FbBBi1B
         rd6EP2mOiMGEUXALWaFUmmERJrXPyjUnxmg1W7fBIaa6INRvtd3wyuCzCIexJagCz0
         EY74ZiCOL9J5Im/FyVUa3OJWYs0SdijKHNolqt9qey2Q1V3ydTnC75o72DrZt435Ov
         UnnxY6vU8GBgvKZNjgfppWYXYmK19ow/ndVgOK53eo2BCGGTzND3n9u/r9+LUMOGJP
         Hbku1SQssJwNw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 04E9A3DFC;
        Tue,  4 Sep 2018 22:38:38 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue, 4
 Sep 2018 22:38:38 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/8] usb: dwc3: make controller clear transfer
 resources after complete
Thread-Topic: [PATCH v2 3/8] usb: dwc3: make controller clear transfer
 resources after complete
Thread-Index: AQHUNiV8hOcNaYvD7kKOGug2l9hEXw==
Date:   Wed, 5 Sep 2018 05:38:38 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544AB8AB@us01wembx1.internal.synopsys.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1534508695-12642-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
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

On 8/17/2018 5:26 AM, Anurag Kumar Vulisha wrote:=0A=
> To start transfer with another stream id, controller needs to free=0A=
> previously allocated transfer resource. This will be automatically=0A=
> done by the controller at the time of XferComplete Event. This=0A=
> patch updates the code to issue XferComplete event once all transfers=0A=
> are done by setting LST bit in the ctrl field of the last TRB.=0A=
>=0A=
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=0A=
> ---=0A=
>  Changes in v2:=0A=
> 	1. None=0A=
> ---=0A=
>  drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---=0A=
>  1 file changed, 16 insertions(+), 3 deletions(-)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
> index efc6e13..b3e9e7f 100644=0A=
> --- a/drivers/usb/dwc3/gadget.c=0A=
> +++ b/drivers/usb/dwc3/gadget.c=0A=
> @@ -571,7 +571,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *=
dep, unsigned int action)=0A=
>  =0A=
>  	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {=0A=
>  		params.param1 |=3D DWC3_DEPCFG_STREAM_CAPABLE=0A=
> -			| DWC3_DEPCFG_STREAM_EVENT_EN;=0A=
> +			| DWC3_DEPCFG_STREAM_EVENT_EN=0A=
> +			| DWC3_DEPCFG_XFER_COMPLETE_EN;=0A=
>  		dep->stream_capable =3D true;=0A=
>  	}=0A=
>  =0A=
> @@ -999,6 +1000,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *=
dep, struct dwc3_trb *trb,=0A=
>  	if (chain)=0A=
>  		trb->ctrl |=3D DWC3_TRB_CTRL_CHN;=0A=
>  =0A=
> +	/*=0A=
> +	 * To issue start transfer on another stream, controller need to free=
=0A=
> +	 * previously acquired transfer resource. Setting the LST bit in=0A=
> +	 * last TRB makes the controller clear transfer resource for that=0A=
> +	 * endpoint, allowing to start another stream on that endpoint.=0A=
> +	 */=0A=
> +	else if (dep->stream_capable)=0A=
> +		trb->ctrl |=3D DWC3_TRB_CTRL_LST;=0A=
> +=0A=
>  	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)=
=0A=
>  		trb->ctrl |=3D DWC3_TRB_CTRL_SID_SOFN(stream_id);=0A=
>  =0A=
> @@ -2268,7 +2278,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(str=
uct dwc3_ep *dep,=0A=
>  	if (event->status & DEPEVT_STATUS_SHORT && !chain)=0A=
>  		return 1;=0A=
>  =0A=
> -	if (event->status & DEPEVT_STATUS_IOC)=0A=
> +	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))=0A=
>  		return 1;=0A=
>  =0A=
>  	return 0;=0A=
> @@ -2457,6 +2467,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *d=
wc,=0A=
>  	}=0A=
>  =0A=
>  	switch (event->endpoint_event) {=0A=
> +	case DWC3_DEPEVT_XFERCOMPLETE:=0A=
> +		if (!dep->stream_capable)=0A=
> +			break;=0A=
> +		dep->flags &=3D ~DWC3_EP_TRANSFER_STARTED;=0A=
 Add this:  /* Falls Through */=0A=
>  	case DWC3_DEPEVT_XFERINPROGRESS:=0A=
>  		dwc3_gadget_endpoint_transfer_in_progress(dep, event);=0A=
>  		break;=0A=
> @@ -2472,7 +2486,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dw=
c,=0A=
>  		}=0A=
>  		break;=0A=
>  	case DWC3_DEPEVT_STREAMEVT:=0A=
> -	case DWC3_DEPEVT_XFERCOMPLETE:=0A=
>  	case DWC3_DEPEVT_RXTXFIFOEVT:=0A=
>  		break;=0A=
>  	}=0A=
=0A=
Thinh=0A=
=0A=
