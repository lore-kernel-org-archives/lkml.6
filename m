Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC43C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 23:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949C42080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 23:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3pgnFmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949C42080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKRJbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 04:31:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33444 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeKRJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 04:31:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so1582542plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 15:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cymbH2fgIELcSPTl0CaAzLl/NqD9CxudyVPbUVDl2AU=;
        b=L3pgnFmObjcrPFzfReIKtJytUMA91fFW0k/JV/GXuMI4Ja3L10Rx9rwsQVO/G1Bkn6
         kjr2vSYnbotljz0LM6MVl22XLXZnHS17EB9sXnw3Bq5Pq0f3mw5mAdvwUntcIl+t8gX4
         AHmSmF0i7AI2yaxZdBQjYVxuHjSm9nkBQuhOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cymbH2fgIELcSPTl0CaAzLl/NqD9CxudyVPbUVDl2AU=;
        b=InhTT3paDf1cGNE/E/oJZMLbJh/XkLi9l54RqGbbPcBjDd1UBobCV9zIO81tRfZhHe
         6armu5or+ntHWQ7BmeeCbrFXeodeQfo+C1siVA8NdGX02ijoRpPLXhJhDnYX6O99QOJa
         QXVWWdkpZkp9EtNoJEZoaqORbip5qpkwfvMT9Fttiye1LFBna4dZ97ftLeMSyCV8CWrb
         utlZ+GXMtsm375OO5uGRMqQ+r8lDyYxGC5W2eC6s8m/c7JC1XXF3pUICXyaac/MH1dRz
         laivZck10Io46kznI8UvGtbv/aH2x4sPks0UV11jfxwhJ+e8uoC7tWiyeSATzmXYIeqq
         V/MA==
X-Gm-Message-State: AA+aEWYeioCg3IgNulRrTlJnfwOaz30ZM8orLXv1BEo2HPlKiB8wDc0x
        7P7G1VRPb4XjKDLn2R/+CYe6XA==
X-Google-Smtp-Source: AFSGD/UcKSxd+OmsqOX/ZmfuI26YG2XbQ4QaePjXM/mLrdWn74/YVC0Nup8GMSbjs4WuljqPR2kzOQ==
X-Received: by 2002:a17:902:887:: with SMTP id 7mr6644400pll.164.1542496366922;
        Sat, 17 Nov 2018 15:12:46 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l87sm11779415pfj.179.2018.11.17.15.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 15:12:46 -0800 (PST)
Date:   Sat, 17 Nov 2018 15:12:44 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 12/18] arm64: dts: qcom: pms405: add gpios
Message-ID: <20181117231244.GC2225@minitux>
References: <20181109094417.12109-1-vkoul@kernel.org>
 <20181109094417.12109-13-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109094417.12109-13-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Nov 01:44 PST 2018, Vinod Koul wrote:

> Add the GPIOs present on PMS405 chip.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pms405.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> index 2b275bbdafa3..8e5a8573430e 100644
> --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> @@ -10,6 +10,25 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pms405_gpios: gpio@c000 {
> +			compatible = "qcom,pms405-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> +				<0 0xc1 0 IRQ_TYPE_NONE>,
> +				<0 0xc2 0 IRQ_TYPE_NONE>,
> +				<0 0xc3 0 IRQ_TYPE_NONE>,
> +				<0 0xc4 0 IRQ_TYPE_NONE>,
> +				<0 0xc5 0 IRQ_TYPE_NONE>,
> +				<0 0xc6 0 IRQ_TYPE_NONE>,
> +				<0 0xc7 0 IRQ_TYPE_NONE>,
> +				<0 0xc8 0 IRQ_TYPE_NONE>,
> +				<0 0xc9 0 IRQ_TYPE_NONE>,
> +				<0 0xca 0 IRQ_TYPE_NONE>,
> +				<0 0xcb 0 IRQ_TYPE_NONE>;
> +		};
> +
>  		rtc@6000 {
>  			compatible = "qcom,pm8941-rtc";
>  			reg = <0x6000>;
> -- 
> 2.14.4
> 
