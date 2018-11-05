Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081BAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB80720854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OoOCqvpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB80720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeKERqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:46:43 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:42850 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKERqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:46:43 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B670E10C1133;
        Mon,  5 Nov 2018 00:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541406491; bh=fGSYD6WY3JFs7uVqm/DwZOEYeAOhnWE073CGT8RUvrE=;
        h=From:To:CC:Subject:Date:References:From;
        b=OoOCqvpWplCMHkOLVtwbsUfmpg8jwVzpcc8OCVOdpNrSVo6A+JhldrI+2Vpmr+30a
         aHF63bOepDRVlxNP+RQeL4EFSOuQ41e108nkJnhoH1ESauYuMX6xu/OggcEyG3zjHl
         yz/TQmcTHx+SIpiG95XlItTy7w2ymJuJ0YjKvJB9e71HMm/qJjukN4sjLnfRl3H1Lc
         jJBPdFhenCrT07IhOt3k91k+aPkc26Qfj1niP83A4ZPnxU5srxsrSsqfjXz6obI2Fn
         bqOCJ99F1uM2NGwTlY2URQOxQ9xeIMqXAHMIS9w46GLNqWTjSqjDWpcvJN78smblcY
         MLaPkh4KXraUw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5B70F3799;
        Mon,  5 Nov 2018 00:28:11 -0800 (PST)
Received: from AM04WEHTCB.internal.synopsys.com (10.116.16.192) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 00:28:11 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtcb.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 5 Nov 2018 12:28:08 +0400
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
Date:   Mon, 5 Nov 2018 08:28:07 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A79E7CE@am04wembxa.internal.synopsys.com>
References: <20181023134355.29829-1-john@metanate.com>
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
On 10/23/2018 5:43 PM, John Keeping wrote:=0A=
> By clearing the overrun flag as soon as the target frame is next=0A=
> incremented, we can end up incrementing the target frame more than=0A=
> expected in dwc2_gadget_handle_ep_disabled() when the endpoint's=0A=
> interval is greater than 1.  This happens if the target frame has just=0A=
> wrapped at the point when the endpoint is disabled and the frame number=
=0A=
> has not yet done so.=0A=
> =0A=
> Instead, wait until the frame number also wraps and then clear the=0A=
> overrun flag.=0A=
> =0A=
> Signed-off-by: John Keeping <john@metanate.com>=0A=
> ---=0A=
>   drivers/usb/dwc2/gadget.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
> index 2d6d2c8244de..8da2c052dfa1 100644=0A=
> --- a/drivers/usb/dwc2/gadget.c=0A=
> +++ b/drivers/usb/dwc2/gadget.c=0A=
> @@ -117,7 +117,7 @@ static inline void dwc2_gadget_incr_frame_num(struct =
dwc2_hsotg_ep *hs_ep)=0A=
>   	if (hs_ep->target_frame > DSTS_SOFFN_LIMIT) {=0A=
>   		hs_ep->frame_overrun =3D true;=0A=
>   		hs_ep->target_frame &=3D DSTS_SOFFN_LIMIT;=0A=
> -	} else {=0A=
> +	} else if (hs_ep->parent->frame_number < hs_ep->target_frame) {=0A=
>   		hs_ep->frame_overrun =3D false;=0A=
>   	}=0A=
>   }=0A=
> =0A=
Did you tested mentioned by you scenario? If you see issue can you =0A=
provide debug log and point the issue line in the log.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
