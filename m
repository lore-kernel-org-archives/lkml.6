Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBABC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C52D20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTbzTMb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C52D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJ2KYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:24:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34312 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeJ2KYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:24:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so3184718pfe.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l6/npn9/1VPeCkjWJwAE8tYQRfDC0Me6DiMKj4x+LBY=;
        b=hTbzTMb6uGXWkNh5SB2/4wwuGA0VczXnFSxBqeKUa7pFbm5caR1nQLLHTb0+AwzSsb
         LGVP9bt6Ei5BNf/eE5ifX7Z4AtFp2qA4750GIxpnZmMLsrO2hd7CxrTmnaZNIf0JMtZ9
         FUDnuT4ci9rMZZjTGN1/f56hH5hohTYAEpu4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l6/npn9/1VPeCkjWJwAE8tYQRfDC0Me6DiMKj4x+LBY=;
        b=C0o4m6gBo3TBCy+woDBp/H4kfPFa//bBHwWCGr2N0ioEUvstxVRtP4uTHIbIzuZ96w
         z0aqEhSl9esHxqkx8GLAZJPrMxYqu3eNy0DDDUS0HRj2/5ixwJDbLesSeIphZbmorO2R
         y1AeTkMLwn9crO8WZSYt6cwfYDb11zoKiJ54kGZ2R+W+/17PiWhHgaZ1kD+/mXfUUTno
         LuWu51uOoncKyZGxVf/RCFzXcb9syVQFPY2lm1w/xhBTYLteCMOxfTozD1R31DxVXmO8
         0dcVyXrzTmym8wxP3EC1Td3zDJScaWqQdUnDeBA/swv5DJv26BeqQ52sbt8PdkoU8pDj
         vs8w==
X-Gm-Message-State: AGRZ1gJLkB/gVCuj6UnsPIK2LC8Z7XbPoaCnR1briqihnWEx5eg1IN/f
        nddVaEjymVCn5wUbozLXQOiRlw==
X-Google-Smtp-Source: AJdET5fh4vidjamdTookYQdTsBXcandzVUD5FYeyGNO6mbEi20Gh/C2hb6UOHGt033p61dr2bsMeBQ==
X-Received: by 2002:a63:4a4a:: with SMTP id j10-v6mr4664045pgl.0.1540777096862;
        Sun, 28 Oct 2018 18:38:16 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m19-v6sm18301800pgv.93.2018.10.28.18.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 18:38:16 -0700 (PDT)
Date:   Sun, 28 Oct 2018 18:38:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        dianders@chromium.org, evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add PDC Global reset driver
 node
Message-ID: <20181029013813.GC1855@tuxbook-pro>
References: <20181026122653.4935-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026122653.4935-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Oct 05:26 PDT 2018, Sibi Sankar wrote:

> This patch adds the node to support PDC Global reset driver on
> SDM845 SoCs
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index fad22acfda4d..d3fe012ad84e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
> +#include <dt-bindings/reset/qcom,sdm845-pdc.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
>  / {
> @@ -1262,6 +1263,12 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		pdc_reset: reset-controller@b2e0000 {
> +			compatible = "qcom,sdm845-pdc-global";
> +			reg = <0xb2e0000 0x20000>;
> +			#reset-cells = <1>;
> +		};
> +
>  		tsens0: thermal-sensor@c263000 {
>  			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>  			reg = <0xc263000 0x1ff>, /* TM */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
