Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 194F6C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F3520693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="g8CQiZRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F3520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933490AbeFLHsd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:48:33 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:39209 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbeFLHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:48:32 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 71BC31E04A3;
        Tue, 12 Jun 2018 09:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528789710; bh=4h3IQ4zqWg9nkcRzeMskTCRxGrJ8+me7ZCSUyvkOch0=;
        h=From:To:CC:Subject:Date:References:From;
        b=g8CQiZRPITqwg75IZq4YowaIEdPJft508nJWxvP9sqS56yTqFo0pDG+vr/w0y289Z
         M+sJiJlm/yxTT92uE3Plj7ToAqi9p7D8zjN3x2opqG1sk21BCspkXF+ELEkImJ2BVm
         Ca8RP55BP7ZGFKir8ziG7kyI4vbktr8b6DvufTJ3Vn5op3Asp6OKKgEbF/QSR6yJMA
         00mDy0Sk9KN+pas0SEIqAfIkLY/yeTl5NyAwU5aQIpTunl5EWOvo5RnfOiRKOTKVFh
         5X2QuIAHFsWpI867lIuMiAfjG8KQVqUxkNY1MElXHGc/7fpt5Fc+ZU5tCUhAalSD0T
         00OYiknplA/Iw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id C5D683203;
        Tue, 12 Jun 2018 00:48:29 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 12 Jun 2018 00:48:29 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 12 Jun 2018 11:48:27 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: fix packet drop issue in
 dwc2_gadget_handle_nak
Thread-Topic: [PATCH] usb: dwc2: gadget: fix packet drop issue in
 dwc2_gadget_handle_nak
Thread-Index: AQHUAhnEFlH/rSKsX0G4MTSftUwoTw==
Date:   Tue, 12 Jun 2018 07:48:25 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A5AA95B@am04wembxa.internal.synopsys.com>
References: <1528814947-27098-1-git-send-email-prime.zeng@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
On 6/12/2018 10:51 AM, Zeng Tao wrote:=0A=
> In ISOC transfer, when the NAK interrupt happens, we shouldn't complete=
=0A=
> a usb request, the current flow will complete one usb request with no=0A=
> hardware transfer, this will lead to a packet drop on the usb bus.=0A=
> =0A=
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>=0A=
> ---=0A=
>   drivers/usb/dwc2/gadget.c | 3 ---=0A=
>   1 file changed, 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c=0A=
> index f0d9ccf..fbe65f6 100644=0A=
> --- a/drivers/usb/dwc2/gadget.c=0A=
> +++ b/drivers/usb/dwc2/gadget.c=0A=
> @@ -2817,9 +2817,6 @@ static void dwc2_gadget_handle_nak(struct dwc2_hsot=
g_ep *hs_ep)=0A=
>   =0A=
>   		tmp =3D dwc2_hsotg_read_frameno(hsotg);=0A=
>   		if (using_desc_dma(hsotg)) {=0A=
> -			dwc2_hsotg_complete_request(hsotg, hs_ep,=0A=
> -						    get_ep_head(hs_ep), 0);=0A=
> -=0A=
>   			hs_ep->target_frame =3D tmp;=0A=
>   			dwc2_gadget_incr_frame_num(hs_ep);=0A=
>   			dwc2_gadget_start_isoc_ddma(hs_ep);=0A=
> =0A=
=0A=
