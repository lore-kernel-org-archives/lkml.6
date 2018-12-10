Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B27C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284272081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544484242;
	bh=ZozId5HCoQoq5U+gUViN80Pw1ZwtYFvrhrw2WrvdfaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h2TBZ9TdmoIkfrLEETCapC9CWA/ZjSzGgc2dl9mgr/q+6jHvUiPHNTDfCtFy3lK7Y
	 Pt0GVevnAgu11B3hwWYQKFh89OkSZM4TKhuiy5wgMP/UVz+zaB2vsppfxIwmu2o3sw
	 iNe88v200EUk6GFu3gayiKxSiJQVssbWTnMvNrJs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 284272081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeLJXYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:24:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34657 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeLJXYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:24:00 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so12260778otk.1;
        Mon, 10 Dec 2018 15:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wytH2VjJePyFuGqDWTvW58pYv89UnREaFtUGmC4XGg=;
        b=CKfrj9ZmajgMxyLFzgbAjEHT6tMSHZauq32mPjS6LfAZTKQzSraBW2B4KbSVOuQqta
         Z2XQ3wpVN9oX3y0rEk9yO64PRAtcHEO/NANtFyx+nArT0quAQqyJ5Vd6sr73a3+PU33q
         UUXDR0NgoD3anZ2QA0h6pXPdNOITLM7q2vRYFLivsxnYQiH4ULaw7cYyIatIPZ0hsL3q
         F1jfxhebhigR0PgrkS8K6EWHInOCYGPpgaD0UTpXNspoK7xH/A0BBwwfyY69fWKd2fIS
         eSNCoxu6e6POhVzP16lN47UA2rhHu8vNFLWWsZGbFYWG6mCCgf+fS2Ea9TWwpikwUqkv
         1Plg==
X-Gm-Message-State: AA+aEWYyQL4BuXMNKTCipW8ZwHDiTLS9ae3blYj27be6GrJkNN7pPjL8
        Q+U1pH1s+VfkVBm8ro13Bq3rFCM=
X-Google-Smtp-Source: AFSGD/V00sFr12ezBvBjnGbdLppZ911bLGSzmvoKfNDAKax44LzxW3N4TYwgTW5OtelDhIrTQkJJ0Q==
X-Received: by 2002:a9d:23e5:: with SMTP id t92mr10219988otb.159.1544484239802;
        Mon, 10 Dec 2018 15:23:59 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b18sm5725850otl.33.2018.12.10.15.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:23:59 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:23:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: light: isl29018: update power
 supply name
Message-ID: <20181210232358.GA11621@bogus>
References: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544425521-775-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 07:11:19AM +0000, Anson Huang wrote:
> According to datasheet, the isl29018 has "vddd/vdda" power
> supply, and isl29023/isl29035 ONLY has "vdd" power supply,
> update the power supply name with "vdd" and "vdda" according
> to datasheet to cover all devices and avoid confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/light/isl29018.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/isl29018.txt b/Documentation/devicetree/bindings/iio/light/isl29018.txt
> index b9bbde3..36f737d 100644
> --- a/Documentation/devicetree/bindings/iio/light/isl29018.txt
> +++ b/Documentation/devicetree/bindings/iio/light/isl29018.txt
> @@ -15,7 +15,9 @@ Optional properties:
>    Refer to interrupt-controller/interrupts.txt for generic interrupt client
>    node bindings.
>  
> -  - vcc-supply: phandle to the regulator that provides power to the sensor.
> +  - vdd-supply: phandle to the regulator that provides vdd power to the sensor.
> +
> +  - vdda-supply: phandle to the regulator that provides vdda power to the sensor.

Is this in use? You can't just change things if it is.

Rob
