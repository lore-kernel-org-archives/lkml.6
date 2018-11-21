Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8D4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD802145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aak4wyye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD802145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbeKURt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:49:26 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:36450 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeKURt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:49:26 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id F342F24E10BE;
        Tue, 20 Nov 2018 23:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542784567; bh=d1teK1WUzfeyItgkuT6GJcnVxMuJcGqLI277Ror7FNg=;
        h=From:To:CC:Subject:Date:References:From;
        b=aak4wyyeQFhtqT2SUoHC7wfuBWb6kfC1nHhPTu4zh8LLXOE4jT3aBNpgy7TZfaJmd
         m9+Cjg3LiKLJSiCVufT3a2KAI+yFQyYC3LjjZaFHzuT9OUalaelZgEoh85IV0a8sFP
         O637+WjkJGr9DbtLImUw31VWWuo+D+W+FLo+B08m/fJr5K47ELGL/2cd4iX9YF5STk
         +GSFSp94Ue/9A2fc7XmX43XMpA4TsON7X9+eoe/BJvX9g5OXiP99hqNJ7H+SCOj8Lm
         SbnGmd2ZgSO8gSGQ90BB8kiA/4o5/sTceBqN1JsXnZjtsWbaFyC/FNX0GeOAX3HY9x
         TQ7lVzrgESG3Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id B095B379E;
        Tue, 20 Nov 2018 23:16:06 -0800 (PST)
Received: from AM04WEHTCA.internal.synopsys.com (10.116.16.190) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 20 Nov 2018 23:16:06 -0800
Received: from AM04WEMBXA.internal.synopsys.com ([fe80::79c3:55f2:1f20:5bf4])
 by am04wehtca.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 21 Nov 2018 11:16:03 +0400
From:   Minas Harutyunyan <minas.harutyunyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <minas.harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] usb: dwc2: Disable power down feature on Samsung SoCs
Thread-Topic: [PATCH] usb: dwc2: Disable power down feature on Samsung SoCs
Thread-Index: AQHUgOcaQGqbY5vux0CaBVOfE8r4oA==
Date:   Wed, 21 Nov 2018 07:16:02 +0000
Message-ID: <410670D7E743164D87FA6160E7907A56013A7A95F0@am04wembxa.internal.synopsys.com>
References: <CGME20181120153828eucas1p206d442b12c16588662c0e3f731ba58c3@eucas1p2.samsung.com>
 <20181120153815.31897-1-m.szyprowski@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.116.70.39]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 7:38 PM, Marek Szyprowski wrote:=0A=
> Power down feature of DWC2 module integrated in Samsung SoCs doesn't work=
=0A=
> properly or needs some additional handling in PHY or SoC glue layer, so=
=0A=
> disable it for now. Without disabling power down, DWC2 causes random memo=
ry=0A=
> trashes and fails enumeration if there is no USB link to host on driver=
=0A=
> probe.=0A=
> =0A=
> Fixes: 03ea6d6e9e1ff1 ("usb: dwc2: Enable power down")=0A=
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>=0A=
=0A=
Acked-by: Minas Harutyunyan <hminas@synopsys.com>=0A=
=0A=
> ---=0A=
>   drivers/usb/dwc2/params.c | 10 +++++++++-=0A=
>   1 file changed, 9 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c=0A=
> index 7c1b6938f212..266157ae179a 100644=0A=
> --- a/drivers/usb/dwc2/params.c=0A=
> +++ b/drivers/usb/dwc2/params.c=0A=
> @@ -71,6 +71,13 @@ static void dwc2_set_his_params(struct dwc2_hsotg *hso=
tg)=0A=
>   	p->power_down =3D false;=0A=
>   }=0A=
>   =0A=
> +static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)=0A=
> +{=0A=
> +	struct dwc2_core_params *p =3D &hsotg->params;=0A=
> +=0A=
> +	p->power_down =3D 0;=0A=
> +}=0A=
> +=0A=
>   static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)=0A=
>   {=0A=
>   	struct dwc2_core_params *p =3D &hsotg->params;=0A=
> @@ -151,7 +158,8 @@ const struct of_device_id dwc2_of_match_table[] =3D {=
=0A=
>   	{ .compatible =3D "lantiq,arx100-usb", .data =3D dwc2_set_ltq_params }=
,=0A=
>   	{ .compatible =3D "lantiq,xrx200-usb", .data =3D dwc2_set_ltq_params }=
,=0A=
>   	{ .compatible =3D "snps,dwc2" },=0A=
> -	{ .compatible =3D "samsung,s3c6400-hsotg" },=0A=
> +	{ .compatible =3D "samsung,s3c6400-hsotg",=0A=
> +	  .data =3D dwc2_set_s3c6400_params },=0A=
>   	{ .compatible =3D "amlogic,meson8-usb",=0A=
>   	  .data =3D dwc2_set_amlogic_params },=0A=
>   	{ .compatible =3D "amlogic,meson8b-usb",=0A=
> =0A=
=0A=
