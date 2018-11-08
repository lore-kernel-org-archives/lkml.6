Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4FEC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FB620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNBsb3OH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FB620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbeKHNjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:39:33 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46840 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbeKHNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:39:33 -0500
Received: by mail-pl1-f193.google.com with SMTP id c13-v6so8882888plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 20:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wfll4NfKYnOomX3sinK/PWBAaaFD7tqVawO4DHolG4Q=;
        b=NNBsb3OHPZZjVqC5ZpQBnDBmmL6H7hloMRR1fM88iDmO87Vfymb7bcrO+gIpG9sOUE
         B/8Y/kvKlalDgm1Vdyn6o6+AdxspNbtUPTpxAGJSPAUxw8dzKJGkhcOsXabAuuDTLcf0
         7qkufQmmegUtIcLCQy+fYmqUBFrBBYI2+TOnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wfll4NfKYnOomX3sinK/PWBAaaFD7tqVawO4DHolG4Q=;
        b=i1vo7k23okt2dPs/qjmJKpt6+jyoMQtt3pFY6HA4Q0nW7AMpNpCx8vORsxkagPAqKk
         gMU0GAxWD6dNMa8zK8SVY4HqVeUaa8JxFZ3vjbQuGRcgwO0jMQUe3KowqyygVRajU+RN
         8cfPnv7pUE72D6LaZF30673Q9Tv53xja08dAs/NjdZ6AgOvJYBkdr9hAqGXVzaQ+VS78
         dBG3T0o3924LJaf0Rh8eQvtvtoCBatrCmdvO7JtyNMo3WMTbU0ovNjRh2ZEgXhMLafWq
         6R9XLE9A/i8xcWSDIgTRk1eubyhzQ0asi0ZJjfxIpAGWubcmbeUptlK8l0NFjY0nNYA8
         XomA==
X-Gm-Message-State: AGRZ1gIF6bygxGJXP5903MN7km+PCuen1Ore0aBH571jtyBEC3sZGuKv
        LZ/ejFeLqYLb2/bbEbKNbnO5iMuBBg==
X-Google-Smtp-Source: AJdET5dN71awQb5D5lu5g/1V/D8iTo8ZraYVkQ0Qp2jtZFOy+edAir+gHBis1qGoVUVTM/lkqllo9g==
X-Received: by 2002:a17:902:6948:: with SMTP id k8-v6mr3067733plt.22.1541649963983;
        Wed, 07 Nov 2018 20:06:03 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:600a:38ce:49ff:31b1:1894:e040])
        by smtp.gmail.com with ESMTPSA id v12-v6sm2723156pfa.167.2018.11.07.20.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 20:06:03 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:35:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, amit.kucheria@linaro.org,
        linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pinctrl: Add devicetree bindings for
 MT6797 SoC Pinctrl
Message-ID: <20181108040551.GB3046@Mani-XPS-13-9360>
References: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
 <20181107174844.5381-2-manivannan.sadhasivam@linaro.org>
 <1541643072.23791.3.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541643072.23791.3.camel@mtksdaap41>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:11:12AM +0800, Yingjoe Chen wrote:
> On Wed, 2018-11-07 at 23:18 +0530, Manivannan Sadhasivam wrote:
> > Add devicetree bindings for Mediatek MT6797 SoC Pin Controller.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../bindings/pinctrl/pinctrl-mt6797.txt       |   83 +
> >  include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 +++++++++++++++++
> >  2 files changed, 1451 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> >  create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> > new file mode 100644
> > index 000000000000..bd83401e6179
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
> 
> Sorry if this is discussed.
> 
> What's the difference between this and
> Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt?
> Should this be added to pinctrl-mt65xx.txt?
>

Currently there are 3 different pinctrl core's available for MediaTek
SoCs:

1. Legacy core - pinctrl-mtk-common.c
2. Moore core - pinctrl-moore.c pinctrl-mtk-common-v2.c
3. Paris core - pinctrl-paris.c pinctrl-mtk-common-v2.c

AFAIU pinctrl-mt65xx binding documents the SoC's based on MediaTek's legacy
pinctrl-mtk-common.c core. Whereas MT6797 is based on the MediaTek's Paris
core. There isn't any binding doc available for the Paris core SoC's yet.
That's why I have created a new bindings doc and expecting the remaining SoC's
of Paris family to be included in new pinctrl-mt6797.txt.

Hope this makes clear!

Thanks,
Mani

> Joe.C
> 
> 
