Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EF6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817A821901
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NTArWyMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437177AbfBNLnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:43:51 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:42442 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfBNLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:43:51 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id DCF7124E20A3;
        Thu, 14 Feb 2019 03:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550144631; bh=vGC8AVemBHxssQXUd3ikttdHqoi7yY2qYaAnNCS9qmE=;
        h=From:To:CC:Subject:Date:References:From;
        b=NTArWyMjutjVUw851p6hni8yeMcL/5Lw9u0j68W74TQvd+wxars0C2m/qQ2NWkygQ
         R/2GeaXkglhHewYbRjfiM0UvJpZ/dhFXnriowAbSQirD6kOpasRoi+5bSlCutpAWAb
         gEWpwbejnwXTpEY3mvuc19HX6Zj7uIaYnodakYAA/QzM9ax8JDAMZQdS1DH9Zrk859
         vULaG+nVTnGjb04p8Op21wq6uJIuaWrTuH6s94K/6cI0FgOVp7MJBGLNqdFnDNCxVo
         Ut48JgdLPew3rqVOxRwz2OkXiKdq7hEII/riR9kQFrMNwJYEhHA2PBji/AlNiZ9fp7
         LRd8vTOmQuK9A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7C27FA0071;
        Thu, 14 Feb 2019 11:43:50 +0000 (UTC)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 Feb 2019 03:43:50 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 14 Feb 2019 15:43:47 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "minas.harutyunyan@synopsys.com" <minas.harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: Re: [PATCH] usb: dwc2: hcd: call dwc2_is_controller_alive under
 spinlock
Thread-Topic: [PATCH] usb: dwc2: hcd: call dwc2_is_controller_alive under
 spinlock
Thread-Index: AQHUxEycCYLg8CCwHU26ysYDrcXjtA==
Date:   Thu, 14 Feb 2019 11:43:46 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7DC6C8@am04wembxa.internal.synopsys.com>
References: <CGME20190214100344epcas1p316a40d88f3b52a10745c95cc3d16a0ed@epcas1p3.samsung.com>
 <1550138622-10761-1-git-send-email-jh80.chung@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaehoon Chung,=0A=
=0A=
On 2/14/2019 2:04 PM, Jaehoon Chung wrote:=0A=
> This patch is referred to Robert's patch=0A=
> commit cf54772b913b ("usb: dwc2: call dwc2_is_controller_alive() under sp=
inlock")=0A=
> =0A=
> During running sdb with otg mode, the usb is hung sometime.=0A=
> =0A=
> The one of SDB hang issues should be fixed with this patch.=0A=
> After hang, it doesn't never trigger the usb interrupt.=0A=
> =0A=
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>=0A=
> ---=0A=
>   drivers/usb/dwc2/hcd_intr.c | 7 ++++---=0A=
>   1 file changed, 4 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c=0A=
> index 88b5dcf..8d3b155 100644=0A=
> --- a/drivers/usb/dwc2/hcd_intr.c=0A=
> +++ b/drivers/usb/dwc2/hcd_intr.c=0A=
> @@ -2222,13 +2222,13 @@ irqreturn_t dwc2_handle_hcd_intr(struct dwc2_hsot=
g *hsotg)=0A=
>   	u32 gintsts, dbg_gintsts;=0A=
>   	irqreturn_t retval =3D IRQ_NONE;=0A=
>   =0A=
> +	spin_lock(&hsotg->lock);=0A=
> +=0A=
>   	if (!dwc2_is_controller_alive(hsotg)) {=0A=
>   		dev_warn(hsotg->dev, "Controller is dead\n");=0A=
> -		return retval;=0A=
> +		goto out;=0A=
>   	}=0A=
>   =0A=
> -	spin_lock(&hsotg->lock);=0A=
> -=0A=
>   	/* Check if HOST Mode */=0A=
>   	if (dwc2_is_host_mode(hsotg)) {=0A=
>   		gintsts =3D dwc2_read_core_intr(hsotg);=0A=
> @@ -2276,6 +2276,7 @@ irqreturn_t dwc2_handle_hcd_intr(struct dwc2_hsotg =
*hsotg)=0A=
>   		}=0A=
>   	}=0A=
>   =0A=
> +out:=0A=
>   	spin_unlock(&hsotg->lock);=0A=
>   =0A=
>   	return retval;=0A=
> =0A=
=0A=
1. Checking core alive or not was introduced in our internal reference =0A=
driver for our setups, because sometime AHB-PCI bridge can hung, not =0A=
core itself. If it happen then only way to overcome it - reboot core =0A=
setup and PC.=0A=
2. Actually this issue was fixed on our setups and currently no need to =0A=
check access via bridge to core.=0A=
3. Any case if it still happen on some platforms then first need to =0A=
check and fix HW.=0A=
=0A=
On asserted any interrupt for dwc2, handlers call sequence is follow: =0A=
common->gadget->host handlers. If core alive checked in common handler =0A=
then checking same stuff in host handler again not needed at all.=0A=
=0A=
So, core alive checking in host handler create issue for your test, I =0A=
suggest to not fix alive checking in host interrupt handler as you =0A=
suggested and done in common handler, but just remove it.=0A=
=0A=
Thanks,=0A=
Minas=0A=
=0A=
=0A=
=0A=
