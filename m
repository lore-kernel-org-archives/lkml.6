Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDFEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F6620700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+e8iOtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfBVS1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:27:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42298 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfBVS1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:27:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id s1so1443613plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uusg/Uxs6yMAEhTeDMTAlNNExid37wE84jUbICMHDWU=;
        b=R+e8iOtXlpwpwW/cdn4RPfZRPKFzQ2snQRD4TRT9EbcCcQnfjwIx2sJ7v63v72lYaN
         xJ5PdVH6RmUufBt1kxUaDLgf/mcYf3w1mvU/j8JrSUibUM0wrwfE1Y0EPFbKeDBzmER3
         ElZll4naagXzHrt2OPPt3/MHhJkkytc27TWds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uusg/Uxs6yMAEhTeDMTAlNNExid37wE84jUbICMHDWU=;
        b=J4aF6FAC5KC+t4FefakaiFHOZ8tEdfpXGLXyTkpGFcwb4Qo2pArbOiHw5Zj1QAiGNp
         JaGXFqu6yaa+LRoGGr2y0+FeP3lCRgaYuuTa9LbhUM+Oni6Q9L834uDBFoEN24VynLg2
         thYoukiSod8Ik9I5A8o03hjyxkIi6H1dU960mZDGb4B2JLHr/fbi/mx6vxk81fpqFySE
         XdKy9kXeKCJec0Com8FVxC8w+2GD8B570WvBx40E9aWAXTMROEqUtr6ORme4fKnTM9Sq
         R+3Od0OJkimZ2Y3qd2D1N0n1600WMKwPZk0HWVYu5JsXyYRjqyVYDiVCwG/fDNvZUrPf
         7RXg==
X-Gm-Message-State: AHQUAuaFriDGuGJjLIOpgRI5LrLcsrevvS57YOeojnAzKAInc6F7bG3J
        j1UXlkKLMc9IDn5K/sDiB05KTw==
X-Google-Smtp-Source: AHgI3Iase7M0desDXFaQ9G7kJPmTDoFmJGbzw0cFVyYRVkZ96UpdUBgDXKYqgwa0O4EsqI8/Fb/pOA==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr5601113plp.80.1550860061704;
        Fri, 22 Feb 2019 10:27:41 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l22sm3743987pfj.179.2019.02.22.10.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:27:41 -0800 (PST)
Date:   Fri, 22 Feb 2019 10:27:40 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: move QCA6174A wakeup pin into
 its USB node
Message-ID: <20190222182740.GC223791@google.com>
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-3-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222003403.128243-3-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 04:34:03PM -0800, Brian Norris wrote:
> Currently, we don't coordinate BT USB activity with our handling of the
> BT out-of-band wake pin, and instead just use gpio-keys. That causes
> problems because we have no way of distinguishing wake activity due to a
> BT device (e.g., mouse) vs. the BT controller (e.g., re-configuring wake
> mask before suspend). This can cause spurious wake events just because
> we, for instance, try to reconfigure the host controller's event mask
> before suspending.
> 
> We can avoid these synchronization problems by handling the BT wake pin
> directly in the btusb driver -- for all activity up until BT controller
> suspend(), we simply listen to normal USB activity (e.g., to know the
> difference between device and host activity); once we're really ready to
> suspend the host controller, there should be no more host activity, and
> only *then* do we unmask the GPIO interrupt.
> 
> This is already supported by btusb; we just need to describe the wake
> pin in the right node.
> 
> We list 2 compatible properties, since both PID/VID pairs show up on
> Scarlet devices, and they're both essentially identical QCA6174A-based
> modules.
> 
> Also note that the polarity was wrong before: Qualcomm implemented WAKE
> as active high, not active low. We only got away with this because
> gpio-keys always reconfigured us as bi-directional edge-triggered.
> 
> Finally, we have an external pull-up and a level-shifter on this line
> (we didn't notice Qualcomm's polarity in the initial design), so we
> can't do pull-down. Switch to pull-none.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch is also required to make this stable, but since it's not
> really tied to the device tree, and it's an existing bug, I sent it
> separately:
> 
>   https://lore.kernel.org/patchwork/patch/1044896/
>   Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
> 
>  .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 13 ++++++
>  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 46 ++++++++++++-------
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 13 ------
>  3 files changed, 42 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> index c400be64170e..931640e9aed4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> @@ -200,6 +200,19 @@
>  		pinctrl-0 = <&bl_en>;
>  		pwm-delay-us = <10000>;
>  	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_host_wake_l>;
> +
> +		wake_on_bt: wake-on-bt {
> +			label = "Wake-on-Bluetooth";
> +			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WAKEUP>;
> +			wakeup-source;
> +		};
> +	};
>  };
>  
>  &ppvar_bigcpu {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> index fc50b3ef758c..3e2196c08473 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> @@ -175,6 +175,21 @@
>  		pinctrl-0 = <&dmic_en>;
>  		wakeup-delay-ms = <250>;
>  	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pen_eject_odl>;
> +
> +		pen-insert {
> +			label = "Pen Insert";
> +			/* Insert = low, eject = high */
> +			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +			linux,code = <SW_PEN_INSERTED>;
> +			linux,input-type = <EV_SW>;
> +			wakeup-source;
> +		};
> +	};
>  };
>  
>  /* pp900_s0 aliases */
> @@ -328,20 +343,6 @@ camera: &i2c7 {
>  		<400000000>;
>  };
>  
> -&gpio_keys {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&bt_host_wake_l>, <&pen_eject_odl>;
> -
> -	pen-insert {
> -		label = "Pen Insert";
> -		/* Insert = low, eject = high */
> -		gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> -		linux,code = <SW_PEN_INSERTED>;
> -		linux,input-type = <EV_SW>;
> -		wakeup-source;
> -	};
> -};
> -
>  &i2c_tunnel {
>  	google,remote-bus = <0>;
>  };
> @@ -437,8 +438,19 @@ camera: &i2c7 {
>  	status = "okay";
>  };
>  
> -&wake_on_bt {
> -	gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> +&usb_host0_ohci {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	qca_bt: bt@1 {
> +		compatible = "usb0cf3,e300", "usb04ca,301a";
> +		reg = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_host_wake_l>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "wakeup";
> +	};
>  };

I didn't know it was possible to configure (certain) USB devices
through the DT, neat!

>  
>  /* PINCTRL OVERRIDES */
> @@ -455,7 +467,7 @@ camera: &i2c7 {
>  };
>  
>  &bt_host_wake_l {
> -	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
> +	rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_none>;
>  };
>  
>  &ec_ap_int_l {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index ea607a601a86..da03fa9c5662 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -269,19 +269,6 @@
>  		#clock-cells = <0>;
>  	};
>  
> -	gpio_keys: gpio-keys {
> -		compatible = "gpio-keys";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&bt_host_wake_l>;
> -
> -		wake_on_bt: wake-on-bt {
> -			label = "Wake-on-Bluetooth";
> -			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> -			linux,code = <KEY_WAKEUP>;
> -			wakeup-source;
> -		};
> -	};
> -
>  	max98357a: max98357a {
>  		compatible = "maxim,max98357a";
>  		pinctrl-names = "default";

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
