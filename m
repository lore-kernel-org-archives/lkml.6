Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E8BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725B820673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkmO38so"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725B820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbeGZRIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:08:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45672 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbeGZRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:08:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id j8-v6so1003087pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QA1uL74FMIkL0dEg0Y9GI3qY4lZ15O9Cinyr1bKkEjo=;
        b=RkmO38so1sl/v35KC3jLr9D1auWEGVbp8/Qv6jd0y4x2en/mHsNcaoIqTxKu5fL6e7
         tH5x5ByRynP0HWdytefEClncfPNwFdx+IBoxc2sa+NWpmvdSeIVntt2DGFx9WE99J0fJ
         FEcg2XKI2iUH/w0ROdiqVXD3S3f/Ex2J/1p68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QA1uL74FMIkL0dEg0Y9GI3qY4lZ15O9Cinyr1bKkEjo=;
        b=og6RnkmJ7Iy51TwSNy7Kp2dapaJINLGripNlBpIpy3V8a0E70Bc+gK95Ygn2L/jMWq
         65nTl/2IPzukM7vQzuqs16Mi5oBy8KXFmLNiC1QNkWSAvMuEL0USG9zJ+/dYVJEC32Ts
         //BAF0WZiIuyMXkto76UD6yOa6/A+8UIp+vZLQsYsVYI0DO/gaHCDxz4efmazlcLgqZs
         2J5WUdSizNo7BV77KR9aDUqb9Ngf28ix3QC7JO0xgkMBt9sX33+rrR8UimTjMnHeJKCY
         mdoCpYB14WHBWvuSz6bCoDJXRh4N+z3SpYTTnVvwZfRDX3RgOdoSvh/ufqhEehpQDYpP
         E5+g==
X-Gm-Message-State: AOUpUlGb1d+J6ReA1yunhmUyeaswZdrgjXlklBbUehmNbasZfIFoMw1G
        3SkPZEAtVdAHxZ2sWjckJTpZ
X-Google-Smtp-Source: AAOMgpf6JKRg1BSghyMXX+z1K7uUZokJumGCOx8GK/UkmT1OKVVeNqOtVgcDVgdrdehND/eOTkV3Ew==
X-Received: by 2002:a17:902:bd97:: with SMTP id q23-v6mr2455945pls.311.1532620239016;
        Thu, 26 Jul 2018 08:50:39 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id v3-v6sm8760152pgb.54.2018.07.26.08.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 08:50:38 -0700 (PDT)
Date:   Thu, 26 Jul 2018 21:20:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     afaerber@suse.de
Cc:     sravanhome@gmail.com, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v7 5/5] arm64: dts: actions: Set UART clock reference
 from CMU
Message-ID: <20180726155025.GA5220@Mani-XPS-13-9360>
References: <20180719090649.12460-1-sravanhome@gmail.com>
 <20180719090649.12460-6-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719090649.12460-6-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Jul 19, 2018 at 11:06:49AM +0200, Saravanan Sekar wrote:
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Will you be queuing up the dts patches through actions tree?

Thanks,
Mani

>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index ef79d7905f44..c08808ca3346 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -28,12 +28,6 @@
>  		device_type = "memory";
>  		reg = <0x1 0xe0000000 0x0 0x0>;
>  	};
> -
> -	uart3_clk: uart3-clk {
> -		compatible = "fixed-clock";
> -		clock-frequency = <921600>;
> -		#clock-cells = <0>;
> -	};
>  };
>  
>  &timer {
> @@ -42,5 +36,5 @@
>  
>  &uart3 {
>  	status = "okay";
> -	clocks = <&uart3_clk>;
> +	clocks = <&cmu CLK_UART3>;
>  };
> -- 
> 2.14.4
> 
