Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28168C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43072082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEesdlbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43072082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbeLDJwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:52:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37411 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeLDJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:52:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so15185881wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wJruvd0nahqYsCR3HVPYYUg2nXEz8fwRVb7G0f4kY4s=;
        b=hEesdlblc+377VkSXUoy+MLGPvMFnE20E7XdYeVv2+oLQZnxU5T2na2RAOlIjELoOi
         84nztmZjVgT1/mGhzxB7G2DVXdWVTbdHc0MBiXdjDvYw3+GOo9sVzPT+ukOfUIJwUptG
         Bv+NrD2prfPJ5AUTC0nsSvH4vLsP1fgewpmHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wJruvd0nahqYsCR3HVPYYUg2nXEz8fwRVb7G0f4kY4s=;
        b=luLeW2Qew8PDVVswZd6PSFpX1XtKxrCCROA4on5JKeYMR+Lq9pmeTSI8fZvDKKFHsN
         wiQUA7Vq0XYbpkJApR15ORs+aa5xmbIiFLnGUcA4bOryEb4vtNwZfyjmCLDQoacmbNlq
         GO7D2bBIKgVyN3RBUswYZxqYIrXXHaGeK+tYPnHrlM0hXZE4fSg5XYSu2yOrRarO4Zh3
         UfVDisY3H2sfIrNVRtu7cL5oXoFqRMIKGNRgzlSGfSbuLYyfF3mBF8dnYBxc+NPV1PrL
         iX0jsJmvGYcD02iMTNGE/SZfElMrwvgrQ6xlLAfTEVkIrXkdwNPA/1UIBsxQdQsnIS1j
         R5GA==
X-Gm-Message-State: AA+aEWalB1hHd7X9fH8CV6e1JOgVJDgIr98ju/Ij+mWzQLgZTGPedI+q
        +dVnRP6G3vrr9FtHlqNM2/ZplBbQVxM=
X-Google-Smtp-Source: AFSGD/WcS+kHg1IDY5/DuarDeSMJ2I/uTlTpZq3RQTBh7kdGB+AQci3p7GiJDkbs9eMlSbnJlOE08w==
X-Received: by 2002:adf:ba05:: with SMTP id o5mr16687848wrg.325.1543917155641;
        Tue, 04 Dec 2018 01:52:35 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id g67sm19667955wmd.38.2018.12.04.01.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 01:52:35 -0800 (PST)
Date:   Tue, 4 Dec 2018 09:52:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ti-tsc-adc: Add new compatible for AM654
 SoCs
Message-ID: <20181204095233.GT26661@dell>
References: <20181119094509.22542-1-vigneshr@ti.com>
 <4b42082c-462d-3d94-8ee9-6e7a61f57134@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b42082c-462d-3d94-8ee9-6e7a61f57134@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Dec 2018, Vignesh R wrote:

> Hi,
> 
> On 19/11/18 3:15 PM, Vignesh R wrote:
> > AM654 SoCs has ADC IP which is similar to AM335x. Add new compatible to
> > handle AM654 SoCs. Also, it seems that existing compatible strings used
> > in the kernel DTs were never documented. So, document them now.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > ---
> 
> Gentle ping on this patch..

Don't do that.

If you think your patch has been forgotten, please submit a [RESEND].

> >  .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt  | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> > index b1163bf97146..aad5e34965eb 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> > @@ -2,7 +2,12 @@
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  
> >  Required properties:
> > +- mfd
> > +	compatible: Should be
> > +		"ti,am3359-tscadc" for AM335x/AM437x SoCs
> > +		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
> >  - child "tsc"
> > +	compatible: Should be "ti,am3359-tsc".
> >  	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
> >  		  support on the platform.
> >  	ti,x-plate-resistance: X plate resistance
> > @@ -25,6 +30,9 @@ Required properties:
> >  			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> >  			XP  = 0, XN = 1, YP = 2, YN = 3.
> >  - child "adc"
> > +	compatible: Should be
> > +		    "ti,am3359-adc" for AM335x/AM437x SoCs
> > +		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
> >  	ti,adc-channels: List of analog inputs available for ADC.
> >  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
> >  
> > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
