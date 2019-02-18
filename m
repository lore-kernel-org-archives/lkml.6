Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3802DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E85320645
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfBRNFN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:05:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33617 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfBRNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:05:13 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id F4131CF2C7;
        Mon, 18 Feb 2019 14:13:04 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/6] dt-bindings: net: bluetooth: add support for MediaTek
 MT7663U and MT7668U UART devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
Date:   Mon, 18 Feb 2019 14:05:11 +0100
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <0EF74A38-3D1F-4BD1-9B72-78E8720C125D@holtmann.org>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Update binding document with adding support of MT7663U and MT7668U UART
> devices to mediatek-bluetooth.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> .../bindings/net/mediatek-bluetooth.txt       | 64 +++++++++++++++++++
> 1 file changed, 64 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> index 14ceb2a5b4e8..41a7dcc80f5b 100644
> --- a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> @@ -33,3 +33,67 @@ Example:
> 			clock-names = "ref";
> 		};
> 	};
> +
> +MediaTek UART based Bluetooth Devices
> +==================================
> +
> +This device is a serial attached device to UART device and thus it must be a
> +child node of the serial node with UART.
> +
> +Please refer to the following documents for generic properties:
> +
> +	Documentation/devicetree/bindings/serial/slave-device.txt
> +
> +Required properties:
> +
> +- compatible:	Must be
> +		  "mediatek,mt7663u-bluetooth": for MT7663U device
> +		  "mediatek,mt7668u-bluetooth": for MT7668U device
> +- vcc-supply:	Main voltage regulator
> +- pinctrl-names: Should be "default", "runtime"
> +- pinctrl-0: Should contain UART RXD low when the device is powered up to
> +	     enter proper bootstrap mode.
> +- pinctrl-1: Should contain UART mode pin ctrl
> +
> +Optional properties:
> +
> +- reset-gpios:	GPIO used to reset the device whose initial state keeps low,
> +		if the GPIO is missing, then board-level design should be
> +		guaranteed.
> +- current-speed:  Current baud rate of the device whose defaults to 921600
> +
> +Example:
> +
> +	uart1_pins_boot: uart1-default {
> +		pins-dat {
> +			pinmux = <MT7623_PIN_81_URXD1_FUNC_GPIO81>;
> +			output-low;
> +		};
> +	};
> +
> +	uart1_pins_runtime: uart1-runtime {
> +		pins-dat {
> +			pinmux = <MT7623_PIN_81_URXD1_FUNC_URXD1>,
> +				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
> +		};
> +	};
> +
> +	uart1: serial@11003000 {
> +		compatible = "mediatek,mt7623-uart",
> +			     "mediatek,mt6577-uart";
> +		reg = <0 0x11003000 0 0x400>;
> +		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_UART1_SEL>,
> +			 <&pericfg CLK_PERI_UART1>;
> +		clock-names = "baud", "bus";
> +
> +		bluetooth {
> +			compatible = "mediatek,mt7663u-bluetooth";
> +			vcc-supply = <&reg_5v>;
> +			reset-gpios = <&pio 24 GPIO_ACTIVE_LOW>;
> +			pinctrl-names = "default", "runtime";
> +			pinctrl-0 = <&uart1_pins_boot>;
> +			pinctrl-1 = <&uart1_pins_runtime>;
> +			current-speed = <921600>;
> +		};
> +	};

can you ACK this please.

Regards

Marcel

