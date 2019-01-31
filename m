Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B09C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83EE20989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7MZhOvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfAaCLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:11:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42738 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfAaCLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:11:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so1097735lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 18:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5KzE+HG2CIC7HNBYFtZjHtRLRSk0+xZjVvot8Yza1vY=;
        b=Y7MZhOvQ9LiuU5ldH+Dh6oD+u6EJ73pl+WquV+GeUuBUDTR1hLWvvWC7k8UymE+Vht
         0MIZ4sjRJ05dXk9PK7CY32AoNiy2CDYOZ0gDCKr/gKLv24xQG2dxjkfEAFFT22ES8FNZ
         pDB5/KrEQFDR978RepNYL+WCKC35ndmkJffRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5KzE+HG2CIC7HNBYFtZjHtRLRSk0+xZjVvot8Yza1vY=;
        b=ecKh9Odh7b18r7DdKmgz29LKvmvCsRDiRETMkkHns9w7yy5UDuVS+wIMYygpvj76cb
         j+2ilU90kuraoMt4WZygjc04nO4vGml2SOyjb2sXCd3CITzJGixOaFyJ2weE+K1ZL18S
         OP9Dg4pRWLvB17XFErc8GimAXZder/b/7CrVE87yiDQ/C8tHnCCTbPfhA1LaRW1cUPL9
         2Jbt3pfZQNRN/V8BTw66J7yrR5Ls2ZkWG3e08tGeVjuBJBLjDeyJOmLbeO9sts/7VCM6
         Yo8gcpbbFNI2fBz+VIhJSOFnn+eZqykC6UFD5GsBvAZqh3RiCBrr/yqfJ9L3D+6bEV4H
         7fSw==
X-Gm-Message-State: AJcUukc9DO8lLTnwD6i4C0G0DuyD8v32MJQ4o/RovwqR9l5LnHN1cbl8
        fLCHWFAlFhXqUDnS/NIlavvmTg==
X-Google-Smtp-Source: ALg8bN601Wk25nmvDeuHfZ+YnXQsSdh11b8vTwqVNJljGoFMzHL2ZDUjKx2uexyvnji/IgsiXqrt4w==
X-Received: by 2002:a19:920a:: with SMTP id u10mr18671637lfd.122.1548900675952;
        Wed, 30 Jan 2019 18:11:15 -0800 (PST)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 185-v6sm521636ljj.49.2019.01.30.18.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 18:11:15 -0800 (PST)
Date:   Thu, 31 Jan 2019 03:11:13 +0100
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add rpmcc node
Message-ID: <20190131021113.GA11855@centauri.lan>
References: <20190125181422.21434-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125181422.21434-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 10:14:22AM -0800, Bjorn Andersson wrote:
> Add the rpm clock controller node, to provide the low-noise baseband
> clock for the USB PHYs, among other things.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index b3be39e088db..d90decd00f5c 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -3,6 +3,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  
>  / {
> @@ -225,6 +226,11 @@
>  		rpm_requests: glink-channel {
>  			compatible = "qcom,rpm-qcs404";
>  			qcom,glink-channels = "rpm_requests";
> +
> +			rpmcc: clock-controller {
> +				compatible = "qcom,rpmcc-qcs404";
> +				#clock-cells = <1>;
> +			};
>  		};
>  	};
>  
> -- 
> 2.18.0
> 

Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>
