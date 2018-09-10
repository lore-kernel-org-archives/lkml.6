Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38978C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CF42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 20:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WcUI2rKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CF42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeIKBJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 21:09:38 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:42852 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeIKBJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 21:09:37 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B4DCD10C0964;
        Mon, 10 Sep 2018 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536610432; bh=orpESdXNZeZGLYTJDOJWXjAVWW08m5AbEkNLwsdh0SU=;
        h=From:To:CC:Subject:Date:References:From;
        b=WcUI2rKaEnPTrpoT17AJxyBQqfS7CFnT0+y27pWkz5HzkSY8rPt8WEZOfWvmSt9U1
         +AdabqT8/SiNEHkJ1xV5if2IGkPZC5/5guk61XDoBct4v8RBwKCtKyt7OUdTv2dtjI
         G9avrPWgfqid499s2EHNcaANynJPuIcLs9FKl1jrr7SZen+saYkmv5xYX4C67m1N5Y
         zcxk7swtaAWZQtaKy0YmSXjgiTgo4oK0etdLIfu0BMKAbZy2Ivi0S4bk5RK1E2KW+t
         3FwiQPX+X1opFdKEUkCXViFC5wX+/HfLTtzRefm2ko+r3H9+6Q/WS/DJkxCgNfutaJ
         WrkoYHuqjCX/w==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 90DCD3876;
        Mon, 10 Sep 2018 13:13:52 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon, 10
 Sep 2018 13:13:52 -0700
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>
Subject: Re: [PATCH v4 6/8] usb: dwc3: check for requests in started list
 for stream capable endpoints
Thread-Topic: [PATCH v4 6/8] usb: dwc3: check for requests in started list
 for stream capable endpoints
Thread-Index: AQHUR4UYRgxFEofqUUKoe+A6FKwC1w==
Date:   Mon, 10 Sep 2018 20:13:51 +0000
Message-ID: <30102591E157244384E984126FC3CB4F544ADE8E@us01wembx1.internal.synopsys.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1536418986-16609-7-git-send-email-anurag.kumar.vulisha@xilinx.com>
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
On 9/8/2018 8:03 AM, Anurag Kumar Vulisha wrote:=0A=
> For stream capable endpoints, uas layer can queue mulpile requests on=0A=
> single ep with different stream ids. So, there can be multiple pending=0A=
> requests waiting to be transferred. This patch changes the code to check=
=0A=
> for any pending requests waiting to be transferred on ep started_list and=
=0A=
> calls __dwc3_gadget_kick_transfer() if any.=0A=
=0A=
Whenever a function driver queues a request, then=0A=
__dwc3_gadget_kick_transfer() will be called right? What case exactly is=0A=
this for? Scatter gathering? If so, then we probably need further=0A=
explanation. (e.g. Why wait to call __dwc3_gadget_kick_transfer() on=0A=
XferComplete event rather than sending a START_TRANSFER command for=0A=
every prepared TRB whenever we do __dwc3_gadget_kick_transfer()?).=0A=
=0A=
Thanks,=0A=
Thinh=0A=
=0A=
>=0A=
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>=0A=
> Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>=0A=
> ---=0A=
>  Changes in v4:=0A=
> 	1. None=0A=
>=0A=
>  Changes in v3:=0A=
> 	1. None=0A=
>=0A=
>  Changes in v2:=0A=
> 	1. None=0A=
> ---=0A=
>  drivers/usb/dwc3/gadget.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
>=0A=
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c=0A=
> index 97bfdf0..c50cad8 100644=0A=
> --- a/drivers/usb/dwc3/gadget.c=0A=
> +++ b/drivers/usb/dwc3/gadget.c=0A=
> @@ -2433,6 +2433,9 @@ static void dwc3_gadget_endpoint_transfer_in_progre=
ss(struct dwc3_ep *dep,=0A=
>  =0A=
>  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);=0A=
>  =0A=
> +	if (dep->stream_capable && !list_empty(&dep->started_list))=0A=
> +		__dwc3_gadget_kick_transfer(dep);=0A=
> +=0A=
>  	if (stop) {=0A=
>  		dwc3_stop_active_transfer(dep, true);=0A=
>  		dep->flags =3D DWC3_EP_ENABLED;=0A=
=0A=
=0A=
