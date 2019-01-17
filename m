Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D52C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C0120859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2LUWinA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfAQT2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:28:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfAQT2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:28:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so5185270plq.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aSBFOaETi2pvgqk6PoYVqjJntpLMNqgedgZtyevDD94=;
        b=m2LUWinAdi/hyXJav2ZWhU7MZeYD8XABUXDp9+4gAjSy1HUJiyOP56b+wP3puVWdyx
         7paeZPXCkCLy6Nl/U2f88EVX8Mg1YWjDNjTVl3hnGHJImeNofp3x+OSxKuN5LjjLtwko
         lcPxuiWS8O8VJ8o4BOEQhR0ahKBAb5JUe0BIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aSBFOaETi2pvgqk6PoYVqjJntpLMNqgedgZtyevDD94=;
        b=NQkz6XEWaEV1lZIrxxdGxRU7d/yXsGrGhanr+/j6MaSygbKPOg2dcKqh1skxuXU+W3
         W6RiUHLFJNbTU4Nn49gxCR1GrgshggMkDIzISTgP2WuNMoaoMuKPscdMbdMUrr2hbSVd
         UoY9cF6Gjh8eSOlL8thxPE9QeW3lk0BfIfn81zAfz2ROejfybiZ7YGEwMJO6j9704Wng
         XzEFqwxuZgKm/8M5KqhDLuIeTu7L+Qra7Emq3sCSA3IUEE/B9+cr2J6W/U1zKaCKmP+k
         RQdzPCIuw7U1WaIx3ZJT0574lGJB904Mxb49jpg4UKUdAN7mBryzBVJBeVWABxb4m81y
         cBQg==
X-Gm-Message-State: AJcUukfXK/g+tJrskdzeObSM8APzHZlRSLrWHvk9tQRDI7aq/Wxx+Gx2
        hUDJWVbOqVZqODYvp00sSxjogg==
X-Google-Smtp-Source: ALg8bN6WocsU1DDW6A8+dpGqtU7F3RhnCu2iwt+JlfAStoT5FzNHl1fnyY7I+rucWTZFfYYkjdV+/g==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr16213899plz.110.1547753294065;
        Thu, 17 Jan 2019 11:28:14 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y184sm3810482pgd.71.2019.01.17.11.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 11:28:13 -0800 (PST)
Date:   Thu, 17 Jan 2019 11:28:12 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Add WCN3990 BT node
Message-ID: <20190117192812.GV261387@google.com>
References: <20190117044006.12463-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117044006.12463-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 08:40:06PM -0800, Bjorn Andersson wrote:
> The SDM845 MTP has a WCN3990 Bluetooth chip on UART6, enable this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 44 +++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index af8c6a2445a2..f65d5a674103 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -17,6 +17,7 @@
>  
>  	aliases {
>  		serial0 = &uart9;
> +		hsuart0 = &uart6;
>  	};
>  
>  	chosen {
> @@ -357,6 +358,10 @@
>  	clock-frequency = <400000>;
>  };
>  
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
>  &qupv3_id_1 {
>  	status = "okay";
>  };
> @@ -373,6 +378,20 @@
>  	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
>  };
>  
> +&uart6 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
>  &uart9 {
>  	status = "okay";
>  };
> @@ -470,6 +489,31 @@
>  	};
>  };
>  
> +&qup_uart6_default {
> +	pinmux {
> +		pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +		function = "qup6";
> +	};
> +
> +	ctsrx {
> +		pins = "gpio45", "gpio48";
> +		drive-strength = <2>;

CTS and RX are input signals, no need to configure drive strength in
this case IIUC.

> +		bias-no-pull;

On another SDM845 based device we observe garbage on RX at
initialization time, unless we enable a pull-up.

> +	};
> +
> +	rts {
> +		pins = "gpio46";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};

On our device we don't configure a pull on the lines driven by the
AP. I think a pull-down on RTS should be fine though since it matches
the pull (during reset) on CTS of the BT module.

> +	tx {
> +		pins = "gpio47";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};

Similar to RTS, the pull matches the one on RXD of the BT module.

For reference, this is what we currently use on our device:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1391888/3/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi

Cheers

Matthias
