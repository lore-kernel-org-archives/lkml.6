Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8232ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6542820873
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 12:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TicVtu8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6542820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeGOMSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 08:18:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37746 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeGOMSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 08:18:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so13169571wmh.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 04:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=P52aWVziuiyguo1m7bowtTQF174nvsgpvqGs2N2U270=;
        b=TicVtu8e6be/wRpaxf/G4RO4ByYrg6S97gEuJdpoNJgDsg1ZpSSdx6s99+Yb87OqEE
         z3+b4cTLnlrL/VdAzgT2H5EPY5CzETqWLnz6ZXAh7uYhKPHuCxbCVfi858kPuP6po70X
         mYAi1mSJNespOpsbfMin36DE1l1EVilqZu1Bg2onDYFZ+aZxNBIi/dTUefeiKtZ5tsfi
         eL+Cu3dEOb/mzawV28R0rM7JsxRAw1r6Bd/bHD6JmAOIFLrwE2IYeLsH5lDHbTNq/ZEQ
         jz0FnT1RjSNEnvxZH62nnx71d51pGlbvdbVWfL9LJuuRukaM1gR5u+9QSgyJki7jhL5G
         IJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P52aWVziuiyguo1m7bowtTQF174nvsgpvqGs2N2U270=;
        b=c9kK2GEhqecz/8r/riRr2Ojh0X3cwTxaEFORfAw0Kvv6lI3Ohqh/VmBp+yM2ZfW6ti
         lG/t2JVluqJp5TKpk76CIMrb/rsD7PZ/7cBY8a/bKrkUlnjssFi7DB+asoHuAseNBIDG
         tsc2APL6XxOEnqj+AdFZae2dY5Mg4LVFRRKvb5ugx24Fd4r4tqKiuCMrCVNacyu5WMxo
         CrnnFcQsnsfddHJkFlZNMse7QJtWi7F1s9gRGIq+KB0z/ORQrROEcKpQphA6LSrPIzOr
         1VFJgDOyqSVFzUdpP8jYX30MgFhfu/8TcBeayNHyotaUnXgauYBiffF2ZzQbzK8xa9l/
         v7Pg==
X-Gm-Message-State: AOUpUlHMR+UOxPb3TnJhX2CKx5VmunEY9tFcIMoWyPcc4EsTCOhiKD46
        +juwFZyGRPdwU9qyv8WlbkgTPw==
X-Google-Smtp-Source: AAOMgpdjjp9YghFBNU3kDhubJqgIsOxlayHx05a1n2kYQvt5EeVDRMycQgGR3E88JAqaQ66zeraAIw==
X-Received: by 2002:a1c:a8d6:: with SMTP id r205-v6mr7344883wme.6.1531655759716;
        Sun, 15 Jul 2018 04:55:59 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v15-v6sm10348647wmc.16.2018.07.15.04.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Jul 2018 04:55:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     catalin.marinas@arm.com, linux@armlinux.org.uk,
        mark.rutland@arm.com, maxime.ripard@free-electrons.com,
        robh+dt@kernel.org, wens@csie.org, will.deacon@arm.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM: dts: sunxi: Remove unused address-cells/size-cells of dwmac-sun8i
Date:   Sun, 15 Jul 2018 11:55:49 +0000
Message-Id: <1531655749-14063-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

address-cells/size-cells is unnecessary for dwmac-sun8i node.
It was in early days, but since a mdio node is used, it could be
removed.

This patch fix the following DT warning:
Warning (avoid_unnecessary_addr_size): /soc/ethernet@1c50000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 8 --------
 arch/arm/boot/dts/sun8i-a83t.dtsi                     | 2 --
 arch/arm/boot/dts/sun8i-r40.dtsi                      | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                    | 2 --
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi         | 2 --
 5 files changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index cfe724398a12..5bb3a18cc38d 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -19,8 +19,6 @@ Required properties:
 - reset-names: must be "stmmaceth"
 - phy-mode: See ethernet.txt
 - phy-handle: See ethernet.txt
-- #address-cells: shall be 1
-- #size-cells: shall be 0
 - syscon: A phandle to the device containing the EMAC or GMAC clock register
 
 Optional properties:
@@ -86,8 +84,6 @@ emac: ethernet@1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&int_mii_phy>;
 	phy-mode = "mii";
@@ -137,8 +133,6 @@ emac: ethernet@1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
@@ -191,8 +185,6 @@ emac: ethernet@1c0b000 {
 	reset-names = "stmmaceth";
 	clocks = <&ccu CLK_BUS_EMAC>;
 	clock-names = "stmmaceth";
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	phy-handle = <&ext_rgmii_phy>;
 	phy-mode = "rgmii";
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index b047f05e690d..276c99fcfcc8 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -913,8 +913,6 @@
 			reset-names = "stmmaceth";
 			clocks = <&ccu 27>;
 			clock-names = "stmmaceth";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 
 			mdio: mdio {
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index cb8932bcef0d..bd369112a400 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -576,8 +576,6 @@
 			reset-names = "stmmaceth";
 			clocks = <&ccu CLK_BUS_GMAC>;
 			clock-names = "stmmaceth";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 
 			gmac_mdio: mdio {
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 90021f38c1ef..f0352b8da19f 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -516,8 +516,6 @@
 			reset-names = "stmmaceth";
 			clocks = <&ccu CLK_BUS_EMAC>;
 			clock-names = "stmmaceth";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			status = "disabled";
 
 			mdio: mdio {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 91dd5dd9e205..357f6cba00cd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -668,8 +668,6 @@
 			clocks = <&ccu CLK_BUS_EMAC>;
 			clock-names = "stmmaceth";
 			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
 
 			mdio: mdio {
 				compatible = "snps,dwmac-mdio";
-- 
2.16.4

