Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69413C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDA5214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DiuHJrWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CDA5214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbeKNWKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:10:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46389 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeKNWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:10:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so7803033pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I3nJQglZhgZAiF9ZYkugvrN4YKtV0VksObD8xGD6E/g=;
        b=DiuHJrWmZr0rQc94D3WgGZujBVtJtvmWUxDnu7D8zw6qTkYGWHnhEipofVyXOaBSkF
         GmuG9dkaMXmUnTWLsKRBhYrjP96xVGKjUaRTcf8fOKDGZypj47RRKx4ln1HIL/YLV3QC
         f2sJu8K4llR9xJTs8f9sv/ynXR4gVMbEOecLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I3nJQglZhgZAiF9ZYkugvrN4YKtV0VksObD8xGD6E/g=;
        b=TyyXvaPs3NxazeSCHuybA63VMLgnTyoMMBDGDOGuZxHUUORStlx0DH8oCh5HuScquu
         z5ZZtUnG2Bo8TruWsCJwoDmLJH6nHvdPFv9YEgsPK35P3KXedxD/LuBiQeFWPfpTzOGU
         WPTWWjlDcVqSiM8x7tDaLlAoO4F0YztkCCq16tmrF77c0g9JTEVugXO8tJpnvL0rXLQ9
         3zDWqfzk+fzreoXGEiIPkdcNua2EVPpAjBYxvCllsg1yB9X1e/mQVa9PUKNdKZ+TJTtE
         J6ql7Ck98KVi1B9sgcMYVP9SpX0MBR5FZ+mhd5KXHZxG/TzU3D4RCshp/MD0Sd0aP4yi
         bJag==
X-Gm-Message-State: AGRZ1gIl/2Zh4b9sqgD23j3FJWw42GAp35+mm0jm5W+lTvHI5pv/TW/d
        J97FqNGDUcBXIrHCarcXBvhd
X-Google-Smtp-Source: AJdET5dWzD75vlyUCRHY3ENncZeJEintzlogaNDVO/7YH/XY+HiTmFBxVLpD64gYwsShdNgiSx7Oog==
X-Received: by 2002:a62:b802:: with SMTP id p2-v6mr1667095pfe.1.1542197228434;
        Wed, 14 Nov 2018 04:07:08 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:734f:c50:bc03:daf0:c43c:4a59])
        by smtp.gmail.com with ESMTPSA id d3sm27603248pgl.64.2018.11.14.04.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 04:07:04 -0800 (PST)
Date:   Wed, 14 Nov 2018 17:36:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, todor.tomov@linaro.org,
        hansverk@cisco.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: media: i2c: Fix external clock frequency
 for OV5645
Message-ID: <20181114120652.GA26112@Mani-XPS-13-9360>
References: <20181114103935.24559-1-manivannan.sadhasivam@linaro.org>
 <20181114105712.j5jkspfasujiyqzs@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114105712.j5jkspfasujiyqzs@valkosipuli.retiisi.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 12:57:12PM +0200, Sakari Ailus wrote:
> Hi Manivannan,
> 
> On Wed, Nov 14, 2018 at 04:09:35PM +0530, Manivannan Sadhasivam wrote:
> > Commit "4adb0a0432f4 media: ov5645: Supported external clock is 24MHz"
> > modified the external clock frequency to be 24MHz instead of the
> > 23.88MHz in driver. Hence, make the same change in corresponding bindings
> > doc and mention the acceptable tolerance.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/media/i2c/ov5645.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/i2c/ov5645.txt b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> > index fd7aec9f8e24..b155583469a4 100644
> > --- a/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> > +++ b/Documentation/devicetree/bindings/media/i2c/ov5645.txt
> > @@ -8,7 +8,8 @@ Required Properties:
> >  - compatible: Value should be "ovti,ov5645".
> >  - clocks: Reference to the xclk clock.
> >  - clock-names: Should be "xclk".
> > -- clock-frequency: Frequency of the xclk clock.
> > +- clock-frequency: Frequency of the xclk clock. Should be 24MHz with 1%
> > +                   acceptable tolerance.
> 
> DT bindings are for documenting the hardware, not the driver implementation.
> The sensor supports a range AFAIU, not a specific frequency.
>

Agree! That's my bad.

> The bit below seems good.
> 

Okay. Will remove the above change and send v2.

Thanks,
Mani

> >  - enable-gpios: Chip enable GPIO. Polarity is GPIO_ACTIVE_HIGH. This corresponds
> >    to the hardware pin PWDNB which is physically active low.
> >  - reset-gpios: Chip reset GPIO. Polarity is GPIO_ACTIVE_LOW. This corresponds to
> > @@ -37,7 +38,7 @@ Example:
> >  
> >  			clocks = <&clks 200>;
> >  			clock-names = "xclk";
> > -			clock-frequency = <23880000>;
> > +			clock-frequency = <24000000>;
> >  
> >  			vdddo-supply = <&camera_dovdd_1v8>;
> >  			vdda-supply = <&camera_avdd_2v8>;
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Sakari Ailus
> e-mail: sakari.ailus@iki.fi
