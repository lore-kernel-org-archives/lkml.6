Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5405C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F69A2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="isJQZjdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F69A2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbeKFEeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:34:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39588 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbeKFEet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:34:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so4914389pla.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OhV2KObqQFedxaqITV6DKAeXpkCZ2iE/MUNgps3yDUw=;
        b=isJQZjdxALXZTMSCAByLddr6t/EKjHxC7IMqjKmgqn+oMPnCsTdpTr72vVOPDLrIeH
         GDB3MCGYtbaIzpGWP2ew+pPvPHxHvHu1C3dZL7i3DdyWWhlhoyWo+XmRUagsw1jCxHB5
         W4ydlhey9w4hbnAyjSAQSJbReGvg+G3yxOSHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhV2KObqQFedxaqITV6DKAeXpkCZ2iE/MUNgps3yDUw=;
        b=CjCj5tQsDVpOYTtGGA74b4O2lI9QPcxa5dndmQvm8zCZ/gTqWwRpxumWu4sdJwOXrk
         FytSRFhnK4X3bw5xn98clPapjviAvwaNW32GFZ7gkWZxCywP6p0M906GGenPN3qmzXOv
         x3WY0oTy3X0ZjBoSvunUQXnOl6La3AR3gy1/CML1w5OQOh582fldyiy5tQWlsouNvCNG
         E4LVUvZOlMbJfKDre+3ztJGuNkTAJYuTzpLOpUzcfw7s04/wgMaylyfbtD2/x0djOjjg
         vkHN2jA3yY/RjL9JuXMe6By/YTXl1aZlS9nOoi+MNnI0x7K9l1Zuv98CuQ4gkYIH3cij
         01Yw==
X-Gm-Message-State: AGRZ1gIo/p8yPo9lOlTtiy0/YwT15/VXgs5jQlNpHURZfH46WuMIZ/TH
        kcvu27vhDqJ98WwDXphGVptXeg==
X-Google-Smtp-Source: AJdET5cDuYyMX48OpN9IFHrfX0r+26X32LmcatYTw+JS8pumEQoj344dodTzf6Pj0Kn7Sd4HyM2KoQ==
X-Received: by 2002:a17:902:8ec2:: with SMTP id x2-v6mr23420337plo.157.1541445223015;
        Mon, 05 Nov 2018 11:13:43 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d16sm12405116pgj.21.2018.11.05.11.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:13:42 -0800 (PST)
Date:   Mon, 5 Nov 2018 11:13:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/17] arm64: dts: qcom: pms405: Add pon and pwrkey
 nodes
Message-ID: <20181105191340.GV2523@minitux>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-18-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105154529.7614-18-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:

> PMS405 also features PON block, so add PON and PWRKEY nodes
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 18410d9f0f8f..2c7cc1e94ff4 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2018, Linaro Limited
>  
>  #include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/input/linux-event-codes.h>
>  
>  &spmi_bus {
>  
> @@ -18,6 +19,21 @@
>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
>  		};
>  
> +		pon@800 {
> +			compatible = "qcom,pms405-pon";
> +			reg = <0x800>;
> +			mode-bootloader = <0x2>;
> +			mode-recovery = <0x1>;
> +
> +			pwrkey {
> +				compatible = "qcom,pm8941-pwrkey";
> +				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +				debounce = <15625>;
> +				bias-pull-up;
> +				linux,code = <KEY_POWER>;
> +			};
> +		};
> +
>  		pms405_gpios: gpios@c000 {
>  			compatible = "qcom,pms405-gpio";
>  			reg = <0xc000>;
> -- 
> 2.14.4
> 
