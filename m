Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1042086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qs57w5LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1042086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeLJNu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:50:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34479 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbeLJNuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:50:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so5438639pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SBdbElkSsuxiJQRSGESbx+Xf6yhcdgnkMiGKWGdWGtE=;
        b=Qs57w5LXNjqnx9UvhDeVj6IrtrtMq9/C/EfYG6BTG3ghpnTZw2sPO0x5OiTZPNcIkL
         m7VhJBdtrtt2Myz4ZX3pW4QpESDBOtjnis+3GDcmTCRmGlLR1aSVLIa3MU3e3NqM0HLX
         lISs05220aRBKxgBlMTwGdhszyVAyBN7h3gRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBdbElkSsuxiJQRSGESbx+Xf6yhcdgnkMiGKWGdWGtE=;
        b=TBE9daQq7GDq6IIiw2LEQU60U62coWfANLn8h4h+o7T76USlR0rVxDF9yKzCW/1TLq
         oHN7ocZYusu5/iA3xNozFmfn8UCzc9wrrDBol0PdnI/n+i7ZM4iw0lBpcvgoKiYduNZO
         34GSjvTr5ofIF6GXtSEp0DgI3RUptP32xMm5InVo6AhBmKQoYQivPidfgEIeGY75UrWz
         M8dF4sMB0fRuybgW3JaAHVJPGILu7hkiPeiGYAKfxcx0r4CeZIaFtOy+fgTolCuI7M0d
         QqchQDbyiZ+xKxplabh1OGf+caWi7EN7IvjHz7yZmYzFoHeKNtok5BHh9AxG9PqllUhp
         85qg==
X-Gm-Message-State: AA+aEWbF1Xn48mfRmddU1KR6iXr/It20wkZxuNIW+5tzLyczFVY4u0AV
        +6Gn3bPNrrtgS3NIS88eeRgC
X-Google-Smtp-Source: AFSGD/WRN9DxD23CGCXNxUtHE5bj28B4H5f9z//4I4qwP2cN265CKncSfDaHUKTyJ/a/WhZkBwsGCQ==
X-Received: by 2002:a63:7a5b:: with SMTP id j27mr10963759pgn.112.1544449854687;
        Mon, 10 Dec 2018 05:50:54 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id e65sm22571248pfc.74.2018.12.10.05.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 05:50:53 -0800 (PST)
Date:   Mon, 10 Dec 2018 19:20:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com,
        wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@cubietech.com,
        thomas.liau@actions-semi.com
Subject: Re: [PATCH v2 4/4] arm64: dts: actions: s700-cubieboard7: Enable
 I2C0 and I2C1
Message-ID: <20181210135044.GC25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-5-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-5-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parthiban,

On Mon, Nov 26, 2018 at 07:58:21PM +0100, Parthiban Nallathambi wrote:
> Add pinctrl definitions for Actions Semiconductor S700 I2C controllers.
> Pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> Enable I2C0 (PMIC), I2C1 (gyro, touchscreen) in cubieboard7.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 28f3f4a0f7f0..6a75fdd7ab42 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -37,3 +37,56 @@
>  &uart3 {
>  	status = "okay";
>  };
> +
> +&i2c0 {

On the board DTS, node names should be sorted alphabetically!

Regards,
Mani

> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_default>;
> +};
> +
> +&pinctrl {
> +	i2c0_default: i2c0_default {
> +		pinmux {
> +			groups = "i2c0_mfp";
> +			function = "i2c0";
> +		};
> +		pinconf {
> +			pins = "i2c0_sclk", "i2c0_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c1_default: i2c1_default {
> +		pinmux {
> +			groups = "i2c1_dummy";
> +			function = "i2c1";
> +		};
> +		pinconf {
> +			pins = "i2c1_sclk", "i2c1_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c2_default: i2c2_default {
> +		pinmux {
> +			groups = "i2c2_dummy";
> +			function = "i2c2";
> +		};
> +		pinconf {
> +			pins = "i2c2_sclk", "i2c2_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +};
> -- 
> 2.17.2
> 
