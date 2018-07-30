Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBFFFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68F20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E68F20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeG3NPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:15:35 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:38683 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbeG3NPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:15:32 -0400
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="17050721"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jul 2018 04:40:52 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Mon, 30 Jul 2018 04:40:51 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Cristian.Birsan@microchip.com>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v6 2/3] ARM: dts: at91: sama5d2: add nodes for I2S controllers
Date:   Mon, 30 Jul 2018 14:40:07 +0300
Message-ID: <20180730114008.30464-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
References: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds DT nodes for I2S0 and I2S1. It also adds an alias for
each I2S node.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu@microchip.com: removed unnecessary clock phandles]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v6:
	- removed unnecessary phandles to audio PLL clock from the I2S nodes;
	- using assigned clocks to set gclk as parent of i2smuxclk;

 arch/arm/boot/dts/sama5d2.dtsi | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index eeb6afa1cda7..bf71dc00223a 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -58,6 +58,8 @@
 		serial1 = &uart3;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2s0 = &i2s0;
+		i2s1 = &i2s1;
 	};
 
 	cpus {
@@ -1313,6 +1315,24 @@
 				clocks = <&clk32k>;
 			};
 
+			i2s0: i2s@f8050000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xf8050000 0x100>;
+				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(31))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(32))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s0_clk>, <&i2s0_gclk>;
+				clock-names = "pclk", "gclk";
+				assigned-clocks = <&i2s0muxck>;
+				assigned-clock-parents = <&i2s0_gclk>;
+				status = "disabled";
+			};
+
 			can0: can@f8054000 {
 				compatible = "bosch,m_can";
 				reg = <0xf8054000 0x4000>, <0x210000 0x4000>;
@@ -1506,6 +1526,24 @@
 				status = "disabled";
 			};
 
+			i2s1: i2s@fc04c000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xfc04c000 0x100>;
+				interrupts = <55 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(33))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(34))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s1_clk>, <&i2s1_gclk>;
+				clock-names = "pclk", "gclk";
+				assigned-clocks = <&i2s1muxck>;
+				assigned-parrents = <&i2s1_gclk>;
+				status = "disabled";
+			};
+
 			can1: can@fc050000 {
 				compatible = "bosch,m_can";
 				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
-- 
2.17.1

