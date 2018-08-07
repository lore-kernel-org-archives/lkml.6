Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67791C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E8921946
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E8921946
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbeHGJc5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:32:57 -0400
Received: from hermes.aosc.io ([199.195.250.187]:55204 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbeHGJc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:32:56 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id A298A59FC4;
        Tue,  7 Aug 2018 07:19:47 +0000 (UTC)
Date:   Tue, 07 Aug 2018 15:19:33 +0800
In-Reply-To: <20180807071839.25305-1-jagan@amarulasolutions.com>
References: <20180807071839.25305-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet support
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
CC:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <2D1B8773-0019-458A-8C7E-20077AA27AD4@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年8月7日 GMT+08:00 下午3:18:39, Jagan Teki <jagan@amarulasolutions.com> 写到:
>Add Ethernet support for orangepi-one-plus board,
>- Ethernet port connected via RTL8211E PHY
>- GMAC_EN is connected via PD6
>- GMAC-3V supplied from ALDO2 regulator

Is the prequisite patchset merged?

>
>Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>---
> .../allwinner/sun50i-h6-orangepi-one-plus.dts | 29 +++++++++++++++++++
> 1 file changed, 29 insertions(+)
>
>diff --git
>a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>index 0612c19cd994..eca5b7ea0d6d 100644
>--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>@@ -21,6 +21,35 @@
> 	chosen {
> 		stdout-path = "serial0:115200n8";
> 	};
>+
>+	reg_gmac_3v3: gmac-3v3 {
>+		compatible = "regulator-fixed";
>+		regulator-name = "vcc-gmac-3v3";
>+		regulator-min-microvolt = <3300000>;
>+		regulator-max-microvolt = <3300000>;
>+		startup-delay-us = <100000>;
>+		enable-active-high;
>+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
>+		vin-supply = <&reg_aldo2>;
>+	};
>+};
>+
>+&emac {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&ext_rgmii_pins>;
>+	phy-mode = "rgmii";
>+	phy-handle = <&ext_rgmii_phy>;
>+	phy-supply = <&reg_gmac_3v3>;
>+	allwinner,rx-delay-ps = <200>;
>+	allwinner,tx-delay-ps = <200>;
>+	status = "okay";
>+};
>+
>+&mdio {
>+	ext_rgmii_phy: ethernet-phy@1 {
>+		compatible = "ethernet-phy-ieee802.3-c22";
>+		reg = <1>;
>+	};
> };
> 
> &mmc0 {
