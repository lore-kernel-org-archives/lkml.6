Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7FB0DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0125C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSh7QtzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0125C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754055AbeFLE7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:59:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41432 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbeFLE67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:58:59 -0400
Received: by mail-pl0-f65.google.com with SMTP id az12-v6so13632012plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s0ftCvdlcKqt78XnO7HrLbdqs5oG3ZZ1HIxrYtDAGKA=;
        b=RSh7QtzYpK7NMnwPfA4i5jonXuZ6yLMVFF8WgaFCTS5wkcSC4T9xuZc9vkxoUO2wGT
         1lKH3oVRZhpm3k23hRyL9R51YJ/Rvtgfc/EtgW2m8Jg1UWVjuHF+E1hm/oJChcUZa0eb
         dcWWXmPOY8pcgSEn4qyKupnb02MC91wOUsDbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0ftCvdlcKqt78XnO7HrLbdqs5oG3ZZ1HIxrYtDAGKA=;
        b=gCTLTN6+I91hIy5eIMpwh4LXUWaooXF1YeVaPXktLYMpPhOoM8SKWAOzlAGVyvK3gP
         z8QGVdf0ZSNhC5NKv8p6PaiAXasNkJ09MkamDcCuQfkqutytH5onZiCn9zOC1buUQJh4
         5fPSISMhPAUiJAV1uATQM56bn/vSV8Q9t/GzOCvpkGf+nIFiDKL3UmRokzHyeEhN9apd
         SyBN37f/1danY5YXUTSJL3+qk06rp9qXjdcEBk6biMTUK5j+T7WLpdw2D7jAIsjvLQxo
         JQy8LCN9ALocI1q6zw3wG9B46f5fqvSMuKXn9ViHznktTdBzDYL+eVrf/OlFim9Tpa4Q
         dKVA==
X-Gm-Message-State: APt69E3KpbJ637aKG5Vl+KcN82EuaBdrNnHAc1al9r5Ce1JUkw1fYokc
        dh3LZa1WVGKHAVNo66r6NkT4QQ==
X-Google-Smtp-Source: ADUXVKKu+VSfmQQwYy/4pCrOKAbrm2OsRXF0O/Iz5X7KOlW6dhjkPfYN8n9eaEpj5v12OeyOWSydmw==
X-Received: by 2002:a17:902:7b95:: with SMTP id w21-v6mr1030218pll.150.1528779538637;
        Mon, 11 Jun 2018 21:58:58 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q82-v6sm82895133pfg.170.2018.06.11.21.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 21:58:57 -0700 (PDT)
Date:   Mon, 11 Jun 2018 22:01:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, rnayak@codeaurora.org,
        kramasub@codeaurora.org, sdharia@codeaurora.org,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9
 nodes
Message-ID: <20180612050108.GU510@tuxbook-pro>
References: <20180607204608.27688-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607204608.27688-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Jun 13:46 PDT 2018, Douglas Anderson wrote:

> This adds nodes to SDM845-dtsi for all the I2C ports, all the SPI
> ports, and UART9.  Note that I2C / SPI / UART are a bit strange on
> sdm845 because each "serial engine" has 4 pins associated with it and
> depending on which firmware has been loaded into the serial engine
> (loaded by the BIOS) the serial engine can behave like an I2C port, a
> SPI port, or a UART.  As per the landed bindings that means that we
> need to create one node for each possible mode that the port could be
> in.  With 16 serial engines that means 16 x 3 = 48 nodes.
> 
> We get away with only creating 33 nodes for now because it seems very
> likely that SDM845-based boards will actually all use the same UART
> (UART 9) for debug purposes.  While another UART could be used for
> something like Bluetooth communication we can cross that path when we
> come to it.  Some documentation that I saw implied that using a UART
> for "high speed" communications actually needs yet another different
> serial engine firmware anyway.
> 
> Note that quick measurements adding all these nodes adds ~10k of extra
> space per dtb that they're included with.  If this becomes a problem
> we may need to think of a different way to structure this so that
> boards only get the nodes they need (or figure out how to get dtc to
> strip 'disabled' nodes).  For now it seems OK.
> 
> These nodes were programmatically generated with a fairly dumb python
> script.  See http://crosreview.com/1091631 for the source.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 1013 ++++++++++++++++++++++++++
>  1 file changed, 1013 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb3c995..2dc5c7dcc9aa 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <dt-bindings/clock/qcom,gcc-sdm845.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>  / {
> @@ -13,6 +14,41 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
> +		i2c9 = &i2c9;
> +		i2c10 = &i2c10;
> +		i2c11 = &i2c11;
> +		i2c12 = &i2c12;
> +		i2c13 = &i2c13;
> +		i2c14 = &i2c14;
> +		i2c15 = &i2c15;
> +		spi0 = &spi0;
> +		spi1 = &spi1;
> +		spi2 = &spi2;
> +		spi3 = &spi3;
> +		spi4 = &spi4;
> +		spi5 = &spi5;
> +		spi6 = &spi6;
> +		spi7 = &spi7;
> +		spi8 = &spi8;
> +		spi9 = &spi9;
> +		spi10 = &spi10;
> +		spi11 = &spi11;
> +		spi12 = &spi12;
> +		spi13 = &spi13;
> +		spi14 = &spi14;
> +		spi15 = &spi15;
> +	};
> +
>  	chosen { };
>  
>  	memory@80000000 {
> @@ -206,6 +242,489 @@
>  			#power-domain-cells = <1>;
>  		};
>  
> +		qupv3_id_0: geniqup@8c0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x8c0000 0x6000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			i2c0: i2c@880000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x880000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c0_default>;
> +				pinctrl-1 = <&qup_i2c0_sleep>;
> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi0: spi@880000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x880000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi0_default>;
> +				pinctrl-1 = <&qup_spi0_sleep>;
> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c1: i2c@884000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x884000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c1_default>;
> +				pinctrl-1 = <&qup_i2c1_sleep>;
> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi1: spi@884000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x884000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi1_default>;
> +				pinctrl-1 = <&qup_spi1_sleep>;
> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c2: i2c@888000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x888000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c2_default>;
> +				pinctrl-1 = <&qup_i2c2_sleep>;
> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi2: spi@888000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x888000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi2_default>;
> +				pinctrl-1 = <&qup_spi2_sleep>;
> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c3: i2c@88c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x88c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c3_default>;
> +				pinctrl-1 = <&qup_i2c3_sleep>;
> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi3: spi@88c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x88c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi3_default>;
> +				pinctrl-1 = <&qup_spi3_sleep>;
> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c4: i2c@890000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x890000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c4_default>;
> +				pinctrl-1 = <&qup_i2c4_sleep>;
> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi4: spi@890000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x890000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi4_default>;
> +				pinctrl-1 = <&qup_spi4_sleep>;
> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c5: i2c@894000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x894000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c5_default>;
> +				pinctrl-1 = <&qup_i2c5_sleep>;
> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi5: spi@894000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x894000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi5_default>;
> +				pinctrl-1 = <&qup_spi5_sleep>;
> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c6: i2c@898000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x898000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c6_default>;
> +				pinctrl-1 = <&qup_i2c6_sleep>;
> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi6: spi@898000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x898000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi6_default>;
> +				pinctrl-1 = <&qup_spi6_sleep>;
> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c7: i2c@89c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0x89c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c7_default>;
> +				pinctrl-1 = <&qup_i2c7_sleep>;
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi7: spi@89c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0x89c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi7_default>;
> +				pinctrl-1 = <&qup_spi7_sleep>;
> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		qupv3_id_1: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0xac0000 0x6000>;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			status = "disabled";
> +
> +			i2c8: i2c@a80000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa80000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c8_default>;
> +				pinctrl-1 = <&qup_i2c8_sleep>;
> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi8: spi@a80000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa80000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi8_default>;
> +				pinctrl-1 = <&qup_spi8_sleep>;
> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c9: i2c@a84000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa84000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c9_default>;
> +				pinctrl-1 = <&qup_i2c9_sleep>;
> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi9: spi@a84000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa84000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi9_default>;
> +				pinctrl-1 = <&qup_spi9_sleep>;
> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			uart9: serial@a84000 {
> +				compatible = "qcom,geni-debug-uart";
> +				reg = <0xa84000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_uart9_default>;
> +				pinctrl-1 = <&qup_uart9_sleep>;
> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			i2c10: i2c@a88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa88000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c10_default>;
> +				pinctrl-1 = <&qup_i2c10_sleep>;
> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi10: spi@a88000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa88000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi10_default>;
> +				pinctrl-1 = <&qup_spi10_sleep>;
> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c11: i2c@a8c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa8c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c11_default>;
> +				pinctrl-1 = <&qup_i2c11_sleep>;
> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi11: spi@a8c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa8c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi11_default>;
> +				pinctrl-1 = <&qup_spi11_sleep>;
> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c12: i2c@a90000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa90000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c12_default>;
> +				pinctrl-1 = <&qup_i2c12_sleep>;
> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi12: spi@a90000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa90000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi12_default>;
> +				pinctrl-1 = <&qup_spi12_sleep>;
> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c13: i2c@a94000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa94000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c13_default>;
> +				pinctrl-1 = <&qup_i2c13_sleep>;
> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi13: spi@a94000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa94000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi13_default>;
> +				pinctrl-1 = <&qup_spi13_sleep>;
> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c14: i2c@a98000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa98000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c14_default>;
> +				pinctrl-1 = <&qup_i2c14_sleep>;
> +				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi14: spi@a98000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa98000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi14_default>;
> +				pinctrl-1 = <&qup_spi14_sleep>;
> +				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			i2c15: i2c@a9c000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0xa9c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_i2c15_default>;
> +				pinctrl-1 = <&qup_i2c15_sleep>;
> +				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +
> +			spi15: spi@a9c000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0xa9c000 0x4000>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-0 = <&qup_spi15_default>;
> +				pinctrl-1 = <&qup_spi15_sleep>;
> +				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +		};
> +
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
>  			reg = <0x1f40000 0x40000>;
> @@ -219,6 +738,500 @@
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> +
> +			qup_i2c0_default: qup-i2c0-default {
> +				pinmux {
> +					pins = "gpio0", "gpio1";
> +					function = "qup0";
> +				};
> +			};
> +
> +			qup_i2c0_sleep: qup-i2c0-sleep {
> +				pinmux {
> +					pins = "gpio0", "gpio1";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c1_default: qup-i2c1-default {
> +				pinmux {
> +					pins = "gpio17", "gpio18";
> +					function = "qup1";
> +				};
> +			};
> +
> +			qup_i2c1_sleep: qup-i2c1-sleep {
> +				pinmux {
> +					pins = "gpio17", "gpio18";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c2_default: qup-i2c2-default {
> +				pinmux {
> +					pins = "gpio27", "gpio28";
> +					function = "qup2";
> +				};
> +			};
> +
> +			qup_i2c2_sleep: qup-i2c2-sleep {
> +				pinmux {
> +					pins = "gpio27", "gpio28";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c3_default: qup-i2c3-default {
> +				pinmux {
> +					pins = "gpio41", "gpio42";
> +					function = "qup3";
> +				};
> +			};
> +
> +			qup_i2c3_sleep: qup-i2c3-sleep {
> +				pinmux {
> +					pins = "gpio41", "gpio42";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c4_default: qup-i2c4-default {
> +				pinmux {
> +					pins = "gpio89", "gpio90";
> +					function = "qup4";
> +				};
> +			};
> +
> +			qup_i2c4_sleep: qup-i2c4-sleep {
> +				pinmux {
> +					pins = "gpio89", "gpio90";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c5_default: qup-i2c5-default {
> +				pinmux {
> +					pins = "gpio85", "gpio86";
> +					function = "qup5";
> +				};
> +			};
> +
> +			qup_i2c5_sleep: qup-i2c5-sleep {
> +				pinmux {
> +					pins = "gpio85", "gpio86";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c6_default: qup-i2c6-default {
> +				pinmux {
> +					pins = "gpio45", "gpio46";
> +					function = "qup6";
> +				};
> +			};
> +
> +			qup_i2c6_sleep: qup-i2c6-sleep {
> +				pinmux {
> +					pins = "gpio45", "gpio46";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c7_default: qup-i2c7-default {
> +				pinmux {
> +					pins = "gpio93", "gpio94";
> +					function = "qup7";
> +				};
> +			};
> +
> +			qup_i2c7_sleep: qup-i2c7-sleep {
> +				pinmux {
> +					pins = "gpio93", "gpio94";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c8_default: qup-i2c8-default {
> +				pinmux {
> +					pins = "gpio65", "gpio66";
> +					function = "qup8";
> +				};
> +			};
> +
> +			qup_i2c8_sleep: qup-i2c8-sleep {
> +				pinmux {
> +					pins = "gpio65", "gpio66";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c9_default: qup-i2c9-default {
> +				pinmux {
> +					pins = "gpio6", "gpio7";
> +					function = "qup9";
> +				};
> +			};
> +
> +			qup_i2c9_sleep: qup-i2c9-sleep {
> +				pinmux {
> +					pins = "gpio6", "gpio7";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c10_default: qup-i2c10-default {
> +				pinmux {
> +					pins = "gpio55", "gpio56";
> +					function = "qup10";
> +				};
> +			};
> +
> +			qup_i2c10_sleep: qup-i2c10-sleep {
> +				pinmux {
> +					pins = "gpio55", "gpio56";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c11_default: qup-i2c11-default {
> +				pinmux {
> +					pins = "gpio31", "gpio32";
> +					function = "qup11";
> +				};
> +			};
> +
> +			qup_i2c11_sleep: qup-i2c11-sleep {
> +				pinmux {
> +					pins = "gpio31", "gpio32";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c12_default: qup-i2c12-default {
> +				pinmux {
> +					pins = "gpio49", "gpio50";
> +					function = "qup12";
> +				};
> +			};
> +
> +			qup_i2c12_sleep: qup-i2c12-sleep {
> +				pinmux {
> +					pins = "gpio49", "gpio50";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c13_default: qup-i2c13-default {
> +				pinmux {
> +					pins = "gpio105", "gpio106";
> +					function = "qup13";
> +				};
> +			};
> +
> +			qup_i2c13_sleep: qup-i2c13-sleep {
> +				pinmux {
> +					pins = "gpio105", "gpio106";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c14_default: qup-i2c14-default {
> +				pinmux {
> +					pins = "gpio33", "gpio34";
> +					function = "qup14";
> +				};
> +			};
> +
> +			qup_i2c14_sleep: qup-i2c14-sleep {
> +				pinmux {
> +					pins = "gpio33", "gpio34";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_i2c15_default: qup-i2c15-default {
> +				pinmux {
> +					pins = "gpio81", "gpio82";
> +					function = "qup15";
> +				};
> +			};
> +
> +			qup_i2c15_sleep: qup-i2c15-sleep {
> +				pinmux {
> +					pins = "gpio81", "gpio82";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi0_default: qup-spi0-default {
> +				pinmux {
> +					pins = "gpio0", "gpio1",
> +					       "gpio2", "gpio3";
> +					function = "qup0";
> +				};
> +			};
> +
> +			qup_spi0_sleep: qup-spi0-sleep {
> +				pinmux {
> +					pins = "gpio0", "gpio1",
> +					       "gpio2", "gpio3";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi1_default: qup-spi1-default {
> +				pinmux {
> +					pins = "gpio17", "gpio18",
> +					       "gpio19", "gpio20";
> +					function = "qup1";
> +				};
> +			};
> +
> +			qup_spi1_sleep: qup-spi1-sleep {
> +				pinmux {
> +					pins = "gpio17", "gpio18",
> +					       "gpio19", "gpio20";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi2_default: qup-spi2-default {
> +				pinmux {
> +					pins = "gpio27", "gpio28",
> +					       "gpio29", "gpio30";
> +					function = "qup2";
> +				};
> +			};
> +
> +			qup_spi2_sleep: qup-spi2-sleep {
> +				pinmux {
> +					pins = "gpio27", "gpio28",
> +					       "gpio29", "gpio30";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi3_default: qup-spi3-default {
> +				pinmux {
> +					pins = "gpio41", "gpio42",
> +					       "gpio43", "gpio44";
> +					function = "qup3";
> +				};
> +			};
> +
> +			qup_spi3_sleep: qup-spi3-sleep {
> +				pinmux {
> +					pins = "gpio41", "gpio42",
> +					       "gpio43", "gpio44";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi4_default: qup-spi4-default {
> +				pinmux {
> +					pins = "gpio89", "gpio90",
> +					       "gpio91", "gpio92";
> +					function = "qup4";
> +				};
> +			};
> +
> +			qup_spi4_sleep: qup-spi4-sleep {
> +				pinmux {
> +					pins = "gpio89", "gpio90",
> +					       "gpio91", "gpio92";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi5_default: qup-spi5-default {
> +				pinmux {
> +					pins = "gpio85", "gpio86",
> +					       "gpio87", "gpio88";
> +					function = "qup5";
> +				};
> +			};
> +
> +			qup_spi5_sleep: qup-spi5-sleep {
> +				pinmux {
> +					pins = "gpio85", "gpio86",
> +					       "gpio87", "gpio88";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi6_default: qup-spi6-default {
> +				pinmux {
> +					pins = "gpio45", "gpio46",
> +					       "gpio47", "gpio48";
> +					function = "qup6";
> +				};
> +			};
> +
> +			qup_spi6_sleep: qup-spi6-sleep {
> +				pinmux {
> +					pins = "gpio45", "gpio46",
> +					       "gpio47", "gpio48";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi7_default: qup-spi7-default {
> +				pinmux {
> +					pins = "gpio93", "gpio94",
> +					       "gpio95", "gpio96";
> +					function = "qup7";
> +				};
> +			};
> +
> +			qup_spi7_sleep: qup-spi7-sleep {
> +				pinmux {
> +					pins = "gpio93", "gpio94",
> +					       "gpio95", "gpio96";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi8_default: qup-spi8-default {
> +				pinmux {
> +					pins = "gpio65", "gpio66",
> +					       "gpio67", "gpio68";
> +					function = "qup8";
> +				};
> +			};
> +
> +			qup_spi8_sleep: qup-spi8-sleep {
> +				pinmux {
> +					pins = "gpio65", "gpio66",
> +					       "gpio67", "gpio68";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi9_default: qup-spi9-default {
> +				pinmux {
> +					pins = "gpio6", "gpio7",
> +					       "gpio4", "gpio5";
> +					function = "qup9";
> +				};
> +			};
> +
> +			qup_spi9_sleep: qup-spi9-sleep {
> +				pinmux {
> +					pins = "gpio6", "gpio7",
> +					       "gpio4", "gpio5";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi10_default: qup-spi10-default {
> +				pinmux {
> +					pins = "gpio55", "gpio56",
> +					       "gpio53", "gpio54";
> +					function = "qup10";
> +				};
> +			};
> +
> +			qup_spi10_sleep: qup-spi10-sleep {
> +				pinmux {
> +					pins = "gpio55", "gpio56",
> +					       "gpio53", "gpio54";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi11_default: qup-spi11-default {
> +				pinmux {
> +					pins = "gpio31", "gpio32",
> +					       "gpio33", "gpio34";
> +					function = "qup11";
> +				};
> +			};
> +
> +			qup_spi11_sleep: qup-spi11-sleep {
> +				pinmux {
> +					pins = "gpio31", "gpio32",
> +					       "gpio33", "gpio34";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi12_default: qup-spi12-default {
> +				pinmux {
> +					pins = "gpio49", "gpio50",
> +					       "gpio51", "gpio52";
> +					function = "qup12";
> +				};
> +			};
> +
> +			qup_spi12_sleep: qup-spi12-sleep {
> +				pinmux {
> +					pins = "gpio49", "gpio50",
> +					       "gpio51", "gpio52";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi13_default: qup-spi13-default {
> +				pinmux {
> +					pins = "gpio105", "gpio106",
> +					       "gpio107", "gpio108";
> +					function = "qup13";
> +				};
> +			};
> +
> +			qup_spi13_sleep: qup-spi13-sleep {
> +				pinmux {
> +					pins = "gpio105", "gpio106",
> +					       "gpio107", "gpio108";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi14_default: qup-spi14-default {
> +				pinmux {
> +					pins = "gpio33", "gpio34",
> +					       "gpio31", "gpio32";
> +					function = "qup14";
> +				};
> +			};
> +
> +			qup_spi14_sleep: qup-spi14-sleep {
> +				pinmux {
> +					pins = "gpio33", "gpio34",
> +					       "gpio31", "gpio32";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_spi15_default: qup-spi15-default {
> +				pinmux {
> +					pins = "gpio81", "gpio82",
> +					       "gpio83", "gpio84";
> +					function = "qup15";
> +				};
> +			};
> +
> +			qup_spi15_sleep: qup-spi15-sleep {
> +				pinmux {
> +					pins = "gpio81", "gpio82",
> +					       "gpio83", "gpio84";
> +					function = "gpio";
> +				};
> +			};
> +
> +			qup_uart9_default: qup-uart9-default {
> +				pinmux {
> +					pins = "gpio4", "gpio5";
> +					function = "qup9";
> +				};
> +			};
> +
> +			qup_uart9_sleep: qup-uart9-sleep {
> +				pinmux {
> +					pins = "gpio4", "gpio5";
> +					function = "gpio";
> +				};
> +			};
>  		};
>  
>  		spmi_bus: spmi@c440000 {
> -- 
> 2.17.1.1185.g55be947832-goog
> 
