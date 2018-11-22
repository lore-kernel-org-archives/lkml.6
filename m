Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C185C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC78920866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhnObrWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC78920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392541AbeKVR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:56:58 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40752 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbeKVR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:56:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so1310196pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fsbtri8kof4s0UI4ySJFDKrKCId73D/PD/kdcegErU0=;
        b=QhnObrWkYcmOuy4IsoipupucfOaidxWtHuV0An3oRleAy+WeEk31A+Ss+vLSLugiaG
         1zOMx1fLQ9BbIuddQ8DB2kYdoELoeyUHrC6OmCYqi/N0VRWzxz4sHVVdkXmr4qPjJmo7
         GvRTaB7E53/tqtMrLg1E4JsG6Qv3i2NYfK34Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fsbtri8kof4s0UI4ySJFDKrKCId73D/PD/kdcegErU0=;
        b=qu6IxXYMetXztGV8LSwBWDKI1h3CstR08lRIoJr+dAjnWd4WmxBrK5bPLutxvBD9a8
         Rh1G3ObQ/fjHm7xQtWr2DsGXZo+epXLZEFqSDXch349UR8bOhxBfmzg8En0NMu9nIhTV
         e6PBFoISNhpXbE4sqmudGro0U+O0fL2x2gFS40ScwVQ2sdM2XKtk71UwJGifXORrV3nJ
         foaSJq3BrkIXaDNvjiKD3o/8hTncrFh/tyBh8FmlYoLgMCn1af7o4vPQ7Hcwbud/aEkj
         aHkrYs7y0qy4AfmH7TVb2INlyqI1kBqUOHKezAf3q39z/2E4L6q3m9xKwByIOscKHFI/
         hD9g==
X-Gm-Message-State: AA+aEWbw5cA2w3908WsXHh5nRGSfkVFtkUf0oQFpZbtIjhH9vFwnbq22
        8881H97ZfkCXrjFUAWabvP7ZKQ==
X-Google-Smtp-Source: AFSGD/XVNRjdbb5NTDwz+fM2+w6LtqnlpRrscbqG04AzJQIok/S08+g+iRx8PbpNxTH8MFwhONsjhg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr8872837pgh.265.1542871130353;
        Wed, 21 Nov 2018 23:18:50 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y6sm23035365pfl.187.2018.11.21.23.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 23:18:49 -0800 (PST)
Date:   Wed, 21 Nov 2018 23:18:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH v5 3/5] arm64: dts: qcom: sdm845: add UFS controller
Message-ID: <20181122071847.GL2225@minitux>
References: <20181026173544.136037-1-evgreen@chromium.org>
 <20181026173544.136037-4-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026173544.136037-4-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Oct 10:35 PDT 2018, Evan Green wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0a31a5..9c72edb678ec 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -808,6 +808,73 @@
>  			};
>  		};
>  
> +		ufshc1: ufshc@1d84000 {

There's only one ufshc and one ufsphy, so no need to include the index.

[..]
> +			resets = <&gcc GCC_UFS_PHY_BCR>;
> +			reset-names = "rst";

I have this as well, but this is not used by the upstream driver nor is
it mentioned in the dt-binding.

> +
> +			status = "disabled";
> +		};
> +
> +		ufsphy1: phy@1d87000 {

With reservation for the "reset" issue:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
