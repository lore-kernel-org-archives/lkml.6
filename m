Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509E2250F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MqmwYGlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C509E2250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387854AbeKOVT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:19:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41473 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeKOVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:19:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id e22-v6so9533131pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 03:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vbop7OBClJCjHFIGAS9SchFiWVOUl+A2vrJQpE6xDgg=;
        b=MqmwYGlCZvrs+wFca/CvXCN/dDPkgaHpKRhTAXgTyjm7SO5PWBqkYXhY52NN2pOtt7
         FgUdlxZshkkyhsDTyxBhp1VBdIaXujfvJJ9pfoh3XmuBjlwMJwQBypTrteDrqF/BVqEL
         6ktLDPFBECMqAgh6cIasWoeBiTdCP3pzJ0ZGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vbop7OBClJCjHFIGAS9SchFiWVOUl+A2vrJQpE6xDgg=;
        b=hhi2YzgkPgC/fWS+Y59frqBDzehFSxu5hQtjAhlYkBugW6uOY/Km0rdtKRlnKL1Nmz
         q90NKetoreQVo9s6pNhdvpEdo0Z2/CvKjG3GCdyzLlxSpwkjMBI+UohAPih5zYXfuVrv
         n8UrTnP50SJkLi68UkabtyGRAMP0XKjLTuxUFyxW1hd+TDLthXpqvdXwhDE3gy5c1HSi
         7GHx4POMQheXbYLM1SMskZFt8g5PlqKYTW1Up1QI7JU0DkO7A7sYkGHooiH09/YEl8Gb
         K0Nkpf0JXanqLCFwULbwdaydOViqRh9w+iJkff6NsMA3d1KrFuAj4u8wX2ycVci9SMpz
         8V8A==
X-Gm-Message-State: AGRZ1gJH5/A8jGuwYTBrI0zfHEVyQUBfM414x5vHRV+H2H/Xa4q7qTI8
        TSMnsrHSTu4MzK2BzSzfkzaG
X-Google-Smtp-Source: AJdET5eNKEk7WQhf1e+rEgCmNG9nmwOMPIU6pAdtoPHqVKk7satIkNmxuNFgfI33rJUQMzpt8ZNsvg==
X-Received: by 2002:a63:4101:: with SMTP id o1mr5308155pga.447.1542280353861;
        Thu, 15 Nov 2018 03:12:33 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:908:5dae:cd7f:9353:9ed0:7488])
        by smtp.gmail.com with ESMTPSA id 19sm4821432pfs.108.2018.11.15.03.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 03:12:33 -0800 (PST)
Date:   Thu, 15 Nov 2018 16:42:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: actions: s700: Add I2C controller nodes
Message-ID: <20181115111217.GC15537@Mani-XPS-13-9360>
References: <20181113133235.37754-1-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113133235.37754-1-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parthiban,

On Tue, Nov 13, 2018 at 02:32:35PM +0100, Parthiban Nallathambi wrote:
> Add I2C controller nodes for Actions Semiconductor S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 192c7b39c8c1..573c844d7afe 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -174,6 +174,46 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		i2c0: i2c@e0170000 {
> +			compatible = "actions,s900-i2c";

Why don't you add a compatible for S700? Also, please add the pinctrl
nodes for these busses and enable the ones exposed on board. These could
go in a separate patch.

Thanks,
Mani

> +			reg = <0 0xe0170000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C0>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@e0174000 {
> +			compatible = "actions,s900-i2c";
> +			reg = <0 0xe0174000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C1>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@e0178000 {
> +			compatible = "actions,s900-i2c";
> +			reg = <0 0xe0178000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C2>;
> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@e017c000 {
> +			compatible = "actions,s900-i2c";
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
