Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489EDC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156A02082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156A02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeLJVf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:35:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54747 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbeLJVf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:35:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0B9F520733; Mon, 10 Dec 2018 22:35:54 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id AB6EC20510;
        Mon, 10 Dec 2018 22:35:53 +0100 (CET)
Date:   Mon, 10 Dec 2018 22:35:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Cyrille.Pitchen@microchip.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-mtd@lists.infradead.org, broonie@kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Message-ID: <20181210213553.GK8952@piout.net>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210171511.21002-1-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/2018 17:15:29+0000, Tudor.Ambarus@microchip.com wrote:
> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> 
> This patch configures the QSPI0 controller pin muxing and declares
> a jedec,spi-nor memory.
> 
> sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> memory which advertises a maximum frequency of 80MHz for Quad IO
> Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> [tudor.ambarus@microchip.com:
> - drop partitions,
> - add spi-rx/tx-bus-width
> - change spi-max-frequency to match the 80MHz limit advertised by
>   MX25L25673G for Quad IO Fast Read,
> - reword commit message and subject.]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 518e2b095ccf..171bc82cfbbf 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -108,6 +108,21 @@
>  		};
>  
>  		apb {
> +			qspi0: spi@f0020000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_qspi0_default>;
> +				/* status = "okay"; */ /* conflict with sdmmc1 */

Isn't that conflicting then because I think the default is okay.

> +
> +				flash@0 {
> +					compatible = "jedec,spi-nor";
> +					reg = <0>;
> +					spi-max-frequency = <80000000>;
> +					spi-tx-bus-width = <4>;
> +					spi-rx-bus-width = <4>;
> +					m25p,fast-read;
> +				};
> +			};
> +
>  			spi0: spi@f8000000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_spi0_default>;
> @@ -485,6 +500,22 @@
>  					bias-disable;
>  				};
>  
> +				pinctrl_qspi0_default: qspi0_default {
> +					sck_cs {
> +						pinmux = <PIN_PA22__QSPI0_SCK>,
> +							 <PIN_PA23__QSPI0_CS>;
> +						bias-disable;
> +					};
> +
> +					data {
> +						pinmux = <PIN_PA24__QSPI0_IO0>,
> +							 <PIN_PA25__QSPI0_IO1>,
> +							 <PIN_PA26__QSPI0_IO2>,
> +							 <PIN_PA27__QSPI0_IO3>;
> +						bias-pull-up;
> +					};
> +				};
> +
>  				pinctrl_sdmmc0_default: sdmmc0_default {
>  					cmd_data {
>  						pinmux = <PIN_PA1__SDMMC0_CMD>,
> -- 
> 2.9.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
