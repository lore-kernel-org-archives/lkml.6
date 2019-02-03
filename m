Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6424CC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1362083B
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 09:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBCJGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 04:06:45 -0500
Received: from gloria.sntech.de ([185.11.138.130]:53296 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfBCJGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 04:06:45 -0500
Received: from [164.15.244.47] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gqDjb-0001LR-FP; Sun, 03 Feb 2019 10:06:39 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add HDMI sound node for rk3328-rock64
Date:   Sun, 03 Feb 2019 10:06:38 +0100
Message-ID: <1970132.3b67tCGWFf@phil>
In-Reply-To: <20190202043444.9308-1-katsuhiro@katsuster.net>
References: <20190202043444.9308-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 2. Februar 2019, 05:34:44 CET schrieb Katsuhiro Suzuki:
> This patch adds HDMI sound (I2S0) node and remove dma properties
> from UART2 node for rock64.
> 
> The DMAC of rk3328 can use 8 channels at same time. Currently, total
> 7 channels are used as follows:
>   - I2S1  2ch
>   - UART2 2ch
>   - SPDIF 1ch
>   - SPI0  2ch
> 
> HDMI audio using I2S0 that requires 2ch but DMAC has only 1 channel.
> 
> UART2 can work without DMA resources, so this patch removes dma
> allocation for UART2 and reuses it to I2S0.

I don't follow that description. How can i2s0 re-use the uart2 dma channels?
Looking at the dma table in the TRM, uart2 has channels 6+7 while i2s0
uses channels 11+12. They should just run concurrently?

> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 24 ++++++++++++++++++-
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |  1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 2157a528276b..e21645aa3fa5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -68,7 +68,8 @@
>  	sound {
>  		compatible = "audio-graph-card";
>  		label = "rockchip,rk3328";
> -		dais = <&i2s1_p0
> +		dais = <&i2s0_p0
> +			&i2s1_p0
>  			&spdif_p0>;
>  	};
>  
> @@ -141,6 +142,12 @@
>  
>  &hdmi {
>  	status = "okay";
> +
> +	port@0 {
> +		hdmi_p0_0: endpoint {
> +			remote-endpoint = <&i2s0_p0_0>;
> +		};
> +	};
>  };
>  
>  &hdmiphy {
> @@ -256,6 +263,18 @@
>  	};
>  };
>  
> +&i2s0 {
> +	status = "okay";
> +
> +	i2s0_p0: port {
> +		i2s0_p0_0: endpoint {
> +			dai-format = "i2s";
> +			mclk-fs = <256>;
> +			remote-endpoint = <&hdmi_p0_0>;
> +		};
> +	};
> +};
> +
>  &i2s1 {
>  	status = "okay";
>  
> @@ -343,6 +362,9 @@
>  
>  &uart2 {
>  	status = "okay";
> +
> +	/delete-property/ dmas;
> +	/delete-property/ dma-names;
>  };
>  
>  &u2phy {
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 84f14b132e8f..374b5da93a35 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -665,6 +665,7 @@
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&hdmi_cec &hdmii2c_xfer &hdmi_hpd>;
>  		rockchip,grf = <&grf>;
> +		#sound-dai-cells = <0>;

please make that a separate patch


Heiko


