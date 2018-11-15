Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46758C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69F22360
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="He4lhJft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F69F22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeKOMcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:32:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38826 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeKOMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:32:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so8267798pgq.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 18:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlHRBdmnaokTvH0NNtZ7xsPt+df2RrAUVeSJ3X3NGv8=;
        b=He4lhJftN0JnqSl5KA3MvNGhCvjLqzTvQJM5E7GyYKA0s3mgOUFCoFHQSXs0OtVemT
         bWzFworYBsdDXKW1+KXfR/Fi9adZD3bD5u0BLfrjLffmZoHgNCxeP8ucCrzJzwPKx8yo
         jVHPQlthpyBP8sR2gMlfyvybIQm+whpGTBcLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlHRBdmnaokTvH0NNtZ7xsPt+df2RrAUVeSJ3X3NGv8=;
        b=ORSmTI5ifuzw1WTxXM7x0wCIiZz/qnXe7MQ3A90vFFWJKNx+mUrcHoAbBGOoJBX521
         p8174qkNHRMT5f6l36WVO46HX/A0SWd8O999qYREyUFFmIQREjv9oYBKhTOstP2F/NNn
         hPI6RleUEUAheGUxUKJSBjisttJuzBwsEhe8Hp1O7Eox/z09M7jpurSQ+m7EVm4UuNtM
         b0L0Y9ZwzNHaYXjJmYDPcT85K0LbZdPSjVt++eGj1iohD3BywSBvoKG/xToPr0IzUEB6
         dZY4j/ZsujdCTJuYmvpevwNqyRCWf0oGQHTigpcHPLP+WjVD53ZKrSIavj9vexc8lMJq
         4hkA==
X-Gm-Message-State: AGRZ1gL20dmsISaNQcD6xPOLtCJVKJU7tDqrOY5rszZ4bFLmFd+NwAae
        s7VdLQN0JvqtEXieGI1f0U6EqA==
X-Google-Smtp-Source: AJdET5dcS2bOr8U3WVtH4wEkY7aA0hpNHSWKDIcFm/7iCrR6otj1vGaJxpUEMCoEsTOmeE8YNHmvsw==
X-Received: by 2002:a62:5793:: with SMTP id i19mr323842pfj.49.1542248815869;
        Wed, 14 Nov 2018 18:26:55 -0800 (PST)
Received: from google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id i62sm8031591pge.44.2018.11.14.18.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 18:26:54 -0800 (PST)
Date:   Wed, 14 Nov 2018 18:26:53 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     andy.gross@linaro.org, ath10k@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-wireless@vger.kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dts: arm64/sdm845: Add WCN3990 WLAN module device
 node
Message-ID: <20181115022652.GA205124@google.com>
References: <1541423318-19312-1-git-send-email-govinds@codeaurora.org>
 <1541423318-19312-3-git-send-email-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541423318-19312-3-git-send-email-govinds@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Govind,

On Mon, Nov 05, 2018 at 06:38:37PM +0530, Govind Singh wrote:
> Add device node for the ath10k SNOC platform driver probe
> and add resources required for WCN3990 on SDM845 soc.
> 
> Signed-off-by: Govind Singh <govinds@codeaurora.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Brian Norris <briannorris@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 ++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 26 ++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index eedfaf8..c062c5c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -440,3 +440,11 @@
>  		bias-pull-up;
>  	};
>  };
> +
> +&wifi {
> +	status = "okay";
> +	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
> +	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
> +};

This node should be above the PINCTRL section.

Brian

> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0..324be5b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -87,6 +87,11 @@
>  			reg = <0 0x86200000 0 0x2d00000>;
>  			no-map;
>  		};
> +
> +		wlan_msa_mem: memory@96700000 {
> +			reg = <0 0x96700000 0 0x100000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> @@ -1403,5 +1408,26 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		wifi: wifi@18800000 {
> +			compatible = "qcom,wcn3990-wifi";
> +			status = "disabled";
> +			reg = <0x18800000 0x800000>;
> +			reg-names = "membase";
> +			memory-region = <&wlan_msa_mem>;
> +			interrupts =
> +				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
