Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14393C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0192084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxTiqO/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0192084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeLJNrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:47:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44270 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeLJNrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:47:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so5272056pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SCSftQKSNYCntANDuG/87Ss7joH+raVpHDPuPUwvWDE=;
        b=QxTiqO/+xqjwTAXygQ0QOqo9QAVSFevY+MXO/9zs/bowfpXHL30oIGU1XFC/OvPxKt
         FAD7HZlpKPEQpd40xs7M2dwrJsWMdvM4H11CRJgggzMV+eq2OAtijRoBc2GTrM3zl+NO
         IkVvcEWKarRe1e+4GBu60WIN5b850PPD0X6ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SCSftQKSNYCntANDuG/87Ss7joH+raVpHDPuPUwvWDE=;
        b=R4fE5FvyGaUc5/m83Coptv4iUsYlxmFD2LCfWP2MGKuT0IF3FIiJCICGHeeQNS5UPq
         dBgoc8rI4IfD733qUrCzU83MVaENIPyCl3gb2ft130SS1YVd9ueVcGvQFeQu2HEN3Gl3
         Edt/C60EAKAlrk7Pwf+aSyDjd5ldzOfXJcwppwRYlPbrzIm/GOqLNvYK1/UQmf9iZzW2
         jIBjjlFPwstyOf6d9YOGTBFdWaCu0yGGO9nE4Bc1EhHjJwXw1l9stlDtCB/KQF3b28lH
         /56l8yS8nF4tBafE3nNEWOyq7k8jhdpFL2laDfsPz6g+b3TJr7+1VfB+oPAImeQOlSLv
         GRZQ==
X-Gm-Message-State: AA+aEWZmFy3TewqMsRLUa0yVRyrn1YGjjQlBMphG2mMJ+Hzgta3U4i/7
        7CTvLYF+lKd6eBMVaOAuQY5/
X-Google-Smtp-Source: AFSGD/XI2quJT25IFou0wOBSlY7EkX8aJvejCDX6Mzi3k8wNaoKX+bP4FUU5Zo6f9FRUHiOz4YCZbQ==
X-Received: by 2002:a17:902:a9c4:: with SMTP id b4mr12206622plr.298.1544449668478;
        Mon, 10 Dec 2018 05:47:48 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id r4sm19503821pgn.54.2018.12.10.05.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 05:47:47 -0800 (PST)
Date:   Mon, 10 Dec 2018 19:17:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@cubietech.com,
        thomas.liau@actions-semi.com
Subject: Re: [PATCH v2 3/4] arm64: dts: actions: s700: Add I2C controller
 nodes
Message-ID: <20181210134738.GB25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-4-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-4-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 07:58:20PM +0100, Parthiban Nallathambi wrote:
> Add I2C controller nodes for Actions Semiconductor S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Ideally, dts patches should come before driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Cheers,
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
