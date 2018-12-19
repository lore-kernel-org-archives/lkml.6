Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998EBC43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724C0218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeLSCUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 21:20:43 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:20752 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727356AbeLSCUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 21:20:43 -0500
X-UUID: 4af08a4aa1af48018b94fedfee2a6329-20181219
X-UUID: 4af08a4aa1af48018b94fedfee2a6329-20181219
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 184522062; Wed, 19 Dec 2018 10:20:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Dec 2018 10:20:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 10:20:27 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Subject: [PATCH v6 2/2] arm: dts: mt2712: add uart APDMA to device tree
Date:   Wed, 19 Dec 2018 10:20:22 +0800
Message-ID: <1545186022-3712-3-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545186022-3712-1-git-send-email-long.cheng@mediatek.com>
References: <1545186022-3712-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DD45F8EA45A144C8E76A63B51C4388EF704808B66F68CADD1BD674C21D928C4E2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. add uart APDMA controller device node
2. add uart 0/1/2/3/4/5 DMA function

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi |   50 +++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 976d92a..be1a22a 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -300,6 +300,9 @@
 		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 10
+			&apdma 11>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -369,6 +372,38 @@
 			 (GIC_CPU_MASK_RAW(0x13) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	apdma: dma-controller@11000400 {
+		compatible = "mediatek,mt2712-uart-dma",
+			     "mediatek,mt6577-uart-dma";
+		reg = <0 0x11000400 0 0x80>,
+		      <0 0x11000480 0 0x80>,
+		      <0 0x11000500 0 0x80>,
+		      <0 0x11000580 0 0x80>,
+		      <0 0x11000600 0 0x80>,
+		      <0 0x11000680 0 0x80>,
+		      <0 0x11000700 0 0x80>,
+		      <0 0x11000780 0 0x80>,
+		      <0 0x11000800 0 0x80>,
+		      <0 0x11000880 0 0x80>,
+		      <0 0x11000900 0 0x80>,
+		      <0 0x11000980 0 0x80>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 105 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 106 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 107 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 109 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 111 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "apdma";
+		#dma-cells = <1>;
+	};
+
 	auxadc: adc@11001000 {
 		compatible = "mediatek,mt2712-auxadc";
 		reg = <0 0x11001000 0 0x1000>;
@@ -385,6 +420,9 @@
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 0
+			&apdma 1>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -395,6 +433,9 @@
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 2
+			&apdma 3>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -405,6 +446,9 @@
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 4
+			&apdma 5>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -415,6 +459,9 @@
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 6
+			&apdma 7>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -629,6 +676,9 @@
 		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&baud_clk>, <&sys_clk>;
 		clock-names = "baud", "bus";
+		dmas = <&apdma 8
+			&apdma 9>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
1.7.9.5

