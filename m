Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFE7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4012075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4012075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbeGRNZF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:25:05 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42801 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbeGRNZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:25:05 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 4858A9EEE7;
        Wed, 18 Jul 2018 12:46:59 +0000 (UTC)
Date:   Wed, 18 Jul 2018 20:46:28 +0800
In-Reply-To: <20180718105458.22304-8-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com> <20180718105458.22304-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 07/18] arm64: dts: allwinner: a64: Add tcon1 HDMI pipeline
To:     linux-arm-kernel@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <651D2B3B-FD6A-49DE-A11F-2A5119114AFC@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月18日 GMT+08:00 下午6:54:47, Jagan Teki <jagan@amarulasolutions.com> 写到:
>HDMI on Allwinner A64 similar behaviour like H3 with
>PHY of two clock parents (pll-0, pll-1) connected via
>second mixer and tcon.
>
>Add all require entries needed for HDMI to function.
>
>Note, that Figure 3-3.Module Clock Diagram also showing
>HDMI connected via TCON0 with PLL_VIDEO0. this can be add
>it in future once we have mixer0 pipeline.
>
>Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>---
>Changes for v3:
>- Squash all pipeline components in one patch
>- Add status for mixer1 and tcon1
>Changes for v2:
>- Change compatibles and other based on previous patch changes
>
> arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 110 ++++++++++++++++++
> 1 file changed, 110 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>index 840753432ea5..572569d8b577 100644
>--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>@@ -112,6 +112,12 @@
> 		};
> 	};
> 
>+	de: display-engine {
>+		compatible = "allwinner,sun50i-a64-display-engine";
>+		allwinner,pipelines = <&mixer1>;
>+		status = "disabled";
>+	};
>+
> 	osc24M: osc24M_clk {
> 		#clock-cells = <0>;
> 		compatible = "fixed-clock";
>@@ -196,6 +202,30 @@
> 			};
> 		};
> 
>+		mixer1: mixer@1200000 {
>+			compatible = "allwinner,sun50i-a64-de2-mixer-1";
>+			reg = <0x01200000 0x100000>;
>+			clocks = <&display_clocks CLK_BUS_MIXER1>,
>+				 <&display_clocks CLK_MIXER1>;
>+			clock-names = "bus",
>+				      "mod";
>+			resets = <&display_clocks RST_WB>;
>+			status = "disabled";
>+
>+			ports {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+
>+				mixer1_out: port@1 {
>+					reg = <1>;
>+
>+					mixer1_out_tcon1: endpoint {
>+						remote-endpoint = <&tcon1_in_mixer1>;
>+					};
>+				};
>+			};
>+		};
>+

It should be subnode of DE2 bus to get the SRAM access
managed by that driver.

> 		syscon: syscon@1c00000 {
> 			compatible = "allwinner,sun50i-a64-system-control";
> 			reg = <0x01c00000 0x1000>;
>@@ -228,6 +258,42 @@
> 			#dma-cells = <1>;
> 		};
> 
>+		tcon1: lcd-controller@1c0d000 {
>+			compatible = "allwinner,sun50i-a64-tcon-tv",
>+				     "allwinner,sun8i-a83t-tcon-tv";
>+			reg = <0x01c0d000 0x1000>;
>+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&ccu CLK_BUS_TCON1>, <&ccu CLK_TCON1>;
>+			clock-names = "ahb", "tcon-ch1";
>+			resets = <&ccu RST_BUS_TCON1>;
>+			reset-names = "lcd";
>+			status = "disabled";
>+
>+			ports {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+
>+				tcon1_in: port@0 {
>+					reg = <0>;
>+
>+					tcon1_in_mixer1: endpoint {
>+						remote-endpoint = <&mixer1_out_tcon1>;
>+					};
>+				};
>+
>+				tcon1_out: port@1 {
>+					#address-cells = <1>;
>+					#size-cells = <0>;
>+					reg = <1>;
>+
>+					tcon1_out_hdmi: endpoint@1 {
>+						reg = <1>;
>+						remote-endpoint = <&hdmi_in_tcon1>;
>+					};
>+				};
>+			};
>+		};
>+
> 		mmc0: mmc@1c0f000 {
> 			compatible = "allwinner,sun50i-a64-mmc";
> 			reg = <0x01c0f000 0x1000>;
>@@ -688,6 +754,50 @@
> 			status = "disabled";
> 		};
> 
>+		hdmi: hdmi@1ee0000 {
>+			compatible = "allwinner,sun50i-a64-dw-hdmi",
>+				     "allwinner,sun8i-a83t-dw-hdmi";
>+			reg = <0x01ee0000 0x10000>;
>+			reg-io-width = <1>;
>+			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>+				 <&ccu CLK_HDMI>;
>+			clock-names = "iahb", "isfr", "tmds";
>+			resets = <&ccu RST_BUS_HDMI1>;
>+			reset-names = "ctrl";
>+			phys = <&hdmi_phy>;
>+			phy-names = "hdmi-phy";
>+			status = "disabled";
>+
>+			ports {
>+				#address-cells = <1>;
>+				#size-cells = <0>;
>+
>+				hdmi_in: port@0 {
>+					reg = <0>;
>+
>+					hdmi_in_tcon1: endpoint {
>+						remote-endpoint = <&tcon1_out_hdmi>;
>+					};
>+				};
>+
>+				hdmi_out: port@1 {
>+					reg = <1>;
>+				};
>+			};
>+		};
>+
>+		hdmi_phy: hdmi-phy@1ef0000 {
>+			compatible = "allwinner,sun50i-a64-hdmi-phy";
>+			reg = <0x01ef0000 0x10000>;
>+			clocks = <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_DDC>,
>+				 <&ccu CLK_PLL_VIDEO0>, <&ccu CLK_PLL_VIDEO1>;
>+			clock-names = "bus", "mod", "pll-0", "pll-1";
>+			resets = <&ccu RST_BUS_HDMI0>;
>+			reset-names = "phy";
>+			#phy-cells = <0>;
>+		};
>+
> 		rtc: rtc@1f00000 {
> 			compatible = "allwinner,sun6i-a31-rtc";
> 			reg = <0x01f00000 0x54>;
