Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57448C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4EC20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4EC20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeFRON3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:13:29 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:37824 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934733AbeFRON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:13:27 -0400
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="15039446"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Jun 2018 07:13:26 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch06.mchp-main.com (10.10.76.107) with Microsoft SMTP Server id
 14.3.352.0; Mon, 18 Jun 2018 07:13:23 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <nicolas.ferre@microchip.com>, <boris.brezillon@bootlin.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <sboyd@kernel.org>
CC:     <Cristian.Birsan@microchip.com>
Subject: [PATCH v5 1/5] dt-bindings: clk: at91: add an I2S mux clock
Date:   Mon, 18 Jun 2018 17:12:35 +0300
Message-ID: <20180618141239.10892-2-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S mux clock can be used to select the I2S input clock. The
available parents are the peripheral and the generated clocks.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v5:
	- specified clock's parent;
	- added a newline before adding the clock's compatible string;

 .../devicetree/bindings/clock/at91-clock.txt  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 51c259a92d02..d0adbf5ae144 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -91,6 +91,9 @@ Required properties:
 		at91 audio pll output on AUDIOPLLCLK that feeds the PMC
 		and can be used by peripheral clock or generic clock
 
+	"atmel,sama5d2-clk-i2s-mux" (under pmc node):
+		at91 I2S clock source selection
+
 Required properties for SCKC node:
 - reg : defines the IO memory reserved for the SCKC.
 - #size-cells : shall be 0 (reg is used to encode clk id).
@@ -507,3 +510,35 @@ For example:
 			atmel,clk-output-range = <0 83000000>;
 		};
 	};
+
+Required properties for I2S mux clocks:
+- #size-cells : shall be 0 (reg is used to encode I2S bus id).
+- #address-cells : shall be 1 (reg is used to encode I2S bus id).
+- name: device tree node describing a specific mux clock.
+	* #clock-cells : from common clock binding; shall be set to 0.
+	* clocks : shall be the mux clock parent phandles; shall be 2 phandles:
+	  peripheral and generated clock; the first phandle shall belong to the
+	  peripheral clock and the second one shall belong to the generated
+	  clock; "clock-indices" property can be user to specify
+	  the correct order.
+	* reg: I2S bus id of the corresponding mux clock.
+	  e.g. reg = <0>; for i2s0, reg = <1>; for i2s1
+
+For example:
+	i2s_clkmux {
+		compatible = "atmel,sama5d2-clk-i2s-mux";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2s0muxck: i2s0_muxclk {
+			clocks = <&i2s0_clk>, <&i2s0_gclk>;
+			#clock-cells = <0>;
+			reg = <0>;
+		};
+
+		i2s1muxck: i2s1_muxclk {
+			clocks = <&i2s1_clk>, <&i2s1_gclk>;
+			#clock-cells = <0>;
+			reg = <1>;
+		};
+	};
-- 
2.17.1

