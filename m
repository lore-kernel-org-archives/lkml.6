Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB39CC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CA02465B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFd3WLiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CA02465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbeFVRFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:05:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32838 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754632AbeFVRFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:05:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so3782821plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L4aixZ77veftpObcjxCI/R5ejZt3xkk5zERvOp0PkDk=;
        b=eFd3WLiqaQSROsn1Ko9eegl2K8/gidmWh/sXuMVzlojsINEeb75kPnD3NBGKmEotL0
         P2sDKvg13UgfErjEuYzwdya9CFWx+Z5HjsGVKy92dBmNuU922At4+W0pbGSAmDiwaK45
         6P3zTVBvO9eq8rAxlQxJxD4CVPDQdBKy9q8w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L4aixZ77veftpObcjxCI/R5ejZt3xkk5zERvOp0PkDk=;
        b=H2lvTFU9CYel/ncpnOTo7EAe4IKcR94D9Ka64ir1gs6Ttuq8UN9UmHtVNbVhMw2B97
         M9mXsjGatNtmfYJkv9/TDtKRFonFQ9jSUqqHEaAuU+NSxbpz/iKaSDVfxPZQHA4/O9Qq
         hPD7KAoKa2grLM0en/iBh3bb+Ey/j2o/SKSB/oVCKScY4EhpwpxrZldACp7TPDB+B6O3
         vh78JNsl6yL9I9GfWCoEsEWB9UDM+0lJc+Kw2PWRwuzTOX3ro2aoBK95WIFSqQS3XpdY
         GqVm//OvhgfSr9RUeALyn0w8u5NqwSQLFfOJlJmmOJ+ptESh2mbQEz9kTJ7MfsI0JcUl
         N/MA==
X-Gm-Message-State: APt69E2F1xk2AABlfbUFUQV4l7vpO8KxCiC0ugvbx436gBrO4wc65OJ0
        NOzlWpKlSjd9+lrClSJLXYw7CA==
X-Google-Smtp-Source: ADUXVKJQMyzRJ9UruphJVWb/ThZdEm5kpR20XZyqCG+V4e2I6ecQyEh7/zMC7TXHYQOLZ5I32AfZ6g==
X-Received: by 2002:a17:902:b604:: with SMTP id b4-v6mr2543068pls.18.1529687104607;
        Fri, 22 Jun 2018 10:05:04 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y11-v6sm11710645pfn.92.2018.06.22.10.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 10:05:03 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:05:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, sboyd@kernel.org, tdas@codeaurora.org,
        rplsssn@codeaurora.org, ilina@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: dts: sdm845: Add rpmh-clk node
Message-ID: <20180622170501.GF10336@builder>
References: <20180618215051.156270-1-dianders@chromium.org>
 <20180618215051.156270-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618215051.156270-2-dianders@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Jun 14:50 PDT 2018, Douglas Anderson wrote:

> This adds the rpmh-clk node to sdm845 based on the examples in the
> bindings.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> NOTE: to apply this patch cleanly, apply it atop:
>   arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes
>   https://patchwork.kernel.org/patch/10462691/
> 
> Changes in v2: None
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 43a182fb42c9..00722b533a92 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
> @@ -1001,6 +1002,11 @@
>  					  <SLEEP_TCS   3>,
>  					  <WAKE_TCS    3>,
>  					  <CONTROL_TCS 1>;
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sdm845-rpmh-clk";
> +				#clock-cells = <1>;
> +			};
>  		};
>  
>  		intc: interrupt-controller@17a00000 {
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 
