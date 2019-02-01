Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C3B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wid9L+pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfBANhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:37:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38585 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfBANhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:37:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so6267124wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gw96D6lV5nc8LJ7jKMUnW98xIShzXHekWm2ox2FWIVg=;
        b=Wid9L+pHvaaHAfpsgoZ/3ly0MWxK8r5mRgIPwOoTM+yHT35p3JBUQ/ldrB/FiCb2EQ
         0qFTJ7z5Aw0KhwLgncT97tLtp1qjmoJ2+L+GoI7D6b5vRUc7XdRTQy3K6dLBWaCRv1lA
         PD95aK27Us9FwsH1nnNKMQB15WLiJ7sWq+K5SEUfb4+M8ea/f1WL1rP29YB4ZJh5tk1i
         EyRTyuR8AUCEzXcydDnndzs97wTTydgNFM9wGQqGPDp6md29YOaxBtQ3YvMln5al66/8
         /sLC3MUIuFMdiMHphaH4eqauMPwFsp9JOKelL6Ra9mSQPNxdvH4MQvQUI84XsESp4JZa
         es4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gw96D6lV5nc8LJ7jKMUnW98xIShzXHekWm2ox2FWIVg=;
        b=oFSJOMLqdJyV5RUvRQjGri92lGyi+0dayW9nLPlsRVuQqIwKfhKhOWbbLpS/G2FKmF
         ZmyBA3idg6YsV28dJcaOJVkj27kR3mCjwkywF7GYK8v6PAywqTVvGTAXoqF7Sw03t9a5
         Q+/E9PAY8pbo2LSuBc08jUeMM8aBurFn99zvQAXB7wBF5TEaiM83qrB3CSiz5w+MMlOQ
         ilTkhMTWOgfdbwAQ7fHvEQXTZa4ai0Lx5AYx3BMDldwJpL5C3neMUhs7tpB2dV7h0pg9
         baf4o4dmW5G5EgQSSW/LnsWiaYkk7esM8Pr16rN8K35ZrsJCJzJi4yXTgJVyxVA6wMv9
         al2Q==
X-Gm-Message-State: AHQUAuY7Ec8hoo+zqh5CtuTnT91woETGR1gRuboyCSaFVPHVJ7MinPPm
        0H82VuWqwdlYomoLB1dxymaYKA==
X-Google-Smtp-Source: AHgI3IbbdUp+oxkOdwmY9/1FF9IHCXtidg+4OnhPcnx6Co7Dd6tFTD8eW1N2+pM53HfTYlhVGaOKhQ==
X-Received: by 2002:a1c:a00f:: with SMTP id j15mr2398672wme.84.1549028264176;
        Fri, 01 Feb 2019 05:37:44 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 125sm3298669wmm.26.2019.02.01.05.37.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 05:37:43 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jianxin Pan <jianxin.pan@amlogic.com>
Subject: [PATCH v2] arm64: dts: meson: fix g12a buses
Date:   Fri,  1 Feb 2019 14:37:32 +0100
Message-Id: <20190201133732.32169-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix apb, cbus, hiu and periph regions which are not aligned
with the documentation and the information provided by Amlogic

Fixes: 9c8c52f7cb4f ("arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support")
Cc: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 46 +++++++++++----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 3b82a975c663..349c4e2df1b0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -78,20 +78,28 @@
 		#size-cells = <2>;
 		ranges;
 
-		periphs: periphs@ff634000 {
+		apb: bus@ff600000 {
 			compatible = "simple-bus";
-			reg = <0x0 0xff634000 0x0 0x2000>;
+			reg = <0x0 0xff600000 0x0 0x200000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
-		};
+			ranges = <0x0 0x0 0x0 0xff600000 0x0 0x200000>;
+
+			periphs: bus@34400 {
+				compatible = "simple-bus";
+				reg = <0x0 0x34400 0x0 0x400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x34400 0x0 0x400>;
+			};
 
-		hiubus: bus@ff63c000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xff63c000 0x0 0x1c00>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
+			hiu: bus@3c000 {
+				compatible = "simple-bus";
+				reg = <0x0 0x3c000 0x0 0x1400>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+				ranges = <0x0 0x0 0x0 0x3c000 0x0 0x1400>;
+			};
 		};
 
 		aobus: bus@ff800000 {
@@ -102,7 +110,8 @@
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
 			uart_AO: serial@3000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
+				compatible = "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&xtal>, <&xtal>;
@@ -111,7 +120,8 @@
 			};
 
 			uart_AO_B: serial@4000 {
-				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
+				compatible = "amlogic,meson-gx-uart",
+					     "amlogic,meson-ao-uart";
 				reg = <0x0 0x4000 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>, <&xtal>, <&xtal>;
@@ -135,18 +145,10 @@
 
 		cbus: bus@ffd00000 {
 			compatible = "simple-bus";
-			reg = <0x0 0xffd00000 0x0 0x25000>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
-		};
-
-		apb: apb@ffe00000 {
-			compatible = "simple-bus";
-			reg = <0x0 0xffe00000 0x0 0x200000>;
+			reg = <0x0 0xffd00000 0x0 0x100000>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
+			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
 		};
 	};
 
-- 
2.20.1

