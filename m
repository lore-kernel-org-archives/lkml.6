Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B563C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3A92089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VlfoDkD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3A92089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbeG0Mcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:32:31 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:53372 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbeG0Mca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:32:30 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5EADA24E0396;
        Fri, 27 Jul 2018 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532689864; bh=23uReKFiTvinKImWq2aBjmupK0oFWfOYXhWxiKRuWns=;
        h=From:To:CC:Subject:Date:References:From;
        b=VlfoDkD6kvn7wTNuHFmkXxyqh3yWrX/JIvBvtW/GdlVlLZ1g2cPlATNICOuHp0PpS
         nd4FejSGIJvULAizO4cn0ujle8OQxP+94VNZaaxiRWhoCPmsxEghFuD4Ol1x9v57Ep
         /G7HN2UGTc6Qx8JaXOWMTEK2fSW/NHxgNp2o0QKoYxiEUWYHnMxpa0J4rvN/PesGs9
         ngu3V8S2VPspRexex+VNpje1ZtZwPXtWdxSyEpWuVzuHdTDrUuXDuo6Hy3UcNuO44m
         CGFikKiuZnf8nsYePTqwWBqdt3lDUVz8Io+QG2GiguG89mUmd2kdhLlookv0sa0gjb
         5HR2Dx3FuiOzQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3DEA43A9A;
        Fri, 27 Jul 2018 04:11:04 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 27 Jul 2018 04:11:04 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 27 Jul 2018 15:11:01 +0400
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Douglas Anderson <dianders@chromium.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "Minas.Harutyunyan@synopsys.com" <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "grigor.tovmasyan@synopsys.com" <grigor.tovmasyan@synopsys.com>,
        "Bruno Herrera" <bruherrera@gmail.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REPOST PATCH 3/4] usb: dwc2: Turn on uframe_sched on "amlogic"
 platforms
Thread-Topic: [REPOST PATCH 3/4] usb: dwc2: Turn on uframe_sched on
 "amlogic" platforms
Thread-Index: AQHUJRxeUWy2qj6wI0S5d3VRi5vBAA==
Date:   Fri, 27 Jul 2018 11:11:00 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A5CBE48@am04wembxa.internal.synopsys.com>
References: <20180726200730.18290-1-dianders@chromium.org>
 <20180726200730.18290-4-dianders@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.151]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2018 12:08 AM, Douglas Anderson wrote:=0A=
> There's no reason to have the uframe scheduler off on dwc2.  Running=0A=
> with uframe_sched =3D False is equivalent to saying "I don't want to run=
=0A=
> the correct code, I want to run the old and incorrect code".=0A=
> =0A=
> The uframe scheduler has been off on Amlogic since commit f94310ac076e=0A=
> ("usb: dwc2: add support for Meson8b and GXBB SoCs").  While this was=0A=
> after most of the recent improvements, notably the commit 9f9f09b048f5=0A=
> ("usb: dwc2: host: Totally redo the microframe scheduler"), presumably=0A=
> the parameters were copied from another platform and the uframe=0A=
> scheduler wasn't tried.=0A=
> =0A=
> Presumably if everyone is good w/ the uframe_sched turned back on we=0A=
> can kill all the old and crufty non-uframe sched code.=0A=
> =0A=
> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
=0A=
Reviewed-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
> =0A=
>   drivers/usb/dwc2/params.c | 1 -=0A=
>   1 file changed, 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index db97bb16ecc4..93380f7c32b4 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -110,7 +110,6 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg=
 *hsotg)=0A=
>   	p->phy_type =3D DWC2_PHY_TYPE_PARAM_UTMI;=0A=
>   	p->ahbcfg =3D GAHBCFG_HBSTLEN_INCR8 <<=0A=
>   		GAHBCFG_HBSTLEN_SHIFT;=0A=
> -	p->uframe_sched =3D false;=0A=
>   }=0A=
>   =0A=
>   static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)=0A=
> =0A=
=0A=
