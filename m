Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA50C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF34206B7
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPHIOcd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfAER6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 12:58:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39203 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfAER6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 12:58:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so19796835pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 09:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ohiuwu+4fFi2Xqw/cg+brZezIhJHfENYsWXOA0F+BMQ=;
        b=IPHIOcd4rAkqCt3+Jyn57TbHyVU+RDQ8hMFcSg3nahFHk3/QNcGcPAToBNhbuHvTqs
         lEsd2KOdU640LZhkAlMobekWiM1Q9FPluY8G5q4Jcc4HUqjqlX56eJcdqgW1h3vXxAtr
         kbzbJwCV2d0niFADHLv/QePGz/9xec6g56x68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ohiuwu+4fFi2Xqw/cg+brZezIhJHfENYsWXOA0F+BMQ=;
        b=KlKgSHwYK9JmXHd0yQjuIDlgBbavhR/05+2X0Vg6+I3ZKCHnA0Mxmvb1xOsJ3UZZSq
         MYzRjc3ME3Coklh9f4GHokixH6UVPwH9XqHNulJ/lIjVM+dOLufCY8uFoYR+6te34MQb
         nPoKQVKn3e1M04SzlxHlzHyyzY47PRPZhgbREUJ/48pgsfscUaaOfhTd53mfoLpPR3IH
         WZ8oIfDwhe9pIRH001UuvKeBXJj9RVf7Kq0PjkaLgC7xhhy9/wplsQ2U7UQFbzBX/As6
         dJIwQlHU1sswIC8VXtH0qao6LytgYTyv680J5+/1Tn3IgXMU7fAx94b9hxCC9ZCp5v7t
         AADA==
X-Gm-Message-State: AA+aEWZxxwGxq9OaGMyIp0SCsdmgPdFTFrRtcZO3SfsgrqPgXan7xb4C
        a0sHhiTwwUXJ03ODb5st0xAX
X-Google-Smtp-Source: AFSGD/WtyICefWI7Is2rAi3RAcPXcy86wRAjHZmKXwYMAKIJXHZiZAX7wPiTn/pE3MXOSniklnuBhw==
X-Received: by 2002:a62:ab0d:: with SMTP id p13mr56976184pff.211.1546711132779;
        Sat, 05 Jan 2019 09:58:52 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730c:d904:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id w88sm104457994pfk.11.2019.01.05.09.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Jan 2019 09:58:51 -0800 (PST)
Date:   Sat, 5 Jan 2019 23:28:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@cubietech.com,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org
Subject: Re: [PATCH v3 2/4] arm64: dts: actions: s700: Add I2C controller
 nodes
Message-ID: <20190105175843.GA32306@Mani-XPS-13-9360>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-3-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-3-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 09:04:46AM +0100, Parthiban Nallathambi wrote:
> Add I2C controller nodes for Actions Semiconductor S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to dt-next branch where I have been collecting patches for
Andreas.

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 192c7b39c8c1..35fddba2af1c 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -174,6 +174,46 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		i2c0: i2c@e0170000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0170000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C0>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@e0174000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0174000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C1>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@e0178000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0178000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C2>;
> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@e017c000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe017c000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C3>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		sps: power-controller@e01b0100 {
>  			compatible = "actions,s700-sps";
>  			reg = <0x0 0xe01b0100 0x0 0x100>;
> -- 
> 2.17.2
> 
