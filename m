Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A082C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1EE214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fywhEGYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1EE214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeK2KKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:10:46 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33440 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeK2KKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:10:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so8587plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EqIR3mp4uDaNPdFFcNsqIVSIQrY2TsDavzNLzryRS2c=;
        b=fywhEGYXB6/+PckTqoUAeXaYP5LceQZk/CzyeVMn236gfHUF/AuA9A/4tiXatZ65/s
         c4V4TPPJuNnIWeDrFJyyRrVu+PIf9Ywu4G69z7YVon4ZDn7GKMHeHEuwU2O3T1Vr8sl3
         G+KQFkYtzr40w0zJCrBf74GyHFtSzbaeqgekE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EqIR3mp4uDaNPdFFcNsqIVSIQrY2TsDavzNLzryRS2c=;
        b=cVAcNp4YNZMxMRl7eo76r8bnNT6MQszZVknLvicScptyWVkIFi8kA66uYmEVb6S7If
         gaYt3xwglkOxEBDlcKImH4kXkYu59iouP05xVkKhf9vK/QvuxoSVN1lXCq21Os7C2uPN
         GH4nv4Xp2aM2qBXw3PuXiKStWsETkGIQIgR3UsAcyih6HccT1HJB7zKhYf9yJyem/ZA4
         R9nIngysMKMvjQ4sXhyP1vrgUsr6H7/eOWoL+1wRPnLjJnisekWrXXeldO8AFyc1PfSo
         Klo8phHHvaIwfPETG7WXhn81Nf7NTw1R/quX9+MNwAD8TWRIEVDTcxHVvhu8w9yvo3Ko
         Y1AQ==
X-Gm-Message-State: AA+aEWapJ3660tw4G1ipph/qjK+gqRgPaQnq9/3LQGQG1GNN20Ulhp3m
        6KYbz1wwj9OWb7mLNYQtXyy2gA==
X-Google-Smtp-Source: AFSGD/VzXTbB2hF0WCx4CGN38PDhaCipVcPfQ2U/hx16J9qdLFaBpP4a6rkX7wO7RtfdvRP9JV4b+w==
X-Received: by 2002:a17:902:7e44:: with SMTP id a4mr38934705pln.338.1543446450717;
        Wed, 28 Nov 2018 15:07:30 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w10sm7325620pgi.81.2018.11.28.15.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 15:07:30 -0800 (PST)
Date:   Wed, 28 Nov 2018 15:07:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-hammerhead: add WiFi support
Message-ID: <20181128230727.GC24969@minitux>
References: <20181104215034.3677-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181104215034.3677-1-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 04 Nov 13:50 PST 2018, Brian Masney wrote:

> From: Jonathan Marek <jonathan@marek.ca>
> 
> This patch adds WiFi support to the LG Nexus 5 (hammerhead) phone.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> [masneyb@onstation.org: Enabled wlan_regulator_pin and wlan_sleep_clk_pin]
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> index fe2b5524a679..7fad5a48d4a3 100644
> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -221,6 +221,20 @@
>  			};
>  		};
>  	};
> +
> +	vreg_wlan: wlan-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "wl-reg";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wlan_regulator_pin>;
> +	};
>  };
>  
>  &soc {
> @@ -253,6 +267,20 @@
>  			};
>  		};
>  
> +		sdhc2_pin_a: sdhc2-pin-active {
> +			clk {
> +				pins = "sdc2_clk";
> +				drive-strength = <6>;
> +				bias-disable;
> +			};
> +
> +			cmd-data {
> +				pins = "sdc2_cmd", "sdc2_data";
> +				drive-strength = <6>;
> +				bias-pull-up;
> +			};
> +		};
> +
>  		i2c3_pins: i2c3 {
>  			mux {
>  				pins = "gpio10", "gpio11";
> @@ -324,6 +352,32 @@
>  		pinctrl-0 = <&sdhc1_pin_a>;
>  	};
>  
> +	sdhci@f98a4900 {
> +		status = "ok";
> +
> +		max-frequency = <100000000>;
> +		bus-width = <4>;
> +		non-removable;
> +		vmmc-supply = <&vreg_wlan>;
> +		vqmmc-supply = <&pm8941_s3>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sdhc2_pin_a>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		bcrmf@1 {
> +			compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";
> +			reg = <1>;
> +
> +			brcm,drive-strength = <10>;
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wlan_sleep_clk_pin>;
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		input-name = "gpio-keys";
> @@ -463,6 +517,22 @@
>  				output-high;
>  				line-name = "otg-gpio";
>  			};
> +
> +			wlan_sleep_clk_pin: wl-sleep-clk {
> +				pins = "gpio16";
> +				function = "func2";
> +
> +				output-high;
> +				power-source = <PM8941_GPIO_S3>;
> +			};
> +
> +			wlan_regulator_pin: wl-reg-active {
> +				pins = "gpio17";
> +				function = "normal";
> +
> +				bias-disable;
> +				power-source = <PM8941_GPIO_S3>;
> +			};
>  		};
>  	};
>  };
> -- 
> 2.17.2
> 
