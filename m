Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C87C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6AB2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SsshPW+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6AB2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeG0MWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:22:17 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:49872 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbeG0MWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:22:17 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D218110C0F9E;
        Fri, 27 Jul 2018 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532689252; bh=SizA2YzQ8vuWSRvvsAWrAVZKwGZIZaYIbXpEE6P5ICU=;
        h=From:To:CC:Subject:Date:References:From;
        b=SsshPW+3ZRaNKUu3zUL5GS0ZKKGsTN3QVcAngvGavYAgnWMW0BtFTgyzgMn4y69zi
         FK6u+2xG9b6opgv39tR4cT58ZREVYs1TqKZ4yBozMJwfLWiZ8ufHR4q/Sb6elfvnCF
         W2WKyryvSx+wlAnlAersq5R0uCE/RsARwe3uFF5XG4SAnpt4OCzQqnfjReD4dD40+t
         Pzrtc/D5E9BEYtS5wqXI0+CO86caUu248a5Za0+BeHPInDcJux+cx6iKUzn5eSfGfX
         TrDFgq65jijvBus8OQbPQKO51mtCbmh+YUVwD1rJBZcCOF5N0YLJppYalnO49k0SGp
         2p/PO+TSnNOVw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id B0FB03180;
        Fri, 27 Jul 2018 04:00:52 -0700 (PDT)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 27 Jul 2018 04:00:52 -0700
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 27 Jul 2018 15:00:50 +0400
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
Subject: Re: [REPOST PATCH 2/4] usb: dwc2: Turn on uframe_sched on "his"
 platforms
Thread-Topic: [REPOST PATCH 2/4] usb: dwc2: Turn on uframe_sched on "his"
 platforms
Thread-Index: AQHUJRxd9SEVjTDe0kKxyJR8PXT+bQ==
Date:   Fri, 27 Jul 2018 11:00:49 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A5CBDD3@am04wembxa.internal.synopsys.com>
References: <20180726200730.18290-1-dianders@chromium.org>
 <20180726200730.18290-3-dianders@chromium.org>
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
> The uframe scheduler has been off on HiSilicon since commit=0A=
> 37dd9d65cc41 ("usb: dwc2: add support of hi6220").  Since then there=0A=
> have been many many improvements, notably the commit 9f9f09b048f5=0A=
> ("usb: dwc2: host: Totally redo the microframe scheduler")=0A=
> =0A=
> Presumably if everyone is good w/ the uframe_sched turned back on we=0A=
> can kill all the old and crufty non-uframe sched code.=0A=
> =0A=
> Signed-off-by: Douglas Anderson <dianders@chromium.org>=0A=
> Tested-by: John Stultz <john.stultz@linaro.org>=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
> =0A=
>   drivers/usb/dwc2/params.c | 1 -=0A=
>   1 file changed, 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index 14b8742e62fa..db97bb16ecc4 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -67,7 +67,6 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hsot=
g)=0A=
>   	p->reload_ctl =3D false;=0A=
>   	p->ahbcfg =3D GAHBCFG_HBSTLEN_INCR16 <<=0A=
>   		GAHBCFG_HBSTLEN_SHIFT;=0A=
> -	p->uframe_sched =3D false;=0A=
>   	p->change_speed_quirk =3D true;=0A=
>   	p->power_down =3D false;=0A=
>   }=0A=
> =0A=
=0A=
