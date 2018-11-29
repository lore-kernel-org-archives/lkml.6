Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A65C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41172081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4HniMQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41172081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeK2LGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:06:49 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40142 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeK2LGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:06:49 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so55474pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DDC2hl4rkJfAKuzO4/7nE+UgiXFPcUupX6ngsJSWIFA=;
        b=B4HniMQ+MRXXquwy/jd2y02XW7mB4noB0P509AzJ7iFarDNBS0zO0LFhr9+0xQNyu9
         ORqQfED7owIUXkakgFvxZkrtWWUrXwRDT3lEnae9EBXfDKkfH3c4xwzN+hfopQ6AFr8w
         RuH3K+CbrW2H49xctG+UcDZB/jCslCTCpYoTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DDC2hl4rkJfAKuzO4/7nE+UgiXFPcUupX6ngsJSWIFA=;
        b=DNPC3PmErSOl+8BWtueynixyOjXUywsobbY48Je+kK6mUA0TVgUYahFNd9jAIEUQL8
         UhweE5s08t1hET7qok5dsx8sCyh5ydbnp++Af1ymEuXGuw0d1hSMkCm+FGtwoxze4t3y
         y9tWz9a4PmIDUjcKjaoafL9yvd9aZushzlHAsrFSFwc0AxO0cpPw6MhmuxwCFOSWJMKg
         SSpjCZYw9KSgp/BmtED5devaOSR5B/2oUudXymj2K4L78V7U91YsYccgz/0qe3CNPv3y
         zTD7mzHC8v2FoVw1H67LQ3w8k4RRYDc/DwIhZOIW8wG7VD2OpcoXjRCFQVPiBeFjVmp+
         EuAQ==
X-Gm-Message-State: AGRZ1gLeuxzE8gMMu5nek+MgglFBPcynvJWyYcJevh51Z4nTwmoDBPBy
        mrZW74SIOxUkHAu3BYxyp2RxZA==
X-Google-Smtp-Source: AJdET5d1cQABjF/BilQ2odk4FEaqOQ/kpgYnYzQxZX+jhpL+XbG3jVakjW+/sfeFDG9adeDIimDglw==
X-Received: by 2002:a62:7796:: with SMTP id s144mr39412174pfc.26.1543449805014;
        Wed, 28 Nov 2018 16:03:25 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c23sm111141pfi.83.2018.11.28.16.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:03:24 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:03:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add SoC-specific string for
 sdhci-msm-v4 nodes
Message-ID: <20181129000322.GG24969@minitux>
References: <20181105210921.253707-1-dianders@chromium.org>
 <20181105210921.253707-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105210921.253707-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 13:09 PST 2018, Douglas Anderson wrote:

> As per upstream discussion [1], we should have an SoC-specific
> compatible string for Qualcomm's SDHCI nodes.  Let's add it.
> 
> [1] https://lkml.kernel.org/r/20181105203657.GA32282@bogus
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8992.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index d302d8d639a1..0a7335526063 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -587,7 +587,7 @@
>                  };
>  
>  		sdhc_1: sdhci@7824000 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  
> @@ -604,7 +604,7 @@
>  		};
>  
>  		sdhc_2: sdhci@7864000 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> index cf5cacdd624d..09d0234cfd99 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> @@ -203,7 +203,7 @@
>  		};
>  
>  		sdhci1: mmc@f9824900 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index b29fe80d7288..5e19f87df020 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -535,7 +535,7 @@
>  
>  		sdhc2: sdhci@74a4900 {
>  			 status = "disabled";
> -			 compatible = "qcom,sdhci-msm-v4";
> +			 compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
>  			 reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
>  			 reg-names = "hc_mem", "core_mem";
>  
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 
