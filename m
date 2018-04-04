Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeDDTAt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:00:49 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.173]:18595 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751567AbeDDTAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:00:40 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pA1dWeZVY=
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 5/5] DTS: Bindings: pca953x: add example how to use interrupt-controller and gpio-controller
Date: Wed,  4 Apr 2018 21:00:24 +0200
Message-Id: <4d00318d00bf0c946ee9b83e30e38d3b7a636183.1522868423.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1522868422.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com>
In-Reply-To: <cover.1522868422.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not completely obvious that these are required as
some .dts files don't specify them.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/gpio/gpio-pca953x.txt      | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
index 6a7cddb187c1..7f3b50a6d681 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -36,6 +36,10 @@ Optional properties:
  - reset-gpios: GPIO specification for the RESET input. This is an
 		active low signal to the PCA953x.
  - vcc-supply:	power supply regulator.
+ - gpio-controller: if used as gpio expander.
+ - #gpio-cells: if used as gpio expander.
+ - interrupt-controller: if to be used as interrupt expander.
+ - #interrupt-cells: if to be used as interrupt expander.
 
 Example:
 
@@ -48,3 +52,32 @@ Example:
 		interrupt-parent = <&gpio3>;
 		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
 	};
+
+
+Example with Interrupts:
+
+
+	gpio99: tca6424@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;	/* gpio6_161 */
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		vcc-supply = <&vdds_1v8_main>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"hdmi-ct-hpd", "hdmi.ls-oe", "p02", "p03", "vibra", "fault2", "p06", "p07",
+			"en-usb", "en-host1", "en-host2", "chg-int", "p14", "p15", "mic-int", "en-modem",
+			"shdn-hs-amp", "chg-status+red", "green", "blue", "en-esata", "fault1", "p26", "p27";
+	};
+
+	ts3a227@3b {
+		compatible = "ti,ts3a227e";
+		reg = <0x3b>;
+		interrupt-parent = <&gpio99>;
+		interrupts = <14 IRQ_TYPE_EDGE_RISING>;
+		ti,micbias = <0>;	/* 2.1V */
+	};
+
-- 
2.12.2
