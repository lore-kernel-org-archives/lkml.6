Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC19EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E24320878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7IQEW3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E24320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeLFX4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:56:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40902 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeLFX4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:56:15 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so964593pfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKKNCjIJYgbYn5fqdj0XkzPlQZokkNNiokF29z+JjLY=;
        b=c7IQEW3VwhpjvWXqZGxkbtWAFsk10TivlZYoETLwcIrrQ6xkIB9Osimn/1aTsiChuv
         Q3UYhZ4IlbotqOb70y8C/UWSJg5y+VQvdgKD4cukeQ4Vx/aUdtBQYuKT6aY4ppIychGM
         X7ez2AlYHteiW0dhLHqys3Llebn6ecsQGxVSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKKNCjIJYgbYn5fqdj0XkzPlQZokkNNiokF29z+JjLY=;
        b=ARCKqgoQJgyrJ/5OCaEngZ4zhusQ1eX7i58WCyIqO6S13zw5V+NOnpVikDl7GyyZ7T
         +ZuJURGp2XpQDgIkkyc7RVX3QRSl/flOUmRl5EaYyWIfwIgsjQlimoFudz1/TlScVcNk
         TANj2nAXCRpE28v7Vm+ENNeewAcF19YmnF2DmIqiCFwlB29fqDy/UyWgNlwb2JkWbxI7
         HswvMsQyefScGWYS1nsUQ3iLA2SYBOmOP3KJmyrNm4gK3Apl2dPdC8FwGpFksxq+3r3J
         jbkcu/wvjxqy2v1KEI6v+7Bhtwfrj7FsRcKh1qmkIoJlIZy/w+cDUerGOnD6GYNGyzfU
         2gVg==
X-Gm-Message-State: AA+aEWaGraDgPsEVIJmQad0V2+ZDfpxGE1rd2p5Q10nzVorva3VY90QM
        DF7cej8XNTb6gudRh2pf4hifdJBIF7o=
X-Google-Smtp-Source: AFSGD/XxxjyqqhtOOa0nJ44An7ubQq3+CCxNyv+LMrrr7/uVcMY9Der9xPMi9yJ1baundbe2HiQGJw==
X-Received: by 2002:a62:c683:: with SMTP id x3mr10730pfk.10.1544140573879;
        Thu, 06 Dec 2018 15:56:13 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r76sm2085892pfb.69.2018.12.06.15.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:56:13 -0800 (PST)
Date:   Thu, 6 Dec 2018 15:56:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sdm845: Add SD node
Message-ID: <20181206235610.GG12886@minitux>
References: <20181206184522.118062-1-evgreen@chromium.org>
 <20181206184522.118062-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206184522.118062-3-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Dec 10:45 PST 2018, Evan Green wrote:

> Add one of the two SD controllers to SDM845.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v2:
>  - Reworded commit message to note that there are multiple SD
>  controllers.
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1419b0098cb38..bb8eacdf40910 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -1078,6 +1078,21 @@
>  			};
>  		};
>  
> +		sdhc_2: sdhci@8804000 {
> +			compatible = "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x8804000 0x1000>;
> +
> +			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +				 <&gcc GCC_SDCC2_APPS_CLK>;
> +			clock-names = "iface", "core";
> +
> +			status = "disabled";
> +		};
> +
>  		usb_1_hsphy: phy@88e2000 {
>  			compatible = "qcom,sdm845-qusb2-phy";
>  			reg = <0x88e2000 0x400>;
> -- 
> 2.18.1
> 
