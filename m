Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4039C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA2020877
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA2020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeGVGz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:55:56 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45545 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbeGVGzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:55:55 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id F087D9F536;
        Sun, 22 Jul 2018 06:00:21 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v3 6/9] dt-bindings: phy: add binding for Allwinner USB3 PHY
Date:   Sun, 22 Jul 2018 13:57:36 +0800
Message-Id: <20180722055739.26464-7-icenowy@aosc.io>
In-Reply-To: <20180722055739.26464-1-icenowy@aosc.io>
References: <20180722055739.26464-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
external USB3 pins of the SoC.

Add a device tree binding for the PHY.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v3:
- Added Chen-Yu's Review tag.

Rob,
Although you mentioned that the supply is for the port, not the phy;
currently in USB situation "powering on the PHY" also indicates
"powering on the port" and nearly all usages of phy-supply is for Vbus.

Maybe we should change the overall phy-supply to satisfy this.

Thanks,
Icenowy

 .../bindings/phy/sun50i-usb3-phy.txt          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
new file mode 100644
index 000000000000..912d55f9f69d
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
@@ -0,0 +1,24 @@
+Allwinner sun50i USB3 PHY
+-----------------------
+
+Required properties:
+- compatible : should be one of
+  * allwinner,sun60i-h6-usb3-phy
+- reg : a list of offset + length pairs
+- #phy-cells : from the generic phy bindings, must be 0
+- clocks : phandle + clock specifier for the phy clock
+- resets : phandle + reset specifier for the phy reset
+
+Optional Properties:
+- phy-supply : from the generic phy bindings, a phandle to a regulator that
+	       provides power to VBUS.
+
+Example:
+	usb3phy: phy@5210000 {
+		compatible = "allwinner,sun50i-h6-usb3-phy";
+		reg = <0x5210000 0x10000>;
+		clocks = <&ccu CLK_USB_PHY1>;
+		resets = <&ccu RST_USB_PHY1>;
+		#phy-cells = <0>;
+		status = "disabled";
+	};
-- 
2.18.0

